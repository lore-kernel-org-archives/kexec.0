Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A22E9B36F
	for <kexec@archiver.kernel.org>; Mon,  2 Mar 2026 12:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3doa6HfxdfxJ1p5CQxQkAhxxDryXGM6DiFWfZesWQ/A=; b=srfgs9LEQ8Hn2OKSNwN7iHEgYD
	dqHsDRf3yGfbJXRdZqEFe2s6rKyrnDiJGcYUs2VjHIFxgc2As68KmMuG9BXIEDe+BLeAujQvmvdjx
	iAUiYSvXhezADHyowMj5UfYVneul0cbUQMzEisT1VjR+BzuShJyp/+Ym1ldfNgh7cxs6BriSzkTSs
	XWBn4h+0gzGiccZh1udFF69kOm3qc0hIBrt/1NlJH1W+zwK1bVK/0s318lbcdn+JPTtEs1h+hhefA
	C6EP21w6DIXGhxaBisamJVWAdIWwvc8rg7X4oNNwdCvK0JTXhf73gtBjJxyyVij33yOBYNWY27OlS
	xtMC7Mnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx2Tl-0000000Czg6-3V7f;
	Mon, 02 Mar 2026 12:34:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx2Ti-0000000CzfW-3WR3
	for kexec@lists.infradead.org;
	Mon, 02 Mar 2026 12:34:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772454864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3doa6HfxdfxJ1p5CQxQkAhxxDryXGM6DiFWfZesWQ/A=;
	b=ABMSQRTksCmKVK6dZ9Mc0reiQq/D/tTWkMwtMWktqLXgJnnU/zlu34Pr3hSKc4EBow726E
	QVLN9yQzsgKfqJUD/IeBZM7Nx4QZJuPXlPUAGppBVoPuf6Uj/VTTT3VZE5VCUB6qRByE1e
	IUcrigBO0PiEIkEL9m5p0OUQd4bKU0c=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-aOd6bPaHMwanbv4wftbSjg-1; Mon, 02 Mar 2026 07:34:23 -0500
X-MC-Unique: aOd6bPaHMwanbv4wftbSjg-1
X-Mimecast-MFC-AGG-ID: aOd6bPaHMwanbv4wftbSjg_1772454862
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5032e68560dso446067781cf.3
        for <kexec@lists.infradead.org>; Mon, 02 Mar 2026 04:34:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772454862; x=1773059662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3doa6HfxdfxJ1p5CQxQkAhxxDryXGM6DiFWfZesWQ/A=;
        b=jvaVHfiInet4f5LZfv85qILcGNKL28MnTkdKeKXAGTlsdFHJ+1n+4DDNNHUhyVh/ze
         wG+Brz1bANtKFvEF7sk2uEOHn2CPCaC5rDUUe06yQvVcRWwghChNn7Lvlmpn1KnWGMgx
         N/vwAF1pe4uZQWWOi1n5tZwe83uzwGOJQZugeiYUAQ6FPqAWcM+FBpRw8jYoeatJZy8D
         Srz80qB34h5xfMCDkOMzYpGl8Qu5DJ0Ojx7sTvLLlCNYaX7gP/yhfUVM4fXhkCjZ4yoC
         gZiTrIG/WjNNaubQaWw6ovurjL20eDmIXFce1XPIRCM9zdn+VKZjX/31s5qiSyPpa9g2
         FG+w==
X-Forwarded-Encrypted: i=1; AJvYcCXLG6mt9zp4Ga75tjeFsckWf8VAb2gv/xXrH/VxY12jkCw+BjrGMDfUdCm5Sm3LiRVNyGyBcg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzOXMrnpcTQE/7Sz9RkBNwCp4MZnLzLAcaLQqe2sYrlMN8jvVpn
	3ntdsk8aa6JhBBquV+n9575B28oo2roSgYj5messugR3Qq+Pg7fzX3giB+Zs7EhIw/uZrDQa/js
	I6kxoLPdQfN6EhGLlbt4SvbFAWdaRB9Xqx80/aRIapN0a5IjVVRLaaFmiNKmqQtp0M6ZNcvC7cs
	9WtwpEiHXDINj78mDAolaEHwFlysH8/uyhxHEN
