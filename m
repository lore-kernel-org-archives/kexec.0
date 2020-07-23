Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyf9O-0008FO-Bw
 for kexec@lists.infradead.org; Thu, 23 Jul 2020 17:37:00 +0000
Received: by mail-pf1-x444.google.com with SMTP id u185so3369703pfu.1
 for <kexec@lists.infradead.org>; Thu, 23 Jul 2020 10:36:57 -0700 (PDT)
Subject: Re: [PATCH v2 10/18] fs/kernel_read_file: Add file_size output
 argument
References: <20200722193020.2676422-1-keescook@chromium.org>
 <20200722193020.2676422-11-keescook@chromium.org>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <01b071ef-3f07-f586-958f-c45829205588@broadcom.com>
Date: Thu, 23 Jul 2020 10:36:50 -0700
MIME-Version: 1.0
In-Reply-To: <20200722193020.2676422-11-keescook@chromium.org>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kees Cook <keescook@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-efi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, Stephen Boyd <stephen.boyd@linaro.org>, SeongJae Park <sjpark@amazon.de>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Tushar Sugandhi <tusharsu@linux.microsoft.com>, Peter Jones <pjones@redhat.com>, linux-kselftest@vger.kernel.org, "Joel Fernandes (Google)" <joel@joelfernandes.org>, Shuah Khan <shuah@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Thomas Cedeno <thomascedeno@google.com>, linux-security-module@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>, Paul Moore <paul@paul-moore.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.ibm.com>, Matthew Garrett <matthewgarrett@google.com>, James Morris <jmorris@namei.org>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Aaron Goidel <acgoide@tycho.nsa.gov>, "Serge E. Hallyn" <serge@hallyn.com>, Wenwen Wang <wenwen@cs.uga.edu>, selinux@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Matthieu Baerts <matthieu.baerts@tessares.net>, KP Singh <kpsingh@chromium.org>, Eric Paris <eparis@parisplace.org>, linux-integrity@vger.kernel.org, Florent Revest <revest@google.com>, Andrea Righi <andrea.righi@canonical.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Dave Olsthoorn <dave@bewaar.me>, Jessica Yu <jeyu@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, Thiago Jung Bauermann <bauerman@linux.ibm.com>

works.

