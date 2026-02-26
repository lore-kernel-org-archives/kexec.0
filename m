Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CFEFD9E1F
	for <kexec@archiver.kernel.org>; Thu, 26 Feb 2026 23:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=du7fewflJTiy4RY4M9JcEhPtcfpcGR3V2HHqx7PYFdQ=; b=yg0mYVq+KOVrP+KDn9fisbZI//
	ptSzJzIY6FW5/I8nPfmSNsSZ01AnChWVx4d1tEa6jLUYuwACKRIVBHgYUAoOOGEFHNbOYo+rfPWeN
	tFC1AfKaf1e/u3S0+APfQ7Z3WMKs/zbdxB1Kh9Ke2FYVjM+QOM1aT3u0d1TydSViFN/6X6ZP6cvip
	XGKTJAxak3qMXYa8I/i8K6pxYKduOp5rinFaHcS/afLOmtv+giID/dkmXSYa8zeg8u0uCU4CelN8H
	Qv6koupdw0TU5y5hC+yEHCAJ6aRXp0i31J5xWDuK/rtjQgPqAKrB9j8wCZCeftOMvU5CayTkkb7Lw
	UyHj3qfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvl0H-00000007OOr-41Yo;
	Thu, 26 Feb 2026 23:42:45 +0000
Received: from flow-b7-smtp.messagingengine.com ([202.12.124.142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvl0G-00000007OOV-0yzZ
	for kexec@lists.infradead.org;
	Thu, 26 Feb 2026 23:42:45 +0000
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id B11A81300CD7;
	Thu, 26 Feb 2026 18:42:41 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 26 Feb 2026 18:42:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772149361;
	 x=1772156561; bh=du7fewflJTiy4RY4M9JcEhPtcfpcGR3V2HHqx7PYFdQ=; b=
	gLN0v/HGUd/V0nfv+tewCC0psNtLQyjZbWvqVO9SniKU+XNel86qvzNsxsTS2rhP
	+Sasie1tUUqBrpPWrS09obG6ygRmkANwrxgWOkCDM99YeG1dyTDlauIbYKRX8PE2
	WMakPQx/cPdRv4HjyoQeOHuAIZTAsaIRiUHu3wpM4uMYzA7nCBVjEz06MLdEm41A
	Sd4QgIB3SB6ZjLRB8hTA+mwlxHlwx7LRGMAhY+tlWeo8q2rfRxajhWY6qzz8WA9h
	w990EEzbp4MIikkoNHGMBz72bsWhYPccOx4lL3iso06dObf9sebg+f59s/ouRF2H
	bgZsfIzIQ8mNqjwY526TqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772149361; x=
	1772156561; bh=du7fewflJTiy4RY4M9JcEhPtcfpcGR3V2HHqx7PYFdQ=; b=A
	Vqkdu04ZkIyGghzqKCUsqcO0POg3Ui7ZMXshuBnxTI388SOk5n10HzYar+rqSDAe
	C/6uGkhD0UC469ivtIUm6MMC5QT+s8RjGroeEQvOS7hXEzSI7hPHQ1ifklfb12AJ
	PZd4rLcWNzS3UBm315m+HpVcQYcoJZ47S4md1oBQZBtfB/90epcrjjt5NDuahanp
	yQ3OJeL9M9U+r3JPhk7hScLGNo3WIMaBA+LMuiOdPtSeCN+7DALf2bLoYs+W0zFh
	vTB1GITGhgd6ioaYRTmpsF+ZbOVhD3SSJMh1OEJPx8/oaB0nIvL/n0pYvarZcmQ1
	/SgJdlDJNbNiv4KcTcrxQ==
X-ME-Sender: <xms:cNqgaXpMmxoB3kSOky1mjx1TJLbpYE_Q3lq2_z-dSIS4jA6vVHQ8qA>
    <xme:cNqgaec7-4keVSCV7QvjAX8g0Bou_cq9lPLalblxCAnCUWGc4psij64v2CSOOGvJO
    09nNikj6hf5yRVfrj5XEWa0utzNlcS8aA1clUFTK3T5w5NPDwIqAQ>
X-ME-Received: <xmr:cNqgaYaQZ8vQYnZbKPuXo5gMhT_Lqft1yYIxjfNrQSAa3SsKG1FQ_U4-QlY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepgeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegumhgrthhlrggtkhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtoheprghjrgihrggthhgrnhgurhgrsehnvhhiughirgdrtghomhdprhgtphht
    thhopehgrhgrfhesrghmrgiiohhnrdgtohhmpdhrtghpthhtoheprghmrghsthhrohesfh
    gsrdgtohhmpdhrtghpthhtoheprghpohhpphhlvgesnhhvihguihgrrdgtohhmpdhrtghp
    thhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtth
    hopegrnhhkihhtrgesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsghhvghlghgrrghs
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopegthhhrihhslheskhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:cNqgaZBWGEMBMo6wAeDnQPoMQ1RB3_FyXD2bgYUBYWWoy3Nil71WIQ>
    <xmx:cNqgabDwuVEK97fr6qnquLcLxnx5_OEE9X7aEzrRhC22YMC0y9IyVw>
    <xmx:cNqgabV1-aqR1IFCc4MWo42xThetUjXbFjeGkiZ1NoD4KZoSUHe_tw>
    <xmx:cNqgaSC5ljiRgzmy6yv2HrPe3PYxrEU4Q8gCyruiHKSfRU2iM0Ohlw>
    <xmx:cdqgadKScMQkDT3KYeKNbDm9q2hUFzCVi1EFn1C9LtAtHYSjWGZ0Cjjz>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 18:42:37 -0500 (EST)
Date: Thu, 26 Feb 2026 16:42:36 -0700
From: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>,
 Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
 Alistair Popple <apopple@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>,
 Jacob Pan <jacob.pan@linux.microsoft.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
 Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org,
 kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>,
 =?UTF-8?B?TWlj?= =?UTF-8?B?aGHFgg==?= Winiarski
 <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>,
 Parav Pandit <parav@nvidia.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pranjal Shrivastava <praan@google.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 Raghavendra Rao Ananta <rananta@google.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Samiullah Khawaja <skhawaja@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?= <thomas.hellstrom@linux.intel.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Zhu Yanjun <yanjun.zhu@linux.dev>, alex@shazbot.org
Subject: Re: [PATCH v2 08/22] vfio: Enforce preserved devices are retrieved
 via LIVEUPDATE_SESSION_RETRIEVE_FD
Message-ID: <20260226164236.1d091ffe@shazbot.org>
In-Reply-To: <aaDW86eWuQLZ3cfP@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
	<20260129212510.967611-9-dmatlack@google.com>
	<20260226161512.532609ec@shazbot.org>
	<aaDW86eWuQLZ3cfP@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_154244_691870_0F929ED8 
X-CRM114-Status: GOOD (  15.98  )
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

On Thu, 26 Feb 2026 23:27:47 +0000
David Matlack <dmatlack@google.com> wrote:

> On 2026-02-26 04:15 PM, Alex Williamson wrote:
> > On Thu, 29 Jan 2026 21:24:55 +0000 David Matlack <dmatlack@google.com> wrote:  
> 
> > > +	/*
> > > +	 * This device was preserved across a Live Update. Accessing it via
> > > +	 * VFIO_GROUP_GET_DEVICE_FD is not allowed.
> > > +	 */
> > > +	if (vfio_liveupdate_incoming_is_preserved(device)) {
> > > +		vfio_device_put_registration(device);
> > > +		return -EBUSY;  
> > 
> > Is this an EPERM issue then?  
> 
> I was thinking EBUSY in the sense that the device is only temporarily
> inaccesible through this interface due it being in a preserved state as
> part of a Live Update. Once the preserved device file is retreived and
> closed, the device can be accessed again through
> VFIO_GROUP_GET_DEVICE_FD.
> 
> EPERM might lead to confusion that there is a filesystem permission
> issue?

Ok, fair explanation.  Thanks,

Alex