X-Gm-Gg: ATEYQzxHbO8O+Um3GBtF19DBdr8cvrygxOjOVjA7u9KqvTWP+nFv77/p6bzn5Bpa5nN
	IuCNA2jaxkk8vf6PsXX1uXoS4ycVcgBpN467hwHPmB9kGz2tO2o13oKk+MSBUY0B4b51p85CHYr
	yThGDB28HTLqsIADrFgN9MW23gUBZ91Ic2n6pnP4GqLnQLs5S9+VO+A9PvQHU7Uv0rZlgTIV/N2
	VGahB0=
X-Received: by 2002:ac8:7f49:0:b0:502:a1c6:4ee with SMTP id d75a77b69052e-50752714b06mr153678681cf.1.1772454862510;
        Mon, 02 Mar 2026 04:34:22 -0800 (PST)
X-Received: by 2002:ac8:7f49:0:b0:502:a1c6:4ee with SMTP id
 d75a77b69052e-50752714b06mr153678311cf.1.1772454862031; Mon, 02 Mar 2026
 04:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20260228130946.50919-2-ltao@redhat.com> <31690b028081ba72ca9babf2d09417376e10f2f1@intel.com>
In-Reply-To: <31690b028081ba72ca9babf2d09417376e10f2f1@intel.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 3 Mar 2026 01:33:44 +1300
X-Gm-Features: AaiRm52a0YHO0oHtZTipmB5LVpX2kFAg8VVxT3gl0IBhaHYmqB6zATtNCm8_Zxk
Message-ID: <CAO7dBbV2AtmXRCQkNgYvaAVW8S_jWoQgqC6c1k83H-aug_tNeA@mail.gmail.com>
Subject: Re: [PATCH] i915: Fix NULL pointer dereference in intel_dmc_update_dc6_allowed_count()
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com, 
	tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch, imre.deak@intel.com, 
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R-aGtkUxq3AuLA86M97Ussh0wGw-n2y2eXxVUl0j7tw_1772454862
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_043426_953548_B6ADF468 
X-CRM114-Status: GOOD (  25.28  )
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

On Mon, Mar 2, 2026 at 10:14=E2=80=AFPM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Sun, 01 Mar 2026, Tao Liu <ltao@redhat.com> wrote:
> > There is a NULL pointer dereference issue noticed in i915 when 2nd kern=
el
> > bootup during kdump. This will panic 2nd kernel and lead to no vmcore
> > generation. The issue is observed in Meteorlake CPU(cpuid: 0xA06A2):
>
> The previously posted fix is [1].

Thanks for the link, I didn't notice it. For kdump case, as far as I
have tested, only adding (!dmc) check for
intel_dmc_update_dc6_allowed_count() is sufficient to allow kdump to
work.

Thanks,
Tao Liu

