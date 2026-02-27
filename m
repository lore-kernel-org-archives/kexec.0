Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4EDFEFB73
	for <kexec@archiver.kernel.org>; Fri, 27 Feb 2026 17:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K2yQm0oOGTcRJfhcrEhEmD0poePPSAOAfmgoK4/aZLQ=; b=ee287G8r5BE+aAbeXQ/2TMLBAH
	BFWl6ojGU46rJkk+zUXPD++K39CMi060yFyOn8CSJRKlrsTMtDmUHbKZ0jjwd3oQLRcVS6o93wJGl
	znxS4Y9wQ2CqMhfSyYiOEkHcrdR+MFW+0rP0YmMYMsaozxUXWRrNCfxNnSBcNzkUGPh7KWWXhIRXp
	plFAaOCoLS9xOjT2Adgqc1T7rBZFCyWPI1rzsa05qMIipdCLUDYrMtIfpg68yrzbhpViO71eOFE1w
	7inbiZaZ3obVWUcF15Yzt53Tvv7X8H9uVpaOwiNbXikHqMNpiahyVXanOqP/fHU5f6yel9agPMxL9
	Wya4v+ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw260-00000008rzM-0RY6;
	Fri, 27 Feb 2026 17:57:48 +0000
Received: from flow-b3-smtp.messagingengine.com ([202.12.124.138])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw25i-00000008rgl-3mLY
	for kexec@lists.infradead.org;
	Fri, 27 Feb 2026 17:57:45 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 3F62C1300E62;
	Fri, 27 Feb 2026 12:57:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 27 Feb 2026 12:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772215047;
	 x=1772222247; bh=K2yQm0oOGTcRJfhcrEhEmD0poePPSAOAfmgoK4/aZLQ=; b=
	aat5WdROMFK4MIAhDBYWwdq0MIcDck8De3aplVKiAQDST6EhMB5PcW5tdYpMASS+
	Lwzt8PZ2t/Vks2Gz4X5ZD6pdN26+IdzlXQZqudjRIN25E+9WKMhgqSWnxhjoWCuU
	Vvy+OwWxDo/e5yr0fnLuFRHymkkXqvE8y6wWzNE3Ojj+EoITsFc3+feRRhqKx7uw
	QCtWIHCyzSB2nG8tHB3q5wtWzmKHRV3bhThUKDX8lSL5eLjDzt9Ltx1XWwPicyHc
	gBFcO+3nfj61Pc3XM1/KVRAyL71hj680c6ci4mtUugl5CjPxlzT1d41uQ+cB3Kjw
	/SxMAZO1OqzqUyUmadPSPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772215047; x=
	1772222247; bh=K2yQm0oOGTcRJfhcrEhEmD0poePPSAOAfmgoK4/aZLQ=; b=W
	xqmtJcO9/vYtHkLC8ry/T0H4riRZtlEP84tsZsbvOF7uyDV2DhRDT9EFxWz8XiZ3
	5YimAM/blxiy5DiQdzLbwfFBeoCdw5gLmTW9CVQOea7C3zb0AyB1sf1XS+wmfv3Q
	Ds3c8w7JL5YsaMfC5Al7JyE92WwHtRZLH8a0uMk94qa9MVsfoP6yhSuvimDw6m7/
	0Vz8KIDNfDn+zdyVaa/tMTWGIwc8UccFyxqFQglgrsg4CseIls3XRYZIDO4ePIei
	HCyVzy589uVArJ51VYsNvO/jUSHwDM0rW/z2eNUHdq2EX5myg0+WDdo9RdMlxi0o
	IsS6cWHKbOS2VNTCGTGUw==
X-ME-Sender: <xms:BtuhaeIZ2jS2UzpJd553k8XHA1Sp13wdZhBu7QQZtWIcByVOCp_UKg>
    <xme:BtuhaS8hJK-hkPnFru1C9zc1y9z6dwFIhx7qBKUOL3_IP1aZ0UeNjHLjD_ZPtaIJb
    Ap74DRRikSk2ywtNYvGEudDqP4xYKNin3E1E33BFNp5CKHwOsAWgQ>
