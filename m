Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC01CD3423
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 18:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ynp4A/JaH22lvkihT3nPFtsXKnzutYHpfXYULBKQQKo=; b=NRjEi9d2I4vJVvwlNwB2RhplLe
	HPf55WXcz+/sbuk4GOMjmVpUmefZe30IbT0HYyn+Po8XSS5NzH8WnAoIjK+9feqxM0qC+TpAzZoTd
	sffrWnBntE6rLxyIBcqNTcnQTR4Rf0srIpSOCKFvBJdnyEj53W05l2+shAq46DuNaT5Phmr8031dr
	+ZmNvIwgzGEVthvoKqhxP9RZde1V5E/DaIL1B3ohsIp7uWEuGvAi/pOKK0aa0DxMcH/99Ow+txrM5
	qLChLpKTLUoyqluVo7qgWm/0WZHUMgjAaDffdFWeojv2IxG7fa2MS2GwbRhplBk/rD6is+Ol4u0Et
	UPR8JuMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIsYt-00000007ZHi-2EAh;
	Fri, 01 May 2026 18:26:03 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIsYp-00000007ZHP-33gI
	for kexec@bombadil.infradead.org;
	Fri, 01 May 2026 18:25:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Ynp4A/JaH22lvkihT3nPFtsXKnzutYHpfXYULBKQQKo=; b=h1FYxIFpWk9RRXlvEoj9nx8kTk
	OdLB+heOHXZY8UX9nB+7VYyV8IuWnhozDCWjWw7DnQG1XBirlhCMHAj5lLvFBkvHzYhjx/PlPT4Ya
	noMpaXvKnPIy6ADfGleos4SWpohJxordSxMHPJMPOXjE2dtyMhbTpta0BXUm1LK1kWgm2cnhsgbdY
	0e46uAWsPjkOBE2uxr6l6LMwpCuO7yh6NI9Bzl53kJkHuQo5PYlUCF+MmKVKOBsWXkZQyNf1zfkLw
	hScxvBAYSjTF6npISr0fE2zQkNzQ2c12FfH35k2o4IK50Qwxe63NHE0CPYVBVvZuKSY7KVUJgAUib
	PUy5cW4Q==;
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIsYm-00000009Hm2-3sLd
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 18:25:58 +0000
Received: by mail-dl1-x1231.google.com with SMTP id a92af1059eb24-12c726ef332so3485903c88.1
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 11:25:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777659954; cv=none;
        d=google.com; s=arc-20240605;
        b=JlLgqhCDgGpfZRnfhBnDOCPrXfxCOashKJQ0i4m0rG4dknOj4j2F264lOqyw3vYIvJ
         bRTTPZ9D1SVOCTFwvfmGpTOEuehlvK/FqN81tdmoJ/CdNMWCYR+Orb4g6nFjmkp4hsLp
         wI0opnaxpJ44FGZaJKAxlsPOQY+4pOH5TanS4t8isZlw2KFWLys7seLmBSdJuudXxodf
         KEZdMSj++Y0nzDNK7/V1RQRSZxUg7utjzXMEE59pf36w/H2jbTdRd8mu0Id3ztQiHaLo
         qp4oLYAVB5AxBMiwEIZGz/v6eRsxWqqRSvYx8xUTXe7Vgz/Q+rfV6YodFH/us65c7mNc
         +SoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ynp4A/JaH22lvkihT3nPFtsXKnzutYHpfXYULBKQQKo=;
        fh=GTcRK9lFZ8PHJXY0f5/tCvkJpO0ZkpDbtQFdIhICgIk=;
        b=EVOIRfuA2FvL91IKpinEKBtX10WTqiv6XK6jxQbYLvQvtWPT/KPl6K/VfcEumlVbG5
         6+HISCmuSZbICWvcrecfbOx2fCkOD6zkuD/kOOxJD0esEKq8F95ZrCwvyCQVLPSn9ZGf
         DqhPZf8+RZwwvXwpcvPGFcnIRZy0G7qW0bJmWajaYRraaVZrfcNumDb+gwXux7ErP8B4
         d6peGBUpYl0I/Wup9G6aIF+D9iGtJftqsxXWG4I2P4w8xHwMFWE3GOivo4vRjso+7tCI
         jG/YPz91IzRFt6i8ZTHk2obGhPmDHWR2p8o7S7/7uVUit/QXIO49/iuSZqTaxnxP3LSF
         /cYw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777659954; x=1778264754; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ynp4A/JaH22lvkihT3nPFtsXKnzutYHpfXYULBKQQKo=;
        b=KzZMoHAuFlcpIcLNS2xTqamkTkjtS/ynKt2/PKwExp04oWXsafz4PQ+dlJLIcj30xz
         W8vkrYeQaNvnyVD+po9lUkrrThF5YNwTYg0aeGm18Kf1UWMrHOS6hwxAaHVRxW5sgUfc
         oSM9pvfFwFyWItgwHQijclzeVhRRcrJ/gRzKxRKYXDyTsqEKDpwCe5Db4pjWWMPCieyK
         qMnPbUWYV+yejvuO2MY5K8+zMvC5GZODJIBMoDXCI8z6l1i+QBYZL1z+Ls/rBS/0U2c0
         InlYYIFvABMk4Sqg7WzrKNjPKr1HucPntPHzR3GwvDntMfXfiUVE3tJIobhOmQplqUOw
         ng2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777659954; x=1778264754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ynp4A/JaH22lvkihT3nPFtsXKnzutYHpfXYULBKQQKo=;
        b=dqFoWchmnpvZjl9QCkK7hoWt7KcUQzbDy7JBPDNbPqTIFrUvDluiAuUrfuQsVa3GL+
         caFYD8iVjThS6AV4m242QXa9SH6LxS2SUrUchBrHBVkbOZVLCnS4LAP+3YcMkyvwxbFc
         jB6Nlq4qI26gMoZS7opyJO9yJvFnM3bC/qvcfYjntsj06dRdFNpOK1REzvMc1EEG+BYk
         uPJIn+C0dqnw/NZ72VGZ+FTZf/cA9eMWLDefuOKagaAMWmG4LdTqhLIz1YIXKbaDVqif
         IvoTMfcZXkhC+7vt79CRgKzBJ7A9KCIQfcRX8+Tz628HElIY7wiaGOjlzLW2eh5nO/Kp
         mBGw==
