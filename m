Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ua0-x244.google.com ([2607:f8b0:400c:c08::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fQHtR-000626-M1
 for kexec@lists.infradead.org; Tue, 05 Jun 2018 19:45:23 +0000
Received: by mail-ua0-x244.google.com with SMTP id a5-v6so2467428uao.8
 for <kexec@lists.infradead.org>; Tue, 05 Jun 2018 12:45:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527780226.3427.20.camel@linux.vnet.ibm.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1527616920-5415-9-git-send-email-zohar@linux.vnet.ibm.com>
 <CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com>
 <1527635645.3534.39.camel@linux.vnet.ibm.com>
 <CAHC9VhQQX-JAnV-6jEOsug-6siyO9mrNa=rYK9Whg-MYcfHxgA@mail.gmail.com>
 <1527780226.3427.20.camel@linux.vnet.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 5 Jun 2018 12:45:09 -0700
Message-ID: <CAGXu5jLXSEWHorm6=h9+1cP-y8ZX2_ALcra6g9x7Tm-O0kU3DQ@mail.gmail.com>
Subject: Re: [PATCH v4a 8/8] module: replace the existing LSM hook in
 init_module
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Paul Moore <paul@paul-moore.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kexec Mailing List <kexec@lists.infradead.org>, "Luis R . Rodriguez" <mcgrof@kernel.org>, LKML <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, Jeff Vander Stoep <jeffv@google.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity <linux-integrity@vger.kernel.org>, Andres Rodriguez <andresx7@gmail.com>

On Thu, May 31, 2018 at 8:23 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index 5fa191252c8f..a9c07bfbc338 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -173,9 +173,24 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
>         return 0;
>  }
>
> +static int loadpin_load_data(enum kernel_load_data_id id)
> +{
> +       int rc = 0;
> +
> +       switch (id) {
> +       case LOADING_MODULE:
> +               rc = loadpin_read_file(NULL, READING_MODULE);
> +       default:
> +               break;
> +       }
> +
> +       return rc;
> +}

Is it worth keeping the same enum between the two hooks? That would
simplify this a bit since it could just pass the id without remapping.

And if you must have a separate enum, please change this to fail
closed instead of open (and mark the fall-through):

int rc = -EPERM;

switch (id) {
case LOADING_MODULE:
    rc = loadpin_read_file(NULL, READING_MODULE);
    /* Fall-through */
default:
    break;
}

Thanks!

-Kees

> +
>  static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
>         LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
>         LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
> +       LSM_HOOK_INIT(kernel_load_data, loadpin_load_data),
>  };
>
>  void __init loadpin_add_hooks(void)
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 02ebd1585eaf..475aed9ee2c7 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4059,6 +4059,20 @@ static int selinux_kernel_read_file(struct file *file,
>         return rc;
>  }
>
> +static int selinux_kernel_load_data(enum kernel_load_data_id id)
> +{
> +       int rc = 0;
> +
> +       switch (id) {
> +       case LOADING_MODULE:
> +               rc = selinux_kernel_module_from_file(NULL);
> +       default:
> +               break;
> +       }
> +
> +       return rc;
> +}
> +
>  static int selinux_task_setpgid(struct task_struct *p, pid_t pgid)
>  {
>         return avc_has_perm(&selinux_state,
> @@ -6950,6 +6964,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>         LSM_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
>         LSM_HOOK_INIT(kernel_create_files_as, selinux_kernel_create_files_as),
>         LSM_HOOK_INIT(kernel_module_request, selinux_kernel_module_request),
> +       LSM_HOOK_INIT(kernel_load_data, selinux_kernel_load_data),
>         LSM_HOOK_INIT(kernel_read_file, selinux_kernel_read_file),
>         LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
>         LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
> --
> 2.7.5
>



-- 
Kees Cook
Pixel Security

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
