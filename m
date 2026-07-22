Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A989C531BC
	for <kexec@archiver.kernel.org>; Wed, 22 Jul 2026 16:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IcI5qs7jN/uu8ChWZU0RS5LTqt9hibuExW779DaX+1k=; b=JTgE0HEo+zGzjhgqV7b+XFmNW/
	vOsA9NvtAWG4DkC2gO7XsYQjroKvnixqKdvP2Fy1S+d2aiHZeo/qxCqb5HgWnVSCxyfnwP00/jFvZ
	k4H2M3+hb4DfPW7f/vJgYylZBtrWlCfDZraw+M710doF5CdqCtVCUM9GHw5Z6lfk+f5fJTz+pLw49
	hov74Dxq2WzAOEpCAhlo1t+kKTKVroSm/Z5uFkO5cfhM+PtPcSVSmpc0xZFL4HTIq3FCj6GI9qC28
	jxZzttaHYsschQCuYqQq1BN8tj0mARysbMbxQV7vyZzrijZYkwm+8onrHcUymnU574GpWq8vsUAjz
	XVRdRSlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmZXO-0000000CIAb-1yIV;
	Wed, 22 Jul 2026 16:11:14 +0000
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmZXL-0000000CI8k-397N
	for kexec@lists.infradead.org;
	Wed, 22 Jul 2026 16:11:13 +0000
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5b14d1f9315so11384502e87.2
        for <kexec@lists.infradead.org>; Wed, 22 Jul 2026 09:11:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784736669; cv=none;
        d=google.com; s=arc-20260327;
        b=r4KgmZmHMAOepE9SKiomqWfFmWUGFGUc/w072b+s8ycUe5FO9vKmiYslLLHpMKgk/a
         h5zGd0B8jFZlacNaH7tjVI+ALpVGYhsNjxVhae47bLhUrzSAmYtNfSY3GS30gLI2WrmQ
         oFU+HjmUSgXnr2FlVQ79Q0JPlMxJrTf5cmYDkukTjrpSlag8FlrDOWP0DT8dypWBhyWv
         vyne2D5uEsLw0HTsXdLMwowRSe3yMoTgDjznldpT9gTfMBMMsxPYMnYzTETON9+7nLjv
         PpvjEDWuOrQ8Aed2YiCEixpS2rohpnNAS7sCsZKFGT23qBJKeLowc8M+15tNZ/vyawCX
         0Ajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IcI5qs7jN/uu8ChWZU0RS5LTqt9hibuExW779DaX+1k=;
        fh=QB3M2dJjDl6AcEKrqFZWRg9plhwoMIP5UfQvadI9R0o=;
        b=XamTQ7rjAjzzNd6gr6qtwf5lXnqfhvWXTll+LXr5253zIsPEhtXj84Y5sE0Ms3+580
         OM/3EmAwUMHp3xp0xwESB5ElzW/xL0bTYL8/8+9iAhkowFAjMBohY2xh4dGja72rJ0N+
         3jB+a3Av9icFfiqzhk4vl3TYRBBFjlGKR1Y3WFcKDhkyY8jtGwGeh/HrAK1nJ5PUEUML
         ve/v5xwL0huqRliXPK23Isl31EgrdJRwzFFV24NMXM3qNdoZpJtzOurRRemlLLp1AAs1
         2/xxiWgB7p3mAbA8PyKshr6Q1+eE/LTQRchxiZGbrAcbopohNQQQfs8lSglp5HHVSdaB
         d3pQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784736669; x=1785341469; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IcI5qs7jN/uu8ChWZU0RS5LTqt9hibuExW779DaX+1k=;
        b=FilVyfMm1js10wtClmCKJ06oakJDJXrMQplEVEI9qPOo5JG3VYXwpjvl9lg89uIN/V
         MMm1yjdqpUHhnXzp7p1xiDXFufG/2uefG40OTjkzx6Qpi43FLy7dpGW4oKKQuhyxqYkp
         af8XEddYRjUfG5JeQtoEwoOHHdHiRpUHdD7AZ34trc3VLHyDHY6IcD0CwUJs2CG0wymB
         +5VGeNeHus6dmrjAuhcWIm0DSTdNtY9qTDg4SacwHS+rM5ZSmeiQfn2nepDwGIdbsqn+
         yTMYHJLMrkwZpXPJMNE2utBzpj7wh71FUdrBELzE1XiPZwhyk2+tul6LUnGtY+6Dt5WH
         OOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784736669; x=1785341469;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IcI5qs7jN/uu8ChWZU0RS5LTqt9hibuExW779DaX+1k=;
        b=DAFoA1Vp75bve1xiMTMF+X8hUinnwSCMM5IoTwE19cFb7slSwb7qrPeM9W+81FxAI1
         JwNnlariI5hrfNxZNOofW7NE9Ma+m6rQKMqre64g/RFCjn7xmdtOWZNVRjEoDoBoaWTV
         Qj1vePhurf/DokGyoqgUZNVsk5XMIxk1XMoMc+7MkfKuNRWK4e2npaQkxnKZ64pePy1e
         6dCsbFjVptwSndhFkNl1QUuIcYKsLR+E3fGZhMJHGKfRJ//EjdCFvgp7dIOXu8pTJAN0
         3ZaYpJeCRiAdyraeRrMXhlbxpYRQGlyqzsJ6WdQYCggITFqF/cc7sz58TYbKGE94/cSx
         dpZw==
