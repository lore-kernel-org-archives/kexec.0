Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FB5C982CF
	for <kexec@archiver.kernel.org>; Wed, 16 Sep 2026 17:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MsBp/K/8Mh4fs+CJj0dFevHba775OvfQ8W0kzE3hMzk=; b=A5X66iTwINBYHzVbEMd+yP7hnl
	lRPNw/vaMe6FMPK1ZehMxweGoHG6GbZ9qVo9G87WB3Gzq/frzYuXI5DWkpm7kngLA3eAQa6gVyBgD
	RZ36q/MbXOEIcbA4Ptw6ICOUeeqgtMzMnueFaAVAwqJYaYVv9WgNtrTHwEkMLI9QcpxV2ewDMSU9C
	ZIZaDm7U5+D7WMyN1oVNqaIvAdtwaVmRu4B+NF8TqqSHrd+Av70jEtahPze3sWdPw7gl8kjupBtMf
	OXenghgWsVosFLWtJ3IfI3g8pKQVAY/bZPZh/+Zy7KIfk/O0y0X0t1D5jY768yaK3pMIg9VavwVzx
	LJKhDGYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6tRk-00000009s8s-0m4P;
	Wed, 16 Sep 2026 17:29:24 +0000
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6tRi-00000009s8U-0Nty
	for kexec@lists.infradead.org;
	Wed, 16 Sep 2026 17:29:23 +0000
Received: by mail-ej2-x10.google.com with SMTP id a640c23a62f3a-c254fa650c8so464766b.0
        for <kexec@lists.infradead.org>; Wed, 16 Sep 2026 10:29:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789579760; cv=none;
        d=google.com; s=arc-20260327;
        b=f3slc/npfZn2vC31NyRiQpo3/t9toFl+nZDX8ya4mMWX9/c//HiohKbv61qdInmKQl
         YE0mio8MLlQzIGZ2ITVS2JAMbabxu36Y1rfcGbVZU4XaA1Fe5SZ4Vapg5/qbReHESARC
         bkjdis6i3I8Rotqe29IZRqFhMuF1UtryOVBhp+YHNrbjsPoCIIXOL+9a9JUUqZ1lAnTV
         +c08VyjEUwGDK76PgJgxNFgrC7+FEm7mntsAoasNO9nzWA6ddET6MOLd70MLL8Z+pwg3
         ehll7rUfgTAIQ5YP8p4T1dXgM227Fcn+05Q+vatNHBQZZu9kJA/m/PIyBwuCTvFP8qeZ
         YlBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MsBp/K/8Mh4fs+CJj0dFevHba775OvfQ8W0kzE3hMzk=;
        fh=qrurRsB6tpOKG7UgO4S4127AKWFozT3W5QrkFxhFbC4=;
        b=aCgUI2MZtTOPBvw277SwBw3Yzvsk2fikDbIN91CPKgyA3Sy5OegUPmEG258OvSSlxw
         sbHD+AcK/3/DagJrp06tqw6MSGfjPharqC+hQnE+QiI2HryJQGoWSgZrkgCsy2/EyZjZ
         JYvZKno+Nbjv9y2i6ZazuXhmqGbM2b99e1H1JI6CxQV8g5F8WdYcG8PCQw3BznBavKUX
         f7WkYZIruR34oFPfmF61CRpmWhui9C8F0MHYPLYycSLNlKMzcE4jszdDbGGulE2q6liv
         hA5nI64S7AmVbbSX5auOWkPwfb7pxXdn2FS2gERmTjehn/0+GZgfSdEogY5jNJkuUu33
         39Ig==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789579760; x=1790184560; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MsBp/K/8Mh4fs+CJj0dFevHba775OvfQ8W0kzE3hMzk=;
        b=pINcEISvG+kZnFm0SW9bkhRHzYK3PWfF2U1c2NgPBwmr7Zbe3AXS2DP4nbrS8K4glZ
         TGNVlcGRNL4CUK6YlymToaiLS1VYtWWaxKPpIZ6mrphz3L18YB9o4wEfL9EeGbs50yz5
         8EDSy0CJcJYloTSiRBHTWa1G0eKSThNazx43TL1hm4Oq3tKcCPLvByWmQqfdoahv7XtV
         O39f+NedLWH6pOtu26krkEl+sTIWTqynBQyBCs8PISBwhG/cfn4PofqFziGqlFyn56k2
         rZtzjBJso7Xh6bxDjkwYpFOPbe10QsoYC/X2m0mRhI+D2KaeuVt99K+P+YO74wd3tous
         CnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789579760; x=1790184560;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MsBp/K/8Mh4fs+CJj0dFevHba775OvfQ8W0kzE3hMzk=;
        b=WYo5mU0FvoH+8myy2OsVbngQ6zIIbfHHnfuyVGLt4qofrAF/MCE2q6sod+wE5BZF1G
         jxE+xpJpuF4luopd9wMJH9sKEtKfXyuE5/xsqopaaJD/sluMudVFT48rReQWqGqU1HeV
         lUCOTqH1d/NeQMdcGerokB18+tQRcSvk3beFNCY2C8qLwLTbzr4sBI2zpo7k8YIhjLK+
         7GbGtTysCBiHk3OVDYwC3F/b0gq2/55t/NjTxK6mLVMXJN50ZXtUN7AF6vPy/1GbC6mw
         3OKyPMU5HVF3s/u3OPyd4gY5IdpAFs2TtevDQ23yVgZ1bcXsWLaOV7zybLURR/Ax74TT
         24ag==
