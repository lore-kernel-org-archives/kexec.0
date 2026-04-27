Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5052FF8868
	for <kexec@archiver.kernel.org>; Mon, 27 Apr 2026 16:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BZLhshO89yxcM6RaaoD8kTAc0/YKMWq2zNVvxtj5g3o=; b=ha1RJULiW1YIOHZiDnewAvy+c6
	0Exo1U32RK1zSG5D7Bn4bYd9hjpwr8G6xusLeEFYz2uPO77mLlNz5wxYunfqiePelcRKzdLfsAKg4
	IV6qV/JM04SXLd3UT7FzvfGMOMNjxhMjtGmqGi40LL6z89wtlEiLY9M0OlyN9yHlw2B83GVrSVvjZ
	hRKj2GLiZZT+WxoVOR8mzglJpwNJB8AVuJ9Z/vkgofazUpi0ZxBPw1Vgq3T9LQ4ZctY6p5hwWDNbS
	8iSUsiAcQsKTRI8juQUOTbEYg/1uPLp7EU5BYWeT6uVTet8ZHEcmVPujelmeKtu9OVSfTIln64dNX
	8Ar/E7Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHOPd-0000000HGNq-1mCX;
	Mon, 27 Apr 2026 16:02:21 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHOPZ-0000000HGNN-0IZm
	for kexec@lists.infradead.org;
	Mon, 27 Apr 2026 16:02:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id ADE9240827;
	Mon, 27 Apr 2026 16:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D7EC19425;
	Mon, 27 Apr 2026 16:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777305735;
	bh=888yAmMb+2bkYxMtzzPRo5jdCa2Khba/ny+n5sOcH1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K2jFVvzDGkCAZLiFdhTVgdqL5mRB2PfHUXgOIXxoROLAeYVwV+Qaj6/yDu1egBPM2
	 cZt/kAcDiKTpGhOPkF8zq/0qyLcvci/blGBbirW6zknFEWzesTY2UHGU0g4FMa9ZUe
	 1Q8UF+g6Qy0I0gvWIwSg27Ihs6vHkjDEiFJSAhoUMkDu/ljyynr9clzWycroan2YzH
	 MTTnon0jwYNnES9kYm5Wmws53DQKnTM6JzKuk5QELUTSwmzi3rFCZB0H+shzzcP8SH
	 XMTgXgLVHgcQsdylWQ4tMODuixTcOKB4/3dP2GVOGR7Fe3tB6gKIm0QEwqgkhydgxI
	 +0fAlJzOnBwhQ==
Date: Mon, 27 Apr 2026 17:02:12 +0100
From: Simon Horman <horms@kernel.org>
To: Ming Wang <wangming01@loongson.cn>
Cc: kexec@lists.infradead.org, loongarch@lists.linux.dev
Subject: Re: [PATCH] LoongArch: Increase MAX_MEMORY_RANGES to 1024
Message-ID: <20260427160212.GA612626@horms.kernel.org>
References: <20260304011914.880120-1-wangming01@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304011914.880120-1-wangming01@loongson.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_090217_178419_FFD94C64 
X-CRM114-Status: GOOD (  10.87  )
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

On Wed, Mar 04, 2026 at 09:19:14AM +0800, Ming Wang wrote:
> On some LoongArch systems, especially multi-socket machines like 3D6000,
> the current limit of MAX_MEMORY_RANGES (64) is too small to accommodate
> all memory range entries in /proc/iomem.
> 
> When the limit is reached, get_memory_ranges() stops parsing, which causes
> kexec to fail with "locate_hole failed" because it cannot correctly identify
> the crash kernel reserved memory or necessary RAM segments.
> 
> Increase MAX_MEMORY_RANGES to 1024 to support systems with complex
> memory layouts.
> 
> Signed-off-by: Ming Wang <wangming01@loongson.cn>

Thanks, and sorry for the delay.

Applied:
- LoongArch: Increase MAX_MEMORY_RANGES to 1024
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=677dd2f8bcf7

