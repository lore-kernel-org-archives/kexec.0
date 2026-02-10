Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A23EA8114
	for <kexec@archiver.kernel.org>; Tue, 10 Feb 2026 13:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Unc9qKAicQ/3X4+uqvXt+dYinmIoJsSf6GoPz9zE95w=; b=DstSKYPKCzLahAaTCu6CYdxRw4
	P/5/iBkuSXPJksgtwD9eKr60aHRxGCCdwcoAf8r7GmVP9MBCIE+j4T7fSL1FhgCmUh7HBLBamAqc2
	kbjnTYl9/Mr6wHi+WFmmmVu93v/qWdIdhaMk9gfKiUYVbMdaqMmR2L9l5qYYSwPUR3iD4K4rYFzYI
	rhUopWwrM5vtj8gixq/tkWfEBUQ3zN630/K6dkNkmRenzaZvIS54la2H/6N+t17v90A3kBbRqvCoH
	bYU7iMb3syVYaygsB8c5KpYCvG7Uro0NJj2++QPRDPeW5Na/DKregNS8+Ecp0XyuK/1f0U24IWNMT
	ZMuSCUnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpnzL-0000000H08h-2joh;
	Tue, 10 Feb 2026 13:41:11 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpnzJ-0000000H08M-3OTJ
	for kexec@lists.infradead.org;
	Tue, 10 Feb 2026 13:41:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4E73541A8D;
	Tue, 10 Feb 2026 13:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9288C116C6;
	Tue, 10 Feb 2026 13:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770730868;
	bh=MT+rctIKmuvnA5eIBAxzoWBQTwTyMz/PD/htQtTMRHA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nIllKt5tMFMZhddu4EvDabsmw0eHTKy8WZOr+dKIUK3L85tK4gxTBXSx759Vo8FSP
	 UEUEtJQRapO+RGb5Lej1n6r3xYUdyvdxWW6Xey2r3uABmMd57mYgPNF/1Vlizl4A/y
	 2Lan/KlFtdWKApPbiTGiOpjdxcEhW5ODyj7+1LjCroZc7eJcd4z7PKmoVr9lV2hUUR
	 hLDipo1c38yuDNcZaraPl5Four8CUKGTqKpey2Dkjbh8XtIagfqAnKbKvqvYZnrhIb
	 XX/7t3NPvotDvDyaeHdjj7EwR++IqchPlbh/kdhhIuc3QtygKOiXDz2mIWRIrKu/SA
	 o00paYupoA1MA==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Binderman <dcb314@hotmail.com>
Cc: "graf@amazon.com" <graf@amazon.com>,  "rppt@kernel.org"
 <rppt@kernel.org>,  "pasha.tatashin@soleen.com"
 <pasha.tatashin@soleen.com>,  "pratyush@kernel.org" <pratyush@kernel.org>,
  "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
  "linux-mm@kvack.org" <linux-mm@kvack.org>,  LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: linux-6.19-rc8/kernel/liveupdate/kexec_handover.c:1089:
 Possible 32/64 bit mixup ?
In-Reply-To: <VI1PR02MB3952964EF347629B2686A36E9C99A@VI1PR02MB3952.eurprd02.prod.outlook.com>
	(David Binderman's message of "Thu, 5 Feb 2026 09:21:17 +0000")
References: <VI1PR02MB3952964EF347629B2686A36E9C99A@VI1PR02MB3952.eurprd02.prod.outlook.com>
Date: Tue, 10 Feb 2026 14:41:05 +0100
Message-ID: <2vxzzf5gsolq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_054109_872015_BDDB0495 
X-CRM114-Status: GOOD (  15.32  )
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

Hi David,

On Thu, Feb 05 2026, David Binderman wrote:

> Hello there,
>
> Source code analyser cppcheck says:
>
> linux-6.19-rc8/kernel/liveupdate/kexec_handover.c:1089:15: style: int result is
> assigned to long variable. If the variable is long to avoid loss of information,
> then you have loss of information. [truncLongCastAssignment]
>
> Source code is
>
>     contig_pages = (1 << order);
>
> I admit the error message is hard to understand, but AFAIK
> if local variable order remains under 30 or so, then there is no problem.
>
> However, if it goes above 32, then there will be loss of data. 
> Expression 1 << order is type int.
>
> Suggest add some code or comment to document the expected range
> of local variable order. If it ever goes above 32, suggest new code
>
>     contig_pages = 1UL << order;

If order is 32, with 4k pages, that means 16 TiB. It is unlikely that we
will see vmalloc area backed by pages this large any time soon. So I am
not worried about any practical problems.

But I think this is still a good idea to do for code hygiene. So a patch
would be much appreciated.

-- 
Regards,
Pratyush Yadav

