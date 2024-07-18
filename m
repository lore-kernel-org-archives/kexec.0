Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48F9C3DA49
	for <kexec@archiver.kernel.org>; Thu, 18 Jul 2024 11:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bnzngXFbVM37+2kiU1FTM/lC4++7lEe8IP8v03P/XfM=; b=wUwK5+R5Ib1hTN
	VL+vu18u0bVFARd3V16Pj4SJHYuOLx46gOLz8zJhmb3xF4wH1SUOHqzfbUbD7ZxqK2wTTDahr1Yaa
	M6HUo2wM5V2ZsliRmb3quER1fHSMO7kvstNqGn9w15TmdJZdQJD/SKRn/rIc5Rk/9vg5OeWbTvZLl
	G5KQMX+6LNbUdSZ36MnCpQCKf3xuEwEUcY5L6YO41BoujcNwXAbv8z4dqdJSqzwkulNtkkKjUuMsL
	iZeg/rJVTf/kfvA0c9N7wu/8bKlzUteWnl5J3FOvHxcICxVeY6cWrzMCgPjRmSmw4bVHKTMyhZE0Q
	avtaQ9SepFt1AlCh4Vkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUP5c-0000000GnmP-12bY;
	Thu, 18 Jul 2024 11:14:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUP5Z-0000000GnlA-0U2w
	for kexec@lists.infradead.org;
	Thu, 18 Jul 2024 11:14:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721301259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yaMYBnsmHVguo1+b/EMIXO5bT8FcNVXk06LyZCMh0p0=;
	b=RtOoNhE3k6ERzY6rTP5tkRnP+HBIyuZBCgNVRMV3am8L+pS5B9TzQtdZ2HwlLc4r6ql9S2
	gCMP3VI9nbt0A+R7eUoS6xwH7QInLVMhD2YU5sU92nZUGbB0AxEeLm//5N7PDelPeI2Jw1
	DA4kFwJvfFNisutuqmxn8FYhfOiBBLM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-hGO9jZbyMYGs8ICG87O2eQ-1; Thu,
 18 Jul 2024 07:14:15 -0400
X-MC-Unique: hGO9jZbyMYGs8ICG87O2eQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5D5B1955D4D;
	Thu, 18 Jul 2024 11:14:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.39])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9849919560B2;
	Thu, 18 Jul 2024 11:14:05 +0000 (UTC)
Date: Thu, 18 Jul 2024 19:14:00 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, vgoyal@redhat.com,
	dyoung@redhat.com, arnd@arndb.de, afd@ti.com,
	linus.walleij@linaro.org, akpm@linux-foundation.org,
	eric.devolder@oracle.com, gregkh@linuxfoundation.org,
	javierm@redhat.com, deller@gmx.de, robh@kernel.org,
	hbathini@linux.ibm.com, thunder.leizhen@huawei.com,
	chenjiahao16@huawei.com, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 2/3] crash: Fix x86_32 crash memory reserve dead loop
 bug at high
Message-ID: <Zpj4+G5OwTYBQGIA@MiWiFi-R3L-srv>
References: <20240718035444.2977105-1-ruanjinjie@huawei.com>
 <20240718035444.2977105-3-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240718035444.2977105-3-ruanjinjie@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_041421_251385_7872E722 
X-CRM114-Status: GOOD (  22.58  )
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

On 07/18/24 at 11:54am, Jinjie Ruan wrote:

I don't fully catch the subject, what does the 'dead loop bug at high'
mean?

> On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=512M" will
> also cause system stall as below:
> 
> 	ACPI: Reserving FACP table memory at [mem 0x3ffe18b8-0x3ffe192b]
> 	ACPI: Reserving DSDT table memory at [mem 0x3ffe0040-0x3ffe18b7]
> 	ACPI: Reserving FACS table memory at [mem 0x3ffe0000-0x3ffe003f]
> 	ACPI: Reserving APIC table memory at [mem 0x3ffe192c-0x3ffe19bb]
> 	ACPI: Reserving HPET table memory at [mem 0x3ffe19bc-0x3ffe19f3]
> 	ACPI: Reserving WAET table memory at [mem 0x3ffe19f4-0x3ffe1a1b]
> 	143MB HIGHMEM available.
> 	879MB LOWMEM available.
> 	  mapped low ram: 0 - 36ffe000
> 	  low ram: 0 - 36ffe000
> 	  (stall here)
> 
> The reason is that the CRASH_ADDR_LOW_MAX is equal to CRASH_ADDR_HIGH_MAX
> on x86_32, the first "low" crash kernel memory reservation for 512M fails,
> then it go into the "retry" loop and never came out as below (consider
> CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX = 512M):
> 
> -> reserve_crashkernel_generic() and high is false
>    -> alloc at [0, 0x20000000] fail
>       -> alloc at [0x20000000, 0x20000000] fail and repeatedly
>       (because CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX).
> 
> Fix it by skipping meaningless calls of memblock_phys_alloc_range() with
> `start = end`
> 
> After this patch, the retry dead loop is avoided and print below info:
> 	cannot allocate crashkernel (size:0x20000000)
> 
> And apply generic crashkernel reservation to 32bit system will be ready.
> 
> Fixes: 9c08a2a139fe ("x86: kdump: use generic interface to simplify crashkernel reservation code")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Tested-by: Jinjie Ruan <ruanjinjie@huawei.com>

Also the tag issues, please update.

Other than above concerns, the patch looks good to me.

> ---
> v3:
> - Fix it as Baoquan suggested.
> - Update the commit message.
> ---
>  kernel/crash_reserve.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index c5213f123e19..dacc268429e2 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -414,7 +414,8 @@ void __init reserve_crashkernel_generic(char *cmdline,
>  			search_end = CRASH_ADDR_HIGH_MAX;
>  			search_base = CRASH_ADDR_LOW_MAX;
>  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> -			goto retry;
> +			if (search_base != search_end)
> +				goto retry;
>  		}
>  
>  		/*
> -- 
> 2.34.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