X-ME-Received: <xmr:BtuhaS7gLyrUe-l3rxzVCz0cLdnzfbW-UmoTkvJBStG9ul5e7o1ztrntfSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeegudevhfejueefveduieeuueeifeettdekveekhffgvdetfeelueehgfdt
    heffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepgeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegumhgrthhlrggtkhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtoheprghjrgihrggthhgrnhgurhgrsehnvhhiughirgdrtghomhdprhgtphht
    thhopehgrhgrfhesrghmrgiiohhnrdgtohhmpdhrtghpthhtoheprghmrghsthhrohesfh
    gsrdgtohhmpdhrtghpthhtoheprghpohhpphhlvgesnhhvihguihgrrdgtohhmpdhrtghp
    thhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtth
    hopegrnhhkihhtrgesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsghhvghlghgrrghs
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopegthhhrihhslheskhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:BtuhaRgx07S3OQW05vQUdMULcKyIxw-lTak2T16g5_r3LQCchEXMMw>
    <xmx:BtuhaZgs_wOwuGV3uCTzdlPxPYWSRXfna-r2yxAr8x8ogV-5YZqCiQ>
    <xmx:BtuhaX1nJjDQ-xPKXDYD3-xh--mPBEI78fmknqtRndSlh83yiY3kdg>
    <xmx:BtuhaUhbU6JSFEpTI_Y42gSPmoFE2aI-6lqMPTHvgr6MwH-vurp96w>
    <xmx:B9uhaXpqlDvWlnCcYlLipLPhEwUJg3Efvxe_E5IjWKRMOlvzQntJDuNL>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 12:57:22 -0500 (EST)
Date: Fri, 27 Feb 2026 10:57:20 -0700
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
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
Message-ID: <20260227105720.522ca97f@shazbot.org>
In-Reply-To: <CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
References: <20260129212510.967611-1-dmatlack@google.com>
	<20260129212510.967611-11-dmatlack@google.com>
	<20260226170030.5a938c74@shazbot.org>
	<aaDqhjdLyf1qSTSh@google.com>
	<20260227084658.3767d801@shazbot.org>
	<CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_095734_195175_4E533DEB 
X-CRM114-Status: GOOD (  24.49  )
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

On Fri, 27 Feb 2026 09:07:48 -0800
David Matlack <dmatlack@google.com> wrote:

> On Fri, Feb 27, 2026 at 7:47=E2=80=AFAM Alex Williamson <alex@shazbot.org=
> wrote:
> >
> > On Fri, 27 Feb 2026 00:51:18 +0000
> > David Matlack <dmatlack@google.com> wrote:
> > =20
> > > On 2026-02-26 05:00 PM, Alex Williamson wrote: =20
> > > > On Thu, 29 Jan 2026 21:24:57 +0000
> > > > David Matlack <dmatlack@google.com> wrote: =20
> > > > >
> > > > > - vdev->reset_works =3D !ret;
> > > > >   pci_save_state(pdev);
> > > > >   vdev->pci_saved_state =3D pci_store_saved_state(pdev); =20
> > > >
> > > > Isn't this a problem too?  In the first kernel we store the initial,
> > > > post reset state of the device, now we're storing some arbitrary st=
ate.
> > > > This is the state we're restore when the device is closed. =20
> > >
> > > The previous kernel resets the device and restores it back to its
> > > post reset state in vfio_pci_liveupdate_freeze() before handing off
> > > control to the next kernel. So my intention here is that VFIO will
> > > receive the device in that state, allowing it to call
> > > pci_store_saved_state() here to capture the post reset state of the
> > > device again.
> > >
> > > Eventually we want to drop the reset in vfio_pci_liveupdate_freeze() =
and
> > > preserve vdev->pci_saved_state across the Live Update. But I was hopi=
ng
> > > to add that in a follow up series to avoid this one getting too long.=
 =20
> >
> > I appreciate reviewing this in smaller chunks, but how does userspace
> > know whether the kernel contains a stub implementation of liveupdate or
> > behaves according to the end goal? =20
>=20
> Would a new VFIO_DEVICE_INFO_CAP be a good way to communicate this
> information to userspace?

Sorry if I don't have the whole model in my head yet, but is exposing
the restriction to the vfio user of the device sufficient to manage the
liveupdate orchestration?  For example, a VFIO_DEVICE_INFO_CAP pushes
the knowledge to QEMU... what does QEMU do with that knowledge?  Who
imposes the policy decision to decide what support is sufficient?
Thanks,

Alex

