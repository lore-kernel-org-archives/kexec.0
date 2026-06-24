Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B38CDE001
	for <kexec@archiver.kernel.org>; Wed, 24 Jun 2026 15:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hxR4MG/qC5C8YyJjFUoDWnC/FyP8VpBZ0QmBHCym7Jc=; b=ApJf2b/GfscgX2In2SfbcJEdEU
	/fqwZ6XXkYcC7J4E3XecQMOK20b3tV+zUsMJpaASApBaxbaMZRjBCgmQVHqld8hV2h4kZVJ/NRwhl
	XzbSsTsDwTS4F+tF9CvOsB30mh7wo6bFuwOiEyMnwhz5+vEbsvFJoAIZ3qSFn0+A0NyFNSdAq6xWV
	ouUWyqTbkGUERbwNQ8POp1H9SvYgwT8+AuwALqnbzR5x6ihnCwwsce/ma8q7s+sgMvQ0ESzvXDlbI
	zngavEirOn5DFXaHa9qgH6TWI1pA28k1HNB/qPQUolFCZH5FS4gkuqemxy0WfTYdkiyBxOfk9E2+a
	mnfu6Efw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcPcJ-000000080dj-2ppb;
	Wed, 24 Jun 2026 15:34:19 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcPcI-000000080dH-1Y3Z
	for kexec@lists.infradead.org;
	Wed, 24 Jun 2026 15:34:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CD8D9600C3;
	Wed, 24 Jun 2026 15:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EA61F00A3A;
	Wed, 24 Jun 2026 15:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782315257;
	bh=hxR4MG/qC5C8YyJjFUoDWnC/FyP8VpBZ0QmBHCym7Jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oRI0U7+d4pDvzhfYUK1ed+TuSP5oghlfHZo0Su1F8FxcdICNXkSeSs4DY/RV372/o
	 powMOBdz/tTa8MLO0R7OzQCtxyDqxaTFkoRaOqLMQKqp34jrVsP0XdO7GtBYdZTCQ+
	 qziKov0A/GLsw4Ww7xn6UzY0UcWJN200TayYN3bl4Fa4bYkRu6wAb36MQoHAldCiWE
	 3fZBcDM53S7l89CPo09IRBNubMDrBRQvmOtuYhnWDQKOsPmLGkP0WaP0Bbux1+MTGZ
	 u/W1b+x0BSb7mJyFQ7OhuTpYd1EzozihuwnT56qe/2g8I5KI6sQ1cdFukFXJlYoD/O
	 WC5C0aB2gvsTw==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 864ACF4008D;
	Wed, 24 Jun 2026 11:34:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 24 Jun 2026 11:34:16 -0400
X-ME-Sender: <xms:-Pg7apme-oZDbyuGaEUN5Op5XWL5n7xmJo5oozSBV7ASo1sMmqKInA>
    <xme:-Pg7allbFYE6YdZtOlFQsAGIbXcJ2_tDM7VLz4A_qvZDpKOX2Fl9R71glXkL987tc
    9_xusqjuBh07ObGr_Jwjm1pAM8uKd61DOtC3yEXgLrrE2FHMeadrnM>
X-ME-Received: <xmr:-Pg7ajcaKx7ZAzReo78iP-2l2yBGDEJaZfiDQ-xWZxqQCD-dSF_MSJ4wr1OV3g>
X-ME-Proxy-Cause: dmFkZTGOIvn2FHCIv9d9YkVJJGv81JNLCBT/TRG37/WouSujzdHvrC/9eKmXzopoMq9cZN
    3CcYHSrqxQp2QnX1h+cq/mkb627F0jaHqwepJxFmYc09ZirIu8o2TR9B/S3eHBvTFYLQKe
    eCNWJxZ9wkRG3GBuTLa5Amg8Ny1KjCXGf3L5T7TM101iROV1LQpHdvbL7eWENMsvtQUkIG
    Z0vWDVdpnuG9YuFHOgRQ3gdOk6wWCTg3tJHtut7C+m4ZDf+18jfhCqVQkgNwe5r1R//JJl
    PbPIxUb5rBU9iyIkzsl24TwZOz8XGSSYuF+XHKtNipFfv2O/n/1Q5bCGBNpA55zvAI5AZ6
    IT4SfaN7a7/1QCgzGPrwFPV3TTsNF0cnRb7irdZpL1JENLpexq9QKsHREPv1COyZW+wwlq
    2jBzOxF5zaz0O2gjTTOYVk6tdQP2RjGsu6ybwanZnizXrtYtnVQL7Qn/qkBHV8KLacuKkt
    nN9Naz6CsVFJRLSqOh79qEOFBers3GyBnON1FoV2wb0vEtHnfaig9tbWEuSWImQXNfdOTx
    odObJryI73zsQMZOiTAg9QPLjOT/3M1bQVgwRYQ5iLfobU3ZZj9sujfs/RVYUjHOElu+6q
    qSF+KhVUW1Aozd/8jDIBI/p7OC117a9bZB04bR4EFk0p3lr0cFHt+1E3472Q
X-ME-Proxy: <xmx:-Pg7arJBtciKspEuJnYrXi1UUnSdNcyn8GYHbIMwzH5tkwNml0L4TQ>
    <xmx:-Pg7am7Y0OkC1V4VD02SnveZJa-s2iffSRjaZ3y0-i4OTCGkFXYK1Q>
    <xmx:-Pg7aiQhOf0vptyHv0cX_gqsemRLvHmkg6Uj8wpCYlxfwlQUjg5lUA>
    <xmx:-Pg7aut13OMmgfcT9zyNJ0y2jq3AQwkrcp8ioZ7C-4DYYZO3sz5Geg>
    <xmx:-Pg7amQCNCFMSIeq1bxFMenPNrVYvkxA5z0_wwhAqRru_dQ7VAgSTp3M>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 11:34:14 -0400 (EDT)
Date: Wed, 24 Jun 2026 16:34:08 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, nao.horiguchi@gmail.com, 
	linmiaohe@huawei.com, david@kernel.org, lance.yang@linux.dev, 
	akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pratyush@kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, rneu@meta.com, riel@surriel.com, 
	caggio@meta.com
Subject: Re: mm/hwpoison: persist poisoned PFN list across kexec via KHO [RFC]
Message-ID: <ajv4f4_m2rQ3hpoW@thinkstation>
References: <ajut_LDQGYCShApx@gmail.com>
 <aju5_WjBtagTOSJw@thinkstation>
 <ajvzUg8KK9gtFTYe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajvzUg8KK9gtFTYe@gmail.com>
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

On Wed, Jun 24, 2026 at 08:21:16AM -0700, Breno Leitao wrote:
> > > Possible solutions
> > > ==================
> > ...
> > > 
> > > 2. e820 / EFI memory map (E820_TYPE_UNUSABLE). Tempting because the
> > >    frame would simply never become RAM (no allocator race at all).
> > >    But: it is x86-only (no arm64 equivalent in the same mechanism;
> > >    this series is tested on arm64);
> > 
> > (+Ard. I might get some details around EFI wrong.)
> > 
> > This isn't accurate, and I think it's the right direction for EFI
> > platforms. EFI_UNUSABLE_MEMORY is honored on both arches today, no new
> > consumer code:
> > 
> >   - arm64: reserve_regions() marks non-usable memory nomap.
> 
> Is it true for non-UEFI arm64 hosts?

No. It is EFI-only thingy.

Is there non-EFI server platforms worth caring about?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

