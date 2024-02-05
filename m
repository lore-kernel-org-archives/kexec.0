Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C63AC48286
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 03:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8DMnXzaT67O2FCJG0i4gyU1ABog0RH1b5TPcTd4qStM=; b=ogXD9FoIKYUuSz
	4hKp1pO/oqZT0OPpzD7UEutpHDDo6nTAnaw6eZu+V/qgUca6Tum5/MNgS+jzfvFxVb46V34F9g3m6
	l+7SNaNW587Tyo067/bX4oEOISb5DkS2t4Kf3ZSw5syb+9kISqO92LOikz9HS3j66wrMG5iBYmRbp
	5kf90HyBCC7LPF2cDlQVF4z9saGmw6F8TNBs/Q4xzLpjglJXpyGkX4L9BMSWUKcM77egIEO/U8jxJ
	ZhrEua6/6pYs793Rok1t/6Y9XAPp5t20KL9RVrnuE4bO3ech0bMBSmATtoz247AQ5mW5erJD9L90j
	rernnrGpdsIxWNlkt/HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWpNT-00000001tL2-0eJx;
	Mon, 05 Feb 2024 03:10:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWpNQ-00000001tJu-0D2q
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 03:10:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707102625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qivc//1MsMgLC1+oQSLS/D2iPWYIjtk7dnlMmFMvk7w=;
	b=hsLpNFKS+TMGTA5YLQ4lvLs2oGQkyBjOF99KL1pmEcGaR9dPbBk+EPBfVHp4sGFH8ieco5
	f5WI4VEMPAe9Wm1Pi2VvvMUn4CZ3mtUYGBiwFFqs5nJXbmmYAXD0mn+mBSgA1wkAP84dFp
	gc4xUYxp08sc0gy7ec8gvnM+ftHX5LA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-EbFoXx9iN9esLaMZ7WX1uA-1; Sun, 04 Feb 2024 22:10:19 -0500
X-MC-Unique: EbFoXx9iN9esLaMZ7WX1uA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B078285A589;
	Mon,  5 Feb 2024 03:10:18 +0000 (UTC)
