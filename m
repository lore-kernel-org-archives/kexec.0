Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aCL1M-0006zQ-Al
 for kexec@lists.infradead.org; Fri, 25 Dec 2015 05:34:34 +0000
Date: Fri, 25 Dec 2015 13:33:56 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [Linux-ima-devel] [PATCH v2 4/7] ima: measure and appraise kexec
 image and initramfs
Message-ID: <20151225053356.GA3398@dhcp-128-65.nay.redhat.com>
References: <1450914903-5793-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1450914903-5793-5-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1450914903-5793-5-git-send-email-zohar@linux.vnet.ibm.com>
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
Cc: "Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, linux-ima-devel@lists.sourceforge.net, David Woodhouse <dwmw2@infradead.org>, Vivek Goyal <vgoyal@redhat.com>

Hi, Mimi

CCing kexec list, not all kexec people subscribed to IMA list.
I just subscribed to it since Vivek CCed me last time about the V1 of this
series.

On 12/23/15 at 06:55pm, Mimi Zohar wrote:
> This patch defines a new IMA hook ima_hash_and_process_file() for
> measuring and appraising files read by the kernel.  The caller loads
> the file into memory before calling this function, which calculates
> the hash followed by the normal IMA policy based processing.
> 
> Two new IMA policy functions named KEXEC_CHECK and INITRAMFS_CHECK
> are defined for measuring, appraising or auditing the kexec image
> and initramfs.

Could you help us understand why do we need it first.

I think I do not really understand the purpose of the IMA handling
about kexec kernel and initramfs.

* Does the files in disk space have already contains some hash values 
and when kernel load it IMA functions will do some checking? But seems I do not
see such handling..

* Does it try to calculate the hash of the file buffer after copying,
and IMA will avoid future modification based on the hash calculated?
If this is the purpose I think it should be wrong because kexe file buffers  
will be freed at the end of kexec_file_load syscall.

