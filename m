Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638FDFED9E7
	for <kexec@archiver.kernel.org>; Tue, 17 Mar 2026 15:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z1ctrVANQ+8yr6DnpZgQDCO1bEwy2mAvdLywczvSivk=; b=bP8r39f5lqbmjtVHV4syKiu/zI
	vvysFEzuoOILKsSBRdJcKXDdjKodWHp09VSQoAEkue9HqK0cjdzUK3Kq4ZTlN0LCu3kzUkxNkbPpc
	S56kF0iJkvkYTm5Dw1DCtNcrMOBOAed/KuMsMi2iiYBCFqXsTS83vp0dWfZRu3mxobeh3bL4oolVL
	ftNzWratL4sTkze3L4slATJDN05wGYJd/jSPw1Dp6BXoZmKVfiru8sgZh6WlCk3pPhouRIrKg3xUP
	+w8c+7ALI5D/fwS7MrrX71ENws6T/wIcNdrxygxv9TzE2TEhNjx0vulPkRQCbhT49+eQ4s9fq4oYV
	PgHoZ7lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2WOt-00000006kMu-0Z3n;
	Tue, 17 Mar 2026 15:32:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2WOp-00000006kMX-1Tpm
	for kexec@lists.infradead.org;
	Tue, 17 Mar 2026 15:32:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773761522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1ctrVANQ+8yr6DnpZgQDCO1bEwy2mAvdLywczvSivk=;
	b=H4EdDabcXE/vD1ToSqm3rXHAmC9suwVleCocW4rYOGE+MBPfZftNQaFqbgRKOcshJWohWf
	Qx1sglg1P9TkgXFRQvXQ0ILbuNX+MeARea4N8sP/d9rR9UJ3f9Frum0wtUTQbLBgzdA0Kn
	IBty+5djVsvdF9jhW3iOh7PhLcrmHdM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-ZHUBnp7YMbi0xhmehozEQQ-1; Tue, 17 Mar 2026 11:31:59 -0400
X-MC-Unique: ZHUBnp7YMbi0xhmehozEQQ-1
X-Mimecast-MFC-AGG-ID: ZHUBnp7YMbi0xhmehozEQQ_1773761519
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5093787e2fdso872514251cf.2
        for <kexec@lists.infradead.org>; Tue, 17 Mar 2026 08:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773761519; x=1774366319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z1ctrVANQ+8yr6DnpZgQDCO1bEwy2mAvdLywczvSivk=;
        b=b/EjmKV/jcJc5Y7Jd1mAWnfhb0zGttkxA9JrfXr7t4ut3zhKS6SQuMuCThbNAndc49
         6lPCdmQdrM9k/sIdl8wB07dPX3wvzGD6NU2lm3yQ4wFCEhERaZXnVWBmkHZ2nfgo8ndG
         2PCEKlXm0ChHoVUiBmFZsjBj81/+ExQtTEmA3R1kLrNcQJEQ3t39lWDb12ECVMqM9ZcA
         twaxBzTMhlrVVEp031G7nLvm29Y59Wq2FGKROpciEAAf0RGsFRgwri4WCco5kt/ePMpq
         SImXzQS7vImGFy74cuCAwDXGr2jW8Gn6THN+kWyxquz2/QLBsgg2630CzVaDvA0vIOdf
         nwdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYXeuyoDvAQStVPiv4bZB7FEFbPWFEZhhFT/qEg+vONsWDx4Vxx4Fe76ilLAhkcxkqkhKrnw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx/0eyBDQBS8WX1WotSNEYHrP/j0bpgjtaKfVI8N0kQV3c0kS4Y
	ihDsOgv0FqbUijysIZd+NPhhb8pkcokl6DOYX52aGYJ1x5rIY50HETF5qXQYFIpJ6wCTvEegJoF
	rfl8u9Xxl6gNTpmnjN8kZ49Q80Q1MJoUic7dfu3ijq+jhI1UxHZCpsKmIk8okpUYKLktSR/MHZR
	LX83FXEa6VgiqzA+P3MgvA+7nfMxKMlccT32wCftnWOGmUaS8=
X-Gm-Gg: ATEYQzx+Iy33TJwckwgFHC6wcrpyvM+eHf9WtaPoPA2BnaESD8KyRtuyDnKT0skXyUQ
	oH+7bELDuetXQa1C6HUtTZySTpkcLvMDnzNrVaT+/1MCXg7tjW7OMpt8S6CNeO5/WHQQPGr+z1p
	G9KOly71en7ZZvQ96qsYHguoF+AL8mginpwsUysSpCyFGHf2eJZ3xSaMwRoSBPOxXmbO3YsfLvO
	ONoC7c=
X-Received: by 2002:a05:622a:291:b0:509:4e59:7f40 with SMTP id d75a77b69052e-50957cc026cmr220959961cf.24.1773761518535;
        Tue, 17 Mar 2026 08:31:58 -0700 (PDT)
