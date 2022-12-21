Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B57DC4332F
	for <kexec@archiver.kernel.org>; Wed, 21 Dec 2022 00:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z3KusFNHsYFwkfi/cGwR5g0lUwRiYjSBTx153fMsVdQ=; b=z7JIMES1CK8uDS
	xnNn9F94oyS7eZWTxm9xkthjSJ8LplBxiCX7ypPsHqcNJuQZKkLA+1eu7R8+WCrWrVVyDeZ464WYA
	8EmvC8MSFdPJcJCp/Vwd/neb5/A/ynaKlOOZsxAHOshuCGf4HQI82+1MSgJr8E9VsBlBE/8a6/bSc
	myRtPECZL6jveIZwKyOh87x5/u7BuujKY0FPg24gDcDIYo6wn3ALDuZvKTCzQiwW6F2ld8zoXlfNp
	6PX0DvfJGbowxkf8u16leK8FJbi/frgUUEVrB/CVnXArpMjfg/HbcmblAEGUFbfzwdO910dZ5f5sC
	saGg/fs/yNTphKE18/kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7msE-006LqM-GH; Wed, 21 Dec 2022 00:22:18 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7msB-006Lmt-66
	for kexec@lists.infradead.org; Wed, 21 Dec 2022 00:22:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9AA0661655;
	Wed, 21 Dec 2022 00:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA947C433EF;
	Wed, 21 Dec 2022 00:22:09 +0000 (UTC)
Date: Tue, 20 Dec 2022 19:22:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCH v3 3/3] kexec: Introduce parameters load_limit_reboot
 and load_limit_panic
Message-ID: <20221220192208.4d0c934f@gandalf.local.home>
In-Reply-To: <20221114-disable-kexec-reset-v3-3-4ef4e929adf6@chromium.org>
References: <20221114-disable-kexec-reset-v3-0-4ef4e929adf6@chromium.org>
	<20221114-disable-kexec-reset-v3-3-4ef4e929adf6@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221220_162215_358267_0ADD81E0 