>
> Imre, please R-b that. It's a NULL pointer dereference in the wild, in
> stable kernels. We need to get it fixed instead of bikeshedding on
> potential incorrect debugfs results.
>
> BR,
> Jani.
>
>
> [1] https://lore.kernel.org/r/20251202183950.2450315-1-jani.nikula@intel.=
com
>
>
> >
> >     BUG: kernel NULL pointer dereference, address: 0000000000000000
> >     #PF: supervisor read access in kernel mode
> >     #PF: error_code(0x0000) - not-present page
> >     PGD 0 P4D 0
> >     Oops: Oops: 0000 [#1] SMP NOPTI
> >     ...
> >     RIP: 0010:intel_dmc_update_dc6_allowed_count+0x16/0xa0 [i915]
> >     ...
> >
> > It is easy to locate the NULL pointer dereference by disassembly:
> >
> >     00000000001171e0 <intel_dmc_update_dc6_allowed_count>:
> >       1171e0:       f3 0f 1e fa             endbr64
> >       1171e4:       e8 00 00 00 00          call   1171e9
> >       1171e9:       41 55                   push   %r13
> >       1171eb:       41 54                   push   %r12
> >       1171ed:       55                      push   %rbp
> >       1171ee:       53                      push   %rbx
> >       1171ef:       4c 8b a7 18 03 00 00    mov    0x318(%rdi),%r12
> >       1171f6:       49 8b 2c 24             mov    (%r12),%rbp
> >
> > To fix this, add a NULL pointer check before dereferencing.
> >
> > Signed-off-by: Tao Liu <ltao@redhat.com>
> > ---
> >
> > The issue doesn't happen in 1st kernel, but in 2nd kernel of kdump. I'm=
 not
> > an expert to i915 and unsure what lead to the NULL pointer. To help fur=
ther
> > analysis, here is the full stack:
> >
> > [    8.608520]  <TASK>
> > [    8.610652]  gen9_set_dc_state.part.0+0x25d/0x2f0 [i915]
> > [    8.616096]  icl_display_core_init+0x2d/0x620 [i915]
> > [    8.621266]  intel_power_domains_init_hw+0x1b2/0x500 [i915]
> > [    8.627047]  intel_display_driver_probe_noirq+0x87/0x300 [i915]
> > [    8.633188]  i915_driver_probe+0x207/0x5d0 [i915]
> > [    8.637977]  ? drm_privacy_screen_get+0x198/0x1c0
> > [    8.642832]  local_pci_probe+0x41/0x90
> > [    8.646646]  pci_call_probe+0x58/0x160
> > [    8.650458]  ? pci_assign_irq+0x2f/0x160
> > [    8.654447]  ? pci_match_device+0xf8/0x120
> > [    8.658522]  pci_device_probe+0x95/0x140
> > [    8.662582]  call_driver_probe+0x27/0x110
> > [    8.666570]  really_probe+0xcc/0x2c0
> > [    8.670190]  __driver_probe_device+0x78/0x120
> > [    8.674692]  driver_probe_device+0x1f/0xa0
> > [    8.678857]  __driver_attach+0xfa/0x230
> > [    8.682757]  ? __pfx___driver_attach+0x10/0x10
> > [    8.687185]  bus_for_each_dev+0x8e/0xe0
> > [    8.691159]  bus_add_driver+0x11f/0x200
> > [    8.694970]  driver_register+0x72/0xd0
> > [    8.698853]  i915_init+0x26/0x90 [i915]
> > [    8.702837]  ? __pfx_i915_init+0x10/0x10 [i915]
> > [    8.707433]  do_one_initcall+0x5c/0x320
> > [    8.711409]  do_init_module+0x60/0x240
> > [    8.715132]  init_module_from_file+0xd6/0x130
> > [    8.719634]  idempotent_init_module+0x114/0x310
> > [    8.724241]  __x64_sys_finit_module+0x71/0xe0
> > [    8.728671]  do_syscall_64+0x11b/0x6d0
> > [    8.732483]  ? ksys_read+0x6b/0xe0
> > [    8.735854]  ? arch_exit_to_user_mode_prepare.isra.0+0xa2/0xd0
> > [    8.741768]  ? do_syscall_64+0x153/0x6d0
> > [    8.745828]  ? do_syscall_64+0x153/0x6d0
> > [    8.749814]  ? do_syscall_64+0x153/0x6d0
> > [    8.753800]  ? clear_bhb_loop+0x30/0x80
> > [    8.757700]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > ---
> >  drivers/gpu/drm/i915/display/intel_dmc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_dmc.c b/drivers/gpu/drm=
/i915/display/intel_dmc.c
> > index 1006b060c3f3..fd2756badc0c 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dmc.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dmc.c
> > @@ -1578,7 +1578,7 @@ void intel_dmc_update_dc6_allowed_count(struct in=
tel_display *display,
> >       struct intel_dmc *dmc =3D display_to_dmc(display);
> >       u32 dc5_cur_count;
> >
> > -     if (DISPLAY_VER(dmc->display) < 14)
> > +     if (!dmc || DISPLAY_VER(dmc->display) < 14)
> >               return;
> >
> >       dc5_cur_count =3D intel_de_read(dmc->display, DG1_DMC_DEBUG_DC5_C=
OUNT);
>
> --
> Jani Nikula, Intel
>


