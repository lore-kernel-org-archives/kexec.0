Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A191C52D71
	for <kexec@archiver.kernel.org>; Fri,  9 Aug 2024 09:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lcjdMew8uneu790jQJv/yX5V4PaSgms0BpPRSN2hn3I=; b=cmnSfwIUMX/fa/
	3tIt9nWWfp0AedUbvCocFkcCGDKz2CceHVx/I6BNto+InXzqMQo6Owiq10wHybu8W5orNPc2iZfHD
	MGWyIHbwNZZaHNisB8Vlf/hcM2zHEVUP7LssnNMTHxtz9jS3GvbKAac2dYlBY11z4xzATcleLMh1U
	ERSddSwaD5oV11I+tYaEl4H9/PLxqjDo146V1cuDCJ5hfNN8sQn3cVDfbP9J70iusH8BDw8mwJ7pj
	4hkzILl2Z/dSmOVUN00/Rb6MwTeiyIWWfz4z7f+1I1j/xbKbxFhTSQ4628dFd8Xtsv5piG3fo7Tuh
	BGhRzyej5i11RoCHmbDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scMHo-0000000As3p-08zC;
	Fri, 09 Aug 2024 09:51:52 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scMHj-0000000As25-20wZ;
	Fri, 09 Aug 2024 09:51:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 18E1CCE130A;
	Fri,  9 Aug 2024 09:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8185C4AF0D;
	Fri,  9 Aug 2024 09:51:41 +0000 (UTC)
Date: Fri, 9 Aug 2024 10:51:39 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Baoquan He <bhe@redhat.com>, vgoyal@redhat.com, dyoung@redhat.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	chenjiahao16@huawei.com, akpm@linux-foundation.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH -next] crash: Fix riscv64 crash memory reserve dead loop
Message-ID: <ZrXmqyhalkcY-wpx@arm.com>
References: <20240802090105.3871929-1-ruanjinjie@huawei.com>
 <ZqywtegyIS/YXOVv@MiWiFi-R3L-srv>
 <ZrJ1JkyDVpRRB_9e@arm.com>
 <ZrJ60vopeGDXFZyK@arm.com>
 <e01df216-0225-ef49-8eb3-2ccdcb424785@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e01df216-0225-ef49-8eb3-2ccdcb424785@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240809_025147_975648_6734E789 
X-CRM114-Status: GOOD (  29.90  )
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

On Thu, Aug 08, 2024 at 03:56:35PM +0800, Jinjie Ruan wrote:
> On 2024/8/7 3:34, Catalin Marinas wrote:
> > On Tue, Aug 06, 2024 at 08:10:30PM +0100, Catalin Marinas wrote:
> >> On Fri, Aug 02, 2024 at 06:11:01PM +0800, Baoquan He wrote:
> >>> And I don't like the idea crashkernel=,high failure will fallback to
> >>> attempt in low area, so this looks good to me.
> >>
> >> Well, I kind of liked this behaviour. One can specify ,high as a
> >> preference rather than forcing a range. The arm64 land has different
> >> platforms with some constrained memory layouts. Such fallback works well
> >> as a default command line option shipped with distros without having to
> >> guess the SoC memory layout.
> > 
> > I haven't tried but it's possible that this patch also breaks those
> > arm64 platforms with all RAM above 4GB when CRASH_ADDR_LOW_MAX is
> > memblock_end_of_DRAM(). Here all memory would be low and in the absence
> > of no fallback, it fails to allocate.
> > 
> > So, my strong preference would be to re-instate the current behaviour
> > and work around the infinite loop in a different way.
> 
> Hi, baoquan, What's your opinion?
> 
> Only this patch should be re-instate or all the 3 dead loop fix patch?

Only the riscv64 patch that that removes the ,high reservation fallback
to ,low. From this series:

https://lore.kernel.org/r/20240719095735.1912878-1-ruanjinjie@huawei.com/

the first two fixes look fine (x86_32). The third one (arm32), not sure
why it's in the series called "crash: Fix x86_32 memory reserve dead
loop bug". Does it fix a problem on arm32? Anyway, I'm not against it
getting merged but I'm not maintaining arm32. If the first two patches
could be merged for 6.11, I think the arm32 one is more of a 6.12
material (unless it does fix something).

On the riscv64 patch removing the high->low fallback to avoid the
infinite loop, I'd rather replace it with something similar to the
x86_32 fix in the series above. I suggested something in the main if
block but, looking at the x86_32 fix, for consistency, I think it would
look better as something like:

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index d3b4cd12bdd1..64d44a52c011 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -423,7 +423,8 @@ void __init reserve_crashkernel_generic(char *cmdline,
 		if (high && search_end == CRASH_ADDR_HIGH_MAX) {
 			search_end = CRASH_ADDR_LOW_MAX;
 			search_base = 0;
-			goto retry;
+			if (search_end != CRASH_ADDR_HIGH_MAX)
+				goto retry;
 		}
 		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
 			crash_size);

In summary, just replace the riscv64 fix with something along the lines
of the diff above (or pick whatever you prefer that still keeps the
fallback).

Thanks.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
