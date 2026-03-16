Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C37F53D78
	for <kexec@archiver.kernel.org>; Mon, 16 Mar 2026 17:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jK2scyfYwBMU55V+xfenTzy10C1cc5BhbFAgTj9RHSs=; b=KmZrE3J0kYb4cfJ3Xhzyr+rdpR
	g1JiOiOfOAYgacrkFz4Yad+c+rQJFqFqXh1qklTDhKWPQIxEe8Pr5XJS5eSoOFfHqEfU45pVy5M+V
	exoRy29P3OFamTPNHuopOrFXVbPR1qxm24HGdWFYt9Wizgczk573/8t0XnfESrnp0N0PEpDHh7eqz
	oH/ASASE8PrPlJI6bvhSAmJDbhmFRwdfEpn2HoeofhbHIex39ZHbkq9zdPwm3AHv1yCFdloLVog5t
	QtYMMTrDVA0jl10n9WmYbE66azwQhn1SDiguvFzjb+q0yWwwB8Os7aYf64bWdYKTwaR496blU2cG/
	jqhAhrSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2Baj-00000004XeV-3GPt;
	Mon, 16 Mar 2026 17:18:57 +0000
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2Bag-00000004Xdj-3rCK
	for kexec@lists.infradead.org;
	Mon, 16 Mar 2026 17:18:56 +0000
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-5fff77ff6ddso851029137.1
        for <kexec@lists.infradead.org>; Mon, 16 Mar 2026 10:18:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773681533; cv=none;
        d=google.com; s=arc-20240605;
        b=ETOf/sCLftdBPnhVqrc28KYgHbgiceeToXIJ9zjogY9mPStH5wEc9rGtQ6CYV64knl
         kjMrgkF1kHDqA4UEPjLcDtDxJlRDN9lfBOaPx5+wP+MiYWKouchkRlccbNXV2fO5gxgJ
         iyhNPjuUcW49j/ivd3tiVMQhhlDBA3yXY+73F65v1XIyxu34iEtFF+GCIkPhWT/m02jq
         5wV4TML6ruJlNIHdE07MCCXUaoFEUS7W+F0thy/2kVuzXCcyWdRSQNFvehyHcdfh/bSM
         Eu5oDH0ud7LnnO0jSGzLy4xa4BmWe4nvmbg2P/QOfEyF+aiJiP3UtUah5ASw1qrCaQ0k
         StyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jK2scyfYwBMU55V+xfenTzy10C1cc5BhbFAgTj9RHSs=;
        fh=+lIqGE5Gyh5PxX9A/IAKysLn9n97Xp4AFApKH1Aq0Cg=;
        b=K662+kLYGuT1jE3d7tkqYPTXWhUvLqAQzesIF15qlZHH6UFItWpPL208pqC7Y9Wgpk
         UUQ90BKwBPJ6cTiM88+3puDmp1nYIsR9+lDNyCmVpDqLlN0ZjpdwBD0j9tNGZ5ndDaHT
         XY4CcQg1/03RB58oNrYzd6AEvSHYO8MXQjwjaLUKz92x0jaAXI0+AF/3wNuhH2LWQJnH
         HgMi95wOElKAhkMgpqJZtUe+ZfT9WfjMKL2m+Op/o4w8GC6YkOCusnj15jv9vFTUl4Cb
         kE6DJzz66l8HXNtkT4VB+lwLD5y3mrds7gB9PzTE+iCdr4er0YgFMUX5xL1Ko2fh5uCY
         DOLg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773681533; x=1774286333; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jK2scyfYwBMU55V+xfenTzy10C1cc5BhbFAgTj9RHSs=;
        b=wHKAD9tm8i2ZfL8HmxSc+orSrbGstG5+S0rbimfQG3U/XqjJ6bsBnWgrWSn0gqiD8i
         ebVzTG0W/rxFpA5zjG6+1DXlNLxnDNbqEFoRDsQcpmznpoIgNvdq/JnjOTQK3FvPrzW4
         51+bUyXKvjN6y7sFFRVAc8clMv0AdiiB6igu599f9xJHsH/luIBe7it3Hq+50XuMzZfY
         xY+wAAwWPiJJqgp6fm5dVkhX16palWJsFNcX66kw/y4RbRt7nKDUgCsg6KqmgAxclOsq
         mtQOyi0iNzMvyTk4yZz/GLTuCp7qKmuTCYDaOBB06O3beEKTMK/cnyD3WTvXaBN3LGAX
         XNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681533; x=1774286333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jK2scyfYwBMU55V+xfenTzy10C1cc5BhbFAgTj9RHSs=;
        b=HxecXw3m0DJHCyzUmg0eha5JVqjDOLpkJhwal23U6okz9qaT4z59h4UUyzC9OnlNUM
         V5H6mH5XGVMKWXlvqcBsqehQygpTVqf2I/a0xikp57GWb8n5rl0N8IO0/rShvQY48y6h
         s2ocsNOAmsHn4ZKCvucRLN1tLtg/PoQBnFu3SKjh1gsxsrt1GrYZn2DxJJaXBwGET/cY
         GBLEurPMFKilysC6GBZz8khxUAySR/oRzd+hpAi8u0+RuVcVZ56p/SlHGJRnR+xOOIey
         A8jAmRCsSyoHbCaI2Y5NjUFUanPmG19LeRMD847Xey01+G3yLE8CxpJTUKmeM6J0wLr1
         tZVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzlIMMtA67Rapi55+BHKkUMdaA5hiy17XAl4IP8UoeR+Q/IIiDCRz5CuqXjal+8S4UjXi50g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx4v+dI3JvpCAckoHF9lqO9sPQF23xMEDbjXQOm4UIlICPpm4Y1
	oSh/aeK1jh4lu/cZH9MyoKhdNW/5EvA+lBV3QRbKqOBxmmrZdZYZxzsQfweFoMMqW+enX++BomM
	nE0VJIbTkYGY3KWhuvT3G5LRKHcvnYCK8dw/yxPCe
