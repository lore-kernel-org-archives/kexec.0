Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49258CD13D2
	for <kexec@archiver.kernel.org>; Thu, 30 Apr 2026 21:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VDdDBeOth/GyO4S6LG5C4tIpCfmXMPVkXYvoyOVLmpc=; b=3PkBsQXNtOIirI4nqy6sAY+7mW
	rD8rebre+B7EDxVjnMHk+347cs1Y7wtUwS/KOCHvE3rkaSNdlUDRoxSESs0zgWD6S1KxCYrW2JHol
	Wk8IDFLrbW6VGQrIeQ8RGj8KWO5aqbmLu2rg315OdcfRB0T6UE9/ZqdR2UATQdYZya1V+cIYNNc5y
	9DkqEWvALPOZ6EBb8Hfiac89NgOrEipa8NsiRC7D3eGbD0JLSNdbZtBl57BRhxXRUWhzjAllN83xa
	VOAFmzWY2IknoV7IeiamepWIS48gLjC59ErZTy6BQSVD2mre4Xs3xh7KnZshthkUd/QYCktrjsmiI
	8fL5mnkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIYqc-00000005yi9-1mkM;
	Thu, 30 Apr 2026 21:23:02 +0000
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIYqa-00000005yhc-130X
	for kexec@lists.infradead.org;
	Thu, 30 Apr 2026 21:23:01 +0000
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-610aadb2d9fso460266137.0
        for <kexec@lists.infradead.org>; Thu, 30 Apr 2026 14:22:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777584179; cv=none;
        d=google.com; s=arc-20240605;
        b=jZr49jEutWFNAJEuyRm9bmU3Q3KvRWHtRZwek5egsovLfEm7D/JFtPb6dyhIIR1Y5n
         ri7CJD9Wdu9TqJ1jYwyAXtJETJk3qV6Dud3GjcYPADJEsMFu+zoSQodGsJf3VNHAJ4/H
         pOVwBBsVpdW2ppvIJsESR4hsVe4SAVQngrKf7eNSogh2KBjyr2Rujez5OUVYDBOSrr6D
         GgHb0opsmSnhA34uSuwPIvl5R3sWQ5Nsm0G3hVxdMOzi0DxILo/85Fy2g4Zd+bPSrfwk
         hvaG/fDE/J0usHOuQOEdBY+lg0ikVWSNao3YEXlXbRLaR93Gp2yc5VehZfvrmix7KiJb
         A11w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VDdDBeOth/GyO4S6LG5C4tIpCfmXMPVkXYvoyOVLmpc=;
        fh=j4EUfM8OJvgVLFghZeP5ZjPwxte9HLBXf+Lu+t1ECFg=;
        b=jyeZUNh+7oQozsDnObMe10XDY4uuoBpNHRdwS+pjtio317Y/jiACCCF+RrbHY6BpgE
         O9CT/2lhaVyyqUM5/Are0wpIFxKAF5ULNqO8l1VSGjrmOhR2hXlA8V5kTbttwj9yTVWR
         BGPACw2ZNzZmgo1mcNfsWZBDrrWFMiYsFpYTCmJU45CEArVPkf6bacKtZAuvznzNfjhq
         t5+UaFzDtYprrRrZplUHzr9NRav5UZXcxaGeGS/bySamLV/N+s9fcrzzmASvh/JsoTQM
         6utu7lh4zGOq45CTh6q1r7NEG8c9XHaUzR9dzppGKd02WwhlxmAb8m9ZDgSk78bAlA//
         7hcg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777584179; x=1778188979; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDdDBeOth/GyO4S6LG5C4tIpCfmXMPVkXYvoyOVLmpc=;
        b=gV2Mynkrxf0xxOyQYAT1Xoc4tmia6FB3MuZeKjOVzExCvkxiMTGkezA8b4rU9gDMBH
         P0W80oI6vH0wZAG1EK/RaNuJXk/sD1Yjxpcooi4d7tZxsas0wt2KEDtX0ZJrTtEF3yfn
         KMSq0M5PQwFgTiKeskJ2cjiL8c5pvtJlmEtYOCLuIsxUVdDMCyFs1RHRSLM7C2YFLDPO
         P9I76xniY8qVMUEVsBz0lS0Fi1WNzwfnEbNr1/xdIl4bCmel6hnfBKPjj3kwa/8mKP+W
         2VHEf2a9Zg/NMyPJHruz4IILHbqAtGHl/V+synb58VgT82QdA+UKGUX+3dRngGk0UqjE
         Iokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584179; x=1778188979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VDdDBeOth/GyO4S6LG5C4tIpCfmXMPVkXYvoyOVLmpc=;
        b=XCd/MIHzqnPXEY5Ovt7RDzL7vHRWr4s3JBLVz5MQrClPorCbQ/s2i4pvmPFCnkOG3h
         uV47l7oEdqZrjYzV2rRx0AxvCD55aWUq/NWB6TSnABXxrqG8jy8JTm7K9QiMjoTGxWLp
         oFoJCouxQRKEnuxCCMSdLrFRvIqB5Tn87YUSBj2zarzFO7hHAOK62vAAJSq47QLBo3mM
         q5lo/KjTweBnq52UwmROGhTkewK17cHRW6HC3RcGnZh1NXYDTtq4kbhwlXdNLWzxVTSJ
         gI5rgxqeK/BUB1euqpo7sEOHxJ1T/raMaDWTbUA/dNLsO12S1f3raPaqFr2NxqOgORPe
         7MYw==