Received: from localhost (unknown [10.72.116.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 155841C060AF;
	Mon,  5 Feb 2024 03:10:17 +0000 (UTC)
Date: Mon, 5 Feb 2024 11:10:13 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Akhil Raj <lf32.dev@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Young <dyoung@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Laurent Dufour <laurent.dufour@fr.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mimi Zohar <zohar@linux.ibm.com>, Naveen N Rao <naveen@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
	x86@kernel.org
Subject: Re: [PATCH v15 2/5] crash: add a new kexec flag for hotplug support
Message-ID: <ZcBRle7szFrD3cW+@MiWiFi-R3L-srv>
References: <20240111105138.251366-1-sourabhjain@linux.ibm.com>
 <20240111105138.251366-3-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20240111105138.251366-3-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240204_191032_175207_DCE24519 
X-CRM114-Status: GOOD (  31.78  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Sourabh,

Thanks for the great work. There are some concerns, please see inline
comments.

On 01/11/24 at 04:21pm, Sourabh Jain wrote:
......
> Now, if the kexec tool sends KEXEC_CRASH_HOTPLUG_SUPPORT kexec flag to
> the kernel, it indicates to the kernel that all the required kexec
> segment is skipped from SHA calculation and it is safe to update kdump
> image loaded using the kexec_load syscall.

So finally you add a new KEXEC_CRASH_HOTPLUG_SUPPORT flag, that's fine.

> 
...... 
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index 9bb6607e864e..e791129fdf6c 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -211,6 +211,9 @@ extern void kdump_nmi_shootdown_cpus(void);
>  void arch_crash_handle_hotplug_event(struct kimage *image, void *arg);
>  #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
>  
> +int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags);
> +#define arch_crash_hotplug_support arch_crash_hotplug_support
> +
>  #ifdef CONFIG_HOTPLUG_CPU
>  int arch_crash_hotplug_cpu_support(void);
>  #define crash_hotplug_cpu_support arch_crash_hotplug_cpu_support

Then crash_hotplug_cpu_support is not needed any more on x86_64, and
crash_hotplug_memory_support(), if you remove their implementation in
arch/x86/kernel/crash.c, won't it cause building warning or error on x86?

> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 44744e9c68ec..293b54bff706 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -398,20 +398,16 @@ int crash_load_segments(struct kimage *image)
>  #undef pr_fmt
>  #define pr_fmt(fmt) "crash hp: " fmt
>  
> -/* These functions provide the value for the sysfs crash_hotplug nodes */
> -#ifdef CONFIG_HOTPLUG_CPU
> -int arch_crash_hotplug_cpu_support(void)
> +int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags)
>  {
> -	return crash_check_update_elfcorehdr();
> -}
> -#endif
>  
> -#ifdef CONFIG_MEMORY_HOTPLUG
> -int arch_crash_hotplug_memory_support(void)
> -{
> -	return crash_check_update_elfcorehdr();
> -}
> +#ifdef CONFIG_KEXEC_FILE
> +	if (image->file_mode)
> +		return 1;
>  #endif
> +	return (kexec_flags & KEXEC_UPDATE_ELFCOREHDR ||
> +		kexec_flags & KEXEC_CRASH_HOTPLUG_SUPPORT);

Do we need add some document to tell why there are two kexec flags on
x86_64, except of checking this patch log?

> +}
>  
>  unsigned int arch_crash_get_elfcorehdr_size(void)
>  {
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 548491de818e..2f411ddfbd8b 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -306,7 +306,7 @@ static ssize_t crash_hotplug_show(struct device *dev,
>  				     struct device_attribute *attr,
>  				     char *buf)
>  {
> -	return sysfs_emit(buf, "%d\n", crash_hotplug_cpu_support());
> +	return sysfs_emit(buf, "%d\n", crash_check_hotplug_support());
>  }
>  static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
>  #endif
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 8a13babd826c..e70ab1d3428e 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -514,7 +514,7 @@ static DEVICE_ATTR_RW(auto_online_blocks);
>  static ssize_t crash_hotplug_show(struct device *dev,
>  				       struct device_attribute *attr, char *buf)
>  {
> -	return sysfs_emit(buf, "%d\n", crash_hotplug_memory_support());
> +	return sysfs_emit(buf, "%d\n", crash_check_hotplug_support());
>  }
>  static DEVICE_ATTR_RO(crash_hotplug);
>  #endif
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 802052d9c64b..7880d74dc5c4 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -317,8 +317,8 @@ struct kimage {
>  	/* If set, we are using file mode kexec syscall */
>  	unsigned int file_mode:1;
>  #ifdef CONFIG_CRASH_HOTPLUG
> -	/* If set, allow changes to elfcorehdr of kexec_load'd image */
> -	unsigned int update_elfcorehdr:1;
> +	/* If set, allow changes to kexec segments of kexec_load'd image */

The code comment doesn't reflect the usage of the flag. You set it too
when it's kexec_file_load. Speaking of this, I do wonder why you need
set it too for kexec_file_load, and why we have
arch_crash_hotplug_support(), then crash_check_hotplug_support() both of
which have the same effect.

> +	unsigned int hotplug_support:1;
>  #endif
>  
>  #ifdef ARCH_HAS_KIMAGE_ARCH
> @@ -396,9 +396,10 @@ bool kexec_load_permitted(int kexec_image_type);
>  
>  /* List of defined/legal kexec flags */
>  #ifndef CONFIG_KEXEC_JUMP
> -#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR)
> +#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR | KEXEC_CRASH_HOTPLUG_SUPPORT)
>  #else
> -#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR)
> +#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR | \
> +			KEXEC_CRASH_HOTPLUG_SUPPORT)
>  #endif
>  
>  /* List of defined/legal kexec file flags */
> @@ -486,14 +487,18 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
>  static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
>  #endif
>  
> -int crash_check_update_elfcorehdr(void);
> +int crash_check_hotplug_support(void);
>  
> -#ifndef crash_hotplug_cpu_support
> -static inline int crash_hotplug_cpu_support(void) { return 0; }
> -#endif
> +#ifndef arch_crash_hotplug_support
> +static inline int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags)
> +{
>  
> -#ifndef crash_hotplug_memory_support
> -static inline int crash_hotplug_memory_support(void) { return 0; }
> +#ifdef CONFIG_KEXEC_FILE
> +	if (image->file_mode)
> +		return 1;
> +#endif
> +	return kexec_flags & KEXEC_CRASH_HOTPLUG_SUPPORT;
> +}
>  #endif
>  
>  #ifndef crash_get_elfcorehdr_size
> diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
> index c17bb096ea68..5ae1741ea8ea 100644
> --- a/include/uapi/linux/kexec.h
> +++ b/include/uapi/linux/kexec.h
> @@ -13,6 +13,7 @@
>  #define KEXEC_ON_CRASH		0x00000001
>  #define KEXEC_PRESERVE_CONTEXT	0x00000002
>  #define KEXEC_UPDATE_ELFCOREHDR	0x00000004
> +#define KEXEC_CRASH_HOTPLUG_SUPPORT 0x00000008
>  #define KEXEC_ARCH_MASK		0xffff0000
>  
>  /*
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index ab1c8e79759d..111548ad03e9 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -876,7 +876,7 @@ DEFINE_MUTEX(__crash_hotplug_lock);
>   * It reflects the kernel's ability/permission to update the crash
>   * elfcorehdr directly.
>   */
> -int crash_check_update_elfcorehdr(void)
> +int crash_check_hotplug_support(void)
>  {
>  	int rc = 0;
>  
> @@ -888,10 +888,7 @@ int crash_check_update_elfcorehdr(void)
>  		return 0;
>  	}
>  	if (kexec_crash_image) {
> -		if (kexec_crash_image->file_mode)
> -			rc = 1;
> -		else
> -			rc = kexec_crash_image->update_elfcorehdr;
> +		rc = kexec_crash_image->hotplug_support;
>  	}
>  	/* Release lock now that update complete */
>  	kexec_unlock();
> @@ -932,8 +929,8 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
>  
>  	image = kexec_crash_image;
>  
> -	/* Check that updating elfcorehdr is permitted */
> -	if (!(image->file_mode || image->update_elfcorehdr))
> +	/* Check that kexec segments update is permitted */
> +	if (!image->hotplug_support)
>  		goto out;
>  
>  	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 8f35a5a42af8..9dc5b7ed5b73 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -130,8 +130,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>  		image->preserve_context = 1;
>  
>  #ifdef CONFIG_CRASH_HOTPLUG
> -	if (flags & KEXEC_UPDATE_ELFCOREHDR)
> -		image->update_elfcorehdr = 1;
> +	if ((flags & KEXEC_ON_CRASH) && arch_crash_hotplug_support(image, flags))
> +		image->hotplug_support = 1;
>  #endif
>  
>  	ret = machine_kexec_prepare(image);
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index bef2f6f2571b..4dddf9264a69 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -373,6 +373,11 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  	if (ret)
>  		goto out;
>  
> +#ifdef CONFIG_CRASH_HOTPLUG
> +	if ((flags & KEXEC_FILE_ON_CRASH) && arch_crash_hotplug_support(image, flags))
> +		image->hotplug_support = 1;
> +#endif
> +
>  	ret = machine_kexec_prepare(image);
>  	if (ret)
>  		goto out;
> -- 
> 2.41.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
