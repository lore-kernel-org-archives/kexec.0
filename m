Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C148109192A
	for <kexec@archiver.kernel.org>; Thu, 19 Mar 2026 22:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=svD4wMks8gwyXRL5XOV+qF8B6FaNKoBJNHk7PXgg3Q0=; b=JSEnLFRyPZ91Ols3Mhrnx7Sa2N
	1PfxW7GjJjWEb6DimQgtpBlOouDib9PbIqSRhxg20PzYfg8zl1oENkkW7ZZiZVlvyWo3nCZbz0eeL
	4VlULg+a95PNUgNq/bpPBCDcJNrTB0UIs/LkGqsexJPYTtS3nlSsWXuh23UnCUi3Gv97zl8jpIy31
	KrJbAQPiqhCZKNfLY3l+zEkqJxSqHpwPKoqOWdlFeZjIQ3MYH+bANxPiWXwB6NGiad8MQaybvOWlN
	tMWHyhwD3rI5vb8huuyjwFmtf6t3yClPOO5P8TCb436k301+Vpxu2H0cfR8sDKbclS7RAIEbMsy+1
	e91p/2nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3LYu-0000000BcUN-0eHF;
	Thu, 19 Mar 2026 22:09:52 +0000
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3LYr-0000000BcTv-46DV
	for kexec@lists.infradead.org;
	Thu, 19 Mar 2026 22:09:51 +0000
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5a12c19affeso847112e87.1
        for <kexec@lists.infradead.org>; Thu, 19 Mar 2026 15:09:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773958187; cv=none;
        d=google.com; s=arc-20240605;
        b=CdIE64QvrM6ZXSnH6kiB8zjYzRXZv6dOLMdwDBZZLiLGbV0QI7tzezfQDwN+GuxZEk
         euRXV3JvB9ZKwHFaehUK5OkeLf+P/tWvDdo6Fqps/DyxyljBPHFkwxx1D+OxCMV0beTh
         0uO1e0+Cattuul435jSZ/4pa931PIJWl+aSmCtlxv6c/U+Y3aP/ZbFBgrG8vReNBrKq8
         zmxtWBT6W+h8nKPQWGCXdwcsMhl34sNvG2Ve9n0XmJ7pYphaiOOltXI8o9Aytjw1hV8x
         Yh+PkzieYCcsckZ5fmwG/irokU0/gAoTXQoqWwb9JBw2pNzV4AelhvOfCLfA/rAZ1icd
         PL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=svD4wMks8gwyXRL5XOV+qF8B6FaNKoBJNHk7PXgg3Q0=;
        fh=EzlXQBZ5d4J0DWtqdsgpIig/lFAX5BOfGPk/zM4qyFE=;
        b=altLkxTWX3y3VElpFnEvmsbdhmeQh/uptEOzZ+OVKKQzq9MNB0miLUzV2izu0evbRZ
         UkLjxgfcqtjQ1XfFizhwJrOUcFYNe1nBMdrC9PvHAETVA4745KesJZlG5Lpi8YYtvik2
         SWugOgnF7981tTr8cmH08MQSydFZm/TArhO1SHwqI+hfvAY/In2bZrLqgZfH/3ToDmdm
         sHa/gcag5k4hDhl+OLbIYxL9xtvwh+vOhelFaEU4eLAbG3HQHumfMDNQZ4eaJJOoJaB5
         Ab+l0NzPBy0DJXQlsE6gyHuxwKtU7StgVH7CTyNXtVNRPLOKWjir//d10l3KSgQGN94i
         2jHA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773958187; x=1774562987; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svD4wMks8gwyXRL5XOV+qF8B6FaNKoBJNHk7PXgg3Q0=;
        b=uzOw5m4t3VY+bWXnTywEUmKVk3wAd5Ap+NdI6x+IqHqrzFnrn/h93Fx+HzUMnlfilW
         EDwFa80RFMMqvANxXUGmbIR9IQ5JpOHHaTGigwrRKn3P9IFnTHQVqO2msLbKc5BJ1NfL
         ZCvhKiBEhSCdJHuzL1CFluk4rUrpRTsLZKAOp+UeHTaqv6DJXnHNgidaNIDRXBXbM2Za
         oUOKMRPVY5tAzJq1LlB/ScT0rf9U54OMuyTkPrI4ugwYInrEuU8OieoOXxThTSnLr8yc
         nVgIAPuD11Qrl1cPlRKspdC19uAD6/+pSagd8uMwXB/Sk62VHJyy+SQyRj6HATYtYh9J
         A6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773958187; x=1774562987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=svD4wMks8gwyXRL5XOV+qF8B6FaNKoBJNHk7PXgg3Q0=;
        b=bQ0yW3BeBjwHsoM8vDIZzFnEnar3CNDWL+gIPCjit783LgVU+RmyuuHWy92H/yzwWI
         S1LRpfQkSNQdDvToRaKOy+qLXY9ErVoBBvjG3VY7aTXChoZNcLSzkVlisEkCJiKw1Xkz
         BpLJJ1yEhWCVmyFNnLy9uVbaMuz9iZYwCiuoFIYesH7YUXMxQveyY83JCU4fU5Vj2sqV
         nDm2os4fYnlX3jJJHs2tD+GJO8jXc2kcjbhY5TNUD5aGJojNj7Ms5BZqwFbZRPFEDFI1
         VrtyDHbPlheBRXUtaGA93Awd1GpmCIcsZIuwMX0Wm5P0iQMkkPK/X04ENJuJia5dEHid
         q/Zg==
