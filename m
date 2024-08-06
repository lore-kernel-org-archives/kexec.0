Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238B9C52D70
	for <kexec@archiver.kernel.org>; Tue,  6 Aug 2024 19:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m1AgNIY4rmYqCJo1W2fxH+foy4bAnbuQ7iyvibH6I24=; b=Mg1VX9F7zPbJAy
	+44zFZGbZ+fGOIT6Q1cRZAOrYCcHPvHo2BDr/VrVNVTWytN1ZoR2sTmTEYulb0FbMDPnN9a+9CbLY
	DwVdEaX6cxKnMVHLBKk0sJ4LfJagc/8Wl05g+8tipPm+feO6JMNsLN+S+0D6mJO4i4roX15nASDUz
	HPRe1v1sAtEbJa66V6dFsyfdmta47phFEcwa6hennQMwzbMkPgFJMRGwrbLzVC7A0GrbZrWTfYUwB
	oVyNiUiFxX8qeKIW+XOr877rr0Krihcc5F1EePeu1QMlYdxQJ+Cl4+biGPS0pPJ/nMxZirBN2wFCs
	Rwg/vym1ApQcqnPi6t1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbPZw-00000002fIv-2SVR;
	Tue, 06 Aug 2024 19:10:40 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbPZs-00000002fIQ-1Bce;
	Tue, 06 Aug 2024 19:10:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 435D060FC8;
	Tue,  6 Aug 2024 19:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731ECC32786;
	Tue,  6 Aug 2024 19:10:32 +0000 (UTC)
Date: Tue, 6 Aug 2024 20:10:30 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Baoquan He <bhe@redhat.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, vgoyal@redhat.com,
	dyoung@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, chenjiahao16@huawei.com,
	akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH -next] crash: Fix riscv64 crash memory reserve dead loop
Message-ID: <ZrJ1JkyDVpRRB_9e@arm.com>
References: <20240802090105.3871929-1-ruanjinjie@huawei.com>
 <ZqywtegyIS/YXOVv@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZqywtegyIS/YXOVv@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_121036_430510_D2877E1F 
X-CRM114-Status: GOOD (  26.38  )
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

To Jinjie, if you make generic changes that affect other architectures,
please either cc the individual lists/maintainers or at least cross-post
to linux-arch. I don't follow lkml, there's just too much traffic there.

On Fri, Aug 02, 2024 at 06:11:01PM +0800, Baoquan He wrote:
> On 08/02/24 at 05:01pm, Jinjie Ruan wrote:
> > On RISCV64 Qemu machine with 512MB memory, cmdline "crashkernel=500M,high"
> > will cause system stall as below:
> > 
> > 	 Zone ranges:
> > 	   DMA32    [mem 0x0000000080000000-0x000000009fffffff]
> > 	   Normal   empty
> > 	 Movable zone start for each node
> > 	 Early memory node ranges
> > 	   node   0: [mem 0x0000000080000000-0x000000008005ffff]
> > 	   node   0: [mem 0x0000000080060000-0x000000009fffffff]
> > 	 Initmem setup node 0 [mem 0x0000000080000000-0x000000009fffffff]
> > 	(stall here)
> > 
> > commit 5d99cadf1568 ("crash: fix x86_32 crash memory reserve dead loop
> > bug") fix this on 32-bit architecture. However, the problem is not
> > completely solved. If `CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX` on 64-bit
> > architecture, for example, when system memory is equal to
> > CRASH_ADDR_LOW_MAX on RISCV64, the following infinite loop will also occur:
> 
> Interesting, I didn't expect risc-v defining them like these.
> 
> #define CRASH_ADDR_LOW_MAX              dma32_phys_limit
> #define CRASH_ADDR_HIGH_MAX             memblock_end_of_DRAM()

arm64 defines the high limit as PHYS_MASK+1, it doesn't need to be
dynamic and x86 does something similar (SZ_64T). Not sure why the
generic code and riscv define it like this.

> > 	-> reserve_crashkernel_generic() and high is true
> > 	   -> alloc at [CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX] fail
> > 	      -> alloc at [0, CRASH_ADDR_LOW_MAX] fail and repeatedly
> > 	         (because CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX).
> > 
> > Before refactor in commit 9c08a2a139fe ("x86: kdump: use generic interface
> > to simplify crashkernel reservation code"), x86 do not try to reserve crash
> > memory at low if it fails to alloc above high 4G. However before refator in
> > commit fdc268232dbba ("arm64: kdump: use generic interface to simplify
> > crashkernel reservation"), arm64 try to reserve crash memory at low if it
> > fails above high 4G. For 64-bit systems, this attempt is less beneficial
> > than the opposite, remove it to fix this bug and align with native x86
> > implementation.
> 
> And I don't like the idea crashkernel=,high failure will fallback to
> attempt in low area, so this looks good to me.

Well, I kind of liked this behaviour. One can specify ,high as a
preference rather than forcing a range. The arm64 land has different
platforms with some constrained memory layouts. Such fallback works well
as a default command line option shipped with distros without having to
guess the SoC memory layout.

Something like below should fix the issue as well (untested):

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index d3b4cd12bdd1..ae92d6745ef4 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -420,7 +420,8 @@ void __init reserve_crashkernel_generic(char *cmdline,
 		 * For crashkernel=size[KMG],high, if the first attempt was
 		 * for high memory, fall back to low memory.
 		 */
-		if (high && search_end == CRASH_ADDR_HIGH_MAX) {
+		if (high && search_end == CRASH_ADDR_HIGH_MAX &&
+		    CRASH_ADDR_LOW_MAX < CRASH_ADDR_HIGH_MAX) {
 			search_end = CRASH_ADDR_LOW_MAX;
 			search_base = 0;
 			goto retry;

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