X-Gm-Gg: ATEYQzxbjwf/Dalh2uss6Y1nR6Z3AZFT5qWI6d4Lz/yIhf0CIMTDkI1Qs5Nh4V51nhB
	27JFG3GtJI6HHVUeAr5wXgCde0hdwXaksDZdofq6jDu0IyDKnuBuJ+kGmD00wfemv0aUCMYu7lF
	G/A9aq4SjVblY8TBYZcUXTAI2tonDj1K48WHGusr8qhe1fmxhaA4TnjtNsEK4GY8XIbvUYqmPUs
	omBNb4E61/ZYn/SAQhREK0meSPMykLqAry+AHGmOWtoJCc/y5YEQq7zCr/L0u2PmbrWgxRn3hER
	bMaVexyt
X-Received: by 2002:a05:6102:d87:b0:601:f3b6:f2ce with SMTP id
 ada2fe7eead31-6020e27c32bmr5393489137.12.1773681532920; Mon, 16 Mar 2026
 10:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-11-dmatlack@google.com>
 <20260226170030.5a938c74@shazbot.org> <aaDqhjdLyf1qSTSh@google.com>
 <20260227084658.3767d801@shazbot.org> <CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
 <20260227105720.522ca97f@shazbot.org> <CALzav=fjRPa_ZbXu7iFXyemcf_8Kq_dZTWT6c-A0bc6czF_Rdw@mail.gmail.com>
 <abNOwcOTXqxCxNzt@google.com> <20260316160759.GA1767448.vipinsh@google.com>
In-Reply-To: <20260316160759.GA1767448.vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 16 Mar 2026 10:18:22 -0700
X-Gm-Features: AaiRm50L1lnLwO1eCIJNJtk4Bw53fGwzF8hjQ-eN_1dFmVAntzs-kWI2tT0ZbZU
Message-ID: <CALzav=cskxLZtZ5-uRa0+aV+1Kb3fwQQJ5dS=Yes4GAHrS6GpQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
To: Vipin Sharma <vipinsh@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_101854_980703_5E87FED7 
X-CRM114-Status: GOOD (  35.58  )
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