X-Gm-Message-State: AOJu0YxI030eMp4PnnKXQgyuGni6ENx35U+UkPLj/PcH4BykwtFzJ9lJ
	LDm2uzzCl5NAASwNaKQjP4KIwsUJZtBZp/6FKq0ILjPHJ9cn03Zj3qCfNJvyvy/iBWTy8LM4cmn
	/FHSjjVLVDUcYjp7b2jrcVLm3QaJ9r5akflRC0xAg
X-Gm-Gg: AR+sD12WrhrpjAvPJ+Df28oS0VBu6R9IKaCxN8emdoxxw1g5/0C48k16VQShs69gdCD
	BRtxafXDUfP9aJx0HwJFA14Se+Aqggqk3mnfbIIJ0Fk0ZXLPMBnLILRb8QQvzLxw5SRa7hB1njl
	NEPv7gz4diO0A6bfmqCqFrBrxZGuTS32i3NkcLVH+jQF/KmeTjjKEVAhJtJAt7DAxPXJThQ7knD
	RMZUqONV2vHqiHTmVgaBofUh32lSw2kdBLwnmu8Ydy2uHINK7S3KPhtxVTgK1NH53fw7my7echW
	1zAS5rJy+UNCVdkj
X-Received: by 2002:a05:6512:124f:b0:5b0:1ace:3bca with SMTP id
 2adb3069b0e04-5b28fac59dcmr5709185e87.65.1784736669024; Wed, 22 Jul 2026
 09:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com> <20260710212616.1351130-4-dmatlack@google.com>
 <20260717163820.6bc8c13b@shazbot.org> <CALzav=eQ-0rbxh6Eekbt4zUoNGNZc_THmSCvVWVwE3om1BPtdw@mail.gmail.com>
In-Reply-To: <CALzav=eQ-0rbxh6Eekbt4zUoNGNZc_THmSCvVWVwE3om1BPtdw@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 22 Jul 2026 09:10:35 -0700
X-Gm-Features: AUfX_myAcr2geqnXYh1xnj0XUmNEe2bz-zIOTwyIeRO5MtevXktrjd32lAucA7Y
Message-ID: <CALzav=ej05tZbVJUqZC4BOSCtZ=EkQ8GsckqLN61qKbyMHWfKg@mail.gmail.com>
Subject: Re: [PATCH v7 03/12] PCI: liveupdate: Track incoming preserved PCI devices
To: Alex Williamson <alex@shazbot.org>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
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
X-CRM114-CacheID: sfid-20260722_091111_999743_56B53428 
X-CRM114-Status: GOOD (  36.16  )
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

