Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65DBFD45FA
	for <kexec@archiver.kernel.org>; Wed, 25 Feb 2026 22:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MsOXiL/6Qn9m7Yd1SU2mFbssuofZOBkFUGv1WIDmPB0=; b=fLvpe+tle2Y29KKx6bypQJsS/F
	9DKf+1cb+GRf+QZ+MYo07aMnrfRmzdF3nqChLyrBb44GB8/rMguCr/r9Dv5kG2puAQKoqQIOkf9yJ
	W+2wrGGgGLrIEOy9DQt6vq70NQ8MHW2sfO7PH2QO8RmDgYVWkDsYQ8Q95eCWt/+XKrE8iumRRurIm
	Y4MqoytwZp/Ag1dQGVE8jn1fXGm31718c77lnQKKjYcvuRAmsx4pdVyTymtrwz/iPpKnQK39nTLNf
	OsfG7hfSHw+xVGHDqb3DVkt6Kquaqwh1XujgII2Y8vwHAHztiMBzqAEBaAQmXcmErteimp45+i/+U
	JBsY2Mvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvNii-000000051iS-3dMO;
	Wed, 25 Feb 2026 22:51:04 +0000
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvNif-000000051hn-3052
	for kexec@lists.infradead.org;
	Wed, 25 Feb 2026 22:51:03 +0000
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-505d3baf1a7so93161cf.1
        for <kexec@lists.infradead.org>; Wed, 25 Feb 2026 14:51:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772059859; cv=none;
        d=google.com; s=arc-20240605;
        b=Cc+wTN3bkFKiuhO0l7zTRut/PH+1f/N064Is2JPgJHrzPVHFK8fgyIsYTSe3OpPoVJ
         9P4RLU3M5EGXVEfXR7dufmBPosFYNxWYLmaalJbJeLYY74h0S/ceMJ/psE+RbRKjQT7H
         md46/2lA/DetjaG7voK8dozl2IwpYTWNa8Nrp+aSmc8nr81tUQvLs23UFGB04kZ90QKl
         UuV2eFYM8eDTdP11Dz3BHntwZsG6Clf24QroWN2HjqYGaNROkHBKd0NGtGl2OkU096wN
         NgVBlpcTSD2q0jKC0Vv6HLScteuTH4aOBw2rcXlNbdn52u1ZlcPAWxq4hnwSw15vOQ2h
         ESeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MsOXiL/6Qn9m7Yd1SU2mFbssuofZOBkFUGv1WIDmPB0=;
        fh=D17zPfDf/xRitT1yj+ehMOs5k9mASvUHKj5OqNS5QXU=;
        b=I1yG7CWHlR5Pd4TwN8MLyujXhP5u1QD2IWRYajbt8KF0x7VjkP54PMWkbohyI6kpaM
         c2Zw2LIiNexYN1JWBZVz5QLmTRgiLF0isM468G92PhMoh8jAjEjeZ+jdPXKYeFswMAwf
         aAl698rXMCAen9tAp4dCYigZUZyc3T8D3XK5S7uuEJI1h26OIgveMfxbTnZ7BTNfP22+
         4OmttFfGWJfZAqDQaftycgiidDBVjRMyUJgbTpT9K6JXqK/JXY7z+RwK58zfB9/4XASP
         IzNZwmZRcg6U+Mh8ilGUU9wlyrtpMX8rd7EeC2rwCVuAPq+exLzsf/tpHiN2FVqH1HZ3
         XkiA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772059859; x=1772664659; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsOXiL/6Qn9m7Yd1SU2mFbssuofZOBkFUGv1WIDmPB0=;
        b=sblvr+Oj6FTZBTUN+XvbaFjKuZjJad5CjJfjltHXlk3G2Z/KpxV59ypQAqrcRDQeMA
         AOY3Jrc+afhwPNIA8Dm3cSgdt1zAwq6rnJQCY3KLfNBYz9XK4b5qOZyGY6U0WoApYza7
         RShoJd1hHMH4BcmmjsjSpxrk9QCOmjq/vN0J77FjfrFdQjCWTbRC6lk/mtgoMONb9MTf
         t/jqf03LT0uhJuZG0/GSVfENZOq5q+6nrJfsWl8YeNKs/5ksEYnPvvvFMPTiAAkgVcTn
         izxnNjmzwzNaW/tg54SQqqyEvaOI8n0JyKE5r1hPvEPXvQxaZMRfZGo+ysWZfFD5eKWf
         CPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772059859; x=1772664659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MsOXiL/6Qn9m7Yd1SU2mFbssuofZOBkFUGv1WIDmPB0=;
        b=oOu6W5ZEMmHyaeylYXPmpGItUAgQnK7Y64pgK+NVVH6LH/AGGipkdj9ZKhDBWzXNoT
         D1vQo61EmqpCdVJCIYLtz7Pj7UHEwCNKkGldATtaGfLks2U11AB7QGu9n7v/mbb3JnAj
         +TasOsB6uNPeOKl6jRoDL3vchiUHMIIzfK3E7+K1oVU+To3Ydc2+Xv6gA14F0rUjHng6
         9rGI+PJIYiyxxaivq93ITIfEl8h9cgoTWg87LiXdfKrHdn7bORijB/5i3HZ/Q/XSVsLC
         QFA4GwnqHfHhfI25wG9bJ3PgamwhiKDHyaONEwQ1gdS7cJsvq0liwkij1l+6q6YB79dB
         NSeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiFFMA6YTDfV9aiRSpDk0E64pqU7mY/FUa+v6hvZPmz96/My4VajZhnA3mVh13nm2K/xp5tA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwTwoylWIRp/Bdnaem4GV2KKmRBG+5yW+Cf11MCiN5iKv1L8G9j
	4FV+4Zr4VF2Y31z/D9O1GOeITSv5PfJvd+Er/LNCJTbIlN8GbYL7dnsiUDCHN8gzexBFTxKKIEq
	lXKL1GgemGtGmsxlok91cqTeIAZE623tdqRYj5XfM
