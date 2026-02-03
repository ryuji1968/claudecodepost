import { Controller } from "@hotwired/stimulus"
import ApexCharts from "apexcharts"

export default class extends Controller {
  static values = {
    daily: Object,
    monthly: Object
  }

  connect() {
    this.renderDaily()
    this.renderMonthly()
  }

  disconnect() {
    this.dailyChart?.destroy()
    this.monthlyChart?.destroy()
  }

  renderDaily() {
    const data = this.dailyValue
    const labels = Object.keys(data).sort()
    const values = labels.map(k => data[k])

    this.dailyChart = new ApexCharts(this.element.querySelector("#dailyChart"), {
      chart: {
        type: "line",
        height: 130,
        sparkline: { enabled: true }
      },
      series: [{ name: "投稿数", data: values }],
      colors: ["#fff"],
      stroke: { curve: "smooth", width: 3 },
      tooltip: {
        theme: "dark",
        fixed: { enabled: false },
        x: { show: true, formatter: (_val, opts) => labels[opts.dataPointIndex]?.slice(5) || "" },
        y: { title: { formatter: () => "投稿数" } },
        marker: { show: false }
      }
    })
    this.dailyChart.render()
  }

  renderMonthly() {
    const data = this.monthlyValue
    const labels = Object.keys(data).sort()
    const values = labels.map(k => data[k])

    this.monthlyChart = new ApexCharts(this.element.querySelector("#monthlyChart"), {
      chart: {
        type: "line",
        height: 130,
        sparkline: { enabled: true }
      },
      series: [{ name: "投稿数", data: values }],
      colors: ["#fff"],
      stroke: { curve: "smooth", width: 3 },
      tooltip: {
        theme: "dark",
        fixed: { enabled: false },
        x: { show: true, formatter: (_val, opts) => labels[opts.dataPointIndex] || "" },
        y: { title: { formatter: () => "投稿数" } },
        marker: { show: false }
      }
    })
    this.monthlyChart.render()
  }
}
