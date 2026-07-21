Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28381C44532
	for <kexec@archiver.kernel.org>; Tue, 21 Jul 2026 23:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SWaHQpsMmrxTrkWgIFegEM8fU8LCXLhjFNzfjSgjkGU=; b=mXFgTyqP7LsL2BudY6o5aCjZU2
	elYFIxYwIEMtUOZHanm7PF9l59g/PLfCaD1gj1RWps2woKqdRkD5wVi81DpPWWmGH/60aBwJuliJu
	Qp29cemSvy46GLaEkZ3K5+sem1Dbe63AygnE4/HwO1jKK0BnatRAMu5lrKhM8mc3xnxJLpSHnNOlx
	bFF76h6YVDRKGzfkT/ee9s5JO4rNSGIiXH5RCOPnwW2lIWV+HpKV2AZXsQ5RLpvqRtC1JyqCzaou7
	MNOX7cgAoKSZsBLpzLrCujTqLY52IH1dSyxbaIxl+Hu4ItPw91xnXaA4J2IWgumkXV5iCSduMvMce
	1TIj/Nng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmJjk-0000000AZrj-1lBD;
	Tue, 21 Jul 2026 23:18:57 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmJjh-0000000AZrC-0REc
	for kexec@lists.infradead.org;
	Tue, 21 Jul 2026 23:18:54 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so11199394a91.0
        for <kexec@lists.infradead.org>; Tue, 21 Jul 2026 16:18:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784675932; cv=none;
        d=google.com; s=arc-20260327;
        b=Vg+7MZQwBrvLnN55MCmyLz+N30gVE1w7p7QXCzzJQPWOiheddPNQNOrg+9YfQgjMSs
         043XVrXs+BXUxFBaB2tVtviRNgdcV7o318zaQs8SxEDjBht7EoiJbQJ3VA9DS2PYbNJd
         ocFECkoOO1mz89ETx6d7+88eJgMgPFO+LUuNHmJdg2WOfF8h5JdyHETTQdkrxEEogeHj
         4f4skOMBekEheQ5BlV4KzV7ePXhsYAxp9TtP0qhRkWKGTPMieSHe0AQsSrBAIPZFbPYg
         diDICbxLU/6vEYG4aNLErYO7UhSnHHfCNTI2bRfwCNjl25KqeuG6LNHvkBPZ1K0TH39Y
         h6bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SWaHQpsMmrxTrkWgIFegEM8fU8LCXLhjFNzfjSgjkGU=;
        fh=HsJz5H88gnrBMerBT7y5ff7V2PUxJaRKsISpT5jLQBY=;
        b=DiXLgrbtr27Zv5P0Ark2w36wiQTGh2DlFCmpGjoigx4z/pcU6z6oIwwknZwuO5zWC5
         cXJy+n9MAZi6q5yaWMhKo3bFCYIkdZF0TaKoPQNpjTewsSoVh9yRE4cvsCaD64Mj8fNj
         UwAwZQTeTFRNQifeFfAgSxETis6FfqZFh88CCWsLNugg9NWB5w1dQhmpP5v44egpC8Ib
         EvRHwddD5O5EBZ34/se5zuV+8S/qr/kKzvlOtMnhnw7xjIBHoapORYEPkxaTvTAFtAQU
         JMCkLCUDNrZxi/CK/eBHFnb1BLzSkrqxtrYYFRJ1ZJoGbyvoWwQkmG0M0kUYP2qq4ghK
         2TSw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784675932; x=1785280732; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SWaHQpsMmrxTrkWgIFegEM8fU8LCXLhjFNzfjSgjkGU=;
        b=u1qZ2wR0S8HUcH9HTjPV+E6llQu8yJnbvZNu5U9bnQgZATaSthfxc3hLWBroZqO8Tl
         Tch6FbOvo2z7Rf9fx4t+wakBpK6dGY5uq8WC4HMD6PCo/93oZrYtMGg04+MrowClfvdx
         9hJXqK1bBlwlqkcO7xm/g31goTyRWd27vW5RUFMc6pC2Z3hNEVkVxvbXDIy88bFU4wds
         8GKbS8XCt+ux6AUnjq+6XWyHM1tjXSeur8HvTAlqLNdIyymV/mbGEUaZ1+QIMzBzH3Ux
         72RHCXCfDt4d7x/vT3zKdw0anS9q9PEQ0ngzLT0+KC9CtSFxmrEqmrBqMBY3ugQVNzV/
         CoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784675932; x=1785280732;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SWaHQpsMmrxTrkWgIFegEM8fU8LCXLhjFNzfjSgjkGU=;
        b=WS4QpyF4LkcAVuJPXDyv9JUsx9eGSzc0L+YiCO0jJ9IxPD/WY8lglp1V01HMpDpQtJ
         YjmaqcGsWelJ/zRzq5MDJiBvO2xp1qxfaeZ4CP7V/wd6Ywuai13+R206BijEXCqyO8bE
         7vw0obQfO4ZMI5D1w/SXX8ESG94aUKMVCGFRs/UnEA3/JwR1Ercjy5NuwPPiNvKJfKJf
         Yc+xhh5tf9y0VuWp0RdnRnCwg1lw5VJwxzeAa87cawjQXzVq47gblVRXpH4QHomf8B04
         sOtquyJxJVOK4F+cwTjkXCdTbEbMKZLR8t2idX5UOs0X6P+tI7ANZWzaenLYami9NtmR
         5Idw==