X-Gm-Gg: ATEYQzwa/oNNcqFkgVVG6v+ZthEbw5/WGUrBzvTNhvHm/e2tXSeKiripxwjy6UuQdoW
	XDjAkT1eTKCEF32Ls+VhyGC2Uya9Stz4IyKt8nWMb2mTmJSGP1h3d6BDui+zpIc6355GxSph58J
	FpHhPEnUX8mAbkEtP8/6vGeljgCVPOCaIiXsjX+chBvYno/CiOGTa6CCx05cS3g7FX0tGX7Yjbr
	pvkJbmgM8yestGDIDv7Xz4ciuf9oykql/PQAjW4mtEoc0V/U6SNFPRuaSXp++ChYF95Seu5wv3/
	lGodhbbw2mRqj1UZSRzJo5IajLwVhxfpCwuDmIMi4KZ8kSL72N7L
X-Received: by 2002:a05:622a:10c:b0:4f3:5475:6b10 with SMTP id
 d75a77b69052e-507441cb73fmr3920551cf.8.1772059858971; Wed, 25 Feb 2026
 14:50:58 -0800 (PST)
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-5-dmatlack@google.com>
 <20260225143328.35be89f6@shazbot.org> <aZ9yWlcqs2b6FLxy@google.com> <aZ931bYILhhkhW-Y@google.com>
In-Reply-To: <aZ931bYILhhkhW-Y@google.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 25 Feb 2026 14:50:47 -0800
X-Gm-Features: AaiRm51aoTymXymwCHLQ9gcq3ldQPi6BvUrjqTLQO_zSuAjigNCnBqzqKSIxD-4
Message-ID: <CAAywjhShWTQbkwhDYB=9a_PZjGHnJ-=HTLAzDBvnDsmtvP=Auw@mail.gmail.com>
Subject: Re: [PATCH v2 04/22] vfio/pci: Register a file handler with Live
 Update Orchestrator
To: Pranjal Shrivastava <praan@google.com>
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_145101_769406_74622FF7 
X-CRM114-Status: GOOD (  35.26  )
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

