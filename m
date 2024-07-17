Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F97FC3DA4B
	for <kexec@archiver.kernel.org>; Wed, 17 Jul 2024 13:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8Dsmv3GCx5GIzZpAg/KAZRgk+4eHpO+br9J2aR9Gj9c=; b=dIsCnEPdgOlFQn
	/wiKEaZpLrj3T2fm7RfCB3xpmOXCvUmG5+h8Dp1I8ylGmob7IJjFM3KOWm75DTSr1RkmXfDmyEnIS
	R4O15vEZrHXmBKd7LvlguZWxAgDYFpe+QPHzZpLYKYd71c4VrlXX5hWyldREeId4JCTXFJzSy/yLf
	Nq8ocVq00hdi2h8V9rB3yJXvp+i2lRj0TyvjbQTrTCdfFd8HQsL1CFYGXgy6Vswl6SkzMZQNpe2E2
	T1EKWCwK31ff8ruw28OUywfhlGk36LNe2IUUlKvbhniYbg89BnREI17PNJN7FHF+6lAP4emc5eshS
	zR/FmRmcNy/CI9+jKJgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU4rx-0000000DvFc-2JW4;
	Wed, 17 Jul 2024 13:38:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU4rv-0000000DvF7-0HMZ
	for kexec@lists.infradead.org;
	Wed, 17 Jul 2024 13:38:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721223534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vhY47IaT+xpjtEKrUmqTs+3xE4CAdxaNkPoUu1I3NaY=;
	b=Lu3BMKxyqKemF0soOcF+0aXT2rtgRtU0w4dQQI2WaKhCYVE1sdWIOWd/Z73EtY0Oi1Rjea
	0GMN0H/XFBYZ5OTkeJ0HklwJQOlqdwLrokakbkRc8fXaMhvgeFhMOU9NsIyJHMGjp1zNEu
	KZqwWWV4aEwj6DI8IUsb0Ge52EQGjGE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-MIIcWOCHNZ6I6qR8600WxQ-1; Wed,
 17 Jul 2024 09:38:51 -0400
X-MC-Unique: MIIcWOCHNZ6I6qR8600WxQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02D2B1955EA7;
	Wed, 17 Jul 2024 13:38:50 +0000 (UTC)
Received: from localhost (unknown [10.72.112.209])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1210C1955F3B;
	Wed, 17 Jul 2024 13:38:47 +0000 (UTC)
Date: Wed, 17 Jul 2024 21:38:41 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: vgoyal@redhat.com, dyoung@redhat.com, akpm@linux-foundation.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] crash: fix x86_32 memory reserve dead loop retry
 bug at "high"
Message-ID: <ZpfJYcjZ0QmFUpPf@MiWiFi-R3L-srv>
References: <20240717070904.2671147-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240717070904.2671147-1-ruanjinjie@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_063855_208887_EA435DAA 
X-CRM114-Status: GOOD (  26.73  )
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

On 07/17/24 at 03:09pm, Jinjie Ruan wrote:
> Similar to commit 8f9dade5906a ("crash: fix x86_32 memory reserve dead loop
> retry bug") and in the symmetry case, on x86_32 Qemu machine with
> 1GB memory, the cmdline "crashkernel=512M" will also cause system stall
> as below:
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
> Fix it by also changing the another out check condition, the fixed base
> situation has no problem because it warn out if it fail to alloc.
> 
> After this patch, it prints:
> 	cannot allocate crashkernel (size:0x20000000)
> 
> Fixes: 9c08a2a139fe ("x86: kdump: use generic interface to simplify crashkernel reservation code")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  kernel/crash_reserve.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index 03e455738e75..36c13cf942f4 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -409,7 +409,7 @@ void __init reserve_crashkernel_generic(char *cmdline,
>  		 * low memory, fall back to high memory, the minimum required
>  		 * low memory will be reserved later.
>  		 */
> -		if (!high && search_end == CRASH_ADDR_LOW_MAX) {
> +		if (!high && !search_base) {

Hmm, this may not be good. We can't guarantee that CRASH_ADDR_LOW_MAX must
not be 0. I still suggest you testing below draft patch to see if it works
well. And we should revert the patch in Andrew's tree since it's not good.
Posting like these mess will confuse people and add difficulty when
backporting.

You haven't responded to my earlier request to test those two draft
patches. When you tested below code and it's good, you can post this as
a formal patch. So my suggestion to the whole work is:

1) revert commit 8f9dade5906a in Andrew's tree;

2) post two patches I suggested to prevert crashkernel=,high for 32bit
system, and fix the issue you found;

3) post patchset to make arm32 use generic crashkernel reservation.

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5b2722a93a48..ac087ba442cd 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -414,7 +414,8 @@ void __init reserve_crashkernel_generic(char *cmdline,
 			search_end = CRASH_ADDR_HIGH_MAX;
 			search_base = CRASH_ADDR_LOW_MAX;
 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
-			goto retry;
+			if (search_base != search_end)
+				goto retry;
 		}
 
 		/*


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