> 
> Changelog v2:
> - Calculate the file hash from the in memory buffer (suggested by Dave Young)
> - Rename ima_read_and_process_file() to ima_hash_and_process_file()
> - replace individual case statements with range:
> 	KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1
> v1:
> - Instead of ima_read_and_process_file() allocating memory, the caller
> allocates and frees the memory.
> - Moved the kexec measurement/appraisal call to copy_file_from_fd(). The
> same call now measures and appraises both the kexec image and initramfs.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  Documentation/ABI/testing/ima_policy  |  2 +-
>  include/linux/ima.h                   | 16 ++++++++++++++
>  kernel/kexec_file.c                   | 24 ++++++++++++--------
>  security/integrity/iint.c             |  1 +
>  security/integrity/ima/ima.h          | 21 ++++++++++++------
>  security/integrity/ima/ima_api.c      |  6 +++--
>  security/integrity/ima/ima_appraise.c | 11 ++++++++--
>  security/integrity/ima/ima_main.c     | 41 ++++++++++++++++++++++++++++-------
>  security/integrity/ima/ima_policy.c   | 38 ++++++++++++++++++++++++--------
>  security/integrity/integrity.h        |  7 ++++--
>  10 files changed, 127 insertions(+), 40 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 0a378a8..e80f767 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -26,7 +26,7 @@ Description:
>  			option:	[[appraise_type=]] [permit_directio]
>  
>  		base: 	func:= [BPRM_CHECK][MMAP_CHECK][FILE_CHECK][MODULE_CHECK]
> -				[FIRMWARE_CHECK]
> +				[FIRMWARE_CHECK] [KEXEC_CHECK] [INITRAMFS_CHECK]
>  			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
>  			       [[^]MAY_EXEC]
>  			fsmagic:= hex value
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 120ccc5..020de0f 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -13,6 +13,12 @@
>  #include <linux/fs.h>
>  struct linux_binprm;
>  
> +enum ima_read_hooks {
> +	KEXEC_CHECK = 1,
> +	INITRAMFS_CHECK,
> +	IMA_MAX_READ_CHECK
> +};
> +
>  #ifdef CONFIG_IMA
>  extern int ima_bprm_check(struct linux_binprm *bprm);
>  extern int ima_file_check(struct file *file, int mask, int opened);
> @@ -20,6 +26,9 @@ extern void ima_file_free(struct file *file);
>  extern int ima_file_mmap(struct file *file, unsigned long prot);
>  extern int ima_module_check(struct file *file);
>  extern int ima_fw_from_file(struct file *file, char *buf, size_t size);
> +extern int ima_hash_and_process_file(struct file *file,
> +				     void *buf, size_t size,
> +				     enum ima_read_hooks read_func);
>  
>  #else
>  static inline int ima_bprm_check(struct linux_binprm *bprm)
> @@ -52,6 +61,13 @@ static inline int ima_fw_from_file(struct file *file, char *buf, size_t size)
>  	return 0;
>  }
>  
> +static inline int ima_hash_and_process_file(struct file *file,
> +					    void *buf, size_t size,
> +					    enum ima_read_hooks read_func)
> +{
> +	return 0;
> +}
> +
>  #endif /* CONFIG_IMA */
>  
>  #ifdef CONFIG_IMA_APPRAISE
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index b70ada0..1d0d998 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -18,6 +18,7 @@
>  #include <linux/kexec.h>
>  #include <linux/mutex.h>
>  #include <linux/list.h>
> +#include <linux/ima.h>
>  #include <crypto/hash.h>
>  #include <crypto/sha.h>
>  #include <linux/syscalls.h>
> @@ -33,7 +34,8 @@ size_t __weak kexec_purgatory_size = 0;
>  
>  static int kexec_calculate_store_digests(struct kimage *image);
>  
> -static int copy_file_from_fd(int fd, void **buf, unsigned long *buf_len)
> +static int copy_file_from_fd(int fd, void **buf, unsigned long *buf_len,
> +			     enum ima_read_hooks read_func)
>  {
>  	struct fd f = fdget(fd);
>  	int ret;
> @@ -70,9 +72,8 @@ static int copy_file_from_fd(int fd, void **buf, unsigned long *buf_len)
>  		bytes = kernel_read(f.file, pos, (char *)(*buf) + pos,
>  				    stat.size - pos);
>  		if (bytes < 0) {
> -			vfree(*buf);
>  			ret = bytes;
> -			goto out;
> +			goto out_free;
>  		}
>  
>  		if (bytes == 0)
> @@ -80,13 +81,17 @@ static int copy_file_from_fd(int fd, void **buf, unsigned long *buf_len)
>  		pos += bytes;
>  	}
>  
> -	if (pos != stat.size) {
> +	if (pos != stat.size)
>  		ret = -EBADF;
> +
> +	ret = ima_hash_and_process_file(f.file, *buf, stat.size, read_func);
> +	if (!ret)
> +		*buf_len = pos;
> +out_free:
> +	if (ret < 0) {
>  		vfree(*buf);
> -		goto out;
> +		*buf = NULL;
>  	}
> -
> -	*buf_len = pos;
>  out:
>  	fdput(f);
>  	return ret;
> @@ -182,7 +187,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  	void *ldata;
>  
>  	ret = copy_file_from_fd(kernel_fd, &image->kernel_buf,
> -				&image->kernel_buf_len);
> +				&image->kernel_buf_len, KEXEC_CHECK);
>  	if (ret)
>  		return ret;
>  
> @@ -205,7 +210,8 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  	/* It is possible that there no initramfs is being loaded */
>  	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
>  		ret = copy_file_from_fd(initrd_fd, &image->initrd_buf,
> -					&image->initrd_buf_len);
> +					&image->initrd_buf_len,
> +					INITRAMFS_CHECK);
>  		if (ret)
>  			goto out;
>  	}
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 54b51a4..8a45576 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -158,6 +158,7 @@ static void init_once(void *foo)
>  	iint->ima_mmap_status = INTEGRITY_UNKNOWN;
>  	iint->ima_bprm_status = INTEGRITY_UNKNOWN;
>  	iint->ima_module_status = INTEGRITY_UNKNOWN;
> +	iint->ima_read_status = INTEGRITY_UNKNOWN;
>  	iint->evm_status = INTEGRITY_UNKNOWN;
>  }
>  
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index e3a5b7b..fa801fa 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -20,6 +20,7 @@
>  #include <linux/types.h>
>  #include <linux/crypto.h>
>  #include <linux/security.h>
> +#include <linux/ima.h>
>  #include <linux/hash.h>
>  #include <linux/tpm.h>
>  #include <linux/audit.h>
> @@ -143,7 +144,8 @@ static inline unsigned long ima_hash_key(u8 *digest)
>  int ima_get_action(struct inode *inode, int mask, int function);
>  int ima_must_measure(struct inode *inode, int mask, int function);
>  int ima_collect_measurement(struct integrity_iint_cache *iint,
> -			    struct file *file, enum hash_algo algo);
> +			    struct file *file, void *buf, size_t buf_len,
> +			    enum hash_algo algo);
>  void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
>  			   const unsigned char *filename,
>  			   struct evm_ima_xattr_data *xattr_value,
> @@ -158,10 +160,16 @@ void ima_free_template_entry(struct ima_template_entry *entry);
>  const char *ima_d_path(struct path *path, char **pathbuf);
>  
>  /* IMA policy related functions */
> -enum ima_hooks { FILE_CHECK = 1, MMAP_CHECK, BPRM_CHECK, MODULE_CHECK, FIRMWARE_CHECK, POST_SETATTR };
> +enum ima_hooks {
> +	FILE_CHECK = IMA_MAX_READ_CHECK,
> +	MMAP_CHECK,
> +	BPRM_CHECK,
> +	MODULE_CHECK,
> +	FIRMWARE_CHECK,
> +	POST_SETATTR
> +};
>  
> -int ima_match_policy(struct inode *inode, enum ima_hooks func, int mask,
> -		     int flags);
> +int ima_match_policy(struct inode *inode, int func, int mask, int flags);
>  void ima_init_policy(void);
>  void ima_update_policy(void);
>  void ima_update_policy_flag(void);
> @@ -184,7 +192,7 @@ int ima_appraise_measurement(int func, struct integrity_iint_cache *iint,
>  			     struct file *file, const unsigned char *filename,
>  			     struct evm_ima_xattr_data *xattr_value,
>  			     int xattr_len, int opened);
> -int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func);
> +int ima_must_appraise(struct inode *inode, int mask, int func);
>  void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file);
>  enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
>  					   int func);
> @@ -204,8 +212,7 @@ static inline int ima_appraise_measurement(int func,
>  	return INTEGRITY_UNKNOWN;
>  }
>  
> -static inline int ima_must_appraise(struct inode *inode, int mask,
> -				    enum ima_hooks func)
> +static inline int ima_must_appraise(struct inode *inode, int mask, int func)
>  {
>  	return 0;
>  }
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index e7c7a5d..f3a5b0b 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -188,7 +188,8 @@ int ima_get_action(struct inode *inode, int mask, int function)
>   * Return 0 on success, error code otherwise
>   */
>  int ima_collect_measurement(struct integrity_iint_cache *iint,
> -			    struct file *file, enum hash_algo algo)
> +			    struct file *file, void *buf, unsigned long buf_len,
> +			    enum hash_algo algo)
>  {
>  	const char *audit_cause = "failed";
>  	struct inode *inode = file_inode(file);
> @@ -210,7 +211,8 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
>  
>  		hash.hdr.algo = algo;
>  
> -		result = ima_calc_file_hash(file, &hash.hdr);
> +		result = (!buf) ?  ima_calc_file_hash(file, &hash.hdr) :
> +			ima_calc_buffer_hash(buf, buf_len, &hash.hdr);
>  		if (!result) {
>  			int length = sizeof(hash.hdr) + hash.hdr.length;
>  			void *tmpbuf = krealloc(iint->ima_hash, length,
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 9c2b46b..3adf937 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -36,7 +36,7 @@ __setup("ima_appraise=", default_appraise_setup);
>   *
>   * Return 1 to appraise
>   */
> -int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
> +int ima_must_appraise(struct inode *inode, int mask, int func)
>  {
>  	if (!ima_appraise)
>  		return 0;
> @@ -78,6 +78,8 @@ enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
>  		return iint->ima_module_status;
>  	case FIRMWARE_CHECK:
>  		return iint->ima_firmware_status;
> +	case KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1:
> +		return iint->ima_read_status;
>  	case FILE_CHECK:
>  	default:
>  		return iint->ima_file_status;
> @@ -100,6 +102,9 @@ static void ima_set_cache_status(struct integrity_iint_cache *iint,
>  	case FIRMWARE_CHECK:
>  		iint->ima_firmware_status = status;
>  		break;
> +	case KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1:
> +		iint->ima_read_status = status;
> +		break;
>  	case FILE_CHECK:
>  	default:
>  		iint->ima_file_status = status;
> @@ -122,6 +127,8 @@ static void ima_cache_flags(struct integrity_iint_cache *iint, int func)
>  	case FIRMWARE_CHECK:
>  		iint->flags |= (IMA_FIRMWARE_APPRAISED | IMA_APPRAISED);
>  		break;
> +	case KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1:
> +		break;
>  	case FILE_CHECK:
>  	default:
>  		iint->flags |= (IMA_FILE_APPRAISED | IMA_APPRAISED);
> @@ -299,7 +306,7 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
>  	if (iint->flags & IMA_DIGSIG)
>  		return;
>  
> -	rc = ima_collect_measurement(iint, file, ima_hash_algo);
> +	rc = ima_collect_measurement(iint, file, NULL, 0, ima_hash_algo);
>  	if (rc < 0)
>  		return;
>  
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index d9fc463..cd9c576 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -153,8 +153,8 @@ void ima_file_free(struct file *file)
>  	ima_check_last_writer(iint, inode, file);
>  }
>  
> -static int process_measurement(struct file *file, int mask, int function,
> -			       int opened)
> +static int process_measurement(struct file *file, char *buf, size_t buf_len,
> +			       int mask, int function, int opened)
>  {
>  	struct inode *inode = file_inode(file);
>  	struct integrity_iint_cache *iint = NULL;
> @@ -226,7 +226,7 @@ static int process_measurement(struct file *file, int mask, int function,
>  
>  	hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
>  
> -	rc = ima_collect_measurement(iint, file, hash_algo);
> +	rc = ima_collect_measurement(iint, file, buf, buf_len, hash_algo);
>  	if (rc != 0) {
>  		if (file->f_flags & O_DIRECT)
>  			rc = (iint->flags & IMA_PERMIT_DIRECTIO) ? 0 : -EACCES;
> @@ -273,7 +273,8 @@ out:
>  int ima_file_mmap(struct file *file, unsigned long prot)
>  {
>  	if (file && (prot & PROT_EXEC))
> -		return process_measurement(file, MAY_EXEC, MMAP_CHECK, 0);
> +		return process_measurement(file, NULL, 0, MAY_EXEC,
> +					   MMAP_CHECK, 0);
>  	return 0;
>  }
>  
> @@ -292,7 +293,8 @@ int ima_file_mmap(struct file *file, unsigned long prot)
>   */
>  int ima_bprm_check(struct linux_binprm *bprm)
>  {
> -	return process_measurement(bprm->file, MAY_EXEC, BPRM_CHECK, 0);
> +	return process_measurement(bprm->file, NULL, 0, MAY_EXEC,
> +				   BPRM_CHECK, 0);
>  }
>  
>  /**
> @@ -307,7 +309,7 @@ int ima_bprm_check(struct linux_binprm *bprm)
>   */
>  int ima_file_check(struct file *file, int mask, int opened)
>  {
> -	return process_measurement(file,
> +	return process_measurement(file, NULL, 0,
>  				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC),
>  				   FILE_CHECK, opened);
>  }
> @@ -332,7 +334,7 @@ int ima_module_check(struct file *file)
>  #endif
>  		return 0;	/* We rely on module signature checking */
>  	}
> -	return process_measurement(file, MAY_EXEC, MODULE_CHECK, 0);
> +	return process_measurement(file, NULL, 0, MAY_EXEC, MODULE_CHECK, 0);
>  }
>  
>  int ima_fw_from_file(struct file *file, char *buf, size_t size)
> @@ -343,7 +345,30 @@ int ima_fw_from_file(struct file *file, char *buf, size_t size)
>  			return -EACCES;	/* INTEGRITY_UNKNOWN */
>  		return 0;
>  	}
> -	return process_measurement(file, MAY_EXEC, FIRMWARE_CHECK, 0);
> +	return process_measurement(file, NULL, 0, MAY_EXEC, FIRMWARE_CHECK, 0);
> +}
> +
> +/**
> + * ima_hash_and_process_file - in memory collect/appraise/audit measurement
> + * @file: pointer to the file to be measured/appraised/audit
> + * @buf: pointer to in memory file contents
> + * @buf_len: size of in memory file contents
> + * @read_func: caller identifier
> + *
> + * Measure/appraise/audit in memory file based on policy.  Policy rules
> + * are written in terms of the read_func identifier (eg. KEXEC_CHECK,
> + * INITRAMFS_CHECK)
> + */
> +int ima_hash_and_process_file(struct file *file, void *buf, size_t buf_len,
> +			      enum ima_read_hooks read_func)
> +{
> +	if (!file || !buf || buf_len == 0) { /* should never happen */
> +		if (ima_appraise & IMA_APPRAISE_ENFORCE)
> +			return -EACCES;
> +		return 0;
> +	}
> +
> +	return process_measurement(file, buf, buf_len, MAY_READ, read_func, 0);
>  }
>  
>  static int __init init_ima(void)
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index ba5d2fc..26e24df 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -53,7 +53,10 @@ struct ima_rule_entry {
>  	struct list_head list;
>  	int action;
>  	unsigned int flags;
> -	enum ima_hooks func;
> +	union {
> +		enum ima_hooks func;
> +		enum ima_read_hooks read_func;
> +	};
>  	int mask;
>  	unsigned long fsmagic;
>  	u8 fsuuid[16];
> @@ -208,7 +211,7 @@ static void ima_lsm_update_rules(void)
>   * Returns true on rule match, false on failure.
>   */
>  static bool ima_match_rules(struct ima_rule_entry *rule,
> -			    struct inode *inode, enum ima_hooks func, int mask)
> +			    struct inode *inode, int func, int mask)
>  {
>  	struct task_struct *tsk = current;
>  	const struct cred *cred = current_cred();
> @@ -303,6 +306,8 @@ static int get_subaction(struct ima_rule_entry *rule, int func)
>  		return IMA_MODULE_APPRAISE;
>  	case FIRMWARE_CHECK:
>  		return IMA_FIRMWARE_APPRAISE;
> +	case KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1:
> +		return IMA_READ_APPRAISE;
>  	case FILE_CHECK:
>  	default:
>  		return IMA_FILE_APPRAISE;
> @@ -322,8 +327,7 @@ static int get_subaction(struct ima_rule_entry *rule, int func)
>   * list when walking it.  Reads are many orders of magnitude more numerous
>   * than writes so ima_match_policy() is classical RCU candidate.
>   */
> -int ima_match_policy(struct inode *inode, enum ima_hooks func, int mask,
> -		     int flags)
> +int ima_match_policy(struct inode *inode, int func, int mask, int flags)
>  {
>  	struct ima_rule_entry *entry;
>  	int action = 0, actmask = flags | (flags << 1);
> @@ -604,6 +608,10 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  				entry->func = MMAP_CHECK;
>  			else if (strcmp(args[0].from, "BPRM_CHECK") == 0)
>  				entry->func = BPRM_CHECK;
> +			else if (strcmp(args[0].from, "KEXEC_CHECK") == 0)
> +				entry->read_func = KEXEC_CHECK;
> +			else if (strcmp(args[0].from, "INITRAMFS_CHECK") == 0)
> +				entry->read_func = INITRAMFS_CHECK;
>  			else
>  				result = -EINVAL;
>  			if (!result)
> @@ -847,7 +855,8 @@ static char *mask_tokens[] = {
>  
>  enum {
>  	func_file = 0, func_mmap, func_bprm,
> -	func_module, func_firmware, func_post
> +	func_module, func_firmware, func_post,
> +	func_kexec, func_initramfs
>  };
>  
>  static char *func_tokens[] = {
> @@ -856,7 +865,9 @@ static char *func_tokens[] = {
>  	"BPRM_CHECK",
>  	"MODULE_CHECK",
>  	"FIRMWARE_CHECK",
> -	"POST_SETATTR"
> +	"POST_SETATTR",
> +	"KEXEC_CHECK",
> +	"INITRAMFS_CHECK",
>  };
>  
>  void *ima_policy_start(struct seq_file *m, loff_t *pos)
> @@ -937,9 +948,18 @@ int ima_policy_show(struct seq_file *m, void *v)
>  			seq_printf(m, pt(Opt_func), ft(func_post));
>  			break;
>  		default:
> -			snprintf(tbuf, sizeof(tbuf), "%d", entry->func);
> -			seq_printf(m, pt(Opt_func), tbuf);
> -			break;
> +			switch (entry->read_func) {
> +			case KEXEC_CHECK:
> +				seq_printf(m, pt(Opt_func), ft(func_kexec));
> +				break;
> +			case INITRAMFS_CHECK:
> +				seq_printf(m, pt(Opt_func), ft(func_initramfs));
> +				break;
> +			default:
> +				snprintf(tbuf, sizeof(tbuf), "%d", entry->func);
> +				seq_printf(m, pt(Opt_func), tbuf);
> +				break;
> +			}
>  		}
>  		seq_puts(m, " ");
>  	}
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 5413f22..645d5be 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -49,12 +49,14 @@
>  #define IMA_MODULE_APPRAISED	0x00008000
>  #define IMA_FIRMWARE_APPRAISE	0x00010000
>  #define IMA_FIRMWARE_APPRAISED	0x00020000
> +#define IMA_READ_APPRAISE	0x00040000
> +#define IMA_READ_APPRAISED	0x00080000
>  #define IMA_APPRAISE_SUBMASK	(IMA_FILE_APPRAISE | IMA_MMAP_APPRAISE | \
>  				 IMA_BPRM_APPRAISE | IMA_MODULE_APPRAISE | \
> -				 IMA_FIRMWARE_APPRAISE)
> +				 IMA_FIRMWARE_APPRAISE | IMA_READ_APPRAISE)
>  #define IMA_APPRAISED_SUBMASK	(IMA_FILE_APPRAISED | IMA_MMAP_APPRAISED | \
>  				 IMA_BPRM_APPRAISED | IMA_MODULE_APPRAISED | \
> -				 IMA_FIRMWARE_APPRAISED)
> +				 IMA_FIRMWARE_APPRAISED | IMA_READ_APPRAISED)
>  
>  enum evm_ima_xattr_type {
>  	IMA_XATTR_DIGEST = 0x01,
> @@ -111,6 +113,7 @@ struct integrity_iint_cache {
>  	enum integrity_status ima_bprm_status:4;
>  	enum integrity_status ima_module_status:4;
>  	enum integrity_status ima_firmware_status:4;
> +	enum integrity_status ima_read_status:4;
>  	enum integrity_status evm_status:4;
>  	struct ima_digest_data *ima_hash;
>  };
> -- 
> 2.1.0
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-ima-devel mailing list
> Linux-ima-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-ima-devel

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
