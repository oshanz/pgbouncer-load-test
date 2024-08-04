import http from 'k6/http';
import { sleep, check, group } from 'k6';
import { htmlReport } from "https://raw.githubusercontent.com/benc-uk/k6-reporter/main/dist/bundle.js";

// export const options = {
//   stages: [
//     { duration: '10s', target: 10 },
//     { duration: '10s', target: 100 },
//     { duration: '10s', target: 0 },
//   ],
// };

export const options = {
  vus: 10,
  duration: '10s',
};

export default function () {

  group('io intensive', function () {
    const res = http.get('http://localhost:8080/io_intensive');
    check(res, { 'status was 200': (r) => r.status == 200 });
  });

  // group('cpu intensive', function () {
  //   const res = http.get('http://localhost:8080/cpu_intensive');
  //   check(res, { 'status was 200': (r) => r.status == 200 });
  // });
}

export function handleSummary(data) {
  return {
    "summary.html": htmlReport(data),
  };
}