X-CRM114-Status: GOOD (  39.49  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: Jonathan Corbet <corbet@lwn.net>, Philipp Rudo <prudo@redhat.com>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>, Eric Biederman <ebiederm@xmission.com>, Ross Zwisler <zwisler@kernel.org>, "Joel Fernandes
 \(Google\)" <joel@joelfernandes.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, 20 Dec 2022 23:05:45 +0100
Ricardo Ribalda <ribalda@chromium.org> wrote:

I hate to be the grammar police, but..

> Add two parameter to specify how many times a kexec kernel can be loaded.

   "parameters"

> 
> The sysadmin can set different limits for kexec panic and kexec reboot
> kernels.
> 
> The value can be modified at runtime via sysfs, but only with a value
> smaller than the current one (except -1).
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 14 ++++
>  include/linux/kexec.h                           |  2 +-
>  kernel/kexec.c                                  |  2 +-
>  kernel/kexec_core.c                             | 91 ++++++++++++++++++++++++-
>  kernel/kexec_file.c                             |  2 +-
>  5 files changed, 106 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 42af9ca0127e..2b37d6a20747 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2374,6 +2374,20 @@
>  			for Movable pages.  "nn[KMGTPE]", "nn%", and "mirror"
>  			are exclusive, so you cannot specify multiple forms.
>  
> +	kexec_core.load_limit_reboot=
> +	kexec_core.load_limit_panic=
> +			[KNL]
> +			This parameter specifies a limit to the number of times
> +			a kexec kernel can be loaded.
> +			Format: <int>
> +			-1  = Unlimited.
> +			int = Number of times kexec can be called.
> +
> +			During runtime, this parameter can be modified with a

> +			value smaller than the current one (but not -1).

Perhaps state:
			smaller positive value than the current one or if
			current is currently -1.

> +
> +			Default: -1
> +
>  	kgdbdbgp=	[KGDB,HW] kgdb over EHCI usb debug port.
>  			Format: <Controller#>[,poll interval]
>  			The controller # is the number of the ehci usb debug
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 182e0c11b87b..5daf9990d5b8 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -407,7 +407,7 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
>  extern struct kimage *kexec_image;
>  extern struct kimage *kexec_crash_image;
>  
> -bool kexec_load_permitted(void);
> +bool kexec_load_permitted(bool crash_image);
>  
>  #ifndef kexec_flush_icache_page
>  #define kexec_flush_icache_page(page)
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index ce1bca874a8d..7aefd134e319 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -193,7 +193,7 @@ static inline int kexec_load_check(unsigned long nr_segments,
>  	int result;
>  
>  	/* We only trust the superuser with rebooting the system. */
> -	if (!kexec_load_permitted())
> +	if (!kexec_load_permitted(flags & KEXEC_ON_CRASH))

Note, here we have KEXEC_ON_CRASH (see bottom).

>  		return -EPERM;
>  
>  	/* Permit LSMs and IMA to fail the kexec */
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index a1efc70f4158..adf71f2be3ff 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -952,13 +952,100 @@ static int __init kexec_core_sysctl_init(void)
>  late_initcall(kexec_core_sysctl_init);
>  #endif
>  
> -bool kexec_load_permitted(void)
> +struct kexec_load_limit {
> +	/* Mutex protects the limit count. */
> +	struct mutex mutex;
> +	int limit;
> +};
> +
> +struct kexec_load_limit load_limit_reboot = {

Perhaps make the above static?

> +	.mutex = __MUTEX_INITIALIZER(load_limit_reboot.mutex),
> +	.limit = -1,
> +};
> +
> +struct kexec_load_limit load_limit_panic = {

static?

> +	.mutex = __MUTEX_INITIALIZER(load_limit_panic.mutex),
> +	.limit = -1,
> +};
> +
> +static int param_get_limit(char *buffer, const struct kernel_param *kp)
>  {
> +	int ret;
> +	struct kexec_load_limit *limit = kp->arg;

Looks better if "int ret;" is after the "limit".

> +
> +	mutex_lock(&limit->mutex);
> +	ret = scnprintf(buffer, PAGE_SIZE, "%i\n", limit->limit);

The above string can be at most "-2147483648\n\0"

Which is 13 characters. Why use PAGE_SIZE. Or scnprintf(), and not just
state:

	/* buffer is PAGE_SIZE, much larger than what %i can be */
	ret = sprintf(buffer, "%i\n", limit->limit);

> +	mutex_unlock(&limit->mutex);
> +
> +	return ret;
> +}
> +
> +static int param_set_limit(const char *buffer, const struct kernel_param *kp)
> +{
> +	int ret;
> +	struct kexec_load_limit *limit = kp->arg;
> +	int new_val;
> +
> +	ret = kstrtoint(buffer, 0, &new_val);
> +	if (ret)
> +		return ret;
> +
> +	new_val = max(-1, new_val);

I wonder if anything less than -1 should be invalid.

> +
> +	mutex_lock(&limit->mutex);
> +
> +	if (new_val == -1 && limit->limit != -1) {

If -1 can't change the value, why allow it to be passed in to begin with.

Perhaps we should only allow sysctl to set positive values? Would make the
code simpler.

> +		ret = -EINVAL;
> +		goto done;
> +	}
> +
> +	if (limit->limit != -1 && new_val > limit->limit) {

Since the above documentation said "small than" perhaps ">="?

> +		ret = -EINVAL;
> +		goto done;
> +	}
> +
> +	limit->limit = new_val;
> +
> +done:
> +	mutex_unlock(&limit->mutex);
> +
> +	return ret;
> +}
> +
> +static const struct kernel_param_ops load_limit_ops = {
> +	.get = param_get_limit,
> +	.set = param_set_limit,
> +};
> +
> +module_param_cb(load_limit_reboot, &load_limit_ops, &load_limit_reboot, 0644);
> +MODULE_PARM_DESC(load_limit_reboot, "Maximum attempts to load a kexec reboot kernel");
> +
> +module_param_cb(load_limit_panic, &load_limit_ops, &load_limit_panic, 0644);
> +MODULE_PARM_DESC(load_limit_reboot, "Maximum attempts to load a kexec panic kernel");

Wait, why the module params if this can not be a module?

The kernel/kexec.c is decided via CONFIG_KEXEC_CORE which is bool. Either
builtin or not at all. No module selection possible.

For kernel parameters, we should just use __setup(), right?

> +
> +bool kexec_load_permitted(bool crash_image)
> +{
> +	struct kexec_load_limit *limit;
> +
>  	/*
>  	 * Only the superuser can use the kexec syscall and if it has not
>  	 * been disabled.
>  	 */
> -	return capable(CAP_SYS_BOOT) && !kexec_load_disabled;
> +	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
> +		return false;
> +
> +	/* Check limit counter and decrease it.*/
> +	limit = crash_image ? &load_limit_panic : &load_limit_reboot;
> +	mutex_lock(&limit->mutex);
> +	if (!limit->limit) {
> +		mutex_unlock(&limit->mutex);
> +		return false;
> +	}
> +	if (limit->limit != -1)
> +		limit->limit--;
> +	mutex_unlock(&limit->mutex);
> +
> +	return true;
>  }
>  
>  /*
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 29efa43ea951..6a1d4b07635e 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -330,7 +330,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  	struct kimage **dest_image, *image;
>  
>  	/* We only trust the superuser with rebooting the system. */
> -	if (!kexec_load_permitted())
> +	if (!kexec_load_permitted(flags & KEXEC_FILE_FLAGS))

Here we have KEXEC_FILE_FLAGS, where above it was KEXCE_FILE_CRASH.

This is confusing to what denotes the "crash_image" boolean. Can we just
pass in flags and figure it out in the kexec_load_permitted() function?

-- Steve


>  		return -EPERM;
>  
>  	/* Make sure we have a legal set of flags */
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
