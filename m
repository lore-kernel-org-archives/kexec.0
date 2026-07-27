Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CD6C531C9
	for <kexec@archiver.kernel.org>; Mon, 27 Jul 2026 23:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aH9fxD7OeNQpvbALLCFcfoa0nXkldfT8Qxn7YBj/IBU=; b=uol2MYCuBpw8byIoPhclFJPC3L
	FjZ7GEyJyRL7JVoZho7ApPGPfbpB6KYy7JOukke+tSZoNonQSNj+qVjRjWzmnaQ7qzMYSC7jWHEjd
	a7AMiHMVoOOK/DsSv+qN6B/DtRiOCZKz0HGhUw1yhVbyLm0ck+2jXvqQl91dmMJltObzM/BANkrtc
	F+LDu3x3kHA4zLbOtqOsDQKLHbXE7PDCMPtBdJ/0BlDYv24XY7sZ6GJmm1auo2DR5SqlKxf8ltxqO
	LF/xuLOMt4BR3+R+mNjOGXuYzcxZN5I3aHys3xEhQg/vszSsZQND2EFAYAL1W70DDFfkoO/EQNyae
	BtBmkd5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woUei-000000044XC-15nv;
	Mon, 27 Jul 2026 23:22:44 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woUef-000000044WS-1kO7
	for kexec@lists.infradead.org;
	Mon, 27 Jul 2026 23:22:42 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so2417465a91.2
        for <kexec@lists.infradead.org>; Mon, 27 Jul 2026 16:22:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785194560; cv=none;
        d=google.com; s=arc-20260327;
        b=N0QOdbT/tyryyXn4vq4AXr7UTb1fbPsR8EQA0hhY+c5YYU9tDvor8idxeSjU0c2FEx
         LgwwQdT4WGLbzx2OyAJ4ntY23DVbvN0apIHWYAjvp+DZrPmqUPg4mQUNKu5j15jEUhNY
         k2G7KdJ9BA+ejIzS2aTWy3gOr0zefYK2sC+BpavLl5F4lfVniWXpmwTzk25b/TvKZinx
         pW5L3YLYcu2MNnJnY3zZKE/l0mmTYgO/kB3myWnTTiiNPnfyEfhxQ7cgVN6EiNEWYgpP
         fI4inORpM0svFzczKFsQwYhonh4sg93YEQRRXt6js+Uf9ZwbTXNsaLwbBLyWYm0uunVc
         khAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aH9fxD7OeNQpvbALLCFcfoa0nXkldfT8Qxn7YBj/IBU=;
        fh=Vqc4ln53D4bxOegRoXRnAZ9HbLniKRCPC/zyIqSj7Z4=;
        b=obgUnc7RzkB9W9HN/8m1bh6Ub51POyX53lWs1f+yFUO6s+cv1grmHCzXSNShIs4hIx
         mGhteJMVAk/US6+pxVX2GJipA23qmbksjKZtAcxUSBUgUAUxFFTMNxnpfAyseYNyhopU
         CMkVJ1SU+7wiMeyE1vKbEOWx8o7elIP5G1XA3aoOxsdUY5oFDV43+P9MhP7f6VfTR1nY
         d7cbzxMI1PdDGU5j6EVod42f4OCOeNayUSmsQPHZVOR4vrl8Nk02koCGV+cXlQ3qt7GY
         0swShIi69TwaQ0RXbWyEb9W/tuBhQllOOrM5/N3MPOnPZGDj1qShoqy+9gEDxD7oZESI
         aHVg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785194560; x=1785799360; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aH9fxD7OeNQpvbALLCFcfoa0nXkldfT8Qxn7YBj/IBU=;
        b=hVQUNjtQDnPLYVuS1IL07PP4xAZVRL0zzfzXS3dWPfhwFVea2PVAU0mLP+CxwNO4Ec
         60hpPZNFD/04WFN1fUkw4sJWFG1eKxSRjGbcB08RVMly84L8iDOO5/qgHS4auYweZzv9
         pf/t6TgakR5VXc6l82lbbm6ftpaHsW5VoTdxGyrrGAviXAMN4djc6FBVvZCV6XWLixP9
         t34EMSL3PIlKkl4JRcipA8L4DqIcrmE6Kczaq5dAj2FpU+by0UK4AlH8oGHbO+mPtbWX
         JhuNeplw21IlybyxvqqStZNHZ56aJs9gTAR1tLVvJZvaFIJJw9KRy/sbDPJDGEZedVsU
         Xkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785194560; x=1785799360;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aH9fxD7OeNQpvbALLCFcfoa0nXkldfT8Qxn7YBj/IBU=;
        b=RRofTYOCSEFM7odHKn6VYIP5ab0Gk3mlFqu1n2FfBJDzYAVPAjvF1wAlIvf3Etcc/U
         Ul2A9wW/fhBZ3fOQgEvuTzy+w5IgHgutr0kAo5iJm4EV9ZCkAlsinAgTWApYX+VEf8jA
         /3PLHi2nEUTBVYQRX3vRYizPzSCVTCzid8zZrgUqkqz/DC6+AWzT6VEO5Z3o2kdFrk2Z
         nbRi4KT5ravAJ1idnAfvEVwWDPVK9e4rb4QHZrXziMl8JHYvmG8ItKE5EqjOxzV5K2E9
         sI9cTbGZeNnaLhqzGevQNHsltZ8J5qQ0rLAVuRfLKgUH0gfwf9YqYllwM/5LryMCHs3o
         +lMw==
