Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D125DFDEE53
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 23:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=du3muYvsQpTSBNV17AfC1+OtrIQr2PLFz51edOhTt/Q=; b=zbeb83K9Q1aRP2fXxB1q8s5JJ+
	XLjYco/UPdScYseQCj5ofTdgV9Zr2SXA9/SeFdJ0UzMMTNJzxMwq9TlJpayKwQPtIG22tdERaPeeV
	5fv8sY/4S2lRvGxo+CabzP5bnVuOAZbTFVYlo60t/SupihUvEejstpZjsrFUjJHbfY1Wnh8xLnVds
	Skhypylnk7r0gyCmAETaXLvCGy0exPDXVysNvdc928SNyIjMPq6uiWOlfHRYRbAS2RPRHNlUyXK1d
	qjtE+Te85y2ADsXI7CJNLQGuW5dXR00xNsLUamcDhomxJAv89utSvDZ6IJOwB9wCk3fCT0XGNnMhP
	8J4zu4Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG3Ar-0000000CP5g-25Os;
	Thu, 23 Apr 2026 23:09:33 +0000
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG3Ap-0000000CP5G-3cPW
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 23:09:33 +0000
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-38eab6cf7d8so69423171fa.1
        for <kexec@lists.infradead.org>; Thu, 23 Apr 2026 16:09:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776985770; cv=none;
        d=google.com; s=arc-20240605;
        b=lRnXI7DasUmsmdbJlHdOAkqn2pRSoyVRWapyu1jBx7KeeoNdMsqNYeDDjyC1ex9Omz
         BUqsT9pRAEL40nB/0PXTYQ2Zc0Fo19DvmEpaj9QUqtSeZfMYB9crq0Z7igiNvbHMinqD
         RMC8c9qhf5ps0/yePVvcNVllO0iITjOnhLn3TLCHjSpoxrys3r79oAtN+Zci7rwFgA7X
         RDhrQjZFmJ8O8fabJVsQV0BZGWxkVMASNplq+QCgzZyNendV5DDkxBZo/sFdHEpnaG+v
         JNbBN+LNFMUWgzdHeUfNcP06uyt+VFYE6wkJXLAdb4Cb6aWltTbMra/ahR8Ig4Vz6z1U
         78Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=du3muYvsQpTSBNV17AfC1+OtrIQr2PLFz51edOhTt/Q=;
        fh=HYderr7TvAzN+kEubjrQVIZ0pMq8ICobkpDsdjGECGA=;
        b=bpyRMN8yvj10R92mmv7Y52rX9JScfwffXT8Tfl4QP0RPs2t5XAixwk0HwdK8alcRsv
         7AA5OngwdSiQHhhcu77eY2QIg+KhcCDhx/2xrcldqa8eIcwbWGgJ+PgiV5V92/3Wkcff
         kViVp2Gwe1N0s0A1p+Z54w6jmYCdt9mdtE7ezx3iDZ5OSA8OPAjhtr9qLDm20d4WDr6u
         OrrVjhLoLP9738Nz+U7GXY8kYcAHMh6CgTGRgnDjG32jB8z7bc0KSw8UhfzSB11Dar6G
         FU66LrI70Jgx+YMGm471dmP2eUsFoETx9Qxs7JBlpULHxn/6XB/OkHRB2YG6cVSsuMuA
         6I4A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776985770; x=1777590570; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=du3muYvsQpTSBNV17AfC1+OtrIQr2PLFz51edOhTt/Q=;
        b=a0kMmlBLNgdbI/nWByYK/E9zPkDwyTU1oTmc92RH0+WQbbWPIFTXI2IqzURNmvliLu
         4yLqqqHovdctYch9B7Tu8IE8Cow0CTI5nabpWOWIhKle3tF04dpXMF6GUSNdPMyuIG1q
         0TC9RvD6Amh50+7rN4Y4G3qZSWFg772DqRed1wQ6+SHXKaqC/OFhmg64NpvdVT/do/f+
         i+x+RuCqzhvErZPlb7Jrfa+M2nsE6v1GvTA/Z4UQ93Z0cJkz5UBOxKUw/ofEpH+8d5Lg
         Ov4VpN4fc2R9UPz/i+ei6QRqwr2MVkKNWTD8zhsMrSamfeOezHG3mrF2mW5f3aT1JZ/t
         +vtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776985770; x=1777590570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=du3muYvsQpTSBNV17AfC1+OtrIQr2PLFz51edOhTt/Q=;
        b=GaguS0lA8svuqcYXgDseXDztIOKpCXol0MYmJTTFJputWxJT6PbfdY7PoBRPgwdk6B
         ZUi1q2J9PacmPCDGAZHPcFjF/Ll5CjlcdmeKhHKnybgQPXxTS5G+L8QdOar+y8Yd3P91
         DHgufW5AnPE9dcCwKa+DngSMrDoJQmL4noTouVVjVwp1V2cKtcMeOdfEZIisbPzgAvJD
         XiSPYqpPJwlrx0cCP/hiNEKm+6M7M5k4fZfxr7j/jIgNojcpuoIQV6dVDCz34hzpUnkq
         UIlerVOR47UqOJFawoLR61zqtUcE+nHyy4f75WsKjOuRhaxDbyzJyga2hub4tZzCXA87
         yFHg==
