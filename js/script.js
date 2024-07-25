$(function () {
    $('#js-hamburger-menu, .navigation__link').on('click', function () {
        $('.navigation').slideToggle(500)
        $('.hamburger-menu').toggleClass('hamburger-menu--open')
    });
});

// カレンダーの日付の制限
document.addEventListener('DOMContentLoaded', function() {
    const today = new Date();
    const formatDate = (date) => {
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        return `${year}-${month}-${day}`;
    };

    const tomorrow = new Date(today);
    tomorrow.setDate(today.getDate() + 1);
    const tomorrowFormatted = formatDate(tomorrow);

    const maxDate = new Date(today);
    maxDate.setDate(today.getDate() + 4);
    const maxDateFormatted = formatDate(maxDate);

    const dateInput = document.getElementById('date');
    dateInput.setAttribute('min', tomorrowFormatted);
    dateInput.setAttribute('max', maxDateFormatted);
});

// 天気予報
$(function() {
    var API_KEY = '';// Github上では削除
    var city = 'Zamami';
    var url = 'https://api.openweathermap.org/data/2.5/forecast?q=' + city + ',jp&units=metric&APPID=' + API_KEY;

    $.ajax({
        url: url,
        type: 'GET',
        cache: false,
        dataType: "json",
    })
    .done(function(data) {
        var insertHTML = "";
        var cityName = '<h2>' + data.city.name + '</h2>';
        $('#city-name').html(cityName);

        window.forecastData = data.list;

        var forecastDays = getDailyForecasts(data.list);
        for (var i = 0; i < forecastDays.length; i++) {
            insertHTML += buildHTML(forecastDays[i]);
        }
        $('#weather').html(insertHTML);
    })
    .fail(function() {
        $('#error-message').text("データの取得に失敗しました。");
    });
});

function getDailyForecasts(list) {
    var dailyForecasts = [];
    var targetHour = "00:00:00";

    for (var i = 0; i < list.length; i++) {
        var item = list[i];
        if (item.dt_txt.includes(targetHour)) {
            dailyForecasts.push(item);
        }
        if (dailyForecasts.length === 5) {
            break;
        }
    }
    console.dir(dailyForecasts);
    return dailyForecasts;
}

function getDescription(disc) {
    switch (disc.toLowerCase()) {
        case "clear sky":
            return "快晴";
        case "few clouds":
            return "くもり（雲少なめ）";
        case "scattered clouds":
            return "くもり（雲ふつう）";
        case "broken clouds":
        case "overcast clouds":
            return "くもり（雲多め）";
        case "light intensity shower rain":
            return "小雨のにわか雨";
        case "shower rain":
            return "にわか雨";
        case "heavy intensity shower rain":
            return "大雨のにわか雨";
        case "light rain":
            return "小雨";
        case "moderate rain":
            return "雨";
        case "heavy intensity rain":
            return "大雨";
        case "very heavy rain":
            return "激しい大雨";
        case "rain":
            return "雨";
        case "thunderstorm":
            return "雷雨";
        case "snow":
            return "雪";
        case "mist":
            return "靄";
        case "tornado":
            return "強風";
        default:
            return disc;
    }
}

function buildHTML(data) {
    var Week = new Array("（日）","（月）","（火）","（水）","（木）","（金）","（土）");
    var date = new Date (data.dt_txt);
    date.setHours(date.getHours() + 9);
    var month = date.getMonth() + 1;
    var day = month + "月" + date.getDate() + "日" + Week[date.getDay()] + date.getHours() + "：00";
    var icon = data.weather[0].icon;
    var windDirection = getWindDirection(data.wind.deg);
    var windSpeed = data.wind.speed;
    var weatherDescription = getDescription(data.weather[0].description);

    var html = `
        <div class="weather-report">
            <img src="https://openweathermap.org/img/w/${icon}.png">
            <div class="weather-date">${day}</div>
            <div class="weather-main">${weatherDescription}</div>
            <div class="weather-temp">${Math.round(data.main.temp)}℃</div>
            <div class="weather-wind">風速: ${windSpeed} m/s, 風向: ${windDirection}</div>
        </div>
    `;
    return html;
}

function getWindDirection(degree) {
    var directions = ['北', '北北東', '北東', '東北東', '東', '東南東', '南東', '南南東', '南', '南南西', '南西', '西南西', '西', '西北西', '北西', '北北西', '北'];
    var index = Math.round(degree / 22.5) % 16;
    return directions[index];
}

function getSelectedDateWindDirection(selectedDate) {
    var windDirection = "";
    if (window.forecastData) {
        var selectedDateForecasts = window.forecastData.filter(item => item.dt_txt.includes(selectedDate));
        if (selectedDateForecasts.length > 0) {
            var firstForecast = selectedDateForecasts[0];
            windDirection = getWindDirection(firstForecast.wind.deg);
        } else {
            windDirection = "データがありません";
        }
    }
    return windDirection;
}

function handleSubmit(event) {
    event.preventDefault();

    var selectedDate = document.getElementById('date').value;
    var windDirection = getSelectedDateWindDirection(selectedDate);

    var formData = {
        point: document.querySelector('input[name="point"]:checked').value,
        date: selectedDate,
        'wind-direction': windDirection
    };

    $.ajax({
        type: 'POST',
        url: 'process.php',
        data: formData,
        success: function(response) {
            $('.result').html(response);
            // $('.result .debug-info').hide(); // 追加

        // デバッグ情報をコンソールに表示
        $('.debug-info').each(function() {
            console.log($(this).text());
        });

        },
        error: function() {
            alert('データの送信に失敗しました。');
        }
    });
}

document.getElementById('forecast-form').addEventListener('submit', handleSubmit);

  