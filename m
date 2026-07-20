Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5091AC44515
	for <kexec@archiver.kernel.org>; Mon, 20 Jul 2026 23:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PYpxNurdbA4XJ/6Vuk5WIdVnSVbgksTgEkNwHBXbZV0=; b=F1PPrg4X+JA05UIXTdKSLx8iJc
	113wExOpmjNP4NC0bjON/4tXbOeovKOA23ZsLFkIuceBpFZ91qvIuScwb1SQV7tFtGaiH98hT8YR8
	21TZ2DJa9sl1YgKyFgxmeMEx499fc/aZHd7Fva2aEdeTWiiTxaGyLp+QSKFO+tK+kWiBOa6JFiyjb
	e5Sd5cdJSjrWEEkw/J+hV7Z8tlkEeq/AGLkRf1WsoEvGgc2HQADA0UJ+jgSKSNbj4m7BVran0Q/AT
	3bkseTRtkSf2u912o6sxJTlCw42ZgLmabjLJnyY9gPZZLcFayrsf2GrjYSzxeDxLXsUC3hgJzhSVe
	C6SWdi5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlxGn-000000085Me-05mj;
	Mon, 20 Jul 2026 23:19:33 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlxGi-000000085M9-2VRe
	for kexec@lists.infradead.org;
	Mon, 20 Jul 2026 23:19:32 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-38e08baf860so8257847a91.2
        for <kexec@lists.infradead.org>; Mon, 20 Jul 2026 16:19:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784589568; cv=none;
        d=google.com; s=arc-20260327;
        b=VeLaXFfnZRR2E5RgU0HlkMi56ov9cVoCr06Xts1dQCGDqB7xrn51hdECa/XKxm74iM
         VM0CsvbRAoY+cSKPTkw0arzeGplP5HqpyQ5hik4XJa9EfW1nD8woFseyjpwY9vYDB+iY
         T6yQVtIyOmKDaSrjliC/759N9WorjTjvJZsl7zItlOV8hu9h6tcOTmaeByzt9zENvrdo
         MBMDc1d+oi/lSff0PlJsOv+RU/MZJ2rtPraHOXuKoiiNhI2m/5tw0s0bXOSNTYNiBnlw
         h+8gfEBtRrRvK5En406y+/R8WtIruRLjXBkyLwE+eJRr5uv4cw6ixNpRi55yWEbpfs6/
         G3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PYpxNurdbA4XJ/6Vuk5WIdVnSVbgksTgEkNwHBXbZV0=;
        fh=NmzZBCo2v6h/OOnChjJyHO5DmoEC8vLdB+rxb6oUc0I=;
        b=VxgVaw4pn8NxVz3OvRrVnQMFg6vGPNAJajdcewhY9ac97IAxB1sLa3gchqmBrqdRbf
         2Tj3F6l2Y4BMOliRO1FwBFJl6bC+WWXdW8vPFLr+1PuDTYbgmebqxIrtywYvB5ggs9zG
         PuLC3F60IWYxDG6r+lfsuvLanZA20DsbNzw3SwG0cRR5Tje6oRer/RY+EQnJEHbTylDT
         5wOl7heZtyN2VbNjBZS7/LCpQAuNwWSZBeBa0nQ1Dko0VsH88fJNvBNZ6Rn+ROj4ob1n
         WlEL0MrgVWPhDxnnssPe6ncecCTJisE+YnwZ6RIwUXs7XvN7kumJjQx7kYz9Bbif/w8+
         JezQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784589568; x=1785194368; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PYpxNurdbA4XJ/6Vuk5WIdVnSVbgksTgEkNwHBXbZV0=;
        b=AyfObnFwGjlgAFc7x1v5UHuDpoKC+SPgPgmAkDEi+gMd5OrgRtUA+kgCQWPYjqx6p5
         oRFfaFWptSgu6/yP9MNQGh2ATC9RKKBw8ePpelcTytap0ZZGvD+64giA5uBglD3z+BdG
         cJ3msbYJYL3URjwEghFvWllujfw29heYFbHG0tCqecYzmiseLjoMKX2BGBrGPUtIgIug
         veb8DAmYfgtStVd42bzIkbriGrxpACBIPfs20P9EiTKFVzTlhW+HmGz74tl2ivmBsTYr
         fRHKfjOziGZAEqOlwuNSVlWqRHDLElrb68LJvp9UrW9RM0qsHUOY8oUCaEyL98g3ePRb
         v/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784589568; x=1785194368;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PYpxNurdbA4XJ/6Vuk5WIdVnSVbgksTgEkNwHBXbZV0=;
        b=FQe2NmiS2olI972jcKmBdz72LuBLa6aVzusOb2qtS+fcCw7nvalkgQcv5442ValDUb
         ek9zzwzOVwzHG9GqkFZIE+vUFtF3NyJFzolociE9oePusbiRMfZYcQ5nYAgroj+Fu5AY
         wHwIJa4HvKMOLjmX7w5oDygK002kADOcYyLJc7SfAIUiPD35IlcwRGKk51pysr2VVHhu
         kSnL5tUQcTQS6P8Acb+mLiROJJSNYo4yCh+52ve0GXX1WvFlS9M+euaCc+uoFQYsDyiq
         gH0eOu4sNfx/gvt1HvSnnRemyePPHezZn2LKLF00cde1o35URPtcP2xyfxW97K4xyCT4
         UVIw==
