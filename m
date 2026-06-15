Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748ADCD98DE
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 23:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rU8PbGBJoPUku3x81mbrU+rfwVCtwy+1ozr856GX86E=; b=nor1FOWFx2vXvlVQ8MdMb16Dlg
	5w4AMcCbGXQOxHBU3LFwbJ7408G4blPRVzCy8jRt2rQWRbYoNCxXhF3Gj62KTiZqxC941JWKLjgJQ
	XL6z9QNF5zf0UqmXGxfIUamKKgMX40bsEMp6uqXVQBteJkjOLcpzQ80L95Wb9yfgDC4egVzeMFth+
	WcJSs07X3QW7AWC0/i+1uVqsn9cHQo7W0y5HX06FcDWsgiPodNk4dkqZOIZFmO+I+X/oZrfK8AokD
	LmKz2MXgihW4/rlUZewRJf8IQzn57NhtRjaYXQjN2nJdMtn+d80NEa07B58gdcqT8IkxYpO9N4bdp
	s949z4pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZGLd-0000000EvPp-0LA0;
	Mon, 15 Jun 2026 23:04:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZGLZ-0000000EvPQ-26yn
	for kexec@lists.infradead.org;
	Mon, 15 Jun 2026 23:04:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781564639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rU8PbGBJoPUku3x81mbrU+rfwVCtwy+1ozr856GX86E=;
	b=UzvD6nD88P/7qPowEJYR6penOdI4xg/gM1ZFEsghc4p40WDzdyODN70H+5059W72HujPM/
	DvfT2UH3WoLbJpkDBHIJi+gsv/fIHriYLhrt4xEs0VDvlYc7xUExbI10RpAAot/QRBeA7U
	JKxNAZsK9+E05WEC4darYNqECL8XoAg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-uniH-KbtOFq3qv9IHCjdqA-1; Mon, 15 Jun 2026 19:03:57 -0400
X-MC-Unique: uniH-KbtOFq3qv9IHCjdqA-1
X-Mimecast-MFC-AGG-ID: uniH-KbtOFq3qv9IHCjdqA_1781564637
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-517c65e497eso79105071cf.2
        for <kexec@lists.infradead.org>; Mon, 15 Jun 2026 16:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781564637; x=1782169437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rU8PbGBJoPUku3x81mbrU+rfwVCtwy+1ozr856GX86E=;
        b=HRtfJjtPyGXS6OHZxk6NsbUhyFQBDGQLhHRsPAFN6MnyC3CA8YZO1t5J08GT1MC6TB
         2BdIaucEGypEEXmRImkDbR2BwVa3fU5qv7DGF0TNYLx3o63ufnkgFYWNvNGBEvcjSA6O
         545eb3JFmco0ohIXfLtZh1ThPho/pxyud5y6xy3bFt2qywz4msOMITl4N29p37pcp688
         QONu6jB0UCem0sQFgaA/27R09i2jSxRF0U1PHfUgJRUcnRM42EeS8FDiQ5h1iOVpXncv
         2VlNdrR2d0obywuZ74Z8U+mKgYSv9XH1hZvCkl5j0f6EZHD8M9vRIIBCaIPRH8WmCqXM
         hq5g==
X-Forwarded-Encrypted: i=1; AFNElJ9AoBADfRECo2yftcAsUHfe37w8xVjUrZ3vdx5TGPITAKtIa1D2Fr89Jzga29cPFHSLGA17ig==@lists.infradead.org
X-Gm-Message-State: AOJu0Yya6OzTFx98G4wXWoxT5LQL4Miz1Fbo1903XqQeadW8b2T9db9Q
	EgCZfkqfEm/X8kF6HS+Hu4IeXLavVxAuvuTJXC4994yul4jbc7e8Gsv9KU/c5VfeSG8rdm/J1hN
	DvQTyBT33aLS1DwKJA3UaIuGSb9JNUl9pKiriT5lLevpVKFnFEIVTeVAuYOwxddrvf3N8CVdVpl
	ZLMdIas7eAOkHmr2vcxl2wdiSAf4A5SbykO5zY