On Mon, Jul 20, 2026 at 3:00=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Fri, Jul 17, 2026 at 3:38=E2=80=AFPM Alex Williamson <alex@shazbot.org=
> wrote:
> >
> > On Fri, 10 Jul 2026 21:26:06 +0000
> > David Matlack <dmatlack@google.com> wrote:
> >
> > > @@ -298,6 +377,87 @@ void pci_liveupdate_unpreserve(struct pci_dev *d=
ev)
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
> > >
> > > +static struct pci_flb_incoming *pci_liveupdate_flb_get_incoming(void=
)
> > > +{
> > > +     struct pci_flb_incoming *incoming =3D NULL;
> > > +     int ret;
> > > +
> > > +     ret =3D liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void =
**)&incoming);
> > > +
> > > +     /* Live Update is not enabled. */
> > > +     if (ret =3D=3D -EOPNOTSUPP)
> > > +             return NULL;
> > > +
> > > +     /* Live Update is enabled, but there is no incoming FLB data. *=
/
> > > +     if (ret =3D=3D -ENODATA)
> > > +             return NULL;
> > > +
> > > +     /*
> > > +      * Live Update is enabled and there is incoming FLB data, but n=
one of it
> > > +      * matches pci_liveupdate_flb.compatible.
> > > +      *
> > > +      * This could mean that no PCI FLB data was passed by the previ=
ous
> > > +      * kernel, but it could also mean the previous kernel used a di=
fferent
> > > +      * compatibility string (i.e. a different ABI).
> > > +      */
> > > +     if (ret =3D=3D -ENOENT) {
> > > +             pr_info_once("No incoming FLB matched %s\n", pci_liveup=
date_flb.compatible);
> > > +             return NULL;
> > > +     }
> > > +
> > > +     /*
> > > +      * There is incoming FLB data that matches pci_liveupdate_flb.c=
ompatible
> > > +      * but it cannot be retrieved.
> > > +      */
> > > +     if (ret)
> > > +             panic("Failed to retrieve incoming FLB data (%d)\n", re=
t);
> > > +
> > > +     return incoming;
> > > +}
> >
> > I'm having trouble following the error escalation here.  What's
> > fundamentally the difference between FLB data being provided and not
> > compatible (subtle log message) versus FLB data being provided and
> > compatible but we cannot access it (panic!)?
>
> There is no fundamental difference IMO and I think we should handle
> them the same way (panic). The problem is the PCI core cannot actually
> distinguish between "PCI FLB provided and not compatible" (should
> panic) and "no PCI FLB provided" (should log). I would like to propose
> changes to LUO so that the FLB handlers can detect the former
> situation but that requires some non-trivial work that I didn't want
> to block on.
>
> For now, I guess you could say it is up to the user to not perform
> Live Update between incompatible versions. I can update the
> documentation.

An alternative approach would be to make the PCI compatibility string
just "pci" and then put the version number as the first field in
struct pci_ser. That would ensure the PCI core can always fetch its
FLB data and panic on a version mismatch. I think first-class handling
in LUO would be better, but that is a larger problem to solve; it also
needs to be solved for file handlers.

Pasha and Sami, what do you think?

> >
> > Don't both suggest devices are running but we can't get their FLB data
> > to continue letting them run?
> >
> > The errno interpretation is also slightly different than the comment
> > above liveupdate_flb_get_incoming():
> >
> >  * Return: 0 on success, or a negative errno on failure. -ENODATA means=
 no
> >  * incoming FLB data, -ENOENT means specific flb not found in the incom=
ing
> >  * data, -ENODEV if the FLB's module is unloading, and -EOPNOTSUPP when
> >  * live update is disabled or not configured.
>
> I think the only disagreement is the lack of specific -ENODEV
> handling. Is that what you are referring to?
>
> >
> > Thanks,
> > Alex

