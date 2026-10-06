Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305C1CA5FFF
	for <kexec@archiver.kernel.org>; Tue,  6 Oct 2026 10:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OcCKnJg82xr9zF1ktKP69bSPFjVHrRcr9zQM04SRH+o=; b=aCkTCHJWvbL7M87NVzkqLKiZp2
	ZrK7vY+LFHDQ+XoD9wz4tmYMx1FHrgeGRA1i6uQWs8g9iIkMq4NSYwujeXgJAxeek/yd7mj14QSfY
	NW49ugVrOLqELMjXzNhcu7T1NQ0Ng40s5HUpQJ9t+wcDBZ2R6qHx6HF4Y2BmkttyL8/Ch1gWwIXdh
	6DRYB1H++Kt+lLBzqE12xIw1qCZ37H+2zJxbV8JFQ5UqnzKYYksqeGueUIId67MwOi2/2X7WSXhgf
	Si6rVRf8JTWhxZiRv4l+0ABpXdQuNnFIFigAAfsnB1QsGMCieDqVd0mzDGKHEcgltlmTmmqltwSaq
	30um2VyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE2pg-00000000Zct-0H4N;
	Tue, 06 Oct 2026 10:55:40 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE2pf-00000000Zch-1fVb
	for kexec@lists.infradead.org;
	Tue, 06 Oct 2026 10:55:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7CC2C43740;
	Tue,  6 Oct 2026 10:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D441F000FF;
	Tue,  6 Oct 2026 10:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791284137;
	bh=OcCKnJg82xr9zF1ktKP69bSPFjVHrRcr9zQM04SRH+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZkLF6Z6yRuA0I5reP8kGotSor41YH90MFptgbXyAQyRUjxpBD9oMtj1zSV/FNC2oU
	 CYDRJLmfE4I71/SvJCnM/5akyVm4xTTU9VMpw7g+zdp+5oKKh3eWgttV9+uBZZpmJM
	 o0bSBlzKt+adSFrWTHVI+x/xlptnB309hbakpFO+7pfXxIvAWVDZkrctXR5mG/ov/4
	 0M15a1mbjvAENfjS7v4PuhgZWg2ozzW0zLI4G/Ym6r2namKefZDDNtPpJxKA/UpwK3
	 dIaLltqn9eMi1gDxQWZakHU/r9wTW2vww3kQ5AcJFAxff/hTSNmNUxZN+bUt6NJB4f
	 mMq7B9LO5riaA==
Date: Tue, 6 Oct 2026 12:55:31 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Chris Bainbridge <chris.bainbridge@canonical.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Miu <jasonmiu@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [BUG] KHO handover hangs when memmap reserves PMEM
Message-ID: <asTTo3AFzQoqZLoP@kernel.org>
References: <asE0R_f2r2TL-3Sy@px13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asE0R_f2r2TL-3Sy@px13>
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

On Sat, Oct 03, 2026 at 06:02:27PM +0100, Chris Bainbridge wrote:
> Hello,
> 
> I am reporting a regression in KHO handover.
> 
> In the most recent Ubuntu 26.10 beta mini-ISO releases (2026-09-18 onwards),
> the first kernel reserves RAM for the downloaded ISO with a memmap directive
> such as memmap=<size>!4G, then kexecs a second kernel. On affected kernels, the
> first kernel reaches "kexec_core: Starting new kernel", but the second kernel
> produces no further output and QEMU spins at 100% CPU. On unaffected kernels,
> the second kernel starts and finds /dev/pmem0 with the expected "Persistent
> Memory (legacy)" range in /proc/iomem.

TO make sure I understand this correctly, you enable KHO in the builds of
the installer kernel and then the installer command line explicitly enables
KHO.

Is there anything you actually preserve with KHO when kexec'ing the second
kernel?
 
> A source bisect identified 3f2ad90060f6 ("kho: adopt radix tree for preserved
> memory tracking") as the first bad commit; reverting it at the bisected
> revision restored the handover. The regression appears related to KHO metadata
> being accessed after the receiving kernel's memmap directive changes how the
> metadata's physical range is mapped.
> 
> #regzbot introduced: 3f2ad90060f6
> 
> I have an AI-generated candidate fix that changes 22 files. I have not attached
> or published it: although the AI did extensive verification on both x64 and
> arm64, I cannot review or explain the complete change, so I am not submitting
> it as a fix. If one of you thinks an unreviewed candidate would be useful for
> further analysis, please let me know.
> 

-- 
Sincerely yours,
Mike.

