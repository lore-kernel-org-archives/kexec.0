Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825DDC44520
	for <kexec@archiver.kernel.org>; Mon, 20 Jul 2026 22:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gj82UvWIC9kB06K4+/XSzH6MrQ6ehsQ00zZOFqHM1MQ=; b=I6D4xuS2kLHZ+ct3OyfvQLBEN0
	SK5q3292dIphtNvwwdnO4Y7E/61wbCcmS7CczlhnU0V7kKwcnCoHmc6l8+zuNzww/4A7yvFHmVqCW
	BogcFnOuYDbTDOX1/jrmjoOM7u0V1jTTzvPKKeqlAj0ZW7Z8VmpKuJeWmtfcjMstsxFKawSgIwKrG
	w+Y6jzzsUV5SaGe4uDnEyIQOZCTMfVaGmhYW/BAwFr4bwmHq7VpjmLqL6S4sDZ9X1sga3uEk2Fnp0
	Xrg4rcMLbF+okNG7XMpqYoBFLaQ2O84hlAPA+Mj5Ex7YGE09ddcqY+icDvYFzmP7fIwTaq3B4rezx
	BiDHBuAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlw2g-00000007zZT-25Pu;
	Mon, 20 Jul 2026 22:00:54 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlw2c-00000007zYs-284e
	for kexec@lists.infradead.org;
	Mon, 20 Jul 2026 22:00:52 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso8295002a91.1
        for <kexec@lists.infradead.org>; Mon, 20 Jul 2026 15:00:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784584849; cv=none;
        d=google.com; s=arc-20260327;
        b=Iv0411IBoQ9/37XaupZSCFOv6uDK/cv2Ubr5NbMb+j931bk0VqxzQK5dx2tfPd0N2L
         15IQ+ANjpuC2ykig/Nl/tukaDaX+kJUp/yMFzHwp4UnnEvJlfj1a1urMRIR0BwUgWn1d
         mLUQgzHkYP3X6yREZi/dRBdVuYON4tbJuVrJ43JM76szSRRLUoyxW5tjwF1nyUmQCIoW
         lWTlHkU6MmhwMLRRvSPt7iLS9UM1EvXrYh7FrI3WA27oyd0u7hW38ciWe9ICKJXTjrie
         PZO7ixUWapfuau53GM44cSZAMXFJ0ew21XWo8zWSMC41JMeFzmejL8msLsxTt5BefIXY
         OgkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gj82UvWIC9kB06K4+/XSzH6MrQ6ehsQ00zZOFqHM1MQ=;
        fh=QB3M2dJjDl6AcEKrqFZWRg9plhwoMIP5UfQvadI9R0o=;
        b=MRQVvoeCqglGCq1VWjuTWjhGueW80q3Nz3TpLSl/8v1Ae3ukFIoL+Wfl3KPBbCmfw6
         Ke2TG4rYlbhlyB0o1+eK7IxUrEkNDOLHt2bbyEJ9xwr5lxt3No8QqO5IuvMs3nKeArTG
         7nr9TP9hEWWfW+iNoEA/aWUJ2Hb543bdExeEhoywV06h0r3AKxRiIqutPRqArAl4Re+A
         Ox5TUVY1ypFVL8RslTh8ZpBXKhO6tiUKnyK8mC2qaqiPDaYQpBf2IeDGwfXSNdI/pZct
         RNAxR8wtSP8pDZVYvg78EwO0HOoBumsZ7NvPchp59C6ur6xcDfLrSLH1zXwCzn/vnpDW
         9pVg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784584849; x=1785189649; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gj82UvWIC9kB06K4+/XSzH6MrQ6ehsQ00zZOFqHM1MQ=;
        b=vosDFmD9usN302k+dwGiKrEa5UKuhjzlIIdQhLt8fKgBuJm7RyLFQ/q429aXJHOFg8
         edzQKsBqppUxsmbMj97JkEgbLLtNnn2XVyMeBONnvzvfp6a1zkJ6jQercVk4p0rp2DjS
         M3AQzNbFCBp2d/K9Ja4H+sE+ANGGWGadjOWnthwbWlWPdzeOituDqVq8ZVcFGOfHFbze
         PdKo9m5U9Ji3uYyS+GPyK+0ZY/oHTDkB7ij2jGd02wRXuZ7RX9AeIblSFGg2BDaU69Ha
         n01KOwYC5EwRfauwlIWhStrnDwfVTk30l+hRVKFfDx9Rb3k/idetWoflzsFd8CC+Ou4D
         9CZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784584849; x=1785189649;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gj82UvWIC9kB06K4+/XSzH6MrQ6ehsQ00zZOFqHM1MQ=;
        b=Y8Ky6PMsRsHzAOVMB8Z4cmK7z+Jwt4nPXobDegOjl00uHa4e+Mlj3Ov1crW81eXyCh
         JqsdQ62E3SunsH+0ZR+CWajAdgxasKr2flk9XBYRL9kydrZ5XwwQ/466pvpL0aKhyBdA
         Um1ePW5fl8I351EYQgUj1gvPxhJoo7MQRpvOxiBwQBQwsQN2xg4TIrEJsjHoMsUysurV
         tM50zmVKvX8tNA6eEXPhxpU5NFFdM5RJO8hncqPIGRDxBuO2Ta68mM8jHAruJxIlcHYv
         6H8EU8wpTmowd1RPIaBB+921h09tl6gbbmUCQWLC/BY0pwNDvKnU32F9jkj27OWt71Jt
         2RVQ==