X-Forwarded-Encrypted: i=1; AHgh+RoLzfe65fiyG9/647IQMYyDtKLrRhZNsUuUxkf2cGvZnXIlbPwtKp2pDqH/ZCoZ+/MImPSn1w==@lists.infradead.org
X-Gm-Message-State: AOJu0YzpB4yW6bPfGk+Jv4brafwxCUoB0TtlWFuz18+JwjPhxDhzk4U3
	Sjfut4m8ZFEPg7P1k52CAgD2tYWPeQgDmc9yyp52lAdrWFYXhK882AUgj5vddFbsZheTg53wMC5
	izqRai0dACzPUDEckrC+maYTG4XnBOpiyWYZ/Hw/c
X-Gm-Gg: AR+sD108BWOUHRzNkqn4XZtY2eVmr5aj9D7gGbmasXybNHhgxMtn86rA+D3HHd+o40U
	c89hnbXBZbsdqI/v717qEs4z7jFt4H14GUj61ZpNw2+pdXypPmqb++eZgxwW6OXUETZoAf8AsbA
	t0GT4tukbUBESJA18bj5FzUxYf+dRuxz0WUBHbP1aQJwH+FmQtrtvmLLAuseVtVwyZzm0CGLKOC
	EamhDZfQ8mlOI7HIL6vtWrn3VAosIkqhBlDYDX7/YBR6n1uoiVSiCNe/KdGmh+lI5gL1HR2
X-Received: by 2002:a17:90a:f94e:b0:38e:500:3975 with SMTP id
 98e67ed59e1d1-38e4b476b7bmr20562050a91.18.1784675931394; Tue, 21 Jul 2026
 16:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com> <20260710212616.1351130-4-dmatlack@google.com>
 <178432481253.189683.3297727348836286619.b4-review@b4> <CALzav=e1Gcu-9TD7F--41cYqKBrStKOE4VqQ4K3PKdNuYnNmcQ@mail.gmail.com>
 <al_3nOssZoa6RoCq@google.com> <CALzav=dvc_bdmFtV1U2APfs1FM-6Zi5=VShcAYQjZ0wwNRfC-Q@mail.gmail.com>
In-Reply-To: <CALzav=dvc_bdmFtV1U2APfs1FM-6Zi5=VShcAYQjZ0wwNRfC-Q@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 21 Jul 2026 16:18:24 -0700
X-Gm-Features: AUfX_mw8WVTULDGM5fg02urMXenJj0foOmNcG_--0euC3EYm6G6QAbnPcLHsH0I
Message-ID: <CALzav=fYx7R7c6FTQ5bC4bbQ+_KNaC3gopcPihOtKmHGaB6s1Q@mail.gmail.com>
Subject: Re: [PATCH v7 03/12] PCI: liveupdate: Track incoming preserved PCI devices
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_161853_169337_F95EE039 
X-CRM114-Status: GOOD (  36.51  )
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

