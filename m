Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F1BC2BD09
	for <kexec@archiver.kernel.org>; Wed,  3 Jul 2024 04:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3bBKXDLupx4oTukrzxvlYsHIz0KT5cUguoSg4rLaS8Y=; b=3JFy0nP1/niWL6
	Rkrqz3NuC6oV7qTIE5jjHKxbqDak1WRPpUlXWw75o8mK0EUJWtkf7FsE9UVWoEV/yGoKKkUqU71UL
	e5W+KTLn+f+ylp6IcauSVKMl9foLlUNofgA/Qu5z/b3P34XKxf3oUTUoBSwHRFIsB/6lvxM//1tBy
	RCUo+SlhGC42qWOBGGUAF2Is2pESu5pqm0by095AhbJmLMP+Wqu6atvJJuhav2oVkyFUyyKE+mFE6
	GuYGurUvDur9pHZ6Kg/TooKmwCXJq2csDFiMqZLpp8PEsyh7ZRaaoICMRc7T06MTROcjQOTj0r7PU
	tFb3DlX55X7KoRks6+vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOreX-00000008xBS-0n2N;
	Wed, 03 Jul 2024 04:31:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOreT-00000008xAM-2f27
	for kexec@lists.infradead.org;
	Wed, 03 Jul 2024 04:31:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719981086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JgHakkQuOZDwtNizCt1o4VIeKwc904nfJFS72Gueq74=;
	b=emAKx5xVH7J7CC4Cjzn1EwjiKuGkS1Y0C2p5eQYNsJddx+YFT1kBwe0S9eaChsaDynE4Zt
	YtMIFTqewKouAGpq8QaVmFvacGsB1kCEPh2We4EHcKgLGIPv/+d5OIQ6zqxNs44JuN9g7o
	iXlfNrfo/u4IQMJZs5X6Ilhx63r+UD0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-Mh6rdM2APS-4PpyzjeLsFw-1; Wed,
 03 Jul 2024 00:31:22 -0400
X-MC-Unique: Mh6rdM2APS-4PpyzjeLsFw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A2B619560AB;
	Wed,  3 Jul 2024 04:31:21 +0000 (UTC)
Received: from localhost (unknown [10.72.116.117])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 746841955F21;
	Wed,  3 Jul 2024 04:31:18 +0000 (UTC)
Date: Wed, 3 Jul 2024 12:31:14 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Aditya Gupta <adityag@linux.ibm.com>,
	Coiby Xu <coxu@redhat.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] kexec_load: Use new kexec flag for hotplug support
Message-ID: <ZoTUEtU6o6wuHvtf@MiWiFi-R3L-srv>
References: <20240702043057.200211-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20240702043057.200211-1-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_213129_780897_16DCA45E 
X-CRM114-Status: GOOD (  23.95  )
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

On 07/02/24 at 10:00am, Sourabh Jain wrote:
......
> diff --git a/kexec/arch/i386/kexec-x86.c b/kexec/arch/i386/kexec-x86.c
> index 444cb69..b4947a0 100644
> --- a/kexec/arch/i386/kexec-x86.c
> +++ b/kexec/arch/i386/kexec-x86.c
> @@ -208,3 +208,11 @@ void arch_update_purgatory(struct kexec_info *info)
>  	elf_rel_set_symbol(&info->rhdr, "panic_kernel",
>  		&panic_kernel, sizeof(panic_kernel));
>  }
> +
> +int arch_do_exclude_segment(struct kexec_segment *seg_ptr, struct kexec_info *info)
> +{
> +	if (info->elfcorehdr == (unsigned long) seg_ptr->mem)
> +		return 1;
> +
> +	return 0;
> +}

I know the similar question has been asked in earlier version, I may not
get it. still raise concern here to ask why x86_64 returns 0 directly,
while i386 will have the different cases.

> diff --git a/kexec/arch/ia64/kexec-ia64.c b/kexec/arch/ia64/kexec-ia64.c
> index 418d997..8d9c1f3 100644
> --- a/kexec/arch/ia64/kexec-ia64.c
> +++ b/kexec/arch/ia64/kexec-ia64.c
> @@ -245,3 +245,7 @@ void arch_update_purgatory(struct kexec_info *UNUSED(info))
>  {
>  }
>  
> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
                                                            ~~~~~~~