X-Gm-Message-State: AOJu0YzRsGRNLML2YhETWqGEVCyweJ274lNpyWhJ/WLNDNh6lU2pq58B
	4bQnxErhI51YFOXbxOQZtw5uYJprv9OvjleMK++4AW1slVOxcnicrgLyOvQ6mKNkCyM34R3JO5P
	XDVBNzeCoaRM5QnnaPoQzCTzYF0ibOf7HpD4Bqr9I
X-Gm-Gg: AR+sD11796WlD7J6clb8AUmJvgEa6uDVvo2rnRzVOPnVQFBeLrLE2QBRwBYKvm8MDOB
	jueOze9awyaqB7Na48s9FP0OgoiRKbGObI2s87QLEKSqj/onG1VlS5XY/+6nPCCaM7RlWF90dbQ
	bsDSczymfCK9J7rkbhjUz2fWU5/fbZR3eO3KLyDkDNOjNiD/2+ci9Pq02uuj7HQDWxGroufsnog
	WOgsA1ObpHN4SgUcoC5G9ZHSjrPeqfco9DzZmRDg+zaGE3NLceAPiINFwlO8A==
X-Received: by 2002:a17:90b:1dca:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-38e4b454d1cmr17323817a91.10.1784584848356; Mon, 20 Jul 2026
 15:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com> <20260710212616.1351130-4-dmatlack@google.com>
 <20260717163820.6bc8c13b@shazbot.org>
In-Reply-To: <20260717163820.6bc8c13b@shazbot.org>
From: David Matlack <dmatlack@google.com>
Date: Mon, 20 Jul 2026 15:00:21 -0700
X-Gm-Features: AUfX_mzNR0w-MD4Mb6dfdU632NpNdotxFCmghB3mJDm5NOOEi_E54XencSYW9rk
Message-ID: <CALzav=eQ-0rbxh6Eekbt4zUoNGNZc_THmSCvVWVwE3om1BPtdw@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20260720_150050_577692_941F07CF 
X-CRM114-Status: GOOD (  27.61  )
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

On Fri, Jul 17, 2026 at 3:38=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> On Fri, 10 Jul 2026 21:26:06 +0000
> David Matlack <dmatlack@google.com> wrote:
>
> > @@ -298,6 +377,87 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev=
)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
> >
> > +static struct pci_flb_incoming *pci_liveupdate_flb_get_incoming(void)
> > +{
> > +     struct pci_flb_incoming *incoming =3D NULL;
> > +     int ret;
> > +
> > +     ret =3D liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **=
)&incoming);
> > +
> > +     /* Live Update is not enabled. */
> > +     if (ret =3D=3D -EOPNOTSUPP)
> > +             return NULL;
> > +
> > +     /* Live Update is enabled, but there is no incoming FLB data. */
> > +     if (ret =3D=3D -ENODATA)
> > +             return NULL;
> > +
> > +     /*
> > +      * Live Update is enabled and there is incoming FLB data, but non=
e of it
> > +      * matches pci_liveupdate_flb.compatible.
> > +      *
> > +      * This could mean that no PCI FLB data was passed by the previou=
s
> > +      * kernel, but it could also mean the previous kernel used a diff=
erent
> > +      * compatibility string (i.e. a different ABI).
> > +      */
> > +     if (ret =3D=3D -ENOENT) {
> > +             pr_info_once("No incoming FLB matched %s\n", pci_liveupda=
te_flb.compatible);
> > +             return NULL;
> > +     }
> > +
> > +     /*
> > +      * There is incoming FLB data that matches pci_liveupdate_flb.com=
patible
> > +      * but it cannot be retrieved.
> > +      */
> > +     if (ret)
> > +             panic("Failed to retrieve incoming FLB data (%d)\n", ret)=
;
> > +
> > +     return incoming;
> > +}
>
> I'm having trouble following the error escalation here.  What's
> fundamentally the difference between FLB data being provided and not
> compatible (subtle log message) versus FLB data being provided and
> compatible but we cannot access it (panic!)?

There is no fundamental difference IMO and I think we should handle
them the same way (panic). The problem is the PCI core cannot actually
distinguish between "PCI FLB provided and not compatible" (should
panic) and "no PCI FLB provided" (should log). I would like to propose
changes to LUO so that the FLB handlers can detect the former
situation but that requires some non-trivial work that I didn't want
to block on.

For now, I guess you could say it is up to the user to not perform
Live Update between incompatible versions. I can update the
documentation.

>
> Don't both suggest devices are running but we can't get their FLB data
> to continue letting them run?
>
> The errno interpretation is also slightly different than the comment
> above liveupdate_flb_get_incoming():
>
>  * Return: 0 on success, or a negative errno on failure. -ENODATA means n=
o
>  * incoming FLB data, -ENOENT means specific flb not found in the incomin=
g
>  * data, -ENODEV if the FLB's module is unloading, and -EOPNOTSUPP when
>  * live update is disabled or not configured.

I think the only disagreement is the lack of specific -ENODEV
handling. Is that what you are referring to?

>
> Thanks,
> Alex

