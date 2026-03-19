Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596DE1090255
	for <kexec@archiver.kernel.org>; Thu, 19 Mar 2026 16:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8r3Rrhjz62mzvDnQKQk9Pz54iwWA+pJBFG61+YWArBw=; b=ACl4CfY7su1P4cBqeRK0gCQ/C1
	jsYSXlpX8SQlpVn9No/Nub1HOB8ECMSCzOjAeFFJ90QZ77jl0wAYrsSepZiDYQQVIuDFpTTJ137uR
	T3Ozh1fxHz+fSXab3+1JwYycFe/1acKxLzI8t2jeik0DtLm3cyHqnSe7UiF8yUVD5C/NQaHFdnCdo
	IpZYCvqY4PmFWpvGVYUs7+EzkY+Lby/vhm31haRllJO5HeVnezbHo5TLeMczJPHaqN0QGq7pqMedU
	shl9GLZ71X/yXsm4cLbEk1jFSPly8kIkKLRfmWsrWg+MxdiMp7F1nTrynsXO9YXlfDpto2Ou1NZZl
	pdGVpSOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3GPK-0000000B6Gt-0E8t;
	Thu, 19 Mar 2026 16:39:38 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3GPH-0000000B6GO-3Bz5
	for kexec@lists.infradead.org;
	Thu, 19 Mar 2026 16:39:36 +0000
Received: from localhost (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id 744CF20B710C;
	Thu, 19 Mar 2026 09:39:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 744CF20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773938375;
	bh=8r3Rrhjz62mzvDnQKQk9Pz54iwWA+pJBFG61+YWArBw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bmMuGENdC7hPcV8u5wKM+LeF+mgtVIFSJy2h9p6W0i9+tl+Hp7PwExVnUfQO1xHwB
	 Ouf5VcCqaSQUs5qKCHuxTDWMmMZ137/dgQcmFiu/HC6R4d58LdmNNYeQegg7/tAA4c
	 QVfQmqGCCPaKOdhfIjpxs7czL0tSUxWhHGO5GW4k=
Date: Thu, 19 Mar 2026 09:39:32 -0700
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
 linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, =?UTF-8?Q?Mich?=
 =?UTF-8?Q?a=C5=82?= Winiarski <michal.winiarski@intel.com>, Mike Rapoport
 <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>,
 Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta
 <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Thomas =?UTF-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Vipin Sharma <vipinsh@google.com>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu
 <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
Message-ID: <20260319093932.000078c2@linux.microsoft.com>
In-Reply-To: <CALzav=eGLpo5nrsHq5L8bUTC=FWZ-SgrTE1FoScrWB4p+NDgnA@mail.gmail.com>
References: <20260129212510.967611-1-dmatlack@google.com>
	<20260129212510.967611-11-dmatlack@google.com>
	<20260226170030.5a938c74@shazbot.org>
	<aaDqhjdLyf1qSTSh@google.com>
	<20260227084658.3767d801@shazbot.org>
	<CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
	<20260227105720.522ca97f@shazbot.org>
	<CALzav=fjRPa_ZbXu7iFXyemcf_8Kq_dZTWT6c-A0bc6czF_Rdw@mail.gmail.com>
	<abNOwcOTXqxCxNzt@google.com>
	<20260313083918.00005731@linux.microsoft.com>
	<CALzav=eGLpo5nrsHq5L8bUTC=FWZ-SgrTE1FoScrWB4p+NDgnA@mail.gmail.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260319_093935_845840_645F0D0A 
X-CRM114-Status: GOOD (  24.11  )
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

On Mon, 16 Mar 2026 11:11:20 -0700
David Matlack <dmatlack@google.com> wrote:

> On Fri, Mar 13, 2026 at 8:39=E2=80=AFAM Jacob Pan
> <jacob.pan@linux.microsoft.com> wrote:
> > On Thu, 12 Mar 2026 23:39:45 +0000
> > David Matlack <dmatlack@google.com> wrote: =20
>=20
> > > +config VFIO_PCI_LIVEUPDATE
> > > +       bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> > > +       depends on LIVEUPDATE && VFIO_PCI
> > > +       help
> > > +         Support for preserving devices bound to vfio-pci across
> > > a Live
> > > +         Update. The eventual goal is that preserved devices can
> > > run
> > > +         uninterrupted during a Live Update, including DMA to
> > > preserved
> > > +         memory buffers and P2P. However there are many steps
> > > still needed to
> > > +         achieve this, including:
> > > +
> > > +          - Preservation of iommufd files
> > > +          - Preservation of IOMMU driver state =20
> > In the interim, what do you think about moving forward with noiommu
> > mode without preserving IOMMU driver state? =20
>=20
> I haven't gotten a chance to look at your noiommu patches yet, but I
> do think noiommu will probably be a good way to develop the VFIO and
> PCI support for Live Update without blocking on IOMMU driver support.
>=20
> > I=E2=80=99ve tested your
> > vfio_pci_liveupdate_kexec_test with the noiommu cdev, and it works
> > as expected. =20
>=20
> Would you be able to send patches to add noiommu support to VFIO
> selftests? That would be very helpful toward allowing us to develop
> and test Live Update support with noiommu.

It is included in the noiommu patchset; the only difference is that the
VFIO cdev name is prefixed with noiommu, which is not strictly required
and is done out of caution.

/dev/vfio/
|-- devices
|   `-- noiommu-vfio0

https://lore.kernel.org/linux-iommu/20260312155637.376854-10-jacob.pan@linu=
x.microsoft.com/