X-Gm-Message-State: AOJu0YyBkTkXaDGafQ8ZcdxxXdcGLf0VuUB85gGet1BZRGsqvwc5+RBq
	UaN2xTPedCQHeCT/dAs6dk1kvwVX2fYzUJhKDzL5Bg0l/kQky0Kcgt3n8Yrwm4C/XHDJ5LryFBI
	TPrJpD7tJcaqmCJJbfot9oZe5bdppQgqQFufFSG4t
X-Gm-Gg: AR+sD13BlW4L7n5sZnHG9RzWQhX+Lb/FaHnbAOA4I/7I4vLD5Up5XX6HxVWrzP6ro5r
	qNtuUSUgSzOhs9d8+cKORPCwaecb5bsEGYb7yg4odxIEyFua9hyPersYIXkQw8zHzIHsP2A+Gqi
	1GE7BlG5IpXKNmkszkpSjELqOBTSNoub0VYhmAMgtothHJk4MgL5SNcGO+M3I4vv+ngBcn5rjLJ
	kfBVQMhFNiMhLmU5XkRGlfyw0IsTSqrH0/4ma9kC/69b3iwYOedpP/H40BbXQ==
X-Received: by 2002:a17:90b:2487:b0:38e:5c6:4db9 with SMTP id
 98e67ed59e1d1-38f6a030477mr10389a91.11.1785194559678; Mon, 27 Jul 2026
 16:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260710212616.1351130-10-dmatlack@google.com> <20260727230740.GA1273350@bhelgaas>
In-Reply-To: <20260727230740.GA1273350@bhelgaas>
From: David Matlack <dmatlack@google.com>
Date: Mon, 27 Jul 2026 16:22:12 -0700
X-Gm-Features: AUfX_myIRjJ65ll44x1imgmZse5x82nFT62Po-YqpjuwILzl8FbHo5wgsdHMnzc
Message-ID: <CALzav=dHdtHPKJVbtnc1BwzccKuGSPxKH9Gvpv1ZVw4z2-0txg@mail.gmail.com>
Subject: Re: [PATCH v7 09/12] PCI: liveupdate: Inherit ARI Forwarding Enable
 on preserved bridges
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_162241_468542_4D9D5AC0 
X-CRM114-Status: GOOD (  34.54  )
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