On 2020-07-22 12:30 p.m., Kees Cook wrote:
> In preparation for adding partial read support, add an optional output
> argument to kernel_read_file*() that reports the file size so callers
> can reason more easily about their reading progress.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   drivers/base/firmware_loader/main.c |  1 +
>   fs/kernel_read_file.c               | 19 +++++++++++++------
>   include/linux/kernel_read_file.h    |  4 ++++
>   kernel/kexec_file.c                 |  4 ++--
>   kernel/module.c                     |  2 +-
>   security/integrity/digsig.c         |  2 +-
>   security/integrity/ima/ima_fs.c     |  2 +-
>   7 files changed, 23 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index f80c0d102be8..bd199404935f 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -495,6 +495,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
>   
>   		/* load firmware files from the mount namespace of init */
>   		rc = kernel_read_file_from_path_initns(path, &buffer, msize,
> +						       NULL,
>   						       READING_FIRMWARE);
>   		if (rc < 0) {
>   			if (rc != -ENOENT)
> diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
> index e21a76001fff..2e29c38eb4df 100644
> --- a/fs/kernel_read_file.c
> +++ b/fs/kernel_read_file.c
> @@ -14,6 +14,8 @@
>    *		@buf_size will be ignored)
>    * @buf_size	size of buf, if already allocated. If @buf not
>    *		allocated, this is the largest size to allocate.
> + * @file_size	if non-NULL, the full size of @file will be
> + *		written here.
>    * @id		the kernel_read_file_id identifying the type of
>    *		file contents being read (for LSMs to examine)
>    *
> @@ -22,7 +24,8 @@
>    *
>    */
>   int kernel_read_file(struct file *file, void **buf,
> -		     size_t buf_size, enum kernel_read_file_id id)
> +		     size_t buf_size, size_t *file_size,
> +		     enum kernel_read_file_id id)
>   {
>   	loff_t i_size, pos;
>   	ssize_t bytes = 0;
> @@ -49,6 +52,8 @@ int kernel_read_file(struct file *file, void **buf,
>   		ret = -EFBIG;
>   		goto out;
>   	}
> +	if (file_size)
> +		*file_size = i_size;
>   
>   	if (!*buf)
>   		*buf = allocated = vmalloc(i_size);
> @@ -91,7 +96,8 @@ int kernel_read_file(struct file *file, void **buf,
>   EXPORT_SYMBOL_GPL(kernel_read_file);
>   
>   int kernel_read_file_from_path(const char *path, void **buf,
> -			       size_t buf_size, enum kernel_read_file_id id)
> +			       size_t buf_size, size_t *file_size,
> +			       enum kernel_read_file_id id)
>   {
>   	struct file *file;
>   	int ret;
> @@ -103,14 +109,14 @@ int kernel_read_file_from_path(const char *path, void **buf,
>   	if (IS_ERR(file))
>   		return PTR_ERR(file);
>   
> -	ret = kernel_read_file(file, buf, buf_size, id);
> +	ret = kernel_read_file(file, buf, buf_size, file_size, id);
>   	fput(file);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
>   
>   int kernel_read_file_from_path_initns(const char *path, void **buf,
> -				      size_t buf_size,
> +				      size_t buf_size, size_t *file_size,
>   				      enum kernel_read_file_id id)
>   {
>   	struct file *file;
> @@ -129,13 +135,14 @@ int kernel_read_file_from_path_initns(const char *path, void **buf,
>   	if (IS_ERR(file))
>   		return PTR_ERR(file);
>   
> -	ret = kernel_read_file(file, buf, buf_size, id);
> +	ret = kernel_read_file(file, buf, buf_size, file_size, id);
>   	fput(file);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
>   
>   int kernel_read_file_from_fd(int fd, void **buf, size_t buf_size,
> +			     size_t *file_size,
>   			     enum kernel_read_file_id id)
>   {
>   	struct fd f = fdget(fd);
> @@ -144,7 +151,7 @@ int kernel_read_file_from_fd(int fd, void **buf, size_t buf_size,
>   	if (!f.file)
>   		goto out;
>   
> -	ret = kernel_read_file(f.file, buf, buf_size, id);
> +	ret = kernel_read_file(f.file, buf, buf_size, file_size, id);
>   out:
>   	fdput(f);
>   	return ret;
> diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
> index 910039e7593e..023293eaf948 100644
> --- a/include/linux/kernel_read_file.h
> +++ b/include/linux/kernel_read_file.h
> @@ -37,15 +37,19 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
>   
>   int kernel_read_file(struct file *file,
>   		     void **buf, size_t buf_size,
> +		     size_t *file_size,
>   		     enum kernel_read_file_id id);
>   int kernel_read_file_from_path(const char *path,
>   			       void **buf, size_t buf_size,
> +			       size_t *file_size,
>   			       enum kernel_read_file_id id);
>   int kernel_read_file_from_path_initns(const char *path,
>   				      void **buf, size_t buf_size,
> +				      size_t *file_size,
>   				      enum kernel_read_file_id id);
>   int kernel_read_file_from_fd(int fd,
>   			     void **buf, size_t buf_size,
> +			     size_t *file_size,
>   			     enum kernel_read_file_id id);
>   
>   #endif /* _LINUX_KERNEL_READ_FILE_H */
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index eda19ca256a3..878ca684a3a1 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -222,7 +222,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>   	void *ldata;
>   
>   	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
> -				       INT_MAX, READING_KEXEC_IMAGE);
> +				       INT_MAX, NULL, READING_KEXEC_IMAGE);
>   	if (ret < 0)
>   		return ret;
>   	image->kernel_buf_len = ret;
> @@ -242,7 +242,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>   	/* It is possible that there no initramfs is being loaded */
>   	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
>   		ret = kernel_read_file_from_fd(initrd_fd, &image->initrd_buf,
> -					       INT_MAX,
> +					       INT_MAX, NULL,
>   					       READING_KEXEC_INITRAMFS);
>   		if (ret < 0)
>   			goto out;
> diff --git a/kernel/module.c b/kernel/module.c
> index b6fd4f51cc30..860d713dd910 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -4001,7 +4001,7 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
>   		      |MODULE_INIT_IGNORE_VERMAGIC))
>   		return -EINVAL;
>   
> -	err = kernel_read_file_from_fd(fd, &hdr, INT_MAX,
> +	err = kernel_read_file_from_fd(fd, &hdr, INT_MAX, NULL,
>   				       READING_MODULE);
>   	if (err < 0)
>   		return err;
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index 04f779c4f5ed..8a523dfd7fd7 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -175,7 +175,7 @@ int __init integrity_load_x509(const unsigned int id, const char *path)
>   	int rc;
>   	key_perm_t perm;
>   
> -	rc = kernel_read_file_from_path(path, &data, INT_MAX,
> +	rc = kernel_read_file_from_path(path, &data, INT_MAX, NULL,
>   					READING_X509_CERTIFICATE);
>   	if (rc < 0) {
>   		pr_err("Unable to open file: %s (%d)", path, rc);
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index 692b83e82edf..5fc56ccb6678 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -284,7 +284,7 @@ static ssize_t ima_read_policy(char *path)
>   	datap = path;
>   	strsep(&datap, "\n");
>   
> -	rc = kernel_read_file_from_path(path, &data, INT_MAX, READING_POLICY);
> +	rc = kernel_read_file_from_path(path, &data, INT_MAX, NULL, READING_POLICY);
>   	if (rc < 0) {
>   		pr_err("Unable to open file: %s (%d)", path, rc);
>   		return rc;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
