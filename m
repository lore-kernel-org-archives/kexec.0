Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CAA104891F
	for <kexec@archiver.kernel.org>; Fri, 27 Feb 2026 22:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5gDryY4zQRH428jXcjjSGP/R/ZBS8LlxLYxDdPgkkiE=; b=HI69IyUfjDNYmA0/joPGR/Lp3G
	e7Zh2B9yDEsNlNozGoBXefo+b4UIKQCKpLnHBt+JFZll2XE6FkPorWtpY0SZ/R8JDDimtSXB2e41H
	LYsOKTWPFFJon1y1Me+YYBv+NU5bZhMcRZ9jZfXB+ZpcKL3k27jYD9uCkJVcO3JSDbGl5SPDdgoe6
	LajW7Alslr6Yy36RnRJ0X3jllQGJRyrUZSPniMC3ENj0X7gZbvcR1F2FfATig9o9dmF8YXU/scAts
	hHDnU0VBiw1Fxm11rE6Lh9HK44Hjbe+IxhdFm84XMPGloI3ZhdepM0SnW1pTkNWQUIPkc/EsRUKRr
	0/xuzy8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6FO-00000009DSE-0yLB;
	Fri, 27 Feb 2026 22:23:46 +0000
Received: from flow-b4-smtp.messagingengine.com ([202.12.124.139])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6FM-00000009DRt-0C2u
	for kexec@lists.infradead.org;
	Fri, 27 Feb 2026 22:23:45 +0000
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.stl.internal (Postfix) with ESMTP id 617581300E4D;
	Fri, 27 Feb 2026 17:23:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 27 Feb 2026 17:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772231020;
	 x=1772238220; bh=5gDryY4zQRH428jXcjjSGP/R/ZBS8LlxLYxDdPgkkiE=; b=
	ibyQ9xq81ZUFDtngjlebvG4FaCgNpNNbQr1R+mWKzerZDqZJKaMwf0HBblpSPQ91
	VFdvsMyKGU5Tg9sMFl/57BZro8wkMOPw1LWE3jqikOFmHEQcnmlkJjpTO3zUAXow
	XOqfcAa0iIMoieG9RdcB8yL8non1RpY3YX3cBZWsNRzgZoVDHcW4WvsrdYMvRR4O
	kXG9r5jcj3nRPeI3wIZjCqx9pYJ+ovtiJyFyz/zG1Tnpx+Wt4tq5H6UYxb5/xjlk
	lkG0YgCvfdWXxZfC5tYJ4+h6oCW1XZQUWE5ZXPBMY4qfpryKhrz4mlFKl0CtABZh
	ozaeXUkPc0VOpKeMVm0KzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772231020; x=
	1772238220; bh=5gDryY4zQRH428jXcjjSGP/R/ZBS8LlxLYxDdPgkkiE=; b=h
	eYMklfxrT1hKh6s89IGlVCYgodJjyXuEtJzsN6GWawwrgE3RWvsVXiKD+nITWgWN
	uNh/M4JytKcYo90WUBaxX6+sbp0D1FJQarxN9Bl5nKn6toxi0MxhIWTI6N3FuwqC
	O38dHRyoBq/f0uv0cZ0cpvnBSDck1XGNuRuaccj7YkBP9n+efQLf7Dwy5Hdi+GHk
	8YOK86rNlDdXf8PkgONcfllG3kXVA5sq8Bm5XES78tNMaptniFche5ptLjl7/U+u
	AoG867Fox04IbnG/hATygTqTDaZqoKyJxDxYxhOyZQugp7Mthn77Ts4A+ePYYqlV
	Z++xJLYSuIBgqTjIBJbjg==
X-ME-Sender: <xms:ZhmiaTqQpfHE1fOXkXhzKjbpYL9Yr0pf-ceFjB6YPvRSGWBU1Ok5Eg>
    <xme:ZhmiaWpKATxZf0QUyqaYcd-5hQ6sPzPCE5RK_NWP5U50Ly0JADS68CrX2pDqRubi0
    NRsKG0qW5uMqo9Qv9rFyGUBShb1aqFQUKn-lJVJvFbN5ytXZJ2VBg>