On Mon, Mar 16, 2026 at 9:22=E2=80=AFAM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On Thu, Mar 12, 2026 at 11:39:45PM +0000, David Matlack wrote:
> > On 2026-03-09 10:32 AM, David Matlack wrote:
> > > On Fri, Feb 27, 2026 at 9:57=E2=80=AFAM Alex Williamson <alex@shazbot=
.org> wrote:
> >
> > > > Sorry if I don't have the whole model in my head yet, but is exposi=
ng
> > > > the restriction to the vfio user of the device sufficient to manage=
 the
> > > > liveupdate orchestration?  For example, a VFIO_DEVICE_INFO_CAP push=
es
> > > > the knowledge to QEMU... what does QEMU do with that knowledge?  Wh=
o
> > > > imposes the policy decision to decide what support is sufficient?
> > >
> > > Hm.. good questions. I don't think we want userspace inspecting bits
> > > exposed by the kernel and trying to infer exactly what's being
> > > preserved and whether it's "good enough" to use. And such a UAPI woul=
d
> > > become tech debt once we finish development, I suspect.
> > >
> > > A better approach would be to hide this support from userspace until
> > > we decide it is ready for production use-cases.
> > >
> > > To enable development and testing, we can add an opt-in mechanism
> >
> > Here is what I am trending towards sending in v3 as the opt-in mechanis=
m:
> >
> > diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> > index 1e82b44bda1a..770231554221 100644
> > --- a/drivers/vfio/pci/Kconfig
> > +++ b/drivers/vfio/pci/Kconfig
> > @@ -58,6 +58,27 @@ config VFIO_PCI_ZDEV_KVM
> >  config VFIO_PCI_DMABUF
> >         def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
> >
> > +config VFIO_PCI_LIVEUPDATE
> > +       bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> > +       depends on LIVEUPDATE && VFIO_PCI
> > +       help
> > +         Support for preserving devices bound to vfio-pci across a Liv=
e
> > +         Update. The eventual goal is that preserved devices can run
> > +         uninterrupted during a Live Update, including DMA to preserve=
d
> > +         memory buffers and P2P. However there are many steps still ne=
eded to
> > +         achieve this, including:
> > +
> > +          - Preservation of iommufd files
> > +          - Preservation of IOMMU driver state
> > +          - Preservation of PCI state (BAR resources, device state, ..=
.)
> > +          - Preservation of vfio-pci driver state
> > +
> > +         This option should only be enabled by developers working on
> > +         implementing this support. Once enough support has landed in =
the
> > +         kernel, this option will no longer be marked EXPERIMENTAL.
> > +
> > +         If you don't know what to do here, say N.
> > +
>
> To use VFIO liveupdate, user has to do at least two things:
> 1. Enable CONFIG_LIVEUPDATE
> 2. Pass VFIO FD to a live update session.
>
> This means someone using it has to know what live update is and
> intentionally pass the VFIO FDs. Isn't act of doing this itself an
> opt-in mechanism?

If it is, then I can leave this out. Alex?

My thinking was: Distros are free to enable LIVEUPDATE and use it. The
support it enables today is all fully functional (albeit new).
vfio-cdev, OTOH, is not. A separate Kconfig can help express that
difference.

Consider that LIVEUPDATE could be enabled by default in a future
release, but vfio-cdev support might not be ready yet at that point.

> I am not sure providing VFIO_PCI_LIVEUPDATE alleviate Alex's concern
> about how userspace will know that sufficient VFIO support exists.

I was thinking we can flip VFIO_PCI_LIVEUPDATE to be enabled by
default (if LIVEUPDATE and VFIO_PCI are enabled), and drop
"(EXPERIMENTAL)" from the option title. That would be how distros and
downstream users of the kernel know that sufficient support exists to
enable VFIO_PCI_LIVEUPDATE.

> May be write in liveupdate documentation (PATCH 11 of this series) that
> support is experimental?

The documentation in patch 11 includes largely the same text that I
put under VFIO_PCI_LIVEU"PDATE. But I can explicitly mention
"experimental" as well if that's what you're asking.