X-Forwarded-Encrypted: i=1; AJvYcCX2ePn+jmBUsxsSJXsiDTMfxY7WxlN0vqdXajIZ3Lad+ttrY88PZiPjgfs8hl+/ESIXUwBgjw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxW6aOm0j7nKwGXsV/QtIj1bWABsLDtdBp4SJbF1TWq4wII1sGE
	xncffAQWOgKhE+8xX8oMktTPTiTgxRCiSQxlGZwnAQyn44hu5uoYJa1U+/4fl9+7y/BsQgD4zQY
	k3U3JCB3sRWZk+apHkPz3yNO6gp720m9Nq/IP2jzf
X-Gm-Gg: ATEYQzwBBikjVrXF/or2wiuFurzfuGgqK9nY2puwMkPk/LTxQR1nrIDarvXRh6TNgC5
	eJH9Tj9RLo3SOBpNc4tWIIBKgto6i8znp698pbenUibDR7TDRGbXDKoASxxucunkrbMnSn+qmSN
	D99TqvkWmkJbSZ/bXXCxjNEdsG8GigOrFAw03bceFpO8QhohEGWRKW6OE/zMC5Aq6RrhVnr1pAo
	5Blq59WnRfYxxyeh/VUs54jKJyPh11zF88FTVnOVdqq9kBnptQaCoehUL0Wx2IHg7EhIcqsDAUw
	CAzel67V
X-Received: by 2002:a05:6512:3b22:b0:5a1:742d:277f with SMTP id
 2adb3069b0e04-5a27de01545mr1986403e87.11.1773958186394; Thu, 19 Mar 2026
 15:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-5-dmatlack@google.com>
 <20260225143328.35be89f6@shazbot.org> <aZ-CnywNgMnr6f1k@google.com> <CAAywjhR4Azqx8hXRap0eLUrwetYRiX8TALEM=b+1BorPc3eJdQ@mail.gmail.com>
In-Reply-To: <CAAywjhR4Azqx8hXRap0eLUrwetYRiX8TALEM=b+1BorPc3eJdQ@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 19 Mar 2026 15:09:18 -0700
X-Gm-Features: AaiRm51momKlFVcCV9Yk7taG4PZCOSiNfgaYNzeVE1MwV2qirg6S-TkURRRSfl8
Message-ID: <CALzav=cMEkenGKYvA=rNmTmVjpf_DW_92MCFx-2gxqKbrdG0Kg@mail.gmail.com>
Subject: Re: [PATCH v2 04/22] vfio/pci: Register a file handler with Live
 Update Orchestrator
To: Samiullah Khawaja <skhawaja@google.com>
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
	Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260319_150950_045098_7C64CD7B 
X-CRM114-Status: GOOD (  24.50  )
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

On Wed, Feb 25, 2026 at 3:55=E2=80=AFPM Samiullah Khawaja <skhawaja@google.=
com> wrote:
>
> On Wed, Feb 25, 2026 at 3:15=E2=80=AFPM David Matlack <dmatlack@google.co=
m> wrote:
> >
> > On 2026-02-25 02:33 PM, Alex Williamson wrote:
> > > On Thu, 29 Jan 2026 21:24:51 +0000
> > > David Matlack <dmatlack@google.com> wrote:
> >
> > > > +int __init vfio_pci_liveupdate_init(void)
> > > > +{
> > > > +   if (!liveupdate_enabled())
> > > > +           return 0;
> > > > +
> > > > +   return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh=
);
> > > > +}
> > >
> > > liveupdate_register_file_handler() "pins" vfio-pci with a
> > > try_module_get().  Since this is done in our module_init function and
> > > unregister occurs in our module_exit function, rather than relative
> > > to any actual device binding or usage, this means vfio-pci CANNOT be
> > > unloaded.  That seems bad.  Thanks,
> >
> > Good point. So a better approach that would allow vfio-pci to be
> > unloaded would be to register the file handler when the number of
> > devices bound to vfio-pci goes from 0->1 and then unregister on 1->0.
>
> Yeah maybe a kref that gets inc/dec in probe/remove. I have a similar
> problem with iommufd preservation, but I think I can handle it based
> on the number of iommufd open.
>
> I am wondering whether this file handler registration kref stuff can
> be moved into LUO by adding it to LUO file_handler and the modules
> only call get/put?

Circling back here, the new plan is for LUO to not take a module
reference in liveupdate_register_file_handler():

  https://lore.kernel.org/lkml/20260318141637.1870220-13-pasha.tatashin@sol=
een.com/

In the next version of this series I am going to rebase on top of
Pasha's changes and keep the call to
liveupdate_register_file_handler() where it is.

