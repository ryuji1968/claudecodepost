// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Override Turbo's confirm with Bootstrap modal
Turbo.setConfirmMethod((message) => {
  return new Promise((resolve) => {
    const id = "turbo-confirm-modal"
    let modal = document.getElementById(id)

    if (!modal) {
      modal = document.createElement("div")
      modal.id = id
      modal.className = "modal fade"
      modal.tabIndex = -1
      modal.innerHTML = `
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title"></h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <p class="modal-message mb-0"></p>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal"></button>
              <button type="button" class="btn btn-danger confirm-btn"></button>
            </div>
          </div>
        </div>
      `
      document.body.appendChild(modal)
    }

    modal.querySelector(".modal-title").textContent = document.querySelector('meta[name="application-name"]')?.content || "確認"
    modal.querySelector(".modal-message").textContent = message
    modal.querySelector(".btn-outline-secondary").textContent = "キャンセル"
    modal.querySelector(".confirm-btn").textContent = "OK"

    const bsModal = new bootstrap.Modal(modal)

    const confirmBtn = modal.querySelector(".confirm-btn")
    const onConfirm = () => {
      cleanup()
      bsModal.hide()
      resolve(true)
    }
    const onDismiss = () => {
      cleanup()
      resolve(false)
    }
    const cleanup = () => {
      confirmBtn.removeEventListener("click", onConfirm)
      modal.removeEventListener("hidden.bs.modal", onDismiss)
    }

    confirmBtn.addEventListener("click", onConfirm)
    modal.addEventListener("hidden.bs.modal", onDismiss)

    bsModal.show()
  })
})