X-Gm-Message-State: AOJu0YxGbEsDyZa16y2h0pcRoKPuxFNE4jWS3GdHcjEAmgxmy7LxpysM
	56699Yslaj/m/ySu/1741+LnJfKx4gY1aOARSyz8o0mz+lfmlHBLDQbyXHHBSYDPf++fNAC/lCZ
	+zHuyAD4ry6esR0G0yIsf+r09gUjr7VBhble5mzNk
X-Gm-Gg: AR+sD12yvlCDqVZLcpyVNZQPVJFTZJm+CW9sFAaZz3ePdAhjEtsB37m1KAyUWi+ZJKx
	4xpgvXR8wZdg9wab6mE1YLtrs+pG43vvtPA4ZAH9xjxxKKiC/RxWV4FKcA0Dmuj2vihhNmjsgU5
	7LXNSbz+A3krGo/oAxx+C3TvScjkQa7pzgsO+2Pr+l5sEn0u0w6Zo/sJWgLNIwo+KMZdMdqeKEy
	CtOxVN2/o1m4A0eL7ZFm73lRNi8zkAR7Zyek3ujZrnawPQUfitX3NFFvPW7Pw==
X-Received: by 2002:a17:90b:5905:b0:381:23d5:693f with SMTP id
 98e67ed59e1d1-38e4b534bedmr15548062a91.28.1784589567330; Mon, 20 Jul 2026
 16:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com> <20260710212616.1351130-10-dmatlack@google.com>
 <178433098576.189683.2364970585754668266.b4-review@b4>
In-Reply-To: <178433098576.189683.2364970585754668266.b4-review@b4>
From: David Matlack <dmatlack@google.com>
Date: Mon, 20 Jul 2026 16:19:00 -0700
X-Gm-Features: AUfX_mzMp9DAjORlO4Z9lJDkbL8nPaOLaXiKeGO1DzMTd_1FqdXSUAFnXR38zlo
Message-ID: <CALzav=eZYfYYKAGEzk4TsGFLp1TPb2iFePNmqGsjX4jEZNJ9XA@mail.gmail.com>
Subject: Re: [PATCH v7 09/12] PCI: liveupdate: Inherit ARI Forwarding Enable
 on preserved bridges
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_161928_640861_5D1B17C9 
X-CRM114-Status: GOOD (  14.63  )
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

On Fri, Jul 17, 2026 at 4:29=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Fri, 10 Jul 2026 21:26:12 +0000, David Matlack <dmatlack@google.com> w=
rote:
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > index a95bfe5eff77..74a11e520f0d 100644
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
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
>
> unsigned int    ari_enabled:1;
>
> Sashiko asks a valid question, what protects other bits in this word
> during modication?  At a very list a comment is needed.

This was my reply to Sashiko, not sure if you saw it:

.  pci_liveupdate_configure_ari() is called from pci_configure_ari()
.  which also sets dev->ari_enabled=3D1 and is pre-existing code.
.
.  If writing to dev->ari_enabled in this path is indeed unsafe then that
.  is a pre-existing bug.

I figured that a comment wouldn't be needed for continuing an
established precedent (it's ok to write to ari_enabled during this
path).

>
> --
> Pasha Tatashin <pasha.tatashin@soleen.com>

