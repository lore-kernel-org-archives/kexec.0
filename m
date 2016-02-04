Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-x234.google.com ([2607:f8b0:4001:c06::234])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aROAy-0007UQ-P1
 for kexec@lists.infradead.org; Thu, 04 Feb 2016 17:58:41 +0000
Received: by mail-io0-x234.google.com with SMTP id 9so101913030iom.1
 for <kexec@lists.infradead.org>; Thu, 04 Feb 2016 09:58:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1454526390-19792-16-git-send-email-zohar@linux.vnet.ibm.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-16-git-send-email-zohar@linux.vnet.ibm.com>
Date: Thu, 4 Feb 2016 09:58:19 -0800
Message-ID: <CAGXu5jJEeYcyUXd21BQa_52XLbuec=xxuhKgKcgu=VE=M3zaNg@mail.gmail.com>
Subject: Re: [PATCH v3 15/22] vfs: define kernel_copy_file_from_fd()
From: Kees Cook <keescook@chromium.org>
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
Cc: Rusty Russell <rusty@rustcorp.com.au>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, "Luis R. Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kexec Mailing List <kexec@lists.infradead.org>, David Howells <dhowells@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Wed, Feb 3, 2016 at 11:06 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> This patch defines kernel_read_file_from_fd(), a wrapper for the VFS
> common kernel_read_file().
>
> Changelog:
> - Separated from the kernel modules patch
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  fs/exec.c          | 16 ++++++++++++++++
>  include/linux/fs.h |  2 ++
>  2 files changed, 18 insertions(+)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 1d39c4e..f3a0ce2 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -910,6 +910,22 @@ int kernel_read_file_from_path(char *path, void **buf, loff_t *size,
>  }
>  EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
>
> +int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
> +                            enum kernel_read_file_id id)
> +{
> +       struct fd f = fdget(fd);
> +       int ret = -EBADF;
> +
> +       if (!f.file)
> +               goto out;
> +
> +       ret = kernel_read_file(f.file, buf, size, max_size, id);
> +out:
> +       fdput(f);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
> +
>  ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
>  {
>         ssize_t res = vfs_read(file, (void __user *)addr, len, &pos);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 2a9670a..5ba806b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2536,6 +2536,8 @@ extern int kernel_read_file(struct file *, void **, loff_t *, loff_t,
>                             enum kernel_read_file_id);
>  extern int kernel_read_file_from_path(char *, void **, loff_t *, loff_t,
>                                       enum kernel_read_file_id);
> +extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t,
> +                                   enum kernel_read_file_id);
>  extern ssize_t kernel_write(struct file *, const char *, size_t, loff_t);
>  extern ssize_t __kernel_write(struct file *, const char *, size_t, loff_t *);
>  extern struct file * open_exec(const char *);
> --
> 2.1.0
>



-- 
Kees Cook
Chrome OS & Brillo Security

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
