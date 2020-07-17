Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwVle-000817-96
 for kexec@lists.infradead.org; Fri, 17 Jul 2020 19:11:38 +0000
Received: by mail-wm1-x343.google.com with SMTP id a6so7743140wmm.0
 for <kexec@lists.infradead.org>; Fri, 17 Jul 2020 12:11:34 -0700 (PDT)
Subject: Re: [PATCH 05/13] fs/kernel_read_file: Split into separate source file
References: <20200717174309.1164575-1-keescook@chromium.org>
 <20200717174309.1164575-6-keescook@chromium.org>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <b574b926-58f3-0f4c-0bbc-1ca978836917@broadcom.com>
Date: Fri, 17 Jul 2020 12:11:24 -0700
MIME-Version: 1.0
In-Reply-To: <20200717174309.1164575-6-keescook@chromium.org>
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
To: Kees Cook <keescook@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephen Boyd <stephen.boyd@linaro.org>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Peter Jones <pjones@redhat.com>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Matthew Garrett <matthewgarrett@google.com>, James Morris <jmorris@namei.org>, Matthew Wilcox <willy@infradead.org>, KP Singh <kpsingh@google.com>, "Serge E. Hallyn" <serge@hallyn.com>, selinux@vger.kernel.org, Jessica Yu <jeyu@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-integrity@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Dave Olsthoorn <dave@bewaar.me>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>



