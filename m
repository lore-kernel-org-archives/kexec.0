Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAEE109024C
	for <kexec@archiver.kernel.org>; Thu, 19 Mar 2026 16:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H52Zybh5o34dbFpC/ZH35I3IR0TeF3CcjTZ7JtQFu2w=; b=ObmK74Pa/2WB664QG1GNYYjmgz
	++yBxtpbLU0C0jJeS37fDrEmb1JaX/pI2lX7oxpe1hzSoW9sQZ+NJKoaE4akttpuFrXoTsvuiDDg2
	Xl7hUp83B+JtP/gz8alEmlFrfMltoKx/c1wdCukCqOcZaGmcu6YVAPcTi0SRnXAxj8Y5awXyp3ig7
	a0RxVqqsJ4tcfeZr/3Wy4J0yECxya4vzoxy2MXH6vlktJIDjZ9ITovUAyJlJXWolrg+AFnYbbJQK4
	jTTy482myfUl+a3PNdL3+yFdNu2hjnZRTozk07S52Y727IhrxlqlOf1ImVATiAFTs7yJvUETGO9S2
	Mc/fNn6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3GEn-0000000B4lF-060d;
	Thu, 19 Mar 2026 16:28:45 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3GEg-0000000B4kj-2zyy
	for kexec@lists.infradead.org;
	Thu, 19 Mar 2026 16:28:40 +0000
Received: from localhost (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3BEFF20B710C;
	Thu, 19 Mar 2026 09:28:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3BEFF20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773937717;
	bh=H52Zybh5o34dbFpC/ZH35I3IR0TeF3CcjTZ7JtQFu2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qVsoVvGZBgiMTYzcaPymyws/zFtGLAsJuSf42v3omgVhgy4V/7SM/UFdDfZU97k+C
	 vY11I8eol4oictnvBu/vQMefqoMTn+2RHUiOztqmT14YgkRFwnc3yMPdzePNXNxnxC
	 Y01VMPNtIKCj5VPxAbfZbdq9ZRMZ8zsrYw0n9y2U=
Date: Thu, 19 Mar 2026 09:28:35 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>,
 Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf
 <graf@amazon.com>, Alex Mastro <amastro@fb.com>, Alistair Popple
 <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, Ankit
 Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li
 <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet
 <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Kevin Tian
 <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
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
 Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
Message-ID: <20260319092835.00004887@linux.microsoft.com>
In-Reply-To: <20260316162518.GB1767448.vipinsh@google.com>
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
	<20260316162518.GB1767448.vipinsh@google.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260319_092838_807121_19EF5301 
X-CRM114-Status: GOOD (  18.57  )
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

Hi Vipin,

On Mon, 16 Mar 2026 09:28:32 -0700
Vipin Sharma <vipinsh@google.com> wrote:

> On Fri, Mar 13, 2026 at 08:39:18AM -0700, Jacob Pan wrote:
> > Hi David,
> >  =20
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
> > mode without preserving IOMMU driver state? I=E2=80=99ve tested your
> > vfio_pci_liveupdate_kexec_test with the noiommu cdev, and it works
> > as expected.
> >  =20
>=20
> Just curious, are you using qemu VM without iommu device for noiommu
> work or do you have actual system without iommu hardware for testing?

I am using a qemu VM without iommu device and with an assigned
nvme device. I use a low level nvme userspace driver (modified to use
iommufd noiommu mode) for testing.
https://github.com/SamsungDS/libvfn

