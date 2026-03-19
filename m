Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8E610854D2
	for <kexec@archiver.kernel.org>; Thu, 19 Mar 2026 17:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bWL7Mvz3ZFb3DsvrD6klOpnMDDqkJa/pdjIb2Ow02uU=; b=Si3QGIe4lF9VO0hJWJfUpg0zzm
	zDWZjWgI/mAv3dh+T3PnOdBJR+X9/60kgpaP96/RZ6QW1VoVqxBUifk+CULeliY5eHJxOWxXqt52W
	TlDGTD9GLbyVx2f7airU0xhIz6NQj07jKp5KA5Y9gHd+1SegN3lEgcmqAnQi3n9p5j02AdB2xnD0e
	r5tnjSTvz2IDflGK7fgHFSHmUGuxsbADPJGLg7av7JK2rkIqN1g78T2++KYhGGn6qSwz45u/UWWAR
	/0B4GFYOtdm9H2w/gcFu6xIwNCleTR+CkzjWVYT/Nin0DbD7LXN0LD98u1iyfKmL4WSGcDuKJgkAT
	EeXrboDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3H6m-0000000BC4q-2sDt;
	Thu, 19 Mar 2026 17:24:32 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3H6l-0000000BC4k-17Fo
	for kexec@bombadil.infradead.org;
	Thu, 19 Mar 2026 17:24:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=bWL7Mvz3ZFb3DsvrD6klOpnMDDqkJa/pdjIb2Ow02uU=; b=fNhJA3ZUHbbNodHHeDMTP0vccn
	c2kkg2Kh/dN1G2l7xP23jOeNrTouLYq514GLggWVUpALDroPYUFz3m//PxAkOT3ntY1EEGybf8gzX
	K7y2YvoxdbCGqqrYX5aUCmfMIzU2F+DCToD49N3DYu2q6S+RczzCUha8SaXga0KvD2VH+yCWLAXAV
	stEwAuroOaisQWQ+aTB7KXgFFchBuK2pmOYjVrRnFqNUjcUbYWzIf7xDPlDL7N048cagHEt1q4G+p
	hpOMVDHXQlvODKcgpLSqA2aYnOhx4EuigCjKdt7jXptGim5xdjh1HrZJlDd/jBl6PNIvZ7FQmW0pJ
	Kjt3fcdQ==;
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3H6h-0000000E6Qt-4AC0
	for kexec@lists.infradead.org;
	Thu, 19 Mar 2026 17:24:29 +0000
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5a126c8aab9so1322573e87.0
        for <kexec@lists.infradead.org>; Thu, 19 Mar 2026 10:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773941065; cv=none;
        d=google.com; s=arc-20240605;
        b=jAsrwbm3sxn+DM7RV6RRl7f6JNsPfbNBBBfMm61cxNoOKRD8ZXsuJe2ynZdKULIgi6
         Hm31LU3NLmyeszctSyXXZjLw3xaEtg0KrL2djeMFgFNFL0E2Cx/crjNsEIb8ErAq1kY1
         +JaPX83zn+spaHE/T1cNElNv1mU95s5aT4wgpdoU6BsUJ3a0mmhK7IjxjE4QpxdUvRWZ
         18IeLPJFnTpWT8j3hRCCB9QE3KmZyttRnVlyhAvSylrXp3/uowC4UVByprG5SlG8eLnz
         JQnZww0srYh4YXKBF5JKr3Em18Xvq2WI0XtApqDzjh+XoUExTchN5quA0Xn60VPi3uzC
         5EsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bWL7Mvz3ZFb3DsvrD6klOpnMDDqkJa/pdjIb2Ow02uU=;
        fh=VrKD89KFLoN7bfI0oRGJSNdg0xcw0R7e0wEdlXxybfs=;
        b=Eummh9KiUNdJ6yvOynC93BWVR6ogI2p3pQSXPoNwVksN4eITaDuLkYeBOKfX3LRoeo
         nki7bmEMBhapgmIXOIng0aLg8geJ1B0NJhAaA/EBBvP5+2fi6bZbqHj5au6XntlJ5DjH
         YBlQQLo7zab+cDM4RHIQxjgytkx60iSy2AIsj5tV1/qxxKkwOfqKJtrscWmVitajYn/h
         XyPmV+tGbVGBMfmN8BltiZtahQUzgHvFrqKYDiHOKHFReJDBopkp2OnuEq3V/l9R3VY2
         /Z42+sw+vfzmB/QUGNKxjLF7lzwxc/bArjQ6zFkIYVqwIq+/ZXrHEDbC4xl+URzLgyva
         rqrg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773941065; x=1774545865; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWL7Mvz3ZFb3DsvrD6klOpnMDDqkJa/pdjIb2Ow02uU=;
        b=ZQskIfG52GdcgMuU5QZkKd0KvQ9he6xRU5QkU8fZ3ydrl4+nMQPJDGBLTuY0sUINU9
         5Aa5xLw00Qy/fqmMjFoHqYpt18G4n7ghpcUvOjZIrZkRLornBztIotL4PfmPV67IutWG
         grUzDT/R9T3UwUmHzliKiWgZdJ0F3MjBEikIkBXiRliLD5c/seM+kYEUVVNskbp9+BzM
         gRqyZ1PFjEdZEAPJrBRjeAqDHeIUrguC0/dWIHgNDqi5TMr4ZVSULY+4tazBFY/LhrYV
         wHO1wyxEzVGlbZXdUYsA62diQla/V6JOQrwe5z7Zc24mVPhe0B46+rYIadKUC5HSXNkt
         7lRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773941065; x=1774545865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bWL7Mvz3ZFb3DsvrD6klOpnMDDqkJa/pdjIb2Ow02uU=;
        b=ACPnKCWX+Ys1cp7oSLXubYw/H5TnI8AtIh8s8y3ijpORWygBE4805VUnT2X5MKKe62
         aEa0NqYEMDcT5eI22Cx/+FrrplLZOUyH/nZAHm/rI6xofyOdkOoEiDOCuYJi2mvEB/aT
         VYpd7qdvSBJRqzs/I1vnuBGwKA9Jwoqc3wOnd4Hudn2Ke2H3LG0DimrpFEgvWnzs2J0B
         43qlAp5d3P3gCDYfWqZYiX1skyro4Q9cXmpuzu/36xy1oibVpqUQjliQLvlvu41kuxpi
         2VTCidF86qND0B+UjI71pzq/7DzKmZ3B0m86oynNFsx0m4bqnbi9MU2zMy0zXuP5/mnY
         15eA==
