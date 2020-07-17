Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwVjT-0007Qx-SB
 for kexec@lists.infradead.org; Fri, 17 Jul 2020 19:09:21 +0000
Received: by mail-wm1-x342.google.com with SMTP id l2so18802805wmf.0
 for <kexec@lists.infradead.org>; Fri, 17 Jul 2020 12:09:19 -0700 (PDT)
Subject: Re: [PATCH 02/13] fs/kernel_read_file: Remove
 FIRMWARE_PREALLOC_BUFFER enum
References: <20200717174309.1164575-1-keescook@chromium.org>
 <20200717174309.1164575-3-keescook@chromium.org>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <5203c5a1-1ced-f6b1-1086-df65479901a9@broadcom.com>
Date: Fri, 17 Jul 2020 12:09:10 -0700
MIME-Version: 1.0
In-Reply-To: <20200717174309.1164575-3-keescook@chromium.org>
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Peter Jones <pjones@redhat.com>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Matthew Garrett <matthewgarrett@google.com>, James Morris <jmorris@namei.org>, Matthew Wilcox <willy@infradead.org>, KP Singh <kpsingh@google.com>, "Serge E. Hallyn" <serge@hallyn.com>, selinux@vger.kernel.org, Jessica Yu <jeyu@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-integrity@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Dave Olsthoorn <dave@bewaar.me>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>



On 2020-07-17 10:42 a.m., Kees Cook wrote:
> FIRMWARE_PREALLOC_BUFFER is a "how", not a "what", and confuses the LSMs
> that are interested in filtering between types of things. The "how"
> should be an internal detail made uninteresting to the LSMs.
>
> Fixes: a098ecd2fa7d ("firmware: support loading into a pre-allocated buffer")
> Fixes: fd90bc559bfb ("ima: based on policy verify firmware signatures (pre-allocated buffer)")
> Fixes: 4f0496d8ffa3 ("ima: based on policy warn about loading firmware (pre-allocated buffer)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
> To aid in backporting, this change is made before moving
> kernel_read_file() to separate header/source files.
> ---
>   drivers/base/firmware_loader/main.c | 5 ++---
>   fs/exec.c                           | 7 ++++---
>   include/linux/fs.h                  | 2 +-
>   kernel/module.c                     | 2 +-
>   security/integrity/digsig.c         | 2 +-
>   security/integrity/ima/ima_fs.c     | 2 +-
>   security/integrity/ima/ima_main.c   | 6 ++----
>   7 files changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index ca871b13524e..c2f57cedcd6f 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -465,14 +465,12 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
>   	int i, len;
>   	int rc = -ENOENT;
>   	char *path;
> -	enum kernel_read_file_id id = READING_FIRMWARE;
>   	size_t msize = INT_MAX;
>   	void *buffer = NULL;
>   
>   	/* Already populated data member means we're loading into a buffer */
>   	if (!decompress && fw_priv->data) {
>   		buffer = fw_priv->data;
> -		id = READING_FIRMWARE_PREALLOC_BUFFER;
>   		msize = fw_priv->allocated_size;
>   	}
>   
> @@ -496,7 +494,8 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
>   
>   		/* load firmware files from the mount namespace of init */
>   		rc = kernel_read_file_from_path_initns(path, &buffer,
> -						       &size, msize, id);
> +						       &size, msize,
> +						       READING_FIRMWARE);
>   		if (rc) {
>   			if (rc != -ENOENT)
>   				dev_warn(device, "loading %s failed with error %d\n",
> diff --git a/fs/exec.c b/fs/exec.c
> index e6e8a9a70327..2bf549757ce7 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -927,6 +927,7 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>   {
>   	loff_t i_size, pos;
>   	ssize_t bytes = 0;
> +	void *allocated = NULL;
>   	int ret;
>   
>   	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
> @@ -950,8 +951,8 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>   		goto out;
>   	}
>   
> -	if (id != READING_FIRMWARE_PREALLOC_BUFFER)
> -		*buf = vmalloc(i_size);
> +	if (!*buf)
> +		*buf = allocated = vmalloc(i_size);
>   	if (!*buf) {
>   		ret = -ENOMEM;
>   		goto out;
> @@ -980,7 +981,7 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>   
>   out_free:
>   	if (ret < 0) {
> -		if (id != READING_FIRMWARE_PREALLOC_BUFFER) {
> +		if (allocated) {
>   			vfree(*buf);
>   			*buf = NULL;
>   		}
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3f881a892ea7..95fc775ed937 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2993,10 +2993,10 @@ static inline void i_readcount_inc(struct inode *inode)
>   #endif
>   extern int do_pipe_flags(int *, int);
>   
> +/* This is a list of *what* is being read, not *how*. */
>   #define __kernel_read_file_id(id) \
>   	id(UNKNOWN, unknown)		\
>   	id(FIRMWARE, firmware)		\
> -	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
>   	id(FIRMWARE_EFI_EMBEDDED, firmware)	\
>   	id(MODULE, kernel-module)		\
>   	id(KEXEC_IMAGE, kexec-image)		\
> diff --git a/kernel/module.c b/kernel/module.c
> index 0c6573b98c36..26105148f4d2 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3988,7 +3988,7 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
>   {
>   	struct load_info info = { };
>   	loff_t size;
> -	void *hdr;
> +	void *hdr = NULL;
>   	int err;
>   
>   	err = may_init_module();
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index e9cbadade74b..ac02b7632353 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -169,7 +169,7 @@ int __init integrity_add_key(const unsigned int id, const void *data,
>   
>   int __init integrity_load_x509(const unsigned int id, const char *path)
>   {
> -	void *data;
> +	void *data = NULL;
>   	loff_t size;
>   	int rc;
>   	key_perm_t perm;
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index e3fcad871861..15a44c5022f7 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -272,7 +272,7 @@ static const struct file_operations ima_ascii_measurements_ops = {
>   
>   static ssize_t ima_read_policy(char *path)
>   {
> -	void *data;
> +	void *data = NULL;
>   	char *datap;
>   	loff_t size;
>   	int rc, pathlen = strlen(path);
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index c1583d98c5e5..f80ee4ce4669 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -611,19 +611,17 @@ void ima_post_path_mknod(struct dentry *dentry)
>   int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
>   {
>   	/*
> -	 * READING_FIRMWARE_PREALLOC_BUFFER
> -	 *
>   	 * Do devices using pre-allocated memory run the risk of the
>   	 * firmware being accessible to the device prior to the completion
>   	 * of IMA's signature verification any more than when using two
> -	 * buffers?
> +	 * buffers? It may be desirable to include the buffer address
> +	 * in this API and walk all the dma_map_single() mappings to check.
>   	 */
>   	return 0;
>   }
>   
>   const int read_idmap[READING_MAX_ID] = {
>   	[READING_FIRMWARE] = FIRMWARE_CHECK,
> -	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
>   	[READING_MODULE] = MODULE_CHECK,
>   	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
>   	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
