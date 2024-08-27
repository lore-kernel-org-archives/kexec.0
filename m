Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B81AC54735
	for <kexec@archiver.kernel.org>; Tue, 27 Aug 2024 12:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SOp7JHN/O2afuWZhAI9ZDy9mOxYc8XdV4L/9qfPHjrM=; b=tLUTtpP6II+Dm0
	C/03Pdjk1JbkReWldQb5TnHwcCsEtZAVJtN+2GQGQi5u6diTNqCNkUA8XIDCXF28hvt+Ia1vDpPbE
	morm+uh8jPWk3Pk1KxDftuU1EKpoOBi11OaD+8E1A90xxRjugGYnlyd0UQHgtdRjIVFizstcFgYGk
	Z2Ln2UXtyOxI++ECcvINUZztqRyRAC/BMxGqti1YqxD04KPu8X5ipqNnfsw39VYU6/FpC8kHfK+Zb
	APIq8Ee++CGuRY202JhQh+h62sQqSpldXvTNtiUOqeH+6orWm9eJRTTSiuRGPIZ2u6I7RTSqyCkbk
	Fz9r6QNRIzj63XY/Jo2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sivI9-0000000BDay-0mXw;
	Tue, 27 Aug 2024 12:27:21 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sivFy-0000000BCrz-0qxR;
	Tue, 27 Aug 2024 12:25:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7C04BA41920;
	Tue, 27 Aug 2024 12:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A3FC61047;
	Tue, 27 Aug 2024 12:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724761505;
	bh=ibFELH6wnefwxqmKPLY/CFWmccSL2UNN83qpRzxLezI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MHDMp0Zs/84W3n2xKjaRCFUmn7pMXCcxZmqzHIEEsZFoD4qv2OgB2rdPpNUTUtQ4l
	 FVKgDPnwvNsyTja6FadTfNhI1CRmKezIZ+SVOq++Gmie8+XBsT0hSjxzzWhB9YXGJO
	 YaeRD96UD5py7GYNPYW7xQTkDHH/aGfnQC6+YE1da0dVhOOokhrfrGiWp3EawHUIiN
	 9Lkqluky0xoVcomrjkcQVRGmGkD8qgXOJc1JhWuSmdiOHRC2HpsmvrGwSBSWEjN3bH
	 jFLF4csYk30tvCGcf5oT5ngr+9EuL3zjM/srmSpj7aEEBg6krZEm2cqN0w2d/tz/xF
	 SISPZITH4x2dg==
Date: Tue, 27 Aug 2024 13:24:59 +0100
From: Will Deacon <will@kernel.org>
To: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ardb@kernel.org
Subject: Re: [PATCH] arm64/vmcore: Add pgtable_l5_enabled information in
 vmcoreinfo
Message-ID: <20240827122459.GA4679@willie-the-truck>
References: <20240826065219.305963-1-kuan-ying.lee@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240826065219.305963-1-kuan-ying.lee@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_052506_331822_48A698E2 
X-CRM114-Status: GOOD (  12.16  )
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

On Mon, Aug 26, 2024 at 02:52:02PM +0800, Kuan-Ying Lee wrote:
> Since arm64 supports 5-level page tables, we need to add this
> information to vmcoreinfo to make debug tools know if 5-level
> page table is enabled or not.
> 
> Missing this information will break the debug tool like crash [1].
> 
> [1] https://github.com/crash-utility/crash
> 
> Signed-off-by: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
> ---
>  Documentation/admin-guide/kdump/vmcoreinfo.rst | 6 ++++++
>  arch/arm64/kernel/vmcore_info.c                | 3 +++
>  2 files changed, 9 insertions(+)

In which case, wouldn't you also want to know about pgtable_l4_enabled()?

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