On Wed, Feb 25, 2026 at 2:29=E2=80=AFPM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> On Wed, Feb 25, 2026 at 10:06:18PM +0000, Pranjal Shrivastava wrote:
> > On Wed, Feb 25, 2026 at 02:33:28PM -0700, Alex Williamson wrote:
> > > On Thu, 29 Jan 2026 21:24:51 +0000
> > > David Matlack <dmatlack@google.com> wrote:
> > > > diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pc=
i.c
> > > > index 0c771064c0b8..19e88322af2c 100644
> > > > --- a/drivers/vfio/pci/vfio_pci.c
> > > > +++ b/drivers/vfio/pci/vfio_pci.c
> > > > @@ -258,6 +258,10 @@ static int __init vfio_pci_init(void)
> > > >   int ret;
> > > >   bool is_disable_vga =3D true;
> > > >
> > > > + ret =3D vfio_pci_liveupdate_init();
> > > > + if (ret)
> > > > +         return ret;
> > > > +
> > > >  #ifdef CONFIG_VFIO_PCI_VGA
> > > >   is_disable_vga =3D disable_vga;
> > > >  #endif
> > > > @@ -266,8 +270,10 @@ static int __init vfio_pci_init(void)
> > > >
> > > >   /* Register and scan for devices */
> > > >   ret =3D pci_register_driver(&vfio_pci_driver);
> > > > - if (ret)
> > > > + if (ret) {
> > > > +         vfio_pci_liveupdate_cleanup();
> > > >           return ret;
> > > > + }
> > > >
> > > >   vfio_pci_fill_ids();
> > > >
> > > > @@ -281,6 +287,7 @@ module_init(vfio_pci_init);
> > > >  static void __exit vfio_pci_cleanup(void)
> > > >  {
> > > >   pci_unregister_driver(&vfio_pci_driver);
> > > > + vfio_pci_liveupdate_cleanup();
> > > >  }
> > > >  module_exit(vfio_pci_cleanup);
> > > >
> > > > diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/=
pci/vfio_pci_liveupdate.c
> > > > new file mode 100644
> > > > index 000000000000..b84e63c0357b
> > > > --- /dev/null
> > > > +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
> > > > @@ -0,0 +1,69 @@
> > > ...
> > > > +static const struct liveupdate_file_ops vfio_pci_liveupdate_file_o=
ps =3D {
> > > > + .can_preserve =3D vfio_pci_liveupdate_can_preserve,
> > > > + .preserve =3D vfio_pci_liveupdate_preserve,
> > > > + .unpreserve =3D vfio_pci_liveupdate_unpreserve,
> > > > + .retrieve =3D vfio_pci_liveupdate_retrieve,
> > > > + .finish =3D vfio_pci_liveupdate_finish,
> > > > + .owner =3D THIS_MODULE,
> > > > +};
> > > > +
> > > > +static struct liveupdate_file_handler vfio_pci_liveupdate_fh =3D {
> > > > + .ops =3D &vfio_pci_liveupdate_file_ops,
> > > > + .compatible =3D VFIO_PCI_LUO_FH_COMPATIBLE,
> > > > +};
> > > > +
> > > > +int __init vfio_pci_liveupdate_init(void)
> > > > +{
> > > > + if (!liveupdate_enabled())
> > > > +         return 0;
> > > > +
> > > > + return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> > > > +}
> > >
> > > liveupdate_register_file_handler() "pins" vfio-pci with a
> > > try_module_get().  Since this is done in our module_init function and
> > > unregister occurs in our module_exit function, rather than relative
> > > to any actual device binding or usage, this means vfio-pci CANNOT be
> > > unloaded.  That seems bad.  Thanks,
> >
> > Hmm... IIUC the concern here is about liveupdate policy if the user
> > wants to unload a module which was previously marked for preservation?
> >
> > AFAICT, In such a case, the user is expected to close the LUO session F=
D,
> > which "unpreserves" the FD. Finally, when rmmod is executed, the __exit
> > (vfio_pci_cleanup) calls vfio_pci_liveupdate_cleanup() which ends up
> > calling liveupdate_unregister_file_handler(), thereby dropping the ref
> > held by the liveupdate orchestrator which allows the module to be
> > unloaded.
> >
>
> Ohh wait, You're right, Alex. I just realized the __exit won't even be
> reached because of the internal pin. The current implementation creates
> a catch-22 where the module pins itself during init and can't reach the
> unregister call in exit. I believe we should drop the ref when the user
> closes the session FD? Additionally, should we move try_module_get out of
> the global liveupdate_register_file_handler() and instead take the ref
> only when a file is actually marked for preservation?

If we don't do try_module_get during registration, the registered file
handler can go away on module unload while LUO is using the handler
during FD preservation. This makes it racy. Maybe register/unregister
need to move outside the module_init/exit.
>
> Thanks,
> Praan
>
> > I think we should document this policy somewhere or have a dev_warn to
> > scream at the users when they try unloading the module without closing
> > the session FD.
> >
> > Thanks,
> > Praan
> >
> > >
> > > Alex
> > >
> > > > +
> > > > +void vfio_pci_liveupdate_cleanup(void)
> > > > +{
> > > > + if (!liveupdate_enabled())
> > > > +         return;
> > > > +
> > > > + liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
> > > > +}

