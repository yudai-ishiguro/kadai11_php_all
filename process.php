<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $point = $_POST['point'];
    $date = $_POST['date'];
    $wind_direction = $_POST['wind-direction'];

    // データベース接続設定
    $host = 'localhost';
    $dbname = 'kadai11_php_all';
    $username = 'root'; // ここにDBユーザー名を入力
    $password = ''; // ここにDBパスワードを入力

    try {
        $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $username, $password);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        // diving_areaのIDを取得
        $stmt = $pdo->prepare("SELECT id FROM diving_area WHERE area_name = ?");
        $stmt->execute([$point]);
        $diving_area_id = $stmt->fetchColumn();

        // wind_directionのIDを取得
        $stmt = $pdo->prepare("SELECT id FROM wind_direction WHERE direction = ?");
        $stmt->execute([$wind_direction]);
        $wind_direction_id = $stmt->fetchColumn();

        // デバッグ情報を表示
        echo "<div class='debug-info'>";
        echo "Diving Area ID: " . htmlspecialchars($diving_area_id) . "<br>";
        echo "Wind Direction ID: " . htmlspecialchars($wind_direction_id) . "<br>";
        echo "</div>";

        // diving_logの条件に合うデータを取得
        $stmt = $pdo->prepare("
            SELECT diving_point.point_name, diving_point.level, diving_point.depth, conditions.image
            FROM diving_log
            JOIN diving_point ON diving_log.diving_point_id = diving_point.id
            JOIN conditions ON diving_log.conditions_id = conditions.id
            WHERE diving_point.diving_area_id = ? AND diving_log.wind_direction_id = ? AND diving_log.conditions_id = 1
        ");
        $stmt->execute([$diving_area_id, $wind_direction_id]);

        $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

        if ($results) {
            echo "<h1>条件に合うダイビングポイント</h1>";
            foreach ($results as $row) {
                echo "<div>";
                echo "<p>ポイント名: " . htmlspecialchars($row['point_name']) . "</p>";
                echo "<p>レベル: " . htmlspecialchars($row['level']) . "</p>";
                echo "<p>水深: " . htmlspecialchars($row['depth']) . "</p>";
                if ($row['image']) {
                    echo "<p><img src='" . htmlspecialchars($row['image']) . "' alt='Condition Image'></p>";
                }
                echo "</div>";
            }
        } else {
            echo "<p>条件に合うダイビングポイントは見つかりませんでした。</p>";
        }
    } catch (PDOException $e) {
        echo "データベース接続エラー: " . $e->getMessage();
    }
}
?>
