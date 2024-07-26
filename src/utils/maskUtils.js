import moment from '@/plugins/momentPlugin';

export function formatedDateTimeTemplate(value, template, utcOffset) {
    if(utcOffset) return moment(value)
            .utcOffset(utcOffset)
            .format(template ?? 'HH:mm / DD-MM-YYYY');

    else return moment(value)
        .utcOffset('+03:00')
        .format(template ?? 'HH:mm / DD-MM-YYYY');
}

export function dateFromNow(value) {
    return moment(value).fromNow();
}

// Функция определяет является ли строка валидной датой
export function isValidData(value) {
    function isNotKebabString(str) {
        let isNotKebab = true;
        if(typeof str === 'string') {
            const splitted = str.split('-');
            if(splitted.length > 1) {
                if(+splitted[0] !== +splitted[0]) return false;
            }
        }
        return isNotKebab;
    }
    function isNotSpecSymbs(str) {
        let unacceptableSymbs = `!@#$%^&*()_<>,/|?;"'{}[]№%= `;
        let isNotSpecSymbs = true;
        if(typeof str === 'string') {
            for (let i = 0; i < str.length; i++) {
                if(unacceptableSymbs.includes(str[i])) {
                    isNotSpecSymbs = false; break;
                }
            }
        }
        return isNotSpecSymbs;
    }
    function isNotNumbers(str) {
        const regex = /\d/;
        return !regex.test(str);
    }
    if(typeof value === 'string') {
        if(value.length > 30 && +value === +value) return false;
        if(isNotKebabString(value) === false) return false;
        if(isNotSpecSymbs(value) === false) return false;
        if(isNotNumbers(value) === true) return false;
        let result = moment(value).format('ll');
        return result !== 'Invalid date';
    }
}