X-Gm-Message-State: AFuF++loQlntwfk4CuLX3ZwVBl/e/ZuBDixi4wUyLt0F3sh+oFLixh0R
	TZz1GjTVyTDRkGZtrRMmZfHN4Y38zT9WhaRIq2BiN40RZgfnolON2njseBki7L6GLHXYvh53dh/
	m9sZ8vBBF59QXZ+2nM5ASQeWGV9piEOK8DysuLCji
X-Gm-Gg: AYBFou3GRtThJ9ZkSGRs3s0Iz+DJ0WmOxOLrqD5bp1XRA3UeGF3xyLFA1PycXPxtNmj
	PGAfent9+tkEF7yWk3mDT3OTrCirbLtevMa3ANGh14No24aHxTnSUlUUVQj1jAfRFiTbAK51gpJ
	z/qi4d0glwjOXAzalxuZzq3J5knKKstz6TeQuCgEJWAwKAgDNSXdhXK5ouFqysbhu5iNiFw2BYZ
	vZKJbUE+5mz//FXejnMl7GHe6qojb9cFNy1QTe5Oe74nmuucy0+sozimS70PbM6Zk3XygMpCF+a
	hTcGTtneZKD2QLzu9l4w1usAAq4Y6IQOZ16wxe6FldVbKaHo25Ox6cjju+EiVWKMl7FAfJv+e/z
	d5HfuxEDD32pxP1qZYbvM
X-Received: by 2002:a17:906:c114:b0:c29:52dd:317c with SMTP id
 a640c23a62f3a-c29e52ff5aamr253749566b.30.1789579759601; Wed, 16 Sep 2026
 10:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260728221007.2098560-1-dmatlack@google.com> <20260728221007.2098560-4-dmatlack@google.com>
 <e099cbaf-3185-4c39-ae36-7f0e074ebff7@linux.dev>
In-Reply-To: <e099cbaf-3185-4c39-ae36-7f0e074ebff7@linux.dev>
From: David Matlack <dmatlack@google.com>
Date: Wed, 16 Sep 2026 10:28:52 -0700
X-Gm-Features: AcwNN1X8OtlPLlB_fEFGTTxlBHL1RWBLk55_RIeZg7bMhopD1i4pmTuVWaDvZaI
Message-ID: <CALzav=eX0gVrbWCnYGwfqPHUkoVxqdr2nw3Tx6Aqze0XOcuwzA@mail.gmail.com>
Subject: Re: [PATCH v8 03/12] PCI: liveupdate: Track incoming preserved PCI devices
To: Zhu Yanjun <yanjun.zhu@linux.dev>
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
X-CRM114-CacheID: sfid-20260916_102922_147703_A50F8740 
X-CRM114-Status: GOOD (  21.55  )
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

On Tue, Sep 15, 2026 at 8:31=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
> =E5=9C=A8 2026/7/28 15:09, David Matlack =E5=86=99=E9=81=93:

> > CONFIG_64BIT is now required to enable CONFIG_PCI_LIVEUPDATE so that th=
e
> > domain and bdf can be guaranteed to fit in an unsigned long and be used
> > as the xarray key.

> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index 3781e2b5f095..8af20f558086 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -273,7 +273,7 @@ config VGA_ARB_MAX_GPUS
> >
> >   config PCI_LIVEUPDATE
> >       bool "PCI Live Update Support"
> > -     depends on PCI && LIVEUPDATE
> > +     depends on PCI && LIVEUPDATE && 64BIT
>
> One question about adding 64BIT to the dependency:
>
> As I understand it, enabling CONFIG_64BIT essentially means that we are
> building a 64-bit kernel, and a 32-bit architecture cannot normally
> enable CONFIG_64BIT.
>
> If that is the case, would depends on 64BIT be necessary here? Or is PCI
> Live Update already inherently restricted to 64-bit architectures by the
> existing LIVEUPDATE/architecture configuration, so that this dependency
> would be redundant?
>
> If this problem has already discussed, I am very sorry about this.

The necessity is that the PCI core needs to store more than 32-bits in
the unsigned long xarray key (see the snippet above). The dependency
on CONFIG_64BIT ensures that unsigned long is big enough. We could
probably remove the dependency but I would rather wait until someone
with a 32-bit build has a real use-case for using PCI_LIVEUPDATE
before putting any effort into it.

