Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D659BD73EA9
	for <kexec@archiver.kernel.org>; Fri, 30 Jan 2026 00:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5QTLnbHZvfOsZm6P1XTvKuZKL+X4Zqmm8W+hY1sTkg8=; b=zXx8YfHmN9kZkHb9H4DCM4huDR
	9NXC/HccOyW0J+F5cmzlc85McoEU5Vf3FRfIOGB39pqu20O+yyE5wfmn7oSAJhrFEgFXx+ZawyjrG
	XBhkEVpL9V04p5kh7tUWkgJEnIEH7Mljr9yCezvqXFx0se56YCC7CgGQbEo6fOwUdpHROee4otWog
	fv451NtkGHgtMcDsCUOs5UdXog4GBtBjHKExrkomPqJZdMCPp5HSIoWdP8plNq8gSsmgD+yhvojOm
	Yk8Tw/KBlZNo6cAMgwdEkRgw7tssvhdP0GiVZzR5U6Lms1srBg+K6IsWsdsCY0O7/SK72mxYq3pBb
	P5KHhPpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlcQZ-00000000p4W-0AOW;
	Fri, 30 Jan 2026 00:31:59 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlcQW-00000000p4B-0lSK
	for kexec@lists.infradead.org;
	Fri, 30 Jan 2026 00:31:57 +0000
Received: from localhost (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 02ED820B7167;
	Thu, 29 Jan 2026 16:31:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 02ED820B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769733114;
	bh=5QTLnbHZvfOsZm6P1XTvKuZKL+X4Zqmm8W+hY1sTkg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eEaDTQq+Esr/RUhilvTOCceWy537iSweTVrOCQF87LN7ewfzzEyzyd4RUlTpzT2bW
	 kg7uIcbs9tYpacoilvpa5mW4vUKyQ+xSa6CjgGAzcB47rSlnza3XRXVmL0xeyblupb
	 26ODqz1MAroYBEfMeqzG7EalDwPpbFYk2tLsdDZs=
Date: Thu, 29 Jan 2026 16:31:50 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran
 <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro
 <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, David Rientjes
 <rientjes@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke
 <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>,
 kexec@lists.infradead.org, kvm@vger.kernel.org, Leon Romanovsky
 <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, =?utf-8?Q?Mich?=
 =?utf-8?Q?a=C5=82?= Winiarski <michal.winiarski@intel.com>, Mike Rapoport
 <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>,
 Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta
 <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Vipin Sharma <vipinsh@google.com>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu
 <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
Message-ID: <20260129163150.000059a2@linux.microsoft.com>
In-Reply-To: <aXvgKRrbfymW5NKb@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
	<20260129212510.967611-11-dmatlack@google.com>
	<20260129142158.00004cdc@linux.microsoft.com>
	<aXvgKRrbfymW5NKb@google.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260129_163156_271988_13CFEB62 
X-CRM114-Status: GOOD (  29.50  )
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

On Thu, 29 Jan 2026 22:33:13 +0000
David Matlack <dmatlack@google.com> wrote:

> On 2026-01-29 02:21 PM, Jacob Pan wrote:
> > On Thu, 29 Jan 2026 21:24:57 +0000 David Matlack
> > <dmatlack@google.com> wrote: =20
>=20
> > > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > > b/drivers/vfio/pci/vfio_pci_core.c index
> > > b01b94d81e28..c9f73f597797 100644 ---
> > > a/drivers/vfio/pci/vfio_pci_core.c +++
> > > b/drivers/vfio/pci/vfio_pci_core.c @@ -515,12 +515,24 @@ int
> > > vfio_pci_core_enable(struct vfio_pci_core_device *vdev) if (ret)
> > >  		goto out_power;
> > > =20
> > > -	/* If reset fails because of the device lock, fail this
> > > path entirely */
> > > -	ret =3D pci_try_reset_function(pdev);
> > > -	if (ret =3D=3D -EAGAIN)
> > > -		goto out_disable_device;
> > > +	if (vdev->liveupdate_incoming_state) {
> > > +		/*
> > > +		 * This device was preserved by the previous
> > > kernel across a
> > > +		 * Live Update, so it does not need to be reset.
> > > +		 */
> > > +		vdev->reset_works =3D
> > > vdev->liveupdate_incoming_state->reset_works; =20
> >
> > Just wondering what happened to skipping the bus master clearing. I
> > understand this version does not preserve the device itself yet; I=E2=
=80=99m
> > just curious whether there were specific difficulties that led to
> > dropping the earlier patch which skipped clearing bus master. =20
>=20
> Hi Jacob,
>=20
> There's several places where bus master gets cleared that we need to
> eventually eliminate to fully preserve the device.
>=20
>  1. vfio_pci_liveupdate_freeze() clears it during shutdown when it
>     restores vdev->pci_saved_state.
>  2. pci_device_shutdown() clears it during shutdown.
>  3. vfio_pci_core_enable() clears it when the preserved device file
>     is bound to an iommufd after the Live Update (in
>     vfio_pci_core_enable()).
>=20
> I think it would be safe to skip (3) in this series, since that's very
> similar to how this series skips resets during vfio_pci_core_enable()
> for preserved devices.
>=20
> But I don't think it would be safe to skip (1) or (2) until the
> attached iommufd is fully preserved.
>=20
> If you are just asking about (3) then I agree it could be skipped and
> I can include that in the next version.

I was just asking about (3) and trying to understand the asymmetric
handling compared to reset. I don=E2=80=99t have a strong preference since =
this
is temporary=E2=80=94thanks for the explanation.

I=E2=80=99ve been testing my noiommu cdev patches on top of yours, and so f=
ar
they behave the same as with a real IOMMU. As you noted, however, final
device preservation still depends on iommufd.


