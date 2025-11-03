Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0532CCFA00
	for <kexec@archiver.kernel.org>; Mon,  3 Nov 2025 02:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X2q0M43HiImC77msPAox01Eekne3kZwBQne5m3Gl0v0=; b=uw+0sGkTWV8OxBdnn8eMncfi8g
	Mg7dPYn0UW1cV65BLoe1GlpDoSXRS19lzXuhTVY0vMDf98tLvoP489va04PlHdHParcZRxLt14/n4
	7L4jWavj+kr2DCLOoh7m8h54Uxa51rMFbGMycSDv11S4F0ss8nnDYGmjRWiMYAWGXkk8RJAVavlGB
	1+1kiBVrnTbU8UxEY6sEwhYINh8/qvO0YNhnNI8STcApqyUR8DDEaOFcB8hFTsrDUP3ATjvtM017R
	hPAXrDa9NfCYBXtZUXnyO6pWk9Li+5bHTBps4u0Vy4v3SQ2JKCSRQwSnEW6qM0gunxKhRC9HKGGcB
	CMIIeM0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFkiu-000000095cm-1A7V;
	Mon, 03 Nov 2025 02:55:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFkio-000000095cI-1HbW
	for kexec@lists.infradead.org;
	Mon, 03 Nov 2025 02:55:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762138504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X2q0M43HiImC77msPAox01Eekne3kZwBQne5m3Gl0v0=;
	b=HiVpjgHPwmZO0Qr8g0guWKUCP+wNpBeGIEMNCZWBM9fHdH2zJjajatkmcn/5bCYQK1MR4v
	9ReNMd95MNthLvmxlRI6Ml07bWbb88C4HMWhF09POkRdO2Of9Si3c4h55Lf0ct7zgBSOOP
	58t2YcThmhQeNrox3CtyXX+5VuTk7mA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-ESv9nNmDPxqM20Jo0oTHrQ-1; Sun,
 02 Nov 2025 21:54:59 -0500
X-MC-Unique: ESv9nNmDPxqM20Jo0oTHrQ-1
X-Mimecast-MFC-AGG-ID: ESv9nNmDPxqM20Jo0oTHrQ_1762138498
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E962195606C;
	Mon,  3 Nov 2025 02:54:56 +0000 (UTC)
Received: from localhost (unknown [10.72.112.98])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8DDC30001A1;
	Mon,  3 Nov 2025 02:54:54 +0000 (UTC)
Date: Mon, 3 Nov 2025 10:54:50 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Zhen Lei <thunder.leizhen@huawei.com>, kexec@lists.infradead.org
Subject: Re: [PATCH] crash: fix crashkernel resource shrink
Message-ID: <aQgZekkvdC6Ekq8V@MiWiFi-R3L-srv>
References: <20251101193741.289252-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101193741.289252-1-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_185506_443691_71B055A0 
X-CRM114-Status: GOOD (  22.63  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 11/02/25 at 01:07am, Sourabh Jain wrote:
> When crashkernel is configured with a high reservation, shrinking its
> value below the low crashkernel reservation causes two issues:
> 
> 1. Invalid crashkernel resource objects
> 2. Kernel crash if crashkernel shrinking is done twice
> 
> For example, with crashkernel=200M,high, the kernel reserves 200MB of
> high memory and some default low memory (say 256MB). The reservation
> appears as:
> 
> cat /proc/iomem | grep -i crash
> af000000-beffffff : Crash kernel
> 433000000-43f7fffff : Crash kernel
> 
> If crashkernel is then shrunk to 50MB (echo 52428800 >
> /sys/kernel/kexec_crash_size), /proc/iomem still shows 256MB reserved:
> af000000-beffffff : Crash kernel
> 
> Instead, it should show 50MB:
> af000000-b21fffff : Crash kernel
> 
> Further shrinking crashkernel to 40MB causes a kernel crash with the
> following trace (x86):
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000038
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> <snip...>
> Call Trace: <TASK>
> ? __die_body.cold+0x19/0x27
> ? page_fault_oops+0x15a/0x2f0
> ? search_module_extables+0x19/0x60
> ? search_bpf_extables+0x5f/0x80
> ? exc_page_fault+0x7e/0x180
> ? asm_exc_page_fault+0x26/0x30
> ? __release_resource+0xd/0xb0
> release_resource+0x26/0x40
> __crash_shrink_memory+0xe5/0x110
> crash_shrink_memory+0x12a/0x190
> kexec_crash_size_store+0x41/0x80
> kernfs_fop_write_iter+0x141/0x1f0
> vfs_write+0x294/0x460
> ksys_write+0x6d/0xf0
> <snip...>
> 
> This happens because __crash_shrink_memory()/kernel/crash_core.c
> incorrectly updates the crashk_res resource object even when
> crashk_low_res should be updated.
> 
> Fix this by ensuring the correct crashkernel resource object is updated
> when shrinking crashkernel memory.
> 
> Fixes: 16c6006af4d4 ("kexec: enable kexec_crash_size to support two crash kernel regions")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: kexec@lists.infradead.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  kernel/crash_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 3b1c43382eec..99dac1aa972a 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -373,7 +373,7 @@ static int __crash_shrink_memory(struct resource *old_res,
>  		old_res->start = 0;
>  		old_res->end   = 0;
>  	} else {
> -		crashk_res.end = ram_res->start - 1;
> +		old_res->end = ram_res->start - 1;

It's a code bug, nice catch, thanks.

Acked-by: Baoquan He <bhe@redhat.com>