X-ME-Received: <xmr:ZhmiaZ7-_PGS79ULJoNU-MK8CiMWbivAY9WumbCm0ZFBs9Fvq0YS9WcGEe8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvhedtudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeetuefgleefhfdvueegffdtffevhfffgfffiedutdetgffhheejtdekfeek
    ieehgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
    pdhnsggprhgtphhtthhopeegiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    hmrghtlhgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehhvghlghgrrghssehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegrjhgrhigrtghhrghnughrrgesnhhvihguih
    grrdgtohhmpdhrtghpthhtohepghhrrghfsegrmhgriihonhdrtghomhdprhgtphhtthho
    pegrmhgrshhtrhhosehfsgdrtghomhdprhgtphhtthhopegrphhophhplhgvsehnvhhiug
    hirgdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhn
    rdhorhhgpdhrtghpthhtoheprghnkhhithgrsehnvhhiughirgdrtghomhdprhgtphhtth
    hopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:Zhmiad2sbjfkxksva4ZZqUdWmMjzHkXGC5X8v-2AP5oEUrr0XTMl1A>
    <xmx:ZhmiaVlE8cxGOSiEybB2C9Afiqd60myTjWnbPqKtENleQaquZovVjA>
    <xmx:ZhmiaWieRutAuXs_kAh6v5Y6dFLmaFCfa8MUC0xje_WFkspzBxewcA>
    <xmx:Zhmiac30mxy-wDrums-gZ6YprIYdP06ito0nnSpm_CQ9sTCgWFmiig>
    <xmx:bBmiacvgXgNhRla-HV46CCK5l8R8PlNCFfSmuJ_LXC__y0uuR4tYHQ8Z>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 17:23:31 -0500 (EST)
Date: Fri, 27 Feb 2026 15:23:30 -0700
From: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Adithya Jayachandran <ajayachandra@nvidia.com>,
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
Subject: Re: [PATCH v2 02/22] PCI: Add API to track PCI devices preserved
 across Live Update
Message-ID: <20260227152330.1b2b0ebb@shazbot.org>
In-Reply-To: <CALzav=egQgG-eHjrjpznGnyf-gpdErSUU_L8y82rbp5u=rQ83A@mail.gmail.com>
References: <20260129212510.967611-3-dmatlack@google.com>
	<20260225224651.GA3711085@bhelgaas>
	<aZ-TrC8P0tLYhxXO@google.com>
	<20260227093233.45891424@shazbot.org>
	<CALzav=dxthSXYo13rOjY710uNbu=6UjzD-OJKm-Xt=wR7oc0mg@mail.gmail.com>
	<20260227112501.465e2a86@shazbot.org>
	<CALzav=egQgG-eHjrjpznGnyf-gpdErSUU_L8y82rbp5u=rQ83A@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_142344_196520_3A0EE4C0 
X-CRM114-Status: GOOD (  41.29  )
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

On Fri, 27 Feb 2026 14:19:45 -0800
David Matlack <dmatlack@google.com> wrote:

