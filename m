Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542ABCAC597
	for <kexec@archiver.kernel.org>; Fri, 19 Sep 2025 01:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jBqT4GDWcNMH7b8efKieP9YpFeoByi0GaQLbR+k6Z54=; b=PO1yHkXqbNRB2Mr8t37hDCwwyb
	ji+Bz+d/Xih4XMePSmOr9uTKIvt3ehgyRO6q7h9wodYWJ0jULvbP6jklNR/dBLd776mtMCROEmBJz
	98dePENh+t4abzKsYcq/s6SmNKmBrMnxSnHzXpVc4F98o2K4VIw3k5QmMANL0f5F69jGZWTWvwiDm
	KuCKrygmFd9kptvC01d1WLOfk9uXTFzjuCsf9rpc4NKMVDDV27ZU2exfQ69Vr7+roCiciL/DNg5G5
	jGGH16TrmwvJZaAI48Anhf0P5BucOc+GXPShikeC6YKb6ZR4MUoguX9qB/m92TvU9e3f3tWFru7kb
	5XXoXBPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzPtR-00000001b4r-3qpk;
	Fri, 19 Sep 2025 01:26:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzPtP-00000001b4M-1S5Y
	for kexec@lists.infradead.org;
	Fri, 19 Sep 2025 01:26:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758245188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jBqT4GDWcNMH7b8efKieP9YpFeoByi0GaQLbR+k6Z54=;
	b=EcmgtS4YxSXpk9u83m2MDWBFlbfbJsVmQeeCykF2F3+F2/ahRGWOc0iwfyovl6hx2UQDff
	Bo58NTqluR/iIzNwT0+EsXqPplNZbIuMtiBwmHj0HjhAY/muagDmdb4laG4u/mpUZKrYJn
	vHOVQ+5tMpF+gJUAa9GAIdH4f8APZ1E=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-oJtrx9FdNs-sL4jOa_pStA-1; Thu, 18 Sep 2025 21:26:25 -0400
X-MC-Unique: oJtrx9FdNs-sL4jOa_pStA-1
X-Mimecast-MFC-AGG-ID: oJtrx9FdNs-sL4jOa_pStA_1758245185
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24457f59889so18751495ad.0
        for <kexec@lists.infradead.org>; Thu, 18 Sep 2025 18:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758245184; x=1758849984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBqT4GDWcNMH7b8efKieP9YpFeoByi0GaQLbR+k6Z54=;
        b=tf0JKzlLas0BrjYHvZcjKg+OPjiIYtzPddkm3leRXxSYdKzY8Dy9ITGwPVS/3V60eV
         v85nZQLJaKmq8G8CmGyBdQDM5spEq9Q8LtOWrQ2aoEgdhzNimopswg0Rnc2nvEgrtnkO
         ntQXL4yRGLhVgNNiRynkNe4O57PDI6MSrj8BU6jSCSk/5CjPIcuGL/DJLtqvAdgypI0H
         N+EA0Cg2ME3Ic66TIZlkEQ8P8e4gKI6XMW2Qjaq7dkna/GBlGhOPHYlG91qYqf3kKej5
         nm5z7+9iMTKHs9Bg8/V9AC9OzVc6FDld7obUJAt7RHwmSMJyDaxmqH6idR1n40ZlC7FQ
         lpKQ==
X-Gm-Message-State: AOJu0Yy7qplS6oB+N8PQfDigwc0wwordVvVmUsop2Nus9136ycr+U9MP
	a9JgddTwfHj/eFWpRtTJwa2rlx5/pe/enDFVm6xjnIY6d0YhbnxIhxVUYl02v+OCQimli/5D4O2
	MDqxERIlQP7+P1Rr4C7XQRWspsTIWHPgIwQSKUzw+Z4AcaB/OuRt0K/GWixRWSHOc+B0RxdlxfY
	4y6F+p2RojqbdIOQIypXHFwlRiTfuHZTKNYQup
X-Gm-Gg: ASbGncshaBGfwEPoUK9QS0gYYF5s4bn3Tv8wYW3hmy8/Ypi/lDzqjb9Z6ep82I5eehd
	3n/DU76rLB9WSxZV7VX/626/g1LRPryDXjMPe2SP7Qze0p0dPPrwg9NxnTtwl4X+Jo20gPygBcj
	ySg+SWoerpBbOYBRE5qQ5eoQ==