On Mon, Jul 27, 2026 at 4:07=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Jul 10, 2026 at 09:26:12PM +0000, David Matlack wrote:
> > Inherit the ARI Forwarding Enable on preserved bridges and update
> > pci_dev->ari_enabled accordingly during a Live Update. This ensures tha=
t
> > the preserved devices on the bridge's secondary bus can be identified
> > with the same expanded 8-bit function number after a Live Update.
> >
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> >  drivers/pci/liveupdate.c | 18 ++++++++++++++++++
> >  drivers/pci/liveupdate.h |  6 ++++++
> >  drivers/pci/pci.c        |  8 +++++++-
> >  3 files changed, 31 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > index a95bfe5eff77..74a11e520f0d 100644
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
> > @@ -128,6 +128,10 @@
> >   *    way after Live Update and ensures that IOMMU groups do not chang=
e. Note
> >   *    that a device will use its inherited ACS flags for the lifetime =
of its
> >   *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
> > + *
> > + *  * The PCI core inherits ARI Forwarding Enable on all bridges with =
downstream
> > + *    preserved devices to ensure that all preserved devices on the br=
idge's
> > + *    secondary bus are addressable after the Live Update.
> >   */
> >
> >  #define pr_fmt(fmt) "PCI: " KBUILD_BASENAME ": " fmt
> > @@ -816,6 +820,20 @@ int pci_liveupdate_enable_acs(struct pci_dev *dev)
> >       return 0;
> >  }
> >
> > +int pci_liveupdate_configure_ari(struct pci_dev *dev)
> > +{
> > +     u16 val;
> > +
> > +     guard(rwsem_read)(&pci_liveupdate.rwsem);
> > +
> > +     if (!dev->liveupdate.incoming)
> > +             return -EINVAL;
> > +
> > +     pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &val);
> > +     dev->ari_enabled =3D !!(val & PCI_EXP_DEVCTL2_ARI);
> > +     return 0;
> > +}
>
> I'm guessing we're going to see a lot of this pattern, so it will
> eventually become familiar, but it's not familiar yet ;)  This doesn't
> "configure" anything (I do understand that avoiding configuration in
> the new kernel is really the main point of liveupdate).
>
> Maybe a comment is the solution.  Or maybe a rename to
> "pci_liveupdate_ari_preserved" or something?  That would have to
> reverse the sense of return values, but I think something like this in
> the callers would read better:
>
>   if (pci_liveupdate_ari_preserved(dev))
>     return;
>
> or maybe:
>
>   if (pci_liveupdate_preserve_ari(dev))
>     return;

I do think a better naming and return value convention is needed.

Perhaps "adopt" or "inherit" as the verb? i.e. "adopt/inherit the
state of the device established by the previous kernel"

if (pci_liveupdate_adopt_ari(dev))
  return;

or

if (pci_liveupdate_inherit_ari(dev))
  return?

>
> >  /**
> >   * pci_liveupdate_is_incoming() - Check if a device is incoming-preser=
ved
> >   * @dev: The PCI device to check
> > diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
> > index 4e8a01bcb4bb..6f21ec50927b 100644
> > --- a/drivers/pci/liveupdate.h
> > +++ b/drivers/pci/liveupdate.h
> > @@ -18,6 +18,7 @@ bool pci_liveupdate_scan_bridge_begin(struct pci_bus =
*bus, struct pci_dev *dev,
> >  void pci_liveupdate_scan_bridge_end(struct pci_dev *dev, int pass);
> >  void pci_liveupdate_init_acs(struct pci_dev *dev);
> >  int pci_liveupdate_enable_acs(struct pci_dev *dev);
> > +int pci_liveupdate_configure_ari(struct pci_dev *dev);
> >  #else
> >  static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
> >  {
> > @@ -46,6 +47,11 @@ static inline int pci_liveupdate_enable_acs(struct p=
ci_dev *dev)
> >  {
> >       return -EINVAL;
> >  }
> > +
> > +static inline int pci_liveupdate_configure_ari(struct pci_dev *dev)
> > +{
> > +     return -EINVAL;
> > +}
> >  #endif
> >
> >  #endif /* DRIVERS_PCI_LIVEUPDATE_H */
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 739ecaab2e76..e0c133b66a35 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3528,7 +3528,7 @@ void pci_configure_ari(struct pci_dev *dev)
> >       u32 cap;
> >       struct pci_dev *bridge;
> >
> > -     if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
> > +     if (!pci_is_pcie(dev) || dev->devfn)
> >               return;
> >
> >       bridge =3D dev->bus->self;
> > @@ -3539,6 +3539,12 @@ void pci_configure_ari(struct pci_dev *dev)
> >       if (!(cap & PCI_EXP_DEVCAP2_ARI))
> >               return;
> >
> > +     if (!pci_liveupdate_configure_ari(bridge))
> > +             return;
> > +
> > +     if (pcie_ari_disabled)
> > +             return;
> > +
> >       if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
> >               pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
> >                                        PCI_EXP_DEVCTL2_ARI);
> > --
> > 2.55.0.795.g602f6c329a-goog
> >