X-Received: by 2002:a05:622a:291:b0:509:4e59:7f40 with SMTP id
 d75a77b69052e-50957cc026cmr220959571cf.24.1773761517894; Tue, 17 Mar 2026
 08:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260120025500.25095-1-ltao@redhat.com> <20260120025500.25095-6-ltao@redhat.com>
 <87ikcuv5ag.fsf@oracle.com> <CAO7dBbV-o4pTkaxaiZxfWHV7WDk=3fBc_XWVEs1XNWnvqJw46A@mail.gmail.com>
 <CAO7dBbW34=+DQMZ8NyPqPtm83nr2DYfa_z0Huf=NS8bzrh053w@mail.gmail.com>
 <87o6kvmc8s.fsf@oracle.com> <CAO7dBbUGHCo8psJCvrfipR=7hYyGM16713ANM+6FDOjrhVNeUQ@mail.gmail.com>
 <87ldfwn0to.fsf@oracle.com>
In-Reply-To: <87ldfwn0to.fsf@oracle.com>
From: Tao Liu <ltao@redhat.com>
Date: Wed, 18 Mar 2026 04:31:20 +1300
X-Gm-Features: AaiRm52LGmruQhSvkOo1_cZWqnX3idVYLpKn6yM8gcayD4ngLdBi0LU_uJK1Z8w
Message-ID: <CAO7dBbUOxj9Zv+R=StKRXmd29mFe++B30_E=ABxcG6q-ezri-A@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] Add makedumpfile extension support
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org, 
	aravinda@linux.vnet.ibm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BsgFxgDvfYh7JCT00u-TaGYg5zi9oS_Oc7Tpp7NkL60_1773761519
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_083203_551375_B8A50C2A 
X-CRM114-Status: GOOD (  79.41  )
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

Hi Stephen,

Thanks a lot for your comments, I have made plenty of code
improvements based on your suggestions and your github code repo.
Sorry I didn't inline reply to all your comments, please check out the
latest v4 patch I posted upstream.

Some notable improvements:

1) I adjusted the extension callback function to amdgpu_filter, so a
same callback interface can serve both our extensions.
2) I followed your implementation of the INIT_OPT_(...) macro for
optional sym/types and the INIT_(...) macro for must-have sym/types.
If extension missing any must-have sym/types, it will load-fail and
exit as early(e.g. a machine doesn't have amdgpu). And optional
symbols checking during extension_init() (e.g. existence of kernel
symbol for kernel version detection)
3) kallsyms address calc for v7.0 kernel