X-Forwarded-Encrypted: i=1; AFNElJ9WIZfjGv4eH46BTlYOaySNEBaIqsLw+L5TE9k3W8qccG0+ipy7rqnpty6DzeiklOo+FY25zg==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywm1UWGI0DvQFujkMZvlM4hzDcjBRnDuWHlagHpsgkc+bXZKIgQ
	Ngh5LEMlp6MlmRKzf8WVzyHm7mv1xsFuSIL1i6gokryjfeZKHGIXAKtrfcn5i4TeXxB5jbBwXlL
	Onk+c63U7dflBTTWfZucDDOiI0kMmawC9yEKPBwul
X-Gm-Gg: AeBDievsXCMX/kV0uXPcAgpFzw129aBCbrQwt3SZo9UslDKdSW32T0aZvEUEqIbXB4I
	j0CS8GyNyrWu4ZDsBx7KKyEOz18Zq3EFhabum/Z3Yq8P46TXtGX/R2eY/vsODEoTBq/wAxaM0TV
	ETTsQxVRTc0pSP1MitNbTgyqeJkg0SRFx7rdebx/GGJXh9g1krK+SjROzIULc7b8bE4mUGDGzBX
	GOSNDMsrqFCQoh6+udSiKdnXjy02wL0cHg3lBXNVGoSwotO6EQzWeWnoa1cxcQisqA9sBttUQcA
	vdqAq1sOwQeWYJtNPIs7I8M3zVtfLw==
X-Received: by 2002:a05:651c:418e:b0:38a:965d:79ac with SMTP id
 38308e7fff4ca-38ec7845ffdmr82161421fa.12.1776985769266; Thu, 23 Apr 2026
 16:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com> <20260423212316.3431746-9-dmatlack@google.com>
 <CALzav=dGpHEnEjyp8qc50iZrGeKJ47vjLvwtvkLCyNzOMJhozw@mail.gmail.com> <20260423225253.GA3444440@nvidia.com>
In-Reply-To: <20260423225253.GA3444440@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 23 Apr 2026 16:09:01 -0700
X-Gm-Features: AQROBzCagtk2g3nQiz1XNHTS_Y7Vpcsrr0LE0644u_NVwvd3XuR0UjLC-oW_vCY
Message-ID: <CALzav=fraXLgGs-XMc-=whMPhMbS99twFskGtV5Eo=UQ9mU5Fg@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] PCI: liveupdate: Require preserved devices are
 in immutable singleton IOMMU groups
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Joerg Roedel <joro@8bytes.org>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_160931_931019_F9BE5664 
X-CRM114-Status: GOOD (  28.87  )
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

On Thu, Apr 23, 2026 at 3:53=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Apr 23, 2026 at 03:10:55PM -0700, David Matlack wrote:
> > On Thu, Apr 23, 2026 at 2:23=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> > >
> > > Restrict support for preserving PCI devices across Live Update to
> > > devices in immutable singleton IOMMU groups. A device's group is
> > > considered immutable if all bridges upstream from the device up to th=
e
> > > root port have the required ACS features enabled.
> > >
> > > Since ACS flags are inherited across a Live Update for preserved devi=
ces
> > > and all the way up to the root port, the preserved device should be i=
n a
> > > singleton IOMMU group after kexec in the new kernel.
> > >
> > > This change should still permit all the current use-cases for PCI dev=
ice
> > > preservation across Live Update, since it is intended to be used in
> > > Cloud enviroments which should have the required ACS features enabled
> > > for virtualization purposes.
> > >
> > > If a device is part of a multi-device IOMMU group, preserving it will
> > > now fail with an error. This restriction may be lifted in the future =
if
> > > support for preserving multi-device groups is desired.
> > >
> > > Signed-off-by: David Matlack <dmatlack@google.com>
> >
> > Jason, do you think requiring singleton iommu groups is still
> > necessary/useful now that this series preserves ACS flags on preserved
> > devices and upstream bridges?
>
> I have forgotten why we introduced that? There are alot of funky
> things about iommu groups that might be important upon restoration..

You had originally suggested it in this thread:

  https://lore.kernel.org/kvm/20260301192236.GQ5933@nvidia.com/

> Like if you preserve one group member but not the other what do you ?

Yeah I imagine there could be some tricky cases there...

I wonder if PCI core is the right layer to enforce this. Maybe this
fits better into Sami's IOMMU core series since that is where all
those tricky cases will be (I imagine?).

> Even if you have ACS flags there are cases where groups are still
> aliasing DMA..

Hm, if a DMA alias can be created after boot time enumeration even
with the REQ_ACS_FLAGS check, then
pci_device_group_immutable_singleton() is not really immutable.



> Frankly, multi-device iommu groups don't even work fully last time we
> tried to use them in a VMM. So I think I would not expect them to ever
> intersect with live update. Blocking something tricky you can't test
> does seem like a reasonable thing.