X-Received: by 2002:a17:903:283:b0:24c:be1f:c1f9 with SMTP id d9443c01a7336-269ba401ffcmr18340795ad.8.1758245184599;
        Thu, 18 Sep 2025 18:26:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO2skCMLMEd8sMR6CZiuCIRgOkrs+OOLYvaa57nTFwaSIwdWHTuOC81sk4hi68CyPIOebLgrM0B/PMSkLqmrE=
X-Received: by 2002:a17:903:283:b0:24c:be1f:c1f9 with SMTP id
 d9443c01a7336-269ba401ffcmr18340485ad.8.1758245184190; Thu, 18 Sep 2025
 18:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250819012428.6217-1-piliu@redhat.com> <20250819012428.6217-7-piliu@redhat.com>
 <20250901163042.721db92d@rotkaeppchen> <aMkJNuORiqSZfpok@fedora> <20250918154342.0589fd4b@rotkaeppchen>
In-Reply-To: <20250918154342.0589fd4b@rotkaeppchen>
From: Pingfan Liu <piliu@redhat.com>
Date: Fri, 19 Sep 2025 09:26:13 +0800
X-Gm-Features: AS18NWDr6iUFJ3p1GM1beWie7SyVvsRSJs8JGgscj1z7Bvo9Oa_M3LitZF84RwI
Message-ID: <CAF+s44Tz=yJVUeRz7Y5LZm7Rso7OLa6Y0cHGoPs4gPFa3PTeRw@mail.gmail.com>
Subject: Re: [PATCHv5 06/12] kexec: Integrate with the introduced bpf kfuncs
To: Philipp Rudo <prudo@redhat.com>
Cc: kexec@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Viktor Malik <vmalik@redhat.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, bpf@vger.kernel.org, 
	systemd-devel@lists.freedesktop.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Dak-57t2oD9EW1BOhRd3AtAMImA2nNTy8IA4J6OMzLI_1758245185
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_182631_462247_FB1C572A 
X-CRM114-Status: GOOD (  37.00  )
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

On Thu, Sep 18, 2025 at 9:43=E2=80=AFPM Philipp Rudo <prudo@redhat.com> wro=
te:
>
> Hi Pingfan,
>
> On Tue, 16 Sep 2025 14:52:38 +0800
> Pingfan Liu <piliu@redhat.com> wrote:
>
> > On Mon, Sep 01, 2025 at 04:30:42PM +0200, Philipp Rudo wrote:
> > > Hi Pingfan,
> > >
> > >
> > > On Tue, 19 Aug 2025 09:24:22 +0800
> > > Pingfan Liu <piliu@redhat.com> wrote:
> > >
> > > > This patch does two things:
> > > > First, register as a listener on bpf_copy_to_kernel()
> > > > Second, in order that the hooked bpf-prog can call the sleepable kf=
uncs,
> > > > bpf_handle_pefile and bpf_post_handle_pefile are marked as
> > > > KF_SLEEPABLE.
> > > >
> > > > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > Cc: Philipp Rudo <prudo@redhat.com>
> > > > Cc: Baoquan He <bhe@redhat.com>
> > > > Cc: Dave Young <dyoung@redhat.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: bpf@vger.kernel.org
> > > > To: kexec@lists.infradead.org
> > > > ---
> > > >  kernel/kexec_pe_image.c | 67 +++++++++++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 67 insertions(+)
> > > >
> > > > diff --git a/kernel/kexec_pe_image.c b/kernel/kexec_pe_image.c
> > > > index b0cf9942e68d2..f8debcde6b516 100644
> > > > --- a/kernel/kexec_pe_image.c
> > > > +++ b/kernel/kexec_pe_image.c
> > > > @@ -38,6 +38,51 @@ static struct kexec_res parsed_resource[3] =3D {
> > > >   { KEXEC_RES_CMDLINE_NAME, },
> > > >  };
> > > >
> > > > +/*
> > > > + * @name should be one of : kernel, initrd, cmdline
> > > > + */
> > > > +static int bpf_kexec_carrier(const char *name, struct mem_range_re=
sult *r)
> > > > +{
> > > > + struct kexec_res *res;
> > > > + int i;
> > > > +
> > > > + if (!r || !name)
> > > > +         return -EINVAL;
> > > > +
> > > > + for (i =3D 0; i < 3; i++) {
> > > > +         if (!strcmp(parsed_resource[i].name, name))
> > > > +                 break;
> > > > + }
> > > > + if (i >=3D 3)
> > > > +         return -EINVAL;
> > >
> > > Can you please replace the magic '3' by ARRAY_SIZE, just like you did
> > > below when (un-)registering the listener.
> > >
> >
> > Yes, I will introduce a macro KEXEC_RES_ARRAY_SIZE to unify all of them=
.
>
> Why do you want to introduce a new macro? Why not simply use
> ARRAY_SIZE(parsed_resource)?
>

The input parameters of kexec_file_load determine that the array size
of parsed_resource[] itself should be three.
And that should be the origin.

Thanks,

Pingfan

> Thanks
> Philipp
>
> > Thanks,
> >
> > Pingfan
> >
> > > Thanks
> > > Philipp
> > >
> > > > +
> > > > + res =3D &parsed_resource[i];
> > > > + /*
> > > > +  * Replace the intermediate resource generated by the previous st=
ep.
> > > > +  */
> > > > + if (!!res->r)
> > > > +         mem_range_result_put(res->r);
> > > > + mem_range_result_get(r);
> > > > + res->r =3D r;
> > > > + return 0;
> > > > +}
> > > > +
> > > > +static struct carrier_listener kexec_res_listener[3] =3D {
> > > > + { .name =3D KEXEC_RES_KERNEL_NAME,
> > > > +   .alloc_type =3D 1,
> > > > +   .handler =3D bpf_kexec_carrier,
> > > > + },
> > > > + { .name =3D KEXEC_RES_INITRD_NAME,
> > > > +   .alloc_type =3D 1,
> > > > +   .handler =3D bpf_kexec_carrier,
> > > > + },
> > > > + { .name =3D KEXEC_RES_CMDLINE_NAME,
> > > > +   /* kmalloc-ed */
> > > > +   .alloc_type =3D 0,
> > > > +   .handler =3D bpf_kexec_carrier,
> > > > + },
> > > > +};
> > > > +
> > > >  static bool pe_has_bpf_section(const char *file_buf, unsigned long=
 pe_sz);
