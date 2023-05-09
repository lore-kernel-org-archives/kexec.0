Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F01FC77B75
	for <kexec@archiver.kernel.org>; Tue,  9 May 2023 22:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XD387NrvQe5OBtp6l7kz/aHFX/XhheY7yOk6ZEg14sA=; b=FvRqjX3G1ihoxq
	ATnFVNiMLZRbb97fA+qqm5GlGuAURwed8yrKY2l+xPfPmn1lEg8DqaW4ExH/DEw2jK9vOaAkVUNxt
	KbVLmhRKt+7R3aFYB0UPxBjsMk1CwlUG9b1jSRGCJDE2J2mttbthHX+zwSdMCehZ0JnUD9rFm0N/0
	thRNSSgPVd/h1glkBprkm+1bCvwxfI21mZqX3LRGwSnRAt5VZ5KHZe74RfC8JlLLN7arZW8eJ+zHJ
	X+haAGM0bJsyRFwSUR9Kq2woOOJlmczk3u9ITSXVwunWuyWxHja3aGX8mIC/9GgNS8XgH5HJVBMsZ
	S49qxoydfPi48CwasFsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwWCI-004R7o-0l;
	Tue, 09 May 2023 22:52:42 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwWCF-004R74-37
	for kexec@lists.infradead.org;
	Tue, 09 May 2023 22:52:41 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1683672757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E8Jaf7DnUTN/1wZBcdgxkgn3jkW3pisAtBKw88TkIaI=;
	b=i91xz4SrqjAG3hHnzidnYdTSK9J/zd8K8IApf8Nu8kNW1/EORrSNrHCEgE379arMJlZ48T
	WbcIv+JHo0fYJLa2Uf/NIrkMOdBfXu8jG9RvsMWFj03TkpcZtnhv2Sr6xKo2zo+xp7Rw6S
	sObU5PMn+J2FI3nc812k4N1odLHL5lOF6WbMNK2f73bQ/o5IPO6aaZ6k8+VjbNLxLtqZf0
	s/6oUUSNg7bngSgYxQ59EoTzF0N/wWEJq9Tq12x2CuWYXer3/ZJ5LeumfdAZpoHfxUkw57
	FzdNhzc2Jm+v/MXmEReytT1iZsxV3BmwvyjVGVtcvjJPJCoQQ0fhYFKcQAiNUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1683672757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E8Jaf7DnUTN/1wZBcdgxkgn3jkW3pisAtBKw88TkIaI=;
	b=lzSAFtKhlGkXUOm08XkO48+uUnmBsDbOk0fcUz15yZm+QwEYw4tWWIMkE3p69/jkjZ4W6B
	6nNxM0rRREZJWIDA==
To: Eric DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
 dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
 robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
 sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
 boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: Re: [PATCH v22 5/8] x86/crash: add x86 crash hotplug support
In-Reply-To: <20230503224145.7405-6-eric.devolder@oracle.com>
References: <20230503224145.7405-1-eric.devolder@oracle.com>
 <20230503224145.7405-6-eric.devolder@oracle.com>
Date: Wed, 10 May 2023 00:52:36 +0200
Message-ID: <875y91yv63.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_155240_151114_6CF0126E 
X-CRM114-Status: GOOD (  24.57  )
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

On Wed, May 03 2023 at 18:41, Eric DeVolder wrote:
> In the patch 'kexec: exclude elfcorehdr from the segment digest'

See reply to 8/8
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 53bab123a8ee..80538524c494 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2119,6 +2119,19 @@ config CRASH_DUMP
>  	  (CONFIG_RELOCATABLE=y).
>  	  For more details see Documentation/admin-guide/kdump/kdump.rst
>  
> +config CRASH_HOTPLUG
> +	bool "Update the crash elfcorehdr on system configuration changes"
> +	default y
> +	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
> +	help
> +	  Enable direct update to the crash elfcorehdr (which contains
> +	  the list of CPUs and memory regions to be dumped upon a crash)
> +	  in response to hot plug/unplug or online/offline of CPUs or
> +	  memory. This is a much more advanced approach than userspace
> +	  attempting that.
> +
> +	  If unsure, say Y.

Why is this config an X86 specific thing?

Neither CRASH_DUMP nor HOTPLUG_CPU nor MEMORY_HOTPLUG are in any way X86
specific at all. So why can't you stick that into a place where it can
be reused by other architectures?

It's not rocket science to do 

+	depends on WANTS_CRASH_HOTPLUG && CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)

or something like that. It's so tiring to have x86 Kconfig be the dump
ground for the initial implementation, then having the sh*t copied to
every other architecture and the cleanup is left to the maintainers.

It's not rocket science to differentiate between a real architecture
specific option and a generally useful option in the first place, right?


> +#ifdef CONFIG_CRASH_HOTPLUG
> +	/*
> +	 * Ensure the elfcorehdr segment large enough for hotplug changes.
> +	 * Account for VMCOREINFO and kernel_map and maximum CPUs.

Neither the first line nor the second one qualifies as parseable sentences.

> +/**
> + * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
> + * @image: the active struct kimage

What is an active struct kimage?

> + *
> + * The new elfcorehdr is prepared in a kernel buffer, and then it is
> + * written on top of the existing/old elfcorehdr.

-ENOPARSE

> + */
> +void arch_crash_handle_hotplug_event(struct kimage *image)
> +{
> +	void *elfbuf = NULL, *old_elfcorehdr;
> +	unsigned long nr_mem_ranges;
> +	unsigned long mem, memsz;
> +	unsigned long elfsz = 0;
> +
> +	/*
> +	 * Create the new elfcorehdr reflecting the changes to CPU and/or
> +	 * memory resources.
> +	 */
> +	if (prepare_elf_headers(image, &elfbuf, &elfsz, &nr_mem_ranges)) {
> +		pr_err("unable to prepare elfcore headers");
> +		goto out;

So this can fail. Why is there just a pr_err() and no return value which
tells the caller that this failed?

> +	/*
> +	 * Copy new elfcorehdr over the old elfcorehdr at destination.
> +	 */
> +	old_elfcorehdr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
> +	if (!old_elfcorehdr) {
> +		pr_err("updating elfcorehdr failed\n");

How hard is it to write an error message which is clearly describing the
problem?

Thanks,

        tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