X-Forwarded-Encrypted: i=1; AJvYcCW0/D3Lj7CfrO3cMlTfgL/f4/9BmceDVLYEwi6ssWuWZAVGklnsK+V8pFZ8QmmGejQNlpumHQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwZCdQYKDs5qLXoW1SQs6e02/h6mHnGngx5nAfzuDcR6bhRUeQu
	uYtyj/j+yxAPr3GDF8oJS8F6oG6GZXgajXAFnUMtCvR5+DqPmKr3zoKfNIgjr+sM2DpTGp/w7ZG
	Lm4youzzlMtcxmWuYfTkuxJhqpfA1oWIAo3at2Gp1
X-Gm-Gg: ATEYQzxrZE9Fl9i+3+y6jPJXZtHEPPJiWb888sGin5ka1hoG1oYi3/6yGoPil4qa8NI
	HhtFiWUHLBrUd69XH2ciNz1Ed+y3Bm4Vkc1tT2oaBK2J28y47rZbaZugx9iAtx8zQcLQu3sVkrb
	Nk0PH3pXbY2BX6g2evPcKgEAWiHn7jZ+Nz+6E/D0hgj/VN1yPtP0IXPHKOk9KJ7Lacb/9O7OIKd
	zFnDyBx6TMdR3/DKxHBHLJYbjx1HBDvX30d6CW+vRr/88YmNODhbptYBq+1nq3Fh3YexBT/XUdo
	AXxbiDVr