> On Fri, Feb 27, 2026 at 10:25=E2=80=AFAM Alex Williamson <alex@shazbot.or=
g> wrote:
> >
> > On Fri, 27 Feb 2026 09:19:28 -0800
> > David Matlack <dmatlack@google.com> wrote:
> > =20
> > > On Fri, Feb 27, 2026 at 8:32=E2=80=AFAM Alex Williamson <alex@shazbot=
.org> wrote: =20
> > > >
> > > > On Thu, 26 Feb 2026 00:28:28 +0000
> > > > David Matlack <dmatlack@google.com> wrote: =20
> > > > > > > +static int pci_flb_preserve(struct liveupdate_flb_op_args *a=
rgs)
> > > > > > > +{
> > > > > > > + struct pci_dev *dev =3D NULL;
> > > > > > > + int max_nr_devices =3D 0;
> > > > > > > + struct pci_ser *ser;
> > > > > > > + unsigned long size;
> > > > > > > +
> > > > > > > + for_each_pci_dev(dev)
> > > > > > > +         max_nr_devices++; =20
> > > > > >
> > > > > > How is this protected against hotplug? =20
> > > > >
> > > > > Pranjal raised this as well. Here was my reply:
> > > > >
> > > > > .  Yes, it's possible to run out space to preserve devices if dev=
ices are
> > > > > .  hot-plugged and then preserved. But I think it's better to def=
er
> > > > > .  handling such a use-case exists (unless you see an obvious sim=
ple
> > > > > .  solution). So far I am not seeing preserving hot-plugged devic=
es
> > > > > .  across Live Update as a high priority use-case to support.
> > > > >
> > > > > I am going to add a comment here in the next revision to clarify =
that.
> > > > > I will also add a comment clarifying why this code doesn't bother=
 to
> > > > > account for VFs created after this call (preserving VFs are expli=
citly
> > > > > disallowed to be preserved in this patch since they require addit=
ional
> > > > > support). =20
> > > >
> > > > TBH, without SR-IOV support and some examples of in-kernel PF
> > > > preservation in support of vfio-pci VFs, it seems like this only
> > > > supports a very niche use case. =20
> > >
> > > The intent is to start by supporting a simple use-case and expand to
> > > more complex scenarios over time, including preserving VFs. Full GPU
> > > passthrough is common at cloud providers so even non-VF preservation
> > > support is valuable.
> > > =20
> > > > I expect the majority of vfio-pci
> > > > devices are VFs and I don't think we want to present a solution whe=
re
> > > > the requirement is to move the PF driver to userspace. =20
> > >
> > > JasonG recommended the upstream support for VF preservation be limited
> > > to cases where the PF is also bound to VFIO:
> > >
> > >   https://lore.kernel.org/lkml/20251003120358.GL3195829@ziepe.ca/
> > >
> > > Within Google we have a way to support in-kernel PF drivers but we are
> > > trying to focus on simpler use-cases first upstream.
> > > =20
> > > > It's not clear,
> > > > for example, how we can have vfio-pci variant drivers relying on
> > > > in-kernel channels to PF drivers to support migration in this model=
. =20
> > >
> > > Agree this still needs to be fleshed out and designed. I think the
> > > roadmap will be something like:
> > >
> > >  1. Get non-VF preservation working end-to-end (device fully preserved
> > > and doing DMA continuously during Live Update).
> > >  2. Extend to support VF preservation where the PF is also bound to v=
fio-pci.
> > >  3. (Maybe) Extend to support in-kernel PF drivers.
> > >
> > > This series is the first step of #1. I have line of sight to how #2
> > > could work since it's all VFIO. =20
> >
> > Without 3, does this become a mainstream feature? =20
>=20
> I do think there will be enough demand for (3) that it will be worth
> doing. But I also think ordering the steps this way makes sense from
> an iterative development point of view.
>=20
> > There's obviously a knee jerk reaction that moving PF drivers into
> > userspace is a means to circumvent the GPL that was evident at LPC,
> > even if the real reason is "in-kernel is hard".
> >
> > Related to that, there's also not much difference between a userspace
> > driver and an out-of-tree driver when it comes to adding in-kernel code
> > for their specific support requirements.  Therefore, unless migration is
> > entirely accomplished via a shared dmabuf between PF and VF,
> > orchestrated through userspace, I'm not sure how we get to migration,
> > making KHO vs migration a binary choice.  I have trouble seeing how
> > that's a viable intermediate step.  Thanks, =20
>=20
> What do you mean by "migration" in this context?

Live migration support, it's the primary use case currently where we
have vfio-pci variant drivers on VFs communicating with in-kernel PF
drivers.  Thanks,

Alex