On Tue, Jul 21, 2026 at 4:16=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Tue, Jul 21, 2026 at 4:02=E2=80=AFPM Samiullah Khawaja <skhawaja@googl=
e.com> wrote:
> >
> > On Mon, Jul 20, 2026 at 02:54:51PM -0700, David Matlack wrote:
> > >On Fri, Jul 17, 2026 at 2:47=E2=80=AFPM Pasha Tatashin
> > ><pasha.tatashin@soleen.com> wrote:
> > >>
> > >> On Fri, 10 Jul 2026 21:26:06 +0000, David Matlack <dmatlack@google.c=
om> wrote:
> > >> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > >> > index 03075ce06ac9..df6a02240aa4 100644
> > >> > --- a/drivers/pci/liveupdate.c
> > >> > +++ b/drivers/pci/liveupdate.c
> > >> > @@ -298,6 +377,87 @@ void pci_liveupdate_unpreserve(struct pci_dev=
 *dev)
> > >> > [ ... skip 76 lines ... ]
> > >> > +     /*
> > >> > +      * Hold the ref on the incoming FLB until pci_liveupdate_fin=
ish() so
> > >> > +      * that dev->liveupdate.incoming cannot get freed while the =
PCI core
> > >> > +      * has a pointer to it. It's better to leak the incoming FLB=
 than do a
> > >> > +      * use-after-free if driver does not call pci_liveupdate_fin=
ish().
> > >> > +      */
> > >>
> > >> I am confused by this. Each preserved PCI device must have an associ=
ated
> > >> FD preserved with it via LUO. I.e., vfiofd would need to be preserve=
d. If
> > >> the vfiofd was not reclaimed, and finish is not possible, that vfiof=
d
> > >> would still be owned by LUO, and therefore PCI FLB refcount would st=
ay
> > >> positive.
> > >>
> > >> However, if finish is possible, and this is the last vfiofd that is
> > >> finished, FLB will be freed as soon as the reference count reaches z=
ero,
> > >> which I would think is the expected behavior.
> > >>
> > >> What is the point of holding a reference here, instead of only for t=
he
> > >> duration of FLB access, i.e. to make sure we are accessing a valid d=
ata?
> > >
> > >The duration of the access is from here until pci_liveupdate_finish()
> > >because that it when the pointer (dev->liveupdate.incoming) is
> > >cleared. So that is why the PCI core holds the reference from here
> > >until pci_liveupdate_finish().
> >
> > I think LUO gives you guarantee that this pointer remains valid until
> > the FLB finish(), because all the vfiofd that were preserved have not
> > finished. And when all vfiofd have finished, LUO lets you know that the
> > pointer is becoming invalid so you can unset these in the finish()
> > callback from LUO?
> >
> > If I understand this correctly, I think by keeping long references unti=
l
> > finish you are replicating the vfiofd bound lifecycle that LUO already
> > gives you.
>
> Yes that's right. I am taking the approach of not trusting drivers
> (i.e. VFIO) and having the PCI core maintain it's own references so
> that FLB finish() is guaranteed to never be called while a device has
> device->liveupdate.incoming set.
>
> Alternatively, the PCI core could avoid taking a reference and instead
> check for driver bugs in FLB finish(). I previously explored that
> approach and ran into a circular lock dependency between the FLB mutex
> and pci_liveupdate.rwsem. But I can look into that again, or just do a
> lockless walk of all PCI devices and panic if any still has
> dev->liveupdate.incoming set. It will only happen if the driver is
> completely broken so panicking seems fine.

Pasha what do you think of this approach?

It avoids the PCI core taking a long reference (your conern) and also
avoids the PCI core needing to take lots of short references to access
dev->liveupdate.incoming (my concern). So seems like a good
compromise.