On Fri, Mar 13, 2026 at 11:24=E2=80=AFAM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Tao Liu <ltao@redhat.com> writes:
>
> > Hi Stephen,
> >
> > On Wed, Mar 11, 2026 at 1:38=E2=80=AFPM Stephen Brennan
> > <stephen.s.brennan@oracle.com> wrote:
> >>
> >> Tao Liu <ltao@redhat.com> writes:
> >> > Hi Stephen,
> >> >
> >> > Sorry I took some time to make modifications on v3 code. Please see =
a
> >> > drafted v4 [1] for a preview.
> >> >
> >> > I followed your suggestion to let extensions declare the kallsyms
> >> > symbol/btf types it needed, then during kallsyms/btf initialization,
> >> > it will only resolve the declared symbol/types, thus getting rid of
> >> > the hash table. Extensions now don't need to initial needed
> >> > symbols/types by itself.
> >> >
> >> > In addition, users can specify which extensions to load at
> >> > makedumpfile cmdline as:
> >> >
> >> > $ ./makedumpfile -d 31 -l
> >> > /var/crash/127.0.0.1-2025-06-10-18\:03\:12/vmcore /tmp/out --extensi=
on
> >> > amdgpu_filter.so
> >> >
> >> > Also "--extension" can be used several times, and amdgpu_filter.so c=
an
> >> > be an absolute path as well. If no extensions are specified, the
> >> > btf/kallsyms of makedumpfile will not initialize.
> >> >
> >> > I don't know if this is what you wanted, or any suggestions for this=
?
> >> > Thanks in advance!
> >>
> >> Hi Tao,
> >>
> >> Please accept my apologies for the long delay on this review.  I've go=
ne through
> >> each commit with my feedback. This looks like a really excellent job a=
nd I
> >> think it is ready for the review of the maintainers. I've implemented =
my own
> >> userspace stack extension on top of this support, and I find it to be =
great for
> >> my use case as well, with one small change (adding flags for detecting=
 whether a
> >> struct or member is found).
> >
> > No worries at all :) Thanks a lot for your detailed comments. I'm
> > looking through them as well as your code branch in github. This may
> > take a while...
> >
> >>
> >> Here is some more detailed feedback on a per-commit level; it's all pr=
etty
> >> minor.
> >>
> >> d3aee7a ("Reserve sections for makedumpfile and extenions")
> >>
> >> * This is just a note, but I've found that the linker script may not b=
e
> >>   necessary. GCC automatically creates the __start_SECTION and __stop_=
SECTION
> >>   symbols for sections it creates.
> >
> > I have tried to remove the makedumpfile.ld linker script. The
> > automatic symbol as __start/stop_SECTION are only generated for
> > makedumpfile, aka the main program, but not for .so extensions. This
> > is a breaker because I would expect all .so files have the
> > __start/stop_SECTION symbol so they can be resigtered to main program.
> > I'm not expert in GCC's default behaviours, so I guess I would prefer
> > the current approach of explicit symbol define within the linker
> > script, seems to be more robust...  Perhaps you can share your code on
> > this, I will give it a try.
>
> The key to making GCC generate the symbols for the sections is that the
> section names should themselves be valid C identifiers (i.e. they should
> not start with a '.'). Here's a patch to give the idea:
>
> From 3618f51869e978328e49f6061eae94469bca43c5 Mon Sep 17 00:00:00 2001
> From: Stephen Brennan <stephen.s.brennan@oracle.com>
> Date: Wed, 11 Mar 2026 09:17:05 -0700
> Subject: [PATCH] Use automatically generated section start symbols
>
> GCC will create __start_SECTION and __stop_SECTION only if the section
> names are valid C identifiers. This means we cannot use a leading dot.
> Drop the leading dot from the section names so we can avoid defining a
> custom linker script.
>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>  Makefile            |  2 +-
>  btf_info.h          |  4 ++--
>  extensions/Makefile |  2 +-
>  kallsyms.h          |  2 +-
>  makedumpfile.ld     | 15 ---------------
>  5 files changed, 5 insertions(+), 20 deletions(-)
>  delete mode 100644 makedumpfile.ld
>
> diff --git a/Makefile b/Makefile
> index 8196aa6..e2cde8f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -113,7 +113,7 @@ $(OBJ_ARCH): $(SRC_ARCH)
>         $(CC) $(CFLAGS_ARCH) -c -o ./$@ $(VPATH)$(@:.o=3D.c)
>
>  makedumpfile: $(SRC_BASE) $(OBJ_PART) $(OBJ_ARCH)
> -       $(CC) $(CFLAGS) $(LDFLAGS) $(OBJ_PART) $(OBJ_ARCH) -rdynamic -Wl,=
-T,makedumpfile.ld -o $@ $< $(LIBS)
> +       $(CC) $(CFLAGS) $(LDFLAGS) $(OBJ_PART) $(OBJ_ARCH) -rdynamic -o $=
@ $< $(LIBS)
>         @sed -e "s/@DATE@/$(DATE)/" \
>              -e "s/@VERSION@/$(VERSION)/" \
>              $(VPATH)makedumpfile.8.in > $(VPATH)makedumpfile.8
> diff --git a/btf_info.h b/btf_info.h
> index 2a78fbf..555f21e 100644
> --- a/btf_info.h
> +++ b/btf_info.h
> @@ -29,7 +29,7 @@ void cleanup_btf(void);
>         struct ktype_info _##MOD##_##S##_##M =3D {                \
>                 QUATE(MOD), QUATE(S), QUATE(M), 0, 0, 0, 0, R, R\
>         };                                                      \
> -       __attribute__((section(".init_ktypes"), used))          \
> +       __attribute__((section("init_ktypes"), used))           \
>         struct ktype_info * _ptr_##MOD##_##S##_##M =3D &_##MOD##_##S##_##=
M
>
>  #define INIT_MOD_STRUCT_MEMBER(MOD, S, M)                      \
> @@ -60,7 +60,7 @@ void cleanup_btf(void);
>         struct ktype_info _##MOD##_##S =3D {                      \
>                 QUATE(MOD), QUATE(S), 0, 0, 0, 0, 0, R, 0       \
>         };                                                      \
> -       __attribute__((section(".init_ktypes"), used))          \
> +       __attribute__((section("init_ktypes"), used))           \
>         struct ktype_info * _ptr_##MOD##_##S =3D &_##MOD##_##S
>
>  #define INIT_MOD_STRUCT(MOD, S) INIT_MOD_STRUCT_RQD(MOD, S, 1)
> diff --git a/extensions/Makefile b/extensions/Makefile
> index fc28577..a4dc86a 100644
> --- a/extensions/Makefile
> +++ b/extensions/Makefile
> @@ -8,7 +8,7 @@ amdgpu_filter.so: maple_tree.c
>  userstack.so: maple_tree.c vma_rbtree.c
>
>  $(CONTRIB_SO): %.so: %.c
> -       $(CC) -O2 -g -fPIC -shared -Wl,-T,../makedumpfile.ld -o $@ $^
> +       $(CC) -O2 -g -fPIC -shared -o $@ $^
>
>  clean:
>         rm -f $(CONTRIB_SO)
> diff --git a/kallsyms.h b/kallsyms.h
> index d94830e..1989dfe 100644
> --- a/kallsyms.h
> +++ b/kallsyms.h
> @@ -17,7 +17,7 @@ struct ksym_info {
>         struct ksym_info _##MOD##_##SYM =3D {             \
>                 QUATE(MOD), QUATE(SYM), 0               \
>         };                                              \
> -       __attribute__((section(".init_ksyms"), used))   \
> +       __attribute__((section("init_ksyms"), used))    \
>         struct ksym_info * _ptr_##MOD##_##SYM =3D &_##MOD##_##SYM
>
>  #define GET_MOD_SYM(MOD, SYM) (_##MOD##_##SYM.value)
> diff --git a/makedumpfile.ld b/makedumpfile.ld
> deleted file mode 100644
> index 231a162..0000000
> --- a/makedumpfile.ld
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -SECTIONS
> -{
> -       .init_ksyms ALIGN(8) : {
> -               __start_init_ksyms =3D .;
> -               KEEP(*(.init_ksyms*))
> -               __stop_init_ksyms =3D .;
> -       }
> -
> -       .init_ktypes ALIGN(8) : {
> -               __start_init_ktypes =3D .;
> -               KEEP(*(.init_ktypes*))
> -               __stop_init_ktypes =3D .;
> -       }
> -}
> -INSERT AFTER .data;
> \ No newline at end of file
> --
> 2.47.3