A tiny nit about the parameter naming, since the existing is taking
'struct kexec_segment *segment', can we also take the same way? Not
strong opinion.

=====
kexec-tools/kexec/kexec.c:
static int valid_memory_segment(struct kexec_info *info,
                                struct kexec_segment *segment)
{
        unsigned long sstart, send;
        sstart = (unsigned long)segment->mem;
        send   = sstart + segment->memsz - 1;

        return valid_memory_range(info, sstart, send);
}

> +{
> +	return 0;
> +}
> diff --git a/kexec/arch/loongarch/kexec-loongarch.c b/kexec/arch/loongarch/kexec-loongarch.c
> index ac75030..ee7b9f1 100644
> --- a/kexec/arch/loongarch/kexec-loongarch.c
> +++ b/kexec/arch/loongarch/kexec-loongarch.c
> @@ -381,3 +381,8 @@ unsigned long add_buffer(struct kexec_info *info, const void *buf,
>  	return add_buffer_phys_virt(info, buf, bufsz, memsz, buf_align,
>  				    buf_min, buf_max, buf_end, 1);
>  }
> +
> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
> +{
> +	return 0;
> +}
> diff --git a/kexec/arch/m68k/kexec-m68k.c b/kexec/arch/m68k/kexec-m68k.c
> index cb54927..0c7dbaf 100644
> --- a/kexec/arch/m68k/kexec-m68k.c
> +++ b/kexec/arch/m68k/kexec-m68k.c
> @@ -108,3 +108,8 @@ void add_segment(struct kexec_info *info, const void *buf, size_t bufsz,
>  {
>  	add_segment_phys_virt(info, buf, bufsz, base, memsz, 1);
>  }
> +
> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
> +{
> +	return 0;
> +}
> diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
> index d8cbea8..94224ee 100644
> --- a/kexec/arch/mips/kexec-mips.c
> +++ b/kexec/arch/mips/kexec-mips.c
> @@ -189,3 +189,7 @@ unsigned long add_buffer(struct kexec_info *info, const void *buf,
>  				    buf_min, buf_max, buf_end, 1);
>  }
>  
> +int arch_do_exclude_segment(const void *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
> +{
> +	return 0;
> +}
> diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
> index 03bec36..c8af870 100644
> --- a/kexec/arch/ppc/kexec-ppc.c
> +++ b/kexec/arch/ppc/kexec-ppc.c
> @@ -966,3 +966,7 @@ void arch_update_purgatory(struct kexec_info *UNUSED(info))
>  {
>  }
>  
> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
> +{
> +	return 0;
> +}
> diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
> index bd5274c..fb27b6b 100644
> --- a/kexec/arch/ppc64/kexec-ppc64.c
> +++ b/kexec/arch/ppc64/kexec-ppc64.c
> @@ -967,3 +967,8 @@ int arch_compat_trampoline(struct kexec_info *UNUSED(info))
>  void arch_update_purgatory(struct kexec_info *UNUSED(info))
>  {
>  }
> +
> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
> +{
> +	return 0;
> +}
> diff --git a/kexec/arch/s390/kexec-s390.c b/kexec/arch/s390/kexec-s390.c
> index 33ba6b9..0561ee7 100644
> --- a/kexec/arch/s390/kexec-s390.c
> +++ b/kexec/arch/s390/kexec-s390.c
> @@ -267,3 +267,8 @@ int get_crash_kernel_load_range(uint64_t *start, uint64_t *end)
>  {
>  	return parse_iomem_single("Crash kernel\n", start, end);
>  }
> +
> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
> +{
> +	return 0;
> +}
> diff --git a/kexec/arch/sh/kexec-sh.c b/kexec/arch/sh/kexec-sh.c
> index ce341c8..f84c40c 100644
> --- a/kexec/arch/sh/kexec-sh.c
> +++ b/kexec/arch/sh/kexec-sh.c
> @@ -257,3 +257,8 @@ unsigned long add_buffer(struct kexec_info *info, const void *buf,
>  	return add_buffer_phys_virt(info, buf, bufsz, memsz, buf_align,
>  				    buf_min, buf_max, buf_end, 1);
>  }
> +
> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
> +{
> +	return 0;
> +}
> diff --git a/kexec/arch/x86_64/kexec-x86_64.c b/kexec/arch/x86_64/kexec-x86_64.c
> index ffd84f0..42af90a 100644
> --- a/kexec/arch/x86_64/kexec-x86_64.c
> +++ b/kexec/arch/x86_64/kexec-x86_64.c
> @@ -188,3 +188,8 @@ void arch_update_purgatory(struct kexec_info *info)
>  	elf_rel_set_symbol(&info->rhdr, "panic_kernel",
>  				&panic_kernel, sizeof(panic_kernel));
>  }
> +
> +int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
> +{
> +	return 0;
> +}
> diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
> index 73e5254..4675c46 100644
> --- a/kexec/kexec-syscall.h
> +++ b/kexec/kexec-syscall.h
> @@ -112,7 +112,7 @@ static inline long kexec_file_load(int kernel_fd, int initrd_fd,
>  
>  #define KEXEC_ON_CRASH		0x00000001
>  #define KEXEC_PRESERVE_CONTEXT	0x00000002
> -#define KEXEC_UPDATE_ELFCOREHDR	0x00000004
> +#define KEXEC_CRASH_HOTPLUG_SUPPORT	0x00000008
>  #define KEXEC_ARCH_MASK		0xffff0000

Yeah, removing KEXEC_UPDATE_ELFCOREHDR sounds good to avoid collision
with xen code. 

>  
>  /* Flags for kexec file based system call */
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index 222f79e..034cea6 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -701,10 +701,13 @@ static void update_purgatory(struct kexec_info *info)
>  			continue;
>  		}
>  
> -		/* Don't include elfcorehdr in the checksum, if hotplug
> -		 * support enabled.
> +		/*
> +		 * Let architecture decide which segments to exclude from checksum
> +		 * if hotplug support is enabled.
>  		 */
> -		if (do_hotplug && (info->segment[i].mem == (void *)info->elfcorehdr)) {
> +		if (do_hotplug && arch_do_exclude_segment(&info->segment[i], info)) {
> +			dbgprintf("Skipping segment mem: 0x%lx from SHA calculation\n",
> +				  (unsigned long)info->segment[i].mem);
>  			continue;
>  		}
>  
> @@ -1651,7 +1654,6 @@ int main(int argc, char *argv[])
>  		die("--load-live-update can only be used with xen\n");
>  	}
>  
> -	/* NOTE: Xen KEXEC_LIVE_UPDATE and KEXEC_UPDATE_ELFCOREHDR collide */
>  	if (do_hotplug) {
>  		const char *ces = "/sys/kernel/crash_elfcorehdr_size";
>  		char *buf, *endptr = NULL;
> @@ -1665,8 +1667,8 @@ int main(int argc, char *argv[])
>  		if (!elfcorehdrsz || (endptr && *endptr != '\0'))
>  			die("Path %s does not exist, the kernel needs CONFIG_CRASH_HOTPLUG\n", ces);
>  		dbgprintf("ELFCOREHDR_SIZE %lu\n", elfcorehdrsz);
> -		/* Indicate to the kernel it is ok to modify the elfcorehdr */
> -		kexec_flags |= KEXEC_UPDATE_ELFCOREHDR;
> +		/* Indicate to the kernel it is ok to modify the relevant kexec segments */
> +		kexec_flags |= KEXEC_CRASH_HOTPLUG_SUPPORT;
>  	}
>  
>  	fileind = optind;
> diff --git a/kexec/kexec.h b/kexec/kexec.h
> index 1004aff..2d758c9 100644
> --- a/kexec/kexec.h
> +++ b/kexec/kexec.h
> @@ -307,6 +307,8 @@ extern int do_hotplug;
>  #define BOOTLOADER_VERSION PACKAGE_VERSION
>  
>  void arch_usage(void);
> +/* Return non-zero if segment needs to be excluded from SHA calculation, else 0. */
> +int arch_do_exclude_segment(struct kexec_segment *seg_ptr, struct kexec_info *info);
>  int arch_process_options(int argc, char **argv);
>  int arch_compat_trampoline(struct kexec_info *info);
>  void arch_update_purgatory(struct kexec_info *info);
> -- 
> 2.45.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
