Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD23C4345F
	for <kexec@archiver.kernel.org>; Fri, 26 Apr 2024 17:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7osVNJZPnGYDLK22TfRWNNmuLCxAg5Z70FUqzmp31TA=; b=KwKHxiigSa5kfI
	K/xXFYTLV3CsYNmR46kcAUwN8loZgia3qvjABDlOwPXysX+0QR3PFMfF3jW1m+EMH+j1oHoG/U0jo
	1hatK5ikhXRCeGIYUcF6cQ7jzJ6ubntZQSGZwpV4y4lFoEPOSb9KEBj/COwzVS74MCft72jBaggUh
	bn290WXCSTYpct8gPQes7HtuvP4lhcqlWeRBnIfEQkhoH6ZmMzZdDpxlsK1uHJXvU1X4ZX8g7upSI
	R7ZEcNoWLV2uJ8CBZzIPKmbkCadAty25dGH1Z65QZdTAdQ+Yhzvg0OeIMkg/borzzP/1MOwGQtg+3
	rAuwBY2xDxuROput73PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0Pai-0000000DWwl-0T2K;
	Fri, 26 Apr 2024 17:42:32 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0Pae-0000000DWvH-2SjJ
	for kexec@lists.infradead.org;
	Fri, 26 Apr 2024 17:42:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 5092DCE1B1B;
	Fri, 26 Apr 2024 17:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3BEC113CD;
	Fri, 26 Apr 2024 17:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714153345;
	bh=Kut+zJqpf1IRNFtLCk9FE2VRXFU5PgNSr7K2pG5olwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=abDfLkzioJNHuFTarN8VgVX07rGK4ru4W7VN91ShsXt6G7zyxNMXegf+v4VXwOEo9
	 tvIhtzPrY5Uls2FGafDiX0AqzKHH4Bf0LqqLZsR50sySomTqv/GOEc/t/D8DyuhS4s
	 nLnePkNM6+egy8HdoBmPkSZkgL5Ybx5LbhX71KIqm/NuFeSytKgqcfxMDKgREaujNZ
	 EWEW+4P1vGH8h5WnC7rR2g2jGJktwMnVY3DC9YwACa4C7jU6PJ15EnOmhGzRVGm8Vp
	 OUg1KMfC0w6FysOtLbh3BZ5pjMFZFAZAoEaX5ac65uhcmcSSdEPxT86NLqitAA+B0K
	 9cSMX/W68hV6A==
Date: Fri, 26 Apr 2024 18:42:22 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Kanavin <alex@linutronix.de>
Cc: kexec@lists.infradead.org, Haiqing Bai <Haiqing.Bai@windriver.com>,
	fredrik.markstrom@gmail.com
Subject: Re: [kexec-tools][PATCH] ARM: Fix add_buffer_phys_virt() align issue
Message-ID: <20240426174222.GA516117@kernel.org>
References: <20240424121727.979683-1-alex@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240424121727.979683-1-alex@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240426_104228_976125_DC634C84 
X-CRM114-Status: UNSURE (   8.29  )
X-CRM114-Notice: Please train this message.
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

On Wed, Apr 24, 2024 at 02:17:27PM +0200, Alexander Kanavin wrote:
> From: Haiqing Bai <Haiqing.Bai@windriver.com>
> 
> When "CONFIG_ARM_LPAE" is enabled,3 level page table
> is used by MMU, the "SECTION_SIZE" is defined with
> (1 << 21), but 'add_buffer_phys_virt()' hardcode this
> to (1 << 20).
> 
> Suggested-By: fredrik.markstrom@gmail.com
> Signed-off-by: Haiqing Bai <Haiqing.Bai@windriver.com>
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
