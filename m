Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB65C43458
	for <kexec@archiver.kernel.org>; Tue, 30 Jun 2026 22:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OLXeb8c7iyYBBm1u3dFIHz9SDW0xbbNuKTG6qGPD7go=; b=Quvm+6leAv4PNz8jtfGUC1hqYu
	rdfIGFNUvmVmQQREE3oVYFCyzIHFBtIXkKkbTaoUfQdg4gEJAtsSJg5GK8uGaFUxqGuE8l1q0H/Fu
	mBB+y22WDXHDsZlnLwDfdFdXRcpiT0o4G/CxYl8qGqpmCX9+0HnMuIxAr/eslRvHgVAhMYHS/QoQ3
	lwYucXHhGmE3J9YBbAat8/tB0g5wwuq9Q9HMzNptQl0FdidkSp0/Z6zOZY8NIkdxF/btgEUZJ0QyR
	FhxPcn/OUQgXoAz4QbFkdrQOBmFvCbRLys7Dfz0SzTdVuoyIFubQw5BQJ9ybsV9u81fLehRsB3PHA
	pSK2oDLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weh3D-00000000Js4-2RHW;
	Tue, 30 Jun 2026 22:35:31 +0000
Received: from mail-dl1-x122f.google.com ([2607:f8b0:4864:20::122f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weh36-00000000JrQ-1rwj
	for kexec@lists.infradead.org;
	Tue, 30 Jun 2026 22:35:29 +0000
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-137335bc3caso10776501c88.0
        for <kexec@lists.infradead.org>; Tue, 30 Jun 2026 15:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782858923; cv=none;
        d=google.com; s=arc-20260327;
        b=PeaXrON+38EHhp8HWO0Q703DRzDGQEgo+Vzj+2Q1jfGgEVcwiGW+Xpb2XRF2tKDx2A
         tXT59JEcP47Nua/TzGXdNfY3rDwrtJaKsQHKf1XLB6921BqqNTwNmiFbBpB0oco7J3yc
         nB7s2SEcYIsG8h2axY8VpUSkPKpD0cV2srIgMolu7DSxFaJuAjrAmKa5giEjg/Wa2ECT
         pZEA9XGUBunIkjwPHUbTieN62+sH1vFhb5b2SEvhhOdssD/OU+QWfEEfmXhoWBmc+sAB
         WKk93Bb4GLEmDX9nnPYHc9fjkMjwqJGnzz0yXq27+g+IZneR7oZPVxq6GZ9P61RZe4Do
         35Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OLXeb8c7iyYBBm1u3dFIHz9SDW0xbbNuKTG6qGPD7go=;
        fh=sEcIE31FlO837aZlyZWu41sJrvjpkFqVx/S5nDpB1Mc=;
        b=Hq8nR5Tfp7hv4gHJBzncHQ8xA3uxAhbcsfkQVfmbZm4//borAh090I9lP8Xo8CErpK
         KEbrNcpGWIQcglDbARQu23OY3R4CK11U1LcI4n3R4/0leMl8TY1MWBHgUzdiXXzAK6+e
         0+rVjHYheFfPHT/YEH+/10SThQWWAymsDea5+Jy5MDLjcxgD0Hpc8rlJLjXcwW0Re6iV
         xGFiFq/01s57e7QiDqqGEaQSxiTg+lfAdMcO0Ux27zqb3TJqTe/vt6JSWd6vjNxU8WWE
         4frJl71c3NrfGbZguOYAETinSTHOBFw8wClzN/WKRtU+FlklU9+VIpfNKq+V0LN/PSJZ
         WKig==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782858923; x=1783463723; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLXeb8c7iyYBBm1u3dFIHz9SDW0xbbNuKTG6qGPD7go=;
        b=Q5qXsRehfuU0Q/dUXvhEPiUwWOxf61CPD1cmEVEHBLkUxYngm09NgUlRFob0FITegT
         egLuq3FsRvuXRxRkjyw5zZGep+DeS3LfitMqFytG/UdjQ9jhg02wNtiHCLZJsmSIGrPc
         tHTIfFvt488LPs6tES2AqF4QlAYTurecZzuOZOWJaElMmxXzpWz+QVyts7J7DZ5hmfHI
         9hCWkcubppfWlaKNnOzzJHunCmSURcqbXLEvhFFMH4uGHavewWEWxW3fHQVD22Ovq0JQ
         rsZLY3Fk5lbLH1BibOZaVpdTbVLkunLdMEV5/Cj6ke/TiFZ6zjI8yrDOx9wmdCJNrXvP
         2gOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782858923; x=1783463723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OLXeb8c7iyYBBm1u3dFIHz9SDW0xbbNuKTG6qGPD7go=;
        b=bt4LmJ4bv3uLCqsShRI9entOPOs0vlZaS9wMvz9Uk4a4FFJCUlyUOrGNyhWH1b1Phv
         4bMT/jXQq7MF7seWdMjYOmB2Z1ZID01U7JuJ1G3tM4PNRI8a9MJdh3XNtP5xOPi0+k0n
         yHgOhSRtVZe8XtaMCGboef2xcQHrwYOfFdrV9h9cF2Of8PD0krcQIQhj1z2A//XLwqDg
         HNhLTdaJafoYvDwG/sbwpMVfLsIUierseyrZtnSAQrj5cdyuXxdY7bxD/GL/hDp4J9g0
         Ehni0rY10HwMQV8sYkTe+3lYXO0/05ZGOd7LbAuMx+HPF8+rTlSPbcgZmZ3MDhHkWoJp
         PSDw==
X-Forwarded-Encrypted: i=1; AFNElJ+CAgb7t1dM2CPUbQF8JCR0gAQCguRr0cBXAFGR4WZKSbTCfn6/HPPhaugLMLXBZBp6mID5tA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzqYvKfaKoglUk3RMzhuR/UuOqw4da4s3nbaFxd59eYzdI6ixKt
	277OCwBluHx1Dd0Na7o+6Kdu1ytZfrvxIjAFD8MoZcY9G5/76RRYmCrq83v5Vr65iHfXLglVkTx
	yWL8E+a32IzrwlZMHwjR1FRIUN7z9kJwXpHnr8YLc2A3Nq+u7BtSH6vBhLAA=
X-Gm-Gg: AfdE7cnaeZ/scE6Y2D8K4X1VyLRC9xn3SAbELi8Z0u+CkSERwHINrErOI8vA2F05Ssp
	pNcDaXNyQUa203ivEKtMfCIjreidgDHoIbd+SsOPuRv8fR12MW9e81LY5pzlozfuzRN7ITITJ23
	cA/+5I7KM/0aFoNv1rygoAfJUuXRCl1yk9xQ5ZBohYzsbMCY8FIuxn7ZU8lIEW7x1E5E/FkDuCk
	oh7bcOsXKSqfHrZ4C2UZJJp2fSdgtusqpUKTt40ZXcKeYxJ25i2BShUzc1QhtbcnHE0anQp
X-Received: by 2002:a05:7022:f690:b0:139:ed59:4b8e with SMTP id
 a92af1059eb24-13b2a1c7f1dmr3156303c88.50.1782858922721; Tue, 30 Jun 2026
 15:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260522202410.3104264-1-dmatlack@google.com> <20260522202410.3104264-10-dmatlack@google.com>
 <aiaoc6Y6qeF_5Wn9@google.com> <20260608181906.GP1962447@nvidia.com>
In-Reply-To: <20260608181906.GP1962447@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 30 Jun 2026 15:34:56 -0700
X-Gm-Features: AVVi8Cd-vdSCkwSqwAz2qbX9b8clCFCtpt-XfTl_1BZFKIa6zUmlOyUobbTWOp8
Message-ID: <CALzav=eGkCom7rM0Mj_AEhcvfryLctRWghPaGkD2V5_bMiXTEg@mail.gmail.com>
Subject: Re: [PATCH v6 09/12] PCI: liveupdate: Inherit ARI Forwarding Enable
 on preserved bridges
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_153524_514822_953649AD 
X-CRM114-Status: GOOD (  38.62  )
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

On Mon, Jun 8, 2026 at 11:19=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Mon, Jun 08, 2026 at 11:33:07AM +0000, Pranjal Shrivastava wrote:
> > On Fri, May 22, 2026 at 08:24:07PM +0000, David Matlack wrote:
> > > Inherit the ARI Forwarding Enable on preserved bridges and update
> > > pci_dev->ari_enabled accordingly during a Live Update. This ensures t=
hat
> > > the preserved devices on the bridge's secondary bus can be identified
> > > with the same expanded 8-bit function number after a Live Update.
> > >
> > > Signed-off-by: David Matlack <dmatlack@google.com>
> > > ---
> > >  drivers/pci/liveupdate.c | 18 ++++++++++++++++++
> > >  drivers/pci/liveupdate.h |  6 ++++++
> > >  drivers/pci/pci.c        |  8 +++++++-
> > >  3 files changed, 31 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > > index a93b7ef065f2..701276ef6cfb 100644
> > > --- a/drivers/pci/liveupdate.c
> > > +++ b/drivers/pci/liveupdate.c
> > > @@ -128,6 +128,10 @@
> > >   *    way after Live Update and ensures that IOMMU groups do not cha=
nge. Note
> > >   *    that a device will use its inherited ACS flags for the lifetim=
e of its
> > >   *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
> > > + *
> > > + *  * The PCI core inherits ARI Forwarding Enable on all bridges wit=
h downstream
> > > + *    preserved devices to ensure that all preserved devices on the =
bridge's
> > > + *    secondary bus are addressable after the Live Update.
> > >   */
> > >
> > >  #define pr_fmt(fmt) "PCI: liveupdate: " fmt
> > > @@ -756,6 +760,20 @@ int pci_liveupdate_enable_acs(struct pci_dev *de=
v)
> > >     return 0;
> > >  }
> > >
> > > +int pci_liveupdate_configure_ari(struct pci_dev *dev)
> > > +{
> > > +   u16 val;
> > > +
> > > +   guard(rwsem_read)(&pci_liveupdate.rwsem);
> > > +
> > > +   if (!dev->liveupdate.incoming)
> > > +           return -EINVAL;
> > > +
> > > +   pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &val);
> >
> > Again, I might be thinking out loud here, but since these are
> > hot-pluggable devices, with some FW / SW running on them, I'm a little
> > worried while assuming the HW registers can be trusted across a kexec.

This is, in-part [*], why I explicitly read the capability rather than
caching what the previous kernel thinks it was in struct pci_dev_ser.

In other words, the kerenl does not assume that hardware registers
remain unchanged across kexec. It reads them after kexec to determine
what state the device is in and inherits that.

[*] The other reason is just to keep the ABI as minimal as possible.

> > Say, if the bridge experiences a reset (e.g. link drop etc) during the
> > kexec blackout, the PCI_EXP_DEVCTL2 register could revert to its defaul=
t
> > state, meaning the ARI bit will be 0.
>
> This does seem like something to be concerned about, but realistically
> I think if you get a PCIe error I'm not sure the incoming kernel is
> equipped to handle it at all :\
>
> Just resuming the driver is going to fail too, I don't know how VFIO
> can learn and forward the event, and so on..
>
> But maybe it is worth being a little more defensive here

If this were to happen, the kernel would see that ARI is disabled on
the bridge after kexec and proceed with that state (ARI disabled).
Devices (devfn) 8+ on the bus would not be available to use or restore
(the kernel would not discover them during scanning). It should be
fairly obvious to the user that something went wrong (devices they are
trying to restore do not even exist) and they can reboot at that point
to recover.

This should be extremely rare though as it requires a PCIe error that
affects the bridge to race with kexec.

This seems like a reasonable way to handle this scenario, at least in
the initial version. We can always look at more gracefully handling
PCIe errors during kexec for Live Update if-and-when there is value.