X-Forwarded-Encrypted: i=1; AFNElJ8kQ25GwXTWHK+HJ1oC+AhuCi7wXCUNMDFsbyFx/hLtAJlCl3hPMQkObuHVxcvuoUBHMPmfHQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YytTpYA9mpBXIF53G1hy5vbUxVv5Hs1Mw1ycBmSZ/SvVU91G0zR
	glRY5T/WC3Rh58Aa8sB15UEPrs2PiztwRLDURkg+XLEvCCs+QARNxQ6VQHY1MBZ9VHkw86itHkg
	vKtnGqWd+PzEsn3tOLbdD8UqBm4nxXwgZ03g605DD
X-Gm-Gg: AeBDieuYkB1pa/9NY5NdUwL9lOtRW/R2IZdi7wgwJ3fgM7nl+Inp6WUgmytu9IvrpYp
	7PiDhvvpcUlvNxQY1r3J2nidJ/ps8BU/1wTTFCcWpJ1xNtfhmTvjVu9xgSdL5uFfed9wzmIVY4n
	Pu01l2309gCb6GuFF/0wlIHgJPFddg3KmvTeBxFs7a/w2h0yrIT53jJPbVbZa1gf0BiNMY7WB0o
	bauBwOt+n+iSmXnowEg71Bpopvac24kqQJhki0e5HKSDpfyoTaeI1KbDC5mnBk5e3keZU0PtMIO
	Pzg8N9VTG7Cc1fw0NBidPj5EhqquDg==
X-Received: by 2002:a05:6102:808f:b0:60f:7499:9b6b with SMTP id
 ada2fe7eead31-62ad51bb6d4mr2567155137.29.1777584178374; Thu, 30 Apr 2026
 14:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com> <20260423212316.3431746-3-dmatlack@google.com>
 <20260428201231.GA3885809.vipinsh@google.com> <CALzav=dfLtdrPhkBkGwHpDAWUBMHnbGPccwhy1__doziNVZQJQ@mail.gmail.com>
 <20260430175916.GA13902.vipinsh@google.com> <afO9VOckgyiiokw8@google.com> <20260430204009.GB22297.vipinsh@google.com>
In-Reply-To: <20260430204009.GB22297.vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 30 Apr 2026 14:22:25 -0700
X-Gm-Features: AVHnY4Ikcvel7QdyZYGumdrGxwhKO_qS6LiUUIjUSJt8Np0PybdhnEVt0dyw8U8
Message-ID: <CALzav=dsQ7fj3MJ8Fbv9LZMjeayOgM31c-PZZd5JVL2gov+3=Q@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI devices
To: Vipin Sharma <vipinsh@google.com>
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
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_142300_301873_D0836DB3 
X-CRM114-Status: GOOD (  24.98  )
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

On Thu, Apr 30, 2026 at 1:42=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On Thu, Apr 30, 2026 at 08:36:36PM +0000, David Matlack wrote:
> > On 2026-04-30 11:25 AM, Vipin Sharma wrote:
> > > On Tue, Apr 28, 2026 at 02:12:13PM -0700, David Matlack wrote:
> > > > On Tue, Apr 28, 2026 at 1:20=E2=80=AFPM Vipin Sharma <vipinsh@googl=
e.com> wrote:
> > > > >
> > > > > On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
> > > > > > +int pci_liveupdate_preserve(struct pci_dev *dev)
> > > > > > +{
> >
> > > > > > +     if (ser->nr_devices =3D=3D ser->max_nr_devices)
> > > > > > +             return -ENOSPC;
> > > > > > +
> > > > > > +     for (i =3D 0; i < ser->max_nr_devices; i++) {
> > > > > > +             /*
> > > > > > +              * Start searching at index ser->nr_devices. This=
 should result
> > > > > > +              * in a constant time search under expected condi=
tions (devices
> > > > > > +              * are not getting unpreserved).
> > > > > > +              */
> > > > > > +             int index =3D (ser->nr_devices + i) % ser->max_nr=
_devices;
> > > > > > +             struct pci_dev_ser *dev_ser =3D &ser->devices[ind=
ex];
> > > > > > +
> > > > > > +             if (dev_ser->refcount)
> > > > > > +                     continue;
> > > > > > +
> > > > > > +             pci_info(dev, "Device will be preserved across ne=
xt Live Update\n");
> > > > > > +             ser->nr_devices++;
> > > > > > +
> > > > > > +             dev_ser->domain =3D pci_domain_nr(dev->bus);
> > > > > > +             dev_ser->bdf =3D pci_dev_id(dev);
> > > > > > +             dev_ser->refcount =3D 1;
> > > > > > +
> > > > > > +             dev->liveupdate_outgoing =3D dev_ser;
> > > > > > +             return 0;
> > > > > > +     }
> > > > > > +
> > > > > > +     return -ENOSPC;
> > > > >
> > > > > Since it is executing under a mutex, and we already failed
> > > > > 'if (ser->nr_devices =3D=3D ser->max_nr_devices) check above, wil=
l we ever reach
> > > > > here and return -ENOSPC?
> > > >
> > > > Yeah I wouldn't expect to ever reach here.
> > >
> > > Will you be removing it or want to keep it just in case scenario?
> >
> > I'm not sure how I would remove it. The code doesn't not compile withou=
t
> > a return.
>
> Oh, I meant, inside loop a break and outside just return 0, that way it
> won't be a dead code.

That would hide bugs if the refcounts in the array got messed up. How about=
:

  /* This should never be reached. */
  return WARN_ON_ONCE(-ENOSPC);