Unfortunately with the patch applied I cannot see the
__start_init_ksyms/ktypes symbol for amdgpu_filter.so. So I had to
keep the linker script in v4...

Thanks,
Tao Liu

>
>
>
> >> * Otherwise, this is exactly what I was thinking!
> >>
> >> 102ae0b ("Implement kernel kallsyms resolving")
> >>
> >> * Again, this is looking very close to the design I hoped for, thanks!
> >> * I'm not sure whether is_unwanted_symbol() needs to exist anymore?  G=
iven that
> >>   users opt-in to specific symbols, we don't need to filter out noisy =
ones that
> >>   would waste memory. What do you think?
> >
> > Agreed, I can remove this function.
> >
> >> * Unfortunately, upstream has made some changes to the vmlinux kallsym=
s encoding
> >>   in 7.0. You may want to check what we did in drgn to support those c=
hanges:
> >>   https://github.com/osandov/drgn/commit/744f36ec3c3f64d7e1323a0037898=
158698585c4
> >> * In kallsyms.c:
> >
> > Thanks for the info, I will try this and update the code in v4.
> >
> >>
> >>   +/*
> >>   + * Makedumpfile's .init_ksyms section
> >>   +*/
> >>   +extern struct ksym_info __start_init_ksyms[];
> >>   +extern struct ksym_info __stop_init_ksyms[];
> >>
> >>   I'm not sure it matters, but the type here is wrong. It should be
> >>   "extern struct ksym_info *" because you're storing pointers, not the=
 actual
> >>   struct. That said, the type isn't used so I don't know that it matte=
rs.
> >
> > Right, this is an error. Thanks for pointing that out.
> >
> >>
> >> 4187b33 ("Implement kernel btf resolving")
> >>
> >> * The get_ktype_info() function fails if either the struct or member i=
s not
> >>   found. This makes sense in a lot of cases, but there are other cases=
 where we
> >>   will want to use the presence or absence of a struct/struct member t=
o detect
> >>   which version of code to use. For example, my userspace stack code w=
ill use
> >>   either maple or rbtree helper code for finding stack VMAs, depending=
 on which
> >>   is available. We can't know until runtime, when we check whether mm_=
rb or
> >>   mm_mt is present.
> >>
> >>   One solution is to handle this at runtime. We can have a macro like
> >>   "HAVE_MEMBER(S, M)" and "HAVE_STRUCT(S)", and then each extension ca=
n check
> >>   whether for the members it expects to be present. I think the major =
downside
> >>   to this approach is that it requires manual effort, which is likely =
to be
> >>   forgotten when writing extensions.
> >>
> >>   Alternatively, we could set a flag in the struct ktype_info if the t=
ype is
> >>   "required" (or optional), and only fail get_ktype_info() for require=
d
> >
> > Agreed, an optional flag looks better.
> >
> >>   structs/members. The concern with this approach is: what if plugin (=
A)
> >>   requires a type which is not present, but plugin (B) does not? If bo=
th are
> >>   loaded, the failure of A would cause B not to run. I'm not sure whet=
her we
> >>   should care about that situation... I don't know if we have a use ca=
se for
> >>   using multiple plugins at the same time. Until we do, we probably wo=
n't have a
> >>   good idea whether it should be allowed for one to fail, but the othe=
r to
> >>   continue.
> >
> > Great question! I have thought about this previously. I suggest that
> > if plugin(A) fails, it should just fail and allow the execution of any
> > later plugins (B, C....) to continue. Each plugin is responsible for
> > one task, like plugin(A) for dealing with amdgpu's mm page
> > filtering,and plugin(B) for Intel's and plugin(C) for NV's. Plugin(A)
> > certainly will fail if one machine have no amdgpu, thus the amdgpu.ko
> > will never been loaded, so related symbol/types missing. This is
> > expected and shouldn't block the later plugins.
> >
> > But the "fail" should gentle, not like the ones as segfault, which
> > will crash the entire makedumpfile program.
>
> Totally agreed up to here! I think it makes sense for plugin failures to
> be independent.
>
> It seems like the BTF loading process should not fail if any type or
> member is not found. But once we've tried to load everything, we can
> then go through each plugin's list, and if we find a "required" type
> or member which is not present, we log that failure and don't run the
> plugin. This shouldn't be much work, because we already have all the
> types in an array for each plugin.
>
> > Since currently plugins
> > are native .so libraries, the quality of code is ensured by each
> > plugin authors, rather than makedumpfile maintainers. Idealy the the
> > plugins are well tested in 1st kernel before they are shipped to kdump
> > img, but who knows. From makedumpfile's view, do you think we need to
> > introduce a sandbox to isolate plugins from makedumpfile? This would
> > prevent serious plugin errors from stopping makedumpfile from
> > generating the vmcore.
>
> Personally, I don't believe we need sandbox. The plugins should be
> written to handle the clear error cases:
>
> - Optional types or symbols may not be present, so validate them.
> - Values read from /proc/vmcore may not be valid, or the read may fail,
>   so check all return values.
>
> That said, I'm not set against it, so if you believe it's necessary I
> could be convinced :)
>
> Thanks again,
> Stephen
>
> >>
> >>   I've implemented this second alternative in my branch.
> >>
> >> * Similar to the previous commit, __start_init_ktypes and __stop_init_=
ktypes are
> >>   declared as structs but should probably be declared as pointers.
> >>
> >> 22097b7 ("Implement kernel module's kallsyms resolving")
> >> edfa698 ("Implement kernel module's btf resolving")
> >>
> >> * These commits are straightforward:
> >>   Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> >>
> >> ede22e8 ("Add makedumpfile extensions support")
> >
> > I will address those later after reading through your code branch.
> > Thanks again for your detailed comments!
> >
> > Thanks,
> > Tao Liu
> >
> >>
> >> * nit: the array "handlers" actually contains "handles" (no r) returne=
d from
> >>   dlopen(). The word handlers usually implies a function pointer or so=
mething
> >>   like that, called to handle a certain situation. Maybe rename this t=
o
> >>   "handles".
> >> * The run_extensions() function is called within a retry loop in
> >>   create_dumpfile(). It seems possible that this could get called mult=
iple
> >>   times. But many of the global variables in the kallsyms, BTF, and ex=
tension
> >>   code are not safe to be cleaned up and reinitialized. In particular,=
 when