> > > >
> > > >  static bool is_valid_pe(const char *kernel_buf, unsigned long kern=
el_len)
> > > > @@ -159,6 +204,22 @@ __attribute__((used, optimize("O0"))) void bpf=
_post_handle_pefile(struct kexec_c
> > > >   dummy +=3D 2;
> > > >  }
> > > >
> > > > +BTF_KFUNCS_START(kexec_modify_return_ids)
> > > > +BTF_ID_FLAGS(func, bpf_handle_pefile, KF_SLEEPABLE)
> > > > +BTF_ID_FLAGS(func, bpf_post_handle_pefile, KF_SLEEPABLE)
> > > > +BTF_KFUNCS_END(kexec_modify_return_ids)
> > > > +
> > > > +static const struct btf_kfunc_id_set kexec_modify_return_set =3D {
> > > > + .owner =3D THIS_MODULE,
> > > > + .set =3D &kexec_modify_return_ids,
> > > > +};
> > > > +
> > > > +static int __init kexec_bpf_prog_run_init(void)
> > > > +{
> > > > + return register_btf_fmodret_id_set(&kexec_modify_return_set);
> > > > +}
> > > > +late_initcall(kexec_bpf_prog_run_init);
> > > > +
> > > >  /*
> > > >   * PE file may be nested and should be unfold one by one.
> > > >   * Query 'kernel', 'initrd', 'cmdline' in cur_phase, as they are i=
nputs for the
> > > > @@ -213,6 +274,9 @@ static void *pe_image_load(struct kimage *image=
,
> > > >   cmdline_start =3D cmdline;
> > > >   cmdline_sz =3D cmdline_len;
> > > >
> > > > + for (int i =3D 0; i < ARRAY_SIZE(kexec_res_listener); i++)
> > > > +         register_carrier_listener(&kexec_res_listener[i]);
> > > > +
> > > >   while (is_valid_format(linux_start, linux_sz) &&
> > > >          pe_has_bpf_section(linux_start, linux_sz)) {
> > > >           struct kexec_context context;
> > > > @@ -250,6 +314,9 @@ static void *pe_image_load(struct kimage *image=
,
> > > >           disarm_bpf_prog();
> > > >   }
> > > >
> > > > + for (int i =3D 0; i < ARRAY_SIZE(kexec_res_listener); i++)
> > > > +         unregister_carrier_listener(kexec_res_listener[i].name);
> > > > +
> > > >   /*
> > > >    * image's kernel_buf, initrd_buf, cmdline_buf are set. Now they =
should
> > > >    * be updated to the new content.
> > >
> >
>