X-Forwarded-Encrypted: i=1; AFNElJ93WFt4gSe3JdVO4h8kHxRQwJ7kLtQDCapb9tkJbdcGzFwxlMje4khYiOwyLnK6HaO8BUH08Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YzWNOrL5O4iYgamOurKo1aZTc3TA21ac/thu6m4XDkQDM8NUtoW
	q7t/fqY/aJtmhpF2c+mBneGMGrkWVgY7GGJDbWidc2G9QlePVv0rfQ4ZwthDZVqBvdg+DRaTErT
	sNK9sIgToER2+CATYGLkrip8IPy4UQaF00XQwsWNA
X-Gm-Gg: AeBDieuWuoLOSejJZQsWahlPeOhRCAQC2w555qZKbDMHOnFGgBEUYipbQ/G+FxpSe5f
	aMLI3nBIBd7LoqOP4HFVWKEFLuxJu7kWQZP2veSC8sqJ8zovU3TjG1nsps22zHnJqF0bubI+517
	s+UUjFvVzmyeiRG6Fkjkpag5HnMWMSFhIwZoVjLoVy/K2P3qptKtBdlKMlo3r3Mex+8/4rEuZpP
	Xf7v7ZWP0VusbCkxQK0WDDdJb/wUXZhJKRR3/oEWrroW894enCgwlQT5duXx4CIA2Ujr+QHNwGc
	jNzeDUicHbqFq9lZqT/zgL6aetE2Nw==
X-Received: by 2002:a05:7022:ebcc:b0:12b:ec15:69d3 with SMTP id
 a92af1059eb24-12dfd7d88femr150449c88.19.1777659953185; Fri, 01 May 2026
 11:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com> <20260423212316.3431746-3-dmatlack@google.com>
 <afDqs6oqWlhoVqMN@google.com> <afPGYp145FbrvURR@google.com> <afTgOXpUNWMapPAS@google.com>
In-Reply-To: <afTgOXpUNWMapPAS@google.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 1 May 2026 11:25:26 -0700
X-Gm-Features: AVHnY4LHOeLRxPaffc9oaSUdxPiYe323BsN3VXy59mO0tVvOtZ5BkXLT2WRxf9Q
Message-ID: <CALzav=cJLA3-gK=Ljfqf=YCPML60F=hM_teB67M_3PNCZE4T9w@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI devices
To: Samiullah Khawaja <skhawaja@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_192557_147905_A7DAC712 
X-CRM114-Status: GOOD (  30.64  )
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

On Fri, May 1, 2026 at 11:17=E2=80=AFAM Samiullah Khawaja <skhawaja@google.=
com> wrote:
>
> On Thu, Apr 30, 2026 at 09:15:14PM +0000, David Matlack wrote:
> >On 2026-04-28 05:24 PM, Samiullah Khawaja wrote:
> >> On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
> >
> >> > +  for (i =3D 0; i < ser->max_nr_devices; i++) {
> >> > +          /*
> >> > +           * Start searching at index ser->nr_devices. This should =
result
> >> > +           * in a constant time search under expected conditions (d=
evices
> >> > +           * are not getting unpreserved).
> >> > +           */
> >> > +          int index =3D (ser->nr_devices + i) % ser->max_nr_devices=
;
> >> > +          struct pci_dev_ser *dev_ser =3D &ser->devices[index];
> >>
> >> nit: Maybe we can move this logic in a separate function as down the r=
oad
> >> when we expand this to add VFs and Hotpluggable devices, this might
> >> change significantly? It's good if it is self-contained.
> >
> >Did you mean to leave this comment on pci_flb_preserve() where it
> >decides how many devices to allocate room for?
>
> I was talking about this one, as I think depending on the scheme we take
> this might change significantly. Just a nit, you can ignore it.

It would depend on if userspace is doing a lot of unpreserving as
well... I'll see what I can do in v5.

> >
> >> > +static inline struct pci_dev_ser *pci_liveupdate_outgoing(struct pc=
i_dev *dev)
> >> > +{
> >> > +  return dev->liveupdate_outgoing;
> >> > +}
> >>
> >> Is this expected to be called under the outgoing lock?
> >
> >For now this API is only used during shutdown, at which point userspace
> >should have already been stopped so drivers should not be changing the
> >preservation status of an outgoing device. So I don't think this needs
> >to be under the outgoing lock, but it would be nice to have some more
> >explicit synchronization.
>
> Ok that makes sense. I have similar cases in my series, but maybe we can
> add kdoc regarding these stating in which context this is expected to be
> used?

Yes will do. I'll add some documentation and also restrict it to avoid
misuse (move to internal pci.h, return a bool instead of pointer, and
use READ_ONCE()).