X-Gm-Gg: Acq92OE9bK97+qneFQiDaK72k3C215vtkfluLVjDDUaAXw4LnkTmFOYUpeJfkx04B6y
	zHIVGP6j5RZyNyTNrL7IqQEmcOvMD6+mxc8rDss0U8qggmUlfVptSy0p4Y8tKjGp3CG6VL2S3yV
	/R50wIT6DhWxQj/IMSiwhgDUuPqpYt23R7cK/tcAR+I+bKIuoaZ+EhvbbE75iPjKl3oIo38O+5+
	K51
X-Received: by 2002:a05:622a:406:b0:517:7ecb:f01d with SMTP id d75a77b69052e-51991ae690emr16483971cf.28.1781564637098;
        Mon, 15 Jun 2026 16:03:57 -0700 (PDT)
X-Received: by 2002:a05:622a:406:b0:517:7ecb:f01d with SMTP id
 d75a77b69052e-51991ae690emr16483461cf.28.1781564636523; Mon, 15 Jun 2026
 16:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260414102656.55200-1-ltao@redhat.com> <20260414102656.55200-7-ltao@redhat.com>
 <8b0079dd-e50a-4667-aabf-1612921b022a@nec.com> <874ij3zq1k.fsf@oracle.com>
In-Reply-To: <874ij3zq1k.fsf@oracle.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 16 Jun 2026 11:03:19 +1200
X-Gm-Features: AVVi8CdMx2V-n2zcuZJ6rTfQLRnEXVkCM8ceAafNpXHnp8Y1eJ7TWb0G-Czl_pM
Message-ID: <CAO7dBbU6V7XYYO9M+z_CK8UCnzfX7TB7DZka4Z_kqP-WvDbTaA@mail.gmail.com>
Subject: Re: [PATCH v5][makedumpfile 6/9] Add makedumpfile extensions support
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>, 
	=?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JF4lz45lgVdbBVpvQnVnKmGkt8It3erHjxLWwCBhE5I_1781564637
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260615_160401_617745_372252E9 
X-CRM114-Status: GOOD (  22.19  )
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

Hi Stephen & Kazu,

On Tue, Jun 16, 2026 at 5:12=E2=80=AFAM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=E3=80=80=E4=B8=80=E4=BB=81)   <k-hagio-=
ab@nec.com> writes:
> > On 2026/04/14 19:26, Tao Liu wrote:
> >
> >> +static bool init_kallsyms_btf(void)
> >> +{
> >> +    int count;
> >> +    bool ret =3D false;
> >> +    /* We will load module's btf/kallsyms on demand */
> >> +    bool init_ksyms_module =3D false;
> >> +    bool init_ktypes_module =3D false;
> >> +
> >> +    if (check_ksyms_require_modname("vmlinux", &count)) {
> >
> > Thank you for the explanation [1].
> >
> > so which code path adds "vmlinux" to the mods array before this line?
> > I could not find it.
>
> Hello Kazu,
>
> In kallsyms.c from patch 2, there is the line:
>   INIT_MOD_SYM(vmlinux, _stext);
> This adds a struct ksym_info to the main makedumpfile executable's
> array, which requests symbol "_stext" from vmlinux.
>
> In kallsyms.c "init_kernel_kallsyms()", again from patch 2, the first
> step is to call:
>    register_ksym_section((char *)__start_init_ksyms,
>                          (char *)__stop_init_ksyms))
> Which is a function generated by the macro REGISTER_SECTION(). The
> implementation will use add_ksym_modname() whens it encounters this
> symbol, ensuring that "vmlinux" is part of the modname array.

Thanks for the detailed info, yes, it is exactly how "vmlinux" is
added to the array.

>
> Thanks,
> Stephen
>
> > [1] https://lore.kernel.org/kexec/CAO7dBbUa_8H0fe+9bTNTQWjMVy9qCPiu0fo3=
g8XamiDS_Mr8eA@mail.gmail.com/
> >
> >
> >> +
> >> +bool has_extension_loaded(void)
> >> +{
> >> +    return extension_opts_len > 0;
> >
> > If an extension is skipped, this looks > 0 with no extention.
> > handle_cbs_len is better?

Yeah, I agree, `has_extension_loaded()` should also be updated to
`has_extension_callback()`. I will fix it in v6.

Thanks,
Tao Liu

> >
> >
> > Thanks,
> > Kazu
>