> >>   array elements are freed, the lengths, capacities, and pointers are =
not reset
> >>   to 0/NULL. I think it would be wise to make all the cleanup function=
s clear
> >>   the globals, so that they may be reinitialized safely.
> >> * Further, I think it might be helpful to split extension loading, run=
ning, and
> >>   cleanup. Something like this in create_dumpfile():
> >>
> >>         load_extensions(); /* loads everything and calls entry() */
> >>     retry:
> >>         /* ... create bitmap and dump ... */
> >>         if (status =3D=3D NOSPACE) {
> >>             /* ... */
> >>             goto retry;
> >>         }
> >>         /* ... */
> >>         cleanup_extensions();
> >>         return;
> >>
> >>   For two reasons: (1) this avoids unnecessary work re-loading and
> >>   re-initializing the BTF, kallsyms, and extensions. (Though I still t=
hink it's
> >>   safer to ensure they can be re-initialized safely.) And (2), this al=
lows for
> >>   future use of extensions in the rest of the dump operation. For my u=
serspace
> >>   stack extension, I plan to add a callback which allows extensions to=
 override
> >>   the decision to filter a page, since my logic can't be easily done v=
ia erase
> >>   info. So the extensions need to remain loaded during the creation of=
 the
> >>   dumpfile, and cleaned up after. I have tweaked this in my own patche=
s,
> >>   but I just wanted to share the use case.
> >>
> >> c568635 ("btf/kallsyms based makedumpfile extension for mm page filter=
ing")
> >>
> >> * This looks good to me!
> >> * I will say that for my userspace stack use case, while the "filter_p=
age(...,
> >>   false)" mechanism for specifying pages that are retained *looks* use=
ful, I
> >>   wouldn't be able to use it because I cannot determine the PFNs for e=
ach stack
> >>   VMA. Instead, I have to use the page "mapping" and "index" fields to=
 match the
> >>   VMA and determine whether the PFN falls in a range I care to save. O=
f course,
> >>   just because *I* won't use it doesn't mean it's not useful :)
> >>
> >> 2b252ec ("Filter amdgpu mm pages")
> >>
> >> * I'm no expert in amdgpu, but the overall approach makes sense to me,=
 and the
> >>   helpers look good.
> >>
> >>
> >> At a broader level, while the add_to_arr() function is useful, I do th=
ink the
> >> dynamic array/vector pattern could be captured with a dedicated data s=
tructure.
> >> For instance, drgn has this excellent LGPL-2.1+ header-only vector lib=
rary:
> >> https://github.com/osandov/drgn/blob/main/libdrgn/vector.h
> >> I don't think it is high priority or must be addressed. Nor do I mean =
that this
> >> particular implementation choice be used. It's just something to share=
 & think
> >> about.
> >>
> >> To provide some context on my comments related to the userspace stack =
tracing,
> >> here is a branch of mine which is based on yours, that adds my userspa=
ce stack
> >> extension and a few tweaks:
> >>
> >> https://github.com/brenns10/makedumpfile/commits/stepbren_userstack_v4=
/
> >>
> >> Thank you,
> >> Stephen
> >>
> >> > Thanks,
> >> > Tao Liu
> >> >
> >> >
> >> >
> >> >
> >> >
> >> >
> >> >
> >> > [1]: https://github.com/liutgnu/makedumpfile/commits/v4/
> >> >
> >> > On Fri, Jan 23, 2026 at 2:43=E2=80=AFAM Tao Liu <ltao@redhat.com> wr=
ote:
> >> >>
> >> >> Hi Stephen,
> >> >>
> >> >> Thanks a lot for your quick reply and detailed information, I reall=
y
> >> >> appreciate it!
> >> >>
> >> >> On Thu, Jan 22, 2026 at 1:51=E2=80=AFPM Stephen Brennan
> >> >> <stephen.s.brennan@oracle.com> wrote:
> >> >> >
> >> >> > Hi Tao,
> >> >> >
> >> >> > This series looks really great -- I'm excited to see the switch t=
o
> >> >> > native .so extensions instead of epicc. I've applied the series l=
ocally
> >> >> > and I'll rebuild my userspace stack inclusion feature based on it=
, to
> >> >> > try it out myself.
> >> >>
> >> >> Awesome, looking forward to your feedback on the code/API designs e=
tc...
> >> >>
> >> >> >
> >> >> > In the meantime, I'll share some of my feedback on the patches (t=
hough
> >> >> > I'm not a makedumpfile developer). This seems like the most impor=
tant
> >> >> > patch in terms of design, so I'll start here.
> >> >> >
> >> >> > Tao Liu <ltao@redhat.com> writes:
> >> >> > > This patch will add .so extension support to makedumpfile, simi=
lar to crash
> >> >> > > extension to crash utility. Currently only "/usr/lib64/makedump=
file/extensions"
> >> >> > > and "./extensions" are searched for extensions. Once found, kal=
lsyms and btf
> >> >> > > will be initialized so all extensions can benifit from it (Curr=
ently makedumpfile
> >> >> > > doesn't use these info, we can move the kallsyms/btf init code =
else where later
> >> >> > > if makedumpfile needs them).
> >> >> > >
> >> >> > > The makedumpfile extension is to help users to customize mm pag=
e filtering upon
> >> >> > > traditional mm page flag filtering, without make code modificat=
ion on makedumpfile
> >> >> > > itself.
> >> >> > >
> >> >> > > Signed-off-by: Tao Liu <ltao@redhat.com>
> >> >> > > ---
> >> >> > >  Makefile            |  7 +++-
> >> >> > >  extension.c         | 82 +++++++++++++++++++++++++++++++++++++=
++++++++
> >> >> > >  extensions/Makefile | 10 ++++++
> >> >> > >  makedumpfile.c      |  4 +++
> >> >> > >  4 files changed, 102 insertions(+), 1 deletion(-)
> >> >> > >  create mode 100644 extension.c
> >> >> > >  create mode 100644 extensions/Makefile
> >> >> > >
> >> >> > > diff --git a/Makefile b/Makefile
> >> >> > > index f3f4da8..7e29220 100644
> >> >> > > --- a/Makefile
> >> >> > > +++ b/Makefile
> >> >> > > @@ -45,7 +45,7 @@ CFLAGS_ARCH +=3D -m32
> >> >> > >  endif
> >> >> > >
> >> >> > >  SRC_BASE =3D makedumpfile.c makedumpfile.h diskdump_mod.h sadu=
mp_mod.h sadump_info.h
> >> >> > > -SRC_PART =3D print_info.c dwarf_info.c elf_info.c erase_info.c=
 sadump_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c btf_info.=
c
> >> >> > > +SRC_PART =3D print_info.c dwarf_info.c elf_info.c erase_info.c=
 sadump_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c btf_info.=
c extension.c
> >> >> > >  OBJ_PART=3D$(patsubst %.c,%.o,$(SRC_PART))
> >> >> > >  SRC_ARCH =3D arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c =
arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64=
.c arch/loongarch64.c arch/riscv64.c
> >> >> > >  OBJ_ARCH=3D$(patsubst %.c,%.o,$(SRC_ARCH))
> >> >> > > @@ -126,6 +126,7 @@ eppic_makedumpfile.so: extension_eppic.c
> >> >> > >
> >> >> > >  clean:
> >> >> > >       rm -f $(OBJ) $(OBJ_PART) $(OBJ_ARCH) makedumpfile makedum=
pfile.8 makedumpfile.conf.5
> >> >> > > +     $(MAKE) -C extensions clean
> >> >> > >
> >> >> > >  install:
> >> >> > >       install -m 755 -d ${DESTDIR}/${SBINDIR} ${DESTDIR}/usr/sh=
are/man/man5 ${DESTDIR}/usr/share/man/man8
> >> >> > > @@ -135,3 +136,7 @@ install:
> >> >> > >       mkdir -p ${DESTDIR}/usr/share/makedumpfile/eppic_scripts
> >> >> > >       install -m 644 -D $(VPATH)makedumpfile.conf ${DESTDIR}/us=
r/share/makedumpfile/makedumpfile.conf.sample
> >> >> > >       install -m 644 -t ${DESTDIR}/usr/share/makedumpfile/eppic=
_scripts/ $(VPATH)eppic_scripts/*
> >> >> > > +
> >> >> > > +.PHONY: extensions
> >> >> > > +extensions:
> >> >> > > +     $(MAKE) -C extensions CC=3D$(CC)
> >> >> > > \ No newline at end of file
> >> >> > > diff --git a/extension.c b/extension.c
> >> >> > > new file mode 100644
> >> >> > > index 0000000..6ee7f4e
> >> >> > > --- /dev/null
> >> >> > > +++ b/extension.c
> >> >> > > @@ -0,0 +1,82 @@
> >> >> > > +#include <stdio.h>
> >> >> > > +#include <stdlib.h>
> >> >> > > +#include <string.h>
> >> >> > > +#include <dirent.h>
> >> >> > > +#include <dlfcn.h>
> >> >> > > +#include <stdbool.h>
> >> >> > > +#include "kallsyms.h"
> >> >> > > +#include "btf_info.h"
> >> >> > > +
> >> >> > > +static const char *dirs[] =3D {
> >> >> > > +     "/usr/lib64/makedumpfile/extensions",
> >> >> > > +     "./extensions",
> >> >> > > +};
> >> >> > > +
> >> >> > > +/* Will only init once */
> >> >> > > +static bool init_kallsyms_btf(void)
> >> >> > > +{
> >> >> > > +     static bool ret =3D false;
> >> >> > > +     static bool has_inited =3D false;
> >> >> > > +
> >> >> > > +     if (has_inited)
> >> >> > > +             goto out;
> >> >> > > +     if (!init_kernel_kallsyms())
> >> >> > > +             goto out;
> >> >> > > +     if (!init_kernel_btf())
> >> >> > > +             goto out;
> >> >> > > +     if (!init_module_kallsyms())
> >> >> > > +             goto out;
> >> >> > > +     if (!init_module_btf())
> >> >> > > +             goto out;
> >> >> > > +     ret =3D true;
> >> >> >
> >> >> > I feel it would be good practice to load as little information as=
 is
> >> >> > necessary for the task. If "amdgpu" module is required, then load=
 kernel
> >> >> > kallsyms, BTF, and then the amdgpu module kallsyms & BTF. If no m=
odule
> >> >> > debuginfo is required, then just the kernel would suffice.
> >> >> >
> >> >> > This would reduce memory usage and runtime, though I don't know i=
f it
> >> >> > would show up in profiling. The main benefit could be reliability=
: by
> >> >> > handling less data, there are fewer chances to hit an error.
> >> >>
> >> >> OK, I agree, mandatory kernel btf/kallsyms info + optional kernel
> >> >> module btf/kallsyms info is a reasonable design. So kernel modules'
> >> >> info can be loaded on demand.
> >> >>
> >> >> >
> >> >> > > +out:
> >> >> > > +     has_inited =3D true;
> >> >> > > +     return ret;
> >> >> > > +}
> >> >> > > +
> >> >> > > +static void cleanup_kallsyms_btf(void)
> >> >> > > +{
> >> >> > > +     cleanup_kallsyms();
> >> >> > > +     cleanup_btf();
> >> >> > > +}
> >> >> > > +
> >> >> > > +void run_extensions(void)
> >> >> > > +{
> >> >> > > +     DIR *dir;
> >> >> > > +     struct dirent *entry;
> >> >> > > +     size_t len;
> >> >> > > +     int i;
> >> >> > > +     void *handle;
> >> >> > > +     char path[512];
> >> >> > > +
> >> >> > > +     for (i =3D 0; i < sizeof(dirs) / sizeof(char *); i++) {
> >> >> > > +             if ((dir =3D opendir(dirs[i])) !=3D NULL)
> >> >> > > +                     break;
> >> >> > > +     }
> >> >> > > +
> >> >> > > +     if (!dir || i >=3D sizeof(dirs) / sizeof(char *))
> >> >> > > +             /* No extensions found */
> >> >> > > +             return;
> >> >> >
> >> >> > It could be confusing that makedumpfile would behave differently =
with
> >> >> > the same command-line arguments depending on the presence or abse=
nce of
> >> >> > these extensions on the filesystem.
> >> >> >
> >> >> > I think it may fit users' expectations better if they are require=
d to
> >> >> > specify extensions on the command line. Then we could load them b=
y
> >> >> > searching each directory in order. This allows:
> >> >> >
> >> >> > (a) more expected behavior
> >> >> > (b) multiple extensions can exist without all being enabled, thus=
 more
> >> >> >     flexibility
> >> >> > (c) extensions can be present in the local "extensions/" director=
y, or
> >> >> >     in the system directory
> >> >>
> >> >> Sure, it also sounds reasonable. My original thoughts are, user
> >> >> customization on mm filtering are specified in .so, and if user don=
't
> >> >> need one .so, e.g. amdgpu mm filtering for a nvidia machine, then h=
e
> >> >> doesn't pack the amdgpu_filter.so into kdump's initramfs. I agree
> >> >> adding extra makedumpfile cmdline option to receive those needed .s=
o
> >> >> is a better design.
> >> >>
> >> >> >
> >> >> > > +     while ((entry =3D readdir(dir)) !=3D NULL) {
> >> >> > > +             len =3D strlen(entry->d_name);
> >> >> > > +             if (len > 3 && strcmp(entry->d_name + len - 3, ".=
so") =3D=3D 0) {
> >> >> > > +                     /* Will only init when .so exist */
> >> >> > > +                     if (!init_kallsyms_btf())
> >> >> > > +                             goto out;
> >> >> > > +
> >> >> > > +                     snprintf(path, sizeof(path), "%s/%s", dir=
s[i], entry->d_name);
> >> >> > > +                     handle =3D dlopen(path, RTLD_NOW);
> >> >> > > +                     if (!handle) {
> >> >> > > +                             fprintf(stderr, "%s: Failed to lo=
ad %s: %s\n",
> >> >> > > +                                     __func__, path, dlerror()=
);
> >> >> > > +                             continue;
> >> >> > > +                     }
> >> >> > > +                     printf("Loaded extension: %s\n", path);
> >> >> > > +                     dlclose(handle);
> >> >> >
> >> >> > Using the constructor/destructor of the shared object is clever! =
But we
> >> >> > lose some flexibility: by the time the dlopen() returns, the cons=
tructor
> >> >> > has executed and the plugin has thus executed.
> >> >> >
> >> >> > What if we instead use dlsym() to load some symbols from the DSO?=
 In
> >> >> > particular, I think it would be useful if extensions could declar=
e a
> >> >> > list of symbols and a list of structure information which they ar=
e
> >> >> > interested in receiving. We could use these lists to know which
> >> >> > kernel/module kallsyms & BTF we should load. We could even load t=
he
> >> >> > information into the local variables of the extension, so the ext=
ension
> >> >> > would not need to manually load it.
> >> >> >
> >> >> > Of course this is more complex, but the benefit is:
> >> >> >
> >> >> > 1. Extensions can be written more simply, and would not need to m=
anually
> >> >> > load each symbol & type.
> >> >> > 2. We could eliminate the hash tables for kallsyms & BTF, and eli=
minate
> >> >> > the loading of unnecessary module information. Instead, we'd just
> >> >> > populate the symbol addresses, struct offsets, and type sizes dir=
ectly
> >> >> > into the local variables which request them.
> >> >>
> >> >> It is a clever idea! Though complex for code, I think it is doable.
> >> >>
> >> >> >
> >> >> > Again, while I don't want to prematurely optimize -- it's good to=
 avoid
> >> >> > loading unnecessary information. I hope I've described my idea we=
ll. I
> >> >> > would be happy to work on an implementation of it based on your p=
atches
> >> >> > here, if you're interested.
> >> >>
> >> >> Thanks again for your suggestions! I got your points and I think I =
can
> >> >> improve the code while waiting for maintainers ideas at the same ti=
me.
> >> >> I will let you know when done or encounter blockers if any.
> >> >>
> >> >> Thanks,
> >> >> Tao Liu
> >> >>
> >> >> >
> >> >> > Thanks,
> >> >> > Stephen
> >> >> >
> >> >> > > +             }
> >> >> > > +     }
> >> >> > > +out:
> >> >> > > +     closedir(dir);
> >> >> > > +     cleanup_kallsyms_btf();
> >> >> > > +}
> >> >> > > \ No newline at end of file
> >> >> > > diff --git a/extensions/Makefile b/extensions/Makefile
> >> >> > > new file mode 100644
> >> >> > > index 0000000..afbc61e
> >> >> > > --- /dev/null
> >> >> > > +++ b/extensions/Makefile
> >> >> > > @@ -0,0 +1,10 @@
> >> >> > > +CC ?=3D gcc
> >> >> > > +CONTRIB_SO :=3D
> >> >> > > +
> >> >> > > +all: $(CONTRIB_SO)
> >> >> > > +
> >> >> > > +$(CONTRIB_SO): %.so: %.c
> >> >> > > +     $(CC) -O2 -g -fPIC -shared -o $@ $^
> >> >> > > +
> >> >> > > +clean:
> >> >> > > +     rm -f $(CONTRIB_SO)
> >> >> > > diff --git a/makedumpfile.c b/makedumpfile.c
> >> >> > > index dba3628..ca8ed8a 100644
> >> >> > > --- a/makedumpfile.c
> >> >> > > +++ b/makedumpfile.c
> >> >> > > @@ -10847,6 +10847,8 @@ update_dump_level(void)
> >> >> > >       }
> >> >> > >  }
> >> >> > >
> >> >> > > +void run_extensions(void);
> >> >> > > +
> >> >> > >  int
> >> >> > >  create_dumpfile(void)
> >> >> > >  {
> >> >> > > @@ -10884,6 +10886,8 @@ retry:
> >> >> > >       if (info->flag_refiltering)
> >> >> > >               update_dump_level();
> >> >> > >
> >> >> > > +     run_extensions();
> >> >> > > +
> >> >> > >       if ((info->name_filterconfig || info->name_eppic_config)
> >> >> > >                       && !gather_filter_info())
> >> >> > >               return FALSE;
> >> >> > > --
> >> >> > > 2.47.0
> >> >> >
> >>
>


