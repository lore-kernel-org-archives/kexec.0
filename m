Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F022C61DD3
	for <kexec@archiver.kernel.org>; Mon, 31 Aug 2026 10:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F2wvnqeVRYzd2zCWHCSdsTWwa6nmQg/2AjbsKl/NI7w=; b=uwFu132mD07/2H5Gv8gke2uCNv
	S1rRgn3S5AwzV31/YGYmWkz6UAyierff98hPJLzdZmTRVJSYqP8mqAargyo+VO6Y4oYCyaawcecdh
	quncpNcVwGMzl6zL5Ck83218pQQg+72wvvn+Bn7lp6hm5dxhXZGQkc+eOVp7gvufRFxSIpeoOuBae
	nEHvHpP0nDoLS+ySy3EJHtUcUkU+51bCa6g7bVLx4ZDArSZf7FU+1oGo1lVfDYqYjDTvUvyftS0zC
	wOTgLx+Zd+tudYUq//p8ZV31VTxqqYsjj7Ce7Yy4EkXz3PdfoIOLS35MmS2H23K4p0ZCeK3DTfRL7
	POAQUbgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0zIz-0000000976r-1t1v;
	Mon, 31 Aug 2026 10:31:57 +0000
Received: from pandora.armlinux.org.uk ([2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0zIv-00000009761-3qlE
	for kexec@lists.infradead.org;
	Mon, 31 Aug 2026 10:31:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F2wvnqeVRYzd2zCWHCSdsTWwa6nmQg/2AjbsKl/NI7w=; b=tGNjNZLCGJF/wYH1Fj2DqH0vFP
	H995FlJYuunQY/xi8dYS5pQ4qWTdTFvsRpC1PuRIMVnyNRPJQ8d80093lz0KKNBI+PYGW+5FuB981
	wx7lCLNF4G+4uloJUKPww/GjVJXHmR6dY2RpDS2ioFsi6uaG9SDKX5Adz4cahStMnPQCV4Vj2MGBM
	374asVpfv21PGkHSVIQHCPJH47jSr9A/IwG7FpAJsRmCG4WwiofZGWJBCe9XLCwEryKR4Q+0p2CnH
	9lwcKuTdItHTYcHYE65EdfyN1j4AmU/et0J5Zw9UZOD0yH46bxV8c05lDTsN/CngxEhZDuat+WHzG
	IfP4wZWg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44374)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1x0zIq-000000004p6-06FW;
	Mon, 31 Aug 2026 11:31:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1x0zIn-000000004Wg-0JNe;
	Mon, 31 Aug 2026 11:31:45 +0100
Date: Mon, 31 Aug 2026 11:31:44 +0100
From: Russell King <linux@armlinux.org.uk>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Simon Horman <horms@kernel.org>, j.neuschaefer@gmx.net
Subject: Re: [PATCH kexec-tools] arm-zImage: prepare for more malloc
 requirements of zstd
Message-ID: <apVYEC-uTnadmbnT@shell.armlinux.org.uk>
References: <20260829094607.689485-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260829094607.689485-1-andreas@kemnade.info>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260831_033154_258178_66DD751E 
X-CRM114-Status: GOOD (  11.89  )
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

On Sat, Aug 29, 2026 at 11:46:07AM +0200, Andreas Kemnade wrote:
> As there are plans for zstd in zImage for ARM, which requires more malloc
> size fo, decompression, increase the space.
> 
> References:
> https://lore.kernel.org/lkml/ZFDMRst2O+RJUYuu@shell.armlinux.org.uk/#t
> https://lore.kernel.org/lkml/20260828-zstd2-v2-0-4d9ce7150877@kemnade.info/
> 
> Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

There's a better way to deal with this, added in commit adc5f7029376
("ARM: add malloc size to decompressor kexec size structure") in the
kernel. An additional member was added to the magic structure which
indicates the required malloc size.

In kexec-tools, this structure can be found as "struct zimage_tag"
but it is missing the extended entry in struct zimage_krnl_size.

This still requires the 4k stack to be added, but will give you the
size of the malloc. If this member is missing, then 64k should be
assumed.

Note that tag->hdr.size checks in kexec look incorrect, as this is
the number of 32-bit words from the start of the tag. It also looks
like find_extension_tag() assumes it's bytes rather than 32-bit
words. :(

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