X-Received: by 2002:a05:6512:4016:b0:5a2:7e5b:5a48 with SMTP id
 2adb3069b0e04-5a27e5b5b70mr1566015e87.26.1773941064245; Thu, 19 Mar 2026
 10:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-11-dmatlack@google.com>
 <20260226170030.5a938c74@shazbot.org> <aaDqhjdLyf1qSTSh@google.com>
 <20260227084658.3767d801@shazbot.org> <CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
 <20260227105720.522ca97f@shazbot.org> <CALzav=fjRPa_ZbXu7iFXyemcf_8Kq_dZTWT6c-A0bc6czF_Rdw@mail.gmail.com>
 <abNOwcOTXqxCxNzt@google.com> <20260313083918.00005731@linux.microsoft.com>
 <CALzav=eGLpo5nrsHq5L8bUTC=FWZ-SgrTE1FoScrWB4p+NDgnA@mail.gmail.com> <20260319093932.000078c2@linux.microsoft.com>
In-Reply-To: <20260319093932.000078c2@linux.microsoft.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 19 Mar 2026 10:23:56 -0700
X-Gm-Features: AaiRm53rqLDO8igOEPnPEHv7Le9OPlkg99gzLBiOllDBuZj0inzOHo1IukO9vNo
Message-ID: <CALzav=fvG+s6MYNzxhuHFmQkmTRJJASXAGs=zQWWSnSv3Y=J9A@mail.gmail.com>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260319_172428_094333_DD41B3CA 
X-CRM114-Status: GOOD (  30.69  )
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

On Thu, Mar 19, 2026 at 9:39=E2=80=AFAM Jacob Pan <jacob.pan@linux.microsof=
t.com> wrote:
>
> Hi David,
>
> On Mon, 16 Mar 2026 11:11:20 -0700
> David Matlack <dmatlack@google.com> wrote:
>
> > On Fri, Mar 13, 2026 at 8:39=E2=80=AFAM Jacob Pan
> > <jacob.pan@linux.microsoft.com> wrote:
> > > On Thu, 12 Mar 2026 23:39:45 +0000
> > > David Matlack <dmatlack@google.com> wrote:
> >
> > > > +config VFIO_PCI_LIVEUPDATE
> > > > +       bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> > > > +       depends on LIVEUPDATE && VFIO_PCI
> > > > +       help
> > > > +         Support for preserving devices bound to vfio-pci across
> > > > a Live
> > > > +         Update. The eventual goal is that preserved devices can
> > > > run
> > > > +         uninterrupted during a Live Update, including DMA to
> > > > preserved
> > > > +         memory buffers and P2P. However there are many steps
> > > > still needed to
> > > > +         achieve this, including:
> > > > +
> > > > +          - Preservation of iommufd files
> > > > +          - Preservation of IOMMU driver state
> > > In the interim, what do you think about moving forward with noiommu
> > > mode without preserving IOMMU driver state?
> >
> > I haven't gotten a chance to look at your noiommu patches yet, but I
> > do think noiommu will probably be a good way to develop the VFIO and
> > PCI support for Live Update without blocking on IOMMU driver support.
> >
> > > I=E2=80=99ve tested your
> > > vfio_pci_liveupdate_kexec_test with the noiommu cdev, and it works
> > > as expected.
> >
> > Would you be able to send patches to add noiommu support to VFIO
> > selftests? That would be very helpful toward allowing us to develop
> > and test Live Update support with noiommu.
>
> It is included in the noiommu patchset; the only difference is that the
> VFIO cdev name is prefixed with noiommu, which is not strictly required
> and is done out of caution.
>
> /dev/vfio/
> |-- devices
> |   `-- noiommu-vfio0
>
> https://lore.kernel.org/linux-iommu/20260312155637.376854-10-jacob.pan@li=
nux.microsoft.com/

This one flew under my radar. I will take a look and respond there, thanks!