On 2020-07-17 10:43 a.m., Kees Cook wrote:
> These routines are used in places outside of exec(2), so in preparation
> for refactoring them, move them into a separate source file,
> fs/kernel_read_file.c.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   fs/Makefile           |   3 +-
>   fs/exec.c             | 132 ----------------------------------------
>   fs/kernel_read_file.c | 138 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 140 insertions(+), 133 deletions(-)
>   create mode 100644 fs/kernel_read_file.c
>
> diff --git a/fs/Makefile b/fs/Makefile
> index 2ce5112b02c8..a05fc247b2a7 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -13,7 +13,8 @@ obj-y :=	open.o read_write.o file_table.o super.o \
>   		seq_file.o xattr.o libfs.o fs-writeback.o \
>   		pnode.o splice.o sync.o utimes.o d_path.o \
>   		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
> -		fs_types.o fs_context.o fs_parser.o fsopen.o
> +		fs_types.o fs_context.o fs_parser.o fsopen.o \
> +		kernel_read_file.o
>   
>   ifeq ($(CONFIG_BLOCK),y)
>   obj-y +=	buffer.o block_dev.o direct-io.o mpage.o
> diff --git a/fs/exec.c b/fs/exec.c
> index 07a7fe9ac5be..d619b79aab30 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -923,138 +923,6 @@ struct file *open_exec(const char *name)
>   }
>   EXPORT_SYMBOL(open_exec);
>   
> -int kernel_read_file(struct file *file, void **buf, loff_t *size,
> -		     loff_t max_size, enum kernel_read_file_id id)
> -{
> -	loff_t i_size, pos;
> -	ssize_t bytes = 0;
> -	void *allocated = NULL;
> -	int ret;
> -
> -	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
> -		return -EINVAL;
> -
> -	ret = deny_write_access(file);
> -	if (ret)
> -		return ret;
> -
> -	ret = security_kernel_read_file(file, id);
> -	if (ret)
> -		goto out;
> -
> -	i_size = i_size_read(file_inode(file));
> -	if (i_size <= 0) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
> -		ret = -EFBIG;
> -		goto out;
> -	}
> -
> -	if (!*buf)
> -		*buf = allocated = vmalloc(i_size);
> -	if (!*buf) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> -
> -	pos = 0;
> -	while (pos < i_size) {
> -		bytes = kernel_read(file, *buf + pos, i_size - pos, &pos);
> -		if (bytes < 0) {
> -			ret = bytes;
> -			goto out_free;
> -		}
> -
> -		if (bytes == 0)
> -			break;
> -	}
> -
> -	if (pos != i_size) {
> -		ret = -EIO;
> -		goto out_free;
> -	}
> -
> -	ret = security_kernel_post_read_file(file, *buf, i_size, id);
> -	if (!ret)
> -		*size = pos;
> -
> -out_free:
> -	if (ret < 0) {
> -		if (allocated) {
> -			vfree(*buf);
> -			*buf = NULL;
> -		}
> -	}
> -
> -out:
> -	allow_write_access(file);
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(kernel_read_file);
> -
> -int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
> -			       loff_t max_size, enum kernel_read_file_id id)
> -{
> -	struct file *file;
> -	int ret;
> -
> -	if (!path || !*path)
> -		return -EINVAL;
> -
> -	file = filp_open(path, O_RDONLY, 0);
> -	if (IS_ERR(file))
> -		return PTR_ERR(file);
> -
> -	ret = kernel_read_file(file, buf, size, max_size, id);
> -	fput(file);
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
> -
> -int kernel_read_file_from_path_initns(const char *path, void **buf,
> -				      loff_t *size, loff_t max_size,
> -				      enum kernel_read_file_id id)
> -{
> -	struct file *file;
> -	struct path root;
> -	int ret;
> -
> -	if (!path || !*path)
> -		return -EINVAL;
> -
> -	task_lock(&init_task);
> -	get_fs_root(init_task.fs, &root);
> -	task_unlock(&init_task);
> -
> -	file = file_open_root(root.dentry, root.mnt, path, O_RDONLY, 0);
> -	path_put(&root);
> -	if (IS_ERR(file))
> -		return PTR_ERR(file);
> -
> -	ret = kernel_read_file(file, buf, size, max_size, id);
> -	fput(file);
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
> -
> -int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
> -			     enum kernel_read_file_id id)
> -{
> -	struct fd f = fdget(fd);
> -	int ret = -EBADF;
> -
> -	if (!f.file)
> -		goto out;
> -
> -	ret = kernel_read_file(f.file, buf, size, max_size, id);
> -out:
> -	fdput(f);
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
> -
>   #if defined(CONFIG_HAVE_AOUT) || defined(CONFIG_BINFMT_FLAT) || \
>       defined(CONFIG_BINFMT_ELF_FDPIC)
>   ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
> diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
> new file mode 100644
> index 000000000000..54d972d4befc
> --- /dev/null
> +++ b/fs/kernel_read_file.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/fs.h>
> +#include <linux/fs_struct.h>
> +#include <linux/kernel_read_file.h>
> +#include <linux/security.h>
> +#include <linux/vmalloc.h>
> +
> +int kernel_read_file(struct file *file, void **buf, loff_t *size,
> +		     loff_t max_size, enum kernel_read_file_id id)
> +{
> +	loff_t i_size, pos;
> +	ssize_t bytes = 0;
> +	void *allocated = NULL;
> +	int ret;
> +
> +	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
> +		return -EINVAL;
> +
> +	ret = deny_write_access(file);
> +	if (ret)
> +		return ret;
> +
> +	ret = security_kernel_read_file(file, id);
> +	if (ret)
> +		goto out;
> +
> +	i_size = i_size_read(file_inode(file));
> +	if (i_size <= 0) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
> +		ret = -EFBIG;
> +		goto out;
> +	}
> +
> +	if (!*buf)
> +		*buf = allocated = vmalloc(i_size);
> +	if (!*buf) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	pos = 0;
> +	while (pos < i_size) {
> +		bytes = kernel_read(file, *buf + pos, i_size - pos, &pos);
> +		if (bytes < 0) {
> +			ret = bytes;
> +			goto out_free;
> +		}
> +
> +		if (bytes == 0)
> +			break;
> +	}
> +
> +	if (pos != i_size) {
> +		ret = -EIO;
> +		goto out_free;
> +	}
> +
> +	ret = security_kernel_post_read_file(file, *buf, i_size, id);
> +	if (!ret)
> +		*size = pos;
> +
> +out_free:
> +	if (ret < 0) {
> +		if (allocated) {
> +			vfree(*buf);
> +			*buf = NULL;
> +		}
> +	}
> +
> +out:
> +	allow_write_access(file);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(kernel_read_file);
> +
> +int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
> +			       loff_t max_size, enum kernel_read_file_id id)
> +{
> +	struct file *file;
> +	int ret;
> +
> +	if (!path || !*path)
> +		return -EINVAL;
> +
> +	file = filp_open(path, O_RDONLY, 0);
> +	if (IS_ERR(file))
> +		return PTR_ERR(file);
> +
> +	ret = kernel_read_file(file, buf, size, max_size, id);
> +	fput(file);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
> +
> +int kernel_read_file_from_path_initns(const char *path, void **buf,
> +				      loff_t *size, loff_t max_size,
> +				      enum kernel_read_file_id id)
> +{
> +	struct file *file;
> +	struct path root;
> +	int ret;
> +
> +	if (!path || !*path)
> +		return -EINVAL;
> +
> +	task_lock(&init_task);
> +	get_fs_root(init_task.fs, &root);
> +	task_unlock(&init_task);
> +
> +	file = file_open_root(root.dentry, root.mnt, path, O_RDONLY, 0);
> +	path_put(&root);
> +	if (IS_ERR(file))
> +		return PTR_ERR(file);
> +
> +	ret = kernel_read_file(file, buf, size, max_size, id);
> +	fput(file);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
> +
> +int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
> +			     enum kernel_read_file_id id)
> +{
> +	struct fd f = fdget(fd);
> +	int ret = -EBADF;
> +
> +	if (!f.file)
> +		goto out;
> +
> +	ret = kernel_read_file(f.file, buf, size, max_size, id);
> +out:
> +	fdput(f);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
