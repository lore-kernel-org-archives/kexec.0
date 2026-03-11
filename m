Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F88112583A
	for <kexec@archiver.kernel.org>; Wed, 11 Mar 2026 14:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UgC+oDTauRxDF3jNihl5gFCU3vljF88p5sJu7+8q1FI=; b=udu5L3Ghmm2y0IqRoq4QkppajJ
	HVPanuRSL2lhJMoR2qaP+VjUg0FKSqoh6evZO1JeL5ZQIo73r8tnwxve3RVY/wZyj3qzW0/7bDyyv
	eQzgoKuxHiNFHkzqLNZcKgrQ6riKoTEEYeHSLsZao3SvRffMJDw+ZICZSmx4XFXs20ZF6Uw9Ejo1H
	evwE/ECTC022vnsQ+JhOcRQpe+wOMkXoybuMukYM/kdA6I5UVKeylCgCCBhzRnzJHdi7sHZ6ob+jJ
	EcBgciWhQWOhzeak8UCpThI4B7cY7SwUo4cmOeiyNQYPSAXTkU7FwzeC71zUcq4yKwAft0sitEAaI
	ml/8B0YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0KlE-0000000BjWU-0kgr;
	Wed, 11 Mar 2026 14:42:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0KlB-0000000BjW0-33AL
	for kexec@lists.infradead.org;
	Wed, 11 Mar 2026 14:42:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773240123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgC+oDTauRxDF3jNihl5gFCU3vljF88p5sJu7+8q1FI=;
	b=Md3qeFa4wZRTWyBu1n8AcHbc4g8BYKaDGJXYw7OXS/XZbYXPwH9E3IsPH0OdNYK+sf45EN
	aK+rO5lOR/WlRIS3kWbEn5x85OqUuTqFdrrcOMUT/r87DC51XVB8Vv58xCXZhgYOcDQRnV
	pxdJFsBBpgp6gJQJpTRFsP9WVh6IqZg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581--FGXz0TvM6WfTm0kyJJINw-1; Wed, 11 Mar 2026 10:42:01 -0400
X-MC-Unique: -FGXz0TvM6WfTm0kyJJINw-1
X-Mimecast-MFC-AGG-ID: -FGXz0TvM6WfTm0kyJJINw_1773240121
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5090cc6a7d2so281933931cf.2
        for <kexec@lists.infradead.org>; Wed, 11 Mar 2026 07:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773240121; x=1773844921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UgC+oDTauRxDF3jNihl5gFCU3vljF88p5sJu7+8q1FI=;
        b=c07QprRb5Y4P1eIw0GbCck240kvmq2+yOq7CEAmyL5mP5sPOf1RvtJ9enl3FmKgxQ2
         GYwYDUNy6X/dj8+x7pXZmXlATPRnzXXQQo/I6XkRc03enPOO5TMfVNowcExvHVrGz2DZ
         +3sPVAboTdZq3GnQeHFPqxTxf2kWjx/z7+qlcIuG3eb7iZxlha+meKOx86T8R8pj9vcD
         dMR+THCFxVLp67qr6d1H4n1XccGqRXvhK9g5KoFXXACq0yFdgUtlhWI+RaNHLZPmxOmt
         2I3a5ar0evpfVjVVVqt4i9lx4IQ/t2+W+zKP6mQZjQRkMWAJbUvuh9MqdhA0Rc/W3PA8
         jOtg==
X-Forwarded-Encrypted: i=1; AJvYcCXdqe4AmK1gdnRjfrAkhoZ4ctovolpKO3zdx4PRDGxMFjKwfmktkImU/fG1HQZMka8WlUYZvA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxLy1dA9g4jM03+HshvBk0J+NKJ66JXHVMb0FEDCcXkiOXoCFQw
	nyKHKX2TxOnEQqX3v1238QhYVlyaMEgyQQumL1Pl3wKcIitaiuxDROtSmGN3jxfY79L7GK6V2ru
	Kng7MuC9bGzPAg3+04yuLh0WEttkoCch1yozmyV2LcbBkJBcXLIfb7sn8rQoczujn9oZPvhr14F
	mo82p6OHV073nqJg/uhA1NefCPxb8bidsAeAGN
X-Gm-Gg: ATEYQzyQvEEyzEF1HteLy7s9tTknxXRUETUDzg7AghEyGmiYRBDKWrgWh15UP6ljW10
	JrOqi9QlCqsf70JNZKrcIQHuQ6lTztlwmnXk0eEMrHIJHbJWB9ESWBZMDrVY74VlMJX4uCyEubd
	AsT4D8DQO3w53TXeV7chSRR79eOWdntddCkavMEDfK1+JacPsIOMulvJ3wICac5nUGNYf3XtbPq
	cq/2Ik=
X-Received: by 2002:ac8:7f08:0:b0:509:3129:a459 with SMTP id d75a77b69052e-50939f6ffb8mr33968511cf.11.1773240120206;
        Wed, 11 Mar 2026 07:42:00 -0700 (PDT)
X-Received: by 2002:ac8:7f08:0:b0:509:3129:a459 with SMTP id
 d75a77b69052e-50939f6ffb8mr33968071cf.11.1773240119567; Wed, 11 Mar 2026
 07:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260120025500.25095-1-ltao@redhat.com> <20260120025500.25095-6-ltao@redhat.com>
 <87ikcuv5ag.fsf@oracle.com> <CAO7dBbV-o4pTkaxaiZxfWHV7WDk=3fBc_XWVEs1XNWnvqJw46A@mail.gmail.com>
 <CAO7dBbW34=+DQMZ8NyPqPtm83nr2DYfa_z0Huf=NS8bzrh053w@mail.gmail.com> <87o6kvmc8s.fsf@oracle.com>
In-Reply-To: <87o6kvmc8s.fsf@oracle.com>
From: Tao Liu <ltao@redhat.com>
Date: Thu, 12 Mar 2026 03:41:22 +1300
X-Gm-Features: AaiRm5098sfEejyWPfm8_OwesNpXXZ5h85G_RWzoBa66-ODPCZ1x0z4g3vR29JI
Message-ID: <CAO7dBbUGHCo8psJCvrfipR=7hYyGM16713ANM+6FDOjrhVNeUQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] Add makedumpfile extension support
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org, 
	aravinda@linux.vnet.ibm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HLGA5-zZjqiLfn20X16KXZ7xbH_GQMuE2cFIwreDYkk_1773240121
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260311_074205_914998_AEB3ED21 
X-CRM114-Status: GOOD (  83.58  )
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

On Wed, Mar 11, 2026 at 1:38=E2=80=AFPM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Tao Liu <ltao@redhat.com> writes:
> > Hi Stephen,
> >
> > Sorry I took some time to make modifications on v3 code. Please see a
> > drafted v4 [1] for a preview.
> >
> > I followed your suggestion to let extensions declare the kallsyms
> > symbol/btf types it needed, then during kallsyms/btf initialization,
> > it will only resolve the declared symbol/types, thus getting rid of
> > the hash table. Extensions now don't need to initial needed
> > symbols/types by itself.
> >
> > In addition, users can specify which extensions to load at
> > makedumpfile cmdline as:
> >
> > $ ./makedumpfile -d 31 -l
> > /var/crash/127.0.0.1-2025-06-10-18\:03\:12/vmcore /tmp/out --extension
> > amdgpu_filter.so
> >
> > Also "--extension" can be used several times, and amdgpu_filter.so can
> > be an absolute path as well. If no extensions are specified, the
> > btf/kallsyms of makedumpfile will not initialize.
> >
> > I don't know if this is what you wanted, or any suggestions for this?
> > Thanks in advance!
>
> Hi Tao,
>
> Please accept my apologies for the long delay on this review.  I've gone =
through
> each commit with my feedback. This looks like a really excellent job and =
I
> think it is ready for the review of the maintainers. I've implemented my =
own
> userspace stack extension on top of this support, and I find it to be gre=
at for
> my use case as well, with one small change (adding flags for detecting wh=
ether a
> struct or member is found).

No worries at all :) Thanks a lot for your detailed comments. I'm
looking through them as well as your code branch in github. This may
take a while...

>
> Here is some more detailed feedback on a per-commit level; it's all prett=
y
> minor.
>
> d3aee7a ("Reserve sections for makedumpfile and extenions")
>
> * This is just a note, but I've found that the linker script may not be
>   necessary. GCC automatically creates the __start_SECTION and __stop_SEC=
TION
>   symbols for sections it creates.

I have tried to remove the makedumpfile.ld linker script. The
automatic symbol as __start/stop_SECTION are only generated for
makedumpfile, aka the main program, but not for .so extensions. This
is a breaker because I would expect all .so files have the
__start/stop_SECTION symbol so they can be resigtered to main program.
I'm not expert in GCC's default behaviours, so I guess I would prefer
the current approach of explicit symbol define within the linker
script, seems to be more robust...  Perhaps you can share your code on
this, I will give it a try.

> * Otherwise, this is exactly what I was thinking!
>
> 102ae0b ("Implement kernel kallsyms resolving")
>
> * Again, this is looking very close to the design I hoped for, thanks!
> * I'm not sure whether is_unwanted_symbol() needs to exist anymore?  Give=
n that
>   users opt-in to specific symbols, we don't need to filter out noisy one=
s that
>   would waste memory. What do you think?

Agreed, I can remove this function.

> * Unfortunately, upstream has made some changes to the vmlinux kallsyms e=
ncoding
>   in 7.0. You may want to check what we did in drgn to support those chan=
ges:
>   https://github.com/osandov/drgn/commit/744f36ec3c3f64d7e1323a0037898158=
698585c4
> * In kallsyms.c:

Thanks for the info, I will try this and update the code in v4.

>
>   +/*
>   + * Makedumpfile's .init_ksyms section
>   +*/
>   +extern struct ksym_info __start_init_ksyms[];
>   +extern struct ksym_info __stop_init_ksyms[];
>
>   I'm not sure it matters, but the type here is wrong. It should be
>   "extern struct ksym_info *" because you're storing pointers, not the ac=
tual
>   struct. That said, the type isn't used so I don't know that it matters.

Right, this is an error. Thanks for pointing that out.

>
> 4187b33 ("Implement kernel btf resolving")
>
> * The get_ktype_info() function fails if either the struct or member is n=
ot
>   found. This makes sense in a lot of cases, but there are other cases wh=
ere we
>   will want to use the presence or absence of a struct/struct member to d=
etect
>   which version of code to use. For example, my userspace stack code will=
 use
>   either maple or rbtree helper code for finding stack VMAs, depending on=
 which
>   is available. We can't know until runtime, when we check whether mm_rb =
or
>   mm_mt is present.
>
>   One solution is to handle this at runtime. We can have a macro like
>   "HAVE_MEMBER(S, M)" and "HAVE_STRUCT(S)", and then each extension can c=
heck
>   whether for the members it expects to be present. I think the major dow=
nside
>   to this approach is that it requires manual effort, which is likely to =
be
>   forgotten when writing extensions.
>
>   Alternatively, we could set a flag in the struct ktype_info if the type=
 is
>   "required" (or optional), and only fail get_ktype_info() for required

Agreed, an optional flag looks better.

>   structs/members. The concern with this approach is: what if plugin (A)
>   requires a type which is not present, but plugin (B) does not? If both =
are
>   loaded, the failure of A would cause B not to run. I'm not sure whether=
 we
>   should care about that situation... I don't know if we have a use case =
for
>   using multiple plugins at the same time. Until we do, we probably won't=
 have a
>   good idea whether it should be allowed for one to fail, but the other t=
o
>   continue.

Great question! I have thought about this previously. I suggest that
if plugin(A) fails, it should just fail and allow the execution of any
later plugins (B, C....) to continue. Each plugin is responsible for
one task, like plugin(A) for dealing with amdgpu's mm page
filtering,and plugin(B) for Intel's and plugin(C) for NV's. Plugin(A)
certainly will fail if one machine have no amdgpu, thus the amdgpu.ko
will never been loaded, so related symbol/types missing. This is
expected and shouldn't block the later plugins.

But the "fail" should gentle, not like the ones as segfault, which
will crash the entire makedumpfile program. Since currently plugins
are native .so libraries, the quality of code is ensured by each
plugin authors, rather than makedumpfile maintainers. Idealy the the
plugins are well tested in 1st kernel before they are shipped to kdump
img, but who knows. From makedumpfile's view, do you think we need to
introduce a sandbox to isolate plugins from makedumpfile? This would
prevent serious plugin errors from stopping makedumpfile from
generating the vmcore.

>
>   I've implemented this second alternative in my branch.
>
> * Similar to the previous commit, __start_init_ktypes and __stop_init_kty=
pes are
>   declared as structs but should probably be declared as pointers.
>
> 22097b7 ("Implement kernel module's kallsyms resolving")
> edfa698 ("Implement kernel module's btf resolving")
>
> * These commits are straightforward:
>   Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>
> ede22e8 ("Add makedumpfile extensions support")

I will address those later after reading through your code branch.
Thanks again for your detailed comments!

Thanks,
Tao Liu

>
> * nit: the array "handlers" actually contains "handles" (no r) returned f=
rom
>   dlopen(). The word handlers usually implies a function pointer or somet=
hing
>   like that, called to handle a certain situation. Maybe rename this to
>   "handles".
> * The run_extensions() function is called within a retry loop in
>   create_dumpfile(). It seems possible that this could get called multipl=
e
>   times. But many of the global variables in the kallsyms, BTF, and exten=
sion
>   code are not safe to be cleaned up and reinitialized. In particular, wh=
en
>   array elements are freed, the lengths, capacities, and pointers are not=
 reset
>   to 0/NULL. I think it would be wise to make all the cleanup functions c=
lear
>   the globals, so that they may be reinitialized safely.
> * Further, I think it might be helpful to split extension loading, runnin=
g, and
>   cleanup. Something like this in create_dumpfile():
>
>         load_extensions(); /* loads everything and calls entry() */
>     retry:
>         /* ... create bitmap and dump ... */
>         if (status =3D=3D NOSPACE) {
>             /* ... */
>             goto retry;
>         }
>         /* ... */
>         cleanup_extensions();
>         return;
>
>   For two reasons: (1) this avoids unnecessary work re-loading and
>   re-initializing the BTF, kallsyms, and extensions. (Though I still thin=
k it's
>   safer to ensure they can be re-initialized safely.) And (2), this allow=
s for
>   future use of extensions in the rest of the dump operation. For my user=
space
>   stack extension, I plan to add a callback which allows extensions to ov=
erride
>   the decision to filter a page, since my logic can't be easily done via =
erase
>   info. So the extensions need to remain loaded during the creation of th=
e
>   dumpfile, and cleaned up after. I have tweaked this in my own patches,
>   but I just wanted to share the use case.
>
> c568635 ("btf/kallsyms based makedumpfile extension for mm page filtering=
")
>
> * This looks good to me!
> * I will say that for my userspace stack use case, while the "filter_page=
(...,
>   false)" mechanism for specifying pages that are retained *looks* useful=
, I
>   wouldn't be able to use it because I cannot determine the PFNs for each=
 stack
>   VMA. Instead, I have to use the page "mapping" and "index" fields to ma=
tch the
>   VMA and determine whether the PFN falls in a range I care to save. Of c=
ourse,
>   just because *I* won't use it doesn't mean it's not useful :)
>
> 2b252ec ("Filter amdgpu mm pages")
>
> * I'm no expert in amdgpu, but the overall approach makes sense to me, an=
d the
>   helpers look good.
>
>
> At a broader level, while the add_to_arr() function is useful, I do think=
 the
> dynamic array/vector pattern could be captured with a dedicated data stru=
cture.
> For instance, drgn has this excellent LGPL-2.1+ header-only vector librar=
y:
> https://github.com/osandov/drgn/blob/main/libdrgn/vector.h
> I don't think it is high priority or must be addressed. Nor do I mean tha=
t this
> particular implementation choice be used. It's just something to share & =
think
> about.
>
> To provide some context on my comments related to the userspace stack tra=
cing,
> here is a branch of mine which is based on yours, that adds my userspace =
stack
> extension and a few tweaks:
>
> https://github.com/brenns10/makedumpfile/commits/stepbren_userstack_v4/
>
> Thank you,
> Stephen
>
> > Thanks,
> > Tao Liu
> >
> >
> >
> >
> >
> >
> >
> > [1]: https://github.com/liutgnu/makedumpfile/commits/v4/
> >
> > On Fri, Jan 23, 2026 at 2:43=E2=80=AFAM Tao Liu <ltao@redhat.com> wrote=
:
> >>
> >> Hi Stephen,
> >>
> >> Thanks a lot for your quick reply and detailed information, I really
> >> appreciate it!
> >>
> >> On Thu, Jan 22, 2026 at 1:51=E2=80=AFPM Stephen Brennan
> >> <stephen.s.brennan@oracle.com> wrote:
> >> >
> >> > Hi Tao,
> >> >
> >> > This series looks really great -- I'm excited to see the switch to
> >> > native .so extensions instead of epicc. I've applied the series loca=
lly
> >> > and I'll rebuild my userspace stack inclusion feature based on it, t=
o
> >> > try it out myself.
> >>
> >> Awesome, looking forward to your feedback on the code/API designs etc.=
..
> >>
> >> >
> >> > In the meantime, I'll share some of my feedback on the patches (thou=
gh
> >> > I'm not a makedumpfile developer). This seems like the most importan=
t
> >> > patch in terms of design, so I'll start here.
> >> >
> >> > Tao Liu <ltao@redhat.com> writes:
> >> > > This patch will add .so extension support to makedumpfile, similar=
 to crash
> >> > > extension to crash utility. Currently only "/usr/lib64/makedumpfil=
e/extensions"
> >> > > and "./extensions" are searched for extensions. Once found, kallsy=
ms and btf
> >> > > will be initialized so all extensions can benifit from it (Current=
ly makedumpfile
> >> > > doesn't use these info, we can move the kallsyms/btf init code els=
e where later
> >> > > if makedumpfile needs them).
> >> > >
> >> > > The makedumpfile extension is to help users to customize mm page f=
iltering upon
> >> > > traditional mm page flag filtering, without make code modification=
 on makedumpfile
> >> > > itself.
> >> > >
> >> > > Signed-off-by: Tao Liu <ltao@redhat.com>
> >> > > ---
> >> > >  Makefile            |  7 +++-
> >> > >  extension.c         | 82 ++++++++++++++++++++++++++++++++++++++++=
+++++
> >> > >  extensions/Makefile | 10 ++++++
> >> > >  makedumpfile.c      |  4 +++
> >> > >  4 files changed, 102 insertions(+), 1 deletion(-)
> >> > >  create mode 100644 extension.c
> >> > >  create mode 100644 extensions/Makefile
> >> > >
> >> > > diff --git a/Makefile b/Makefile
> >> > > index f3f4da8..7e29220 100644
> >> > > --- a/Makefile
> >> > > +++ b/Makefile
> >> > > @@ -45,7 +45,7 @@ CFLAGS_ARCH +=3D -m32
> >> > >  endif
> >> > >
> >> > >  SRC_BASE =3D makedumpfile.c makedumpfile.h diskdump_mod.h sadump_=
mod.h sadump_info.h
> >> > > -SRC_PART =3D print_info.c dwarf_info.c elf_info.c erase_info.c sa=
dump_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c btf_info.c
> >> > > +SRC_PART =3D print_info.c dwarf_info.c elf_info.c erase_info.c sa=
dump_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c btf_info.c e=
xtension.c
> >> > >  OBJ_PART=3D$(patsubst %.c,%.o,$(SRC_PART))
> >> > >  SRC_ARCH =3D arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arc=
h/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c =
arch/loongarch64.c arch/riscv64.c
> >> > >  OBJ_ARCH=3D$(patsubst %.c,%.o,$(SRC_ARCH))
> >> > > @@ -126,6 +126,7 @@ eppic_makedumpfile.so: extension_eppic.c
> >> > >
> >> > >  clean:
> >> > >       rm -f $(OBJ) $(OBJ_PART) $(OBJ_ARCH) makedumpfile makedumpfi=
le.8 makedumpfile.conf.5
> >> > > +     $(MAKE) -C extensions clean
> >> > >
> >> > >  install:
> >> > >       install -m 755 -d ${DESTDIR}/${SBINDIR} ${DESTDIR}/usr/share=
/man/man5 ${DESTDIR}/usr/share/man/man8
> >> > > @@ -135,3 +136,7 @@ install:
> >> > >       mkdir -p ${DESTDIR}/usr/share/makedumpfile/eppic_scripts
> >> > >       install -m 644 -D $(VPATH)makedumpfile.conf ${DESTDIR}/usr/s=
hare/makedumpfile/makedumpfile.conf.sample
> >> > >       install -m 644 -t ${DESTDIR}/usr/share/makedumpfile/eppic_sc=
ripts/ $(VPATH)eppic_scripts/*
> >> > > +
> >> > > +.PHONY: extensions
> >> > > +extensions:
> >> > > +     $(MAKE) -C extensions CC=3D$(CC)
> >> > > \ No newline at end of file
> >> > > diff --git a/extension.c b/extension.c
> >> > > new file mode 100644
> >> > > index 0000000..6ee7f4e
> >> > > --- /dev/null
> >> > > +++ b/extension.c
> >> > > @@ -0,0 +1,82 @@
> >> > > +#include <stdio.h>
> >> > > +#include <stdlib.h>
> >> > > +#include <string.h>
> >> > > +#include <dirent.h>
> >> > > +#include <dlfcn.h>
> >> > > +#include <stdbool.h>
> >> > > +#include "kallsyms.h"
> >> > > +#include "btf_info.h"
> >> > > +
> >> > > +static const char *dirs[] =3D {
> >> > > +     "/usr/lib64/makedumpfile/extensions",
> >> > > +     "./extensions",
> >> > > +};
> >> > > +
> >> > > +/* Will only init once */
> >> > > +static bool init_kallsyms_btf(void)
> >> > > +{
> >> > > +     static bool ret =3D false;
> >> > > +     static bool has_inited =3D false;
> >> > > +
> >> > > +     if (has_inited)
> >> > > +             goto out;
> >> > > +     if (!init_kernel_kallsyms())
> >> > > +             goto out;
> >> > > +     if (!init_kernel_btf())
> >> > > +             goto out;
> >> > > +     if (!init_module_kallsyms())
> >> > > +             goto out;
> >> > > +     if (!init_module_btf())
> >> > > +             goto out;
> >> > > +     ret =3D true;
> >> >
> >> > I feel it would be good practice to load as little information as is
> >> > necessary for the task. If "amdgpu" module is required, then load ke=
rnel
> >> > kallsyms, BTF, and then the amdgpu module kallsyms & BTF. If no modu=
le
> >> > debuginfo is required, then just the kernel would suffice.
> >> >
> >> > This would reduce memory usage and runtime, though I don't know if i=
t
> >> > would show up in profiling. The main benefit could be reliability: b=
y
> >> > handling less data, there are fewer chances to hit an error.
> >>
> >> OK, I agree, mandatory kernel btf/kallsyms info + optional kernel
> >> module btf/kallsyms info is a reasonable design. So kernel modules'
> >> info can be loaded on demand.
> >>
> >> >
> >> > > +out:
> >> > > +     has_inited =3D true;
> >> > > +     return ret;
> >> > > +}
> >> > > +
> >> > > +static void cleanup_kallsyms_btf(void)
> >> > > +{
> >> > > +     cleanup_kallsyms();
> >> > > +     cleanup_btf();
> >> > > +}
> >> > > +
> >> > > +void run_extensions(void)
> >> > > +{
> >> > > +     DIR *dir;
> >> > > +     struct dirent *entry;
> >> > > +     size_t len;
> >> > > +     int i;
> >> > > +     void *handle;
> >> > > +     char path[512];
> >> > > +
> >> > > +     for (i =3D 0; i < sizeof(dirs) / sizeof(char *); i++) {
> >> > > +             if ((dir =3D opendir(dirs[i])) !=3D NULL)
> >> > > +                     break;
> >> > > +     }
> >> > > +
> >> > > +     if (!dir || i >=3D sizeof(dirs) / sizeof(char *))
> >> > > +             /* No extensions found */
> >> > > +             return;
> >> >
> >> > It could be confusing that makedumpfile would behave differently wit=
h
> >> > the same command-line arguments depending on the presence or absence=
 of
> >> > these extensions on the filesystem.
> >> >
> >> > I think it may fit users' expectations better if they are required t=
o
> >> > specify extensions on the command line. Then we could load them by
> >> > searching each directory in order. This allows:
> >> >
> >> > (a) more expected behavior
> >> > (b) multiple extensions can exist without all being enabled, thus mo=
re
> >> >     flexibility
> >> > (c) extensions can be present in the local "extensions/" directory, =
or
> >> >     in the system directory
> >>
> >> Sure, it also sounds reasonable. My original thoughts are, user
> >> customization on mm filtering are specified in .so, and if user don't
> >> need one .so, e.g. amdgpu mm filtering for a nvidia machine, then he
> >> doesn't pack the amdgpu_filter.so into kdump's initramfs. I agree
> >> adding extra makedumpfile cmdline option to receive those needed .so
> >> is a better design.
> >>
> >> >
> >> > > +     while ((entry =3D readdir(dir)) !=3D NULL) {
> >> > > +             len =3D strlen(entry->d_name);
> >> > > +             if (len > 3 && strcmp(entry->d_name + len - 3, ".so"=
) =3D=3D 0) {
> >> > > +                     /* Will only init when .so exist */
> >> > > +                     if (!init_kallsyms_btf())
> >> > > +                             goto out;
> >> > > +
> >> > > +                     snprintf(path, sizeof(path), "%s/%s", dirs[i=
], entry->d_name);
> >> > > +                     handle =3D dlopen(path, RTLD_NOW);
> >> > > +                     if (!handle) {
> >> > > +                             fprintf(stderr, "%s: Failed to load =
%s: %s\n",
> >> > > +                                     __func__, path, dlerror());
> >> > > +                             continue;
> >> > > +                     }
> >> > > +                     printf("Loaded extension: %s\n", path);
> >> > > +                     dlclose(handle);
> >> >
> >> > Using the constructor/destructor of the shared object is clever! But=
 we
> >> > lose some flexibility: by the time the dlopen() returns, the constru=
ctor
> >> > has executed and the plugin has thus executed.
> >> >
> >> > What if we instead use dlsym() to load some symbols from the DSO? In
> >> > particular, I think it would be useful if extensions could declare a
> >> > list of symbols and a list of structure information which they are
> >> > interested in receiving. We could use these lists to know which
> >> > kernel/module kallsyms & BTF we should load. We could even load the
> >> > information into the local variables of the extension, so the extens=
ion
> >> > would not need to manually load it.
> >> >
> >> > Of course this is more complex, but the benefit is:
> >> >
> >> > 1. Extensions can be written more simply, and would not need to manu=
ally
> >> > load each symbol & type.
> >> > 2. We could eliminate the hash tables for kallsyms & BTF, and elimin=
ate
> >> > the loading of unnecessary module information. Instead, we'd just
> >> > populate the symbol addresses, struct offsets, and type sizes direct=
ly
> >> > into the local variables which request them.
> >>
> >> It is a clever idea! Though complex for code, I think it is doable.
> >>
> >> >
> >> > Again, while I don't want to prematurely optimize -- it's good to av=
oid
> >> > loading unnecessary information. I hope I've described my idea well.=
 I
> >> > would be happy to work on an implementation of it based on your patc=
hes
> >> > here, if you're interested.
> >>
> >> Thanks again for your suggestions! I got your points and I think I can
> >> improve the code while waiting for maintainers ideas at the same time.
> >> I will let you know when done or encounter blockers if any.
> >>
> >> Thanks,
> >> Tao Liu
> >>
> >> >
> >> > Thanks,
> >> > Stephen
> >> >
> >> > > +             }
> >> > > +     }
> >> > > +out:
> >> > > +     closedir(dir);
> >> > > +     cleanup_kallsyms_btf();
> >> > > +}
> >> > > \ No newline at end of file
> >> > > diff --git a/extensions/Makefile b/extensions/Makefile
> >> > > new file mode 100644
> >> > > index 0000000..afbc61e
> >> > > --- /dev/null
> >> > > +++ b/extensions/Makefile
> >> > > @@ -0,0 +1,10 @@
> >> > > +CC ?=3D gcc
> >> > > +CONTRIB_SO :=3D
> >> > > +
> >> > > +all: $(CONTRIB_SO)
> >> > > +
> >> > > +$(CONTRIB_SO): %.so: %.c
> >> > > +     $(CC) -O2 -g -fPIC -shared -o $@ $^
> >> > > +
> >> > > +clean:
> >> > > +     rm -f $(CONTRIB_SO)
> >> > > diff --git a/makedumpfile.c b/makedumpfile.c
> >> > > index dba3628..ca8ed8a 100644
> >> > > --- a/makedumpfile.c
> >> > > +++ b/makedumpfile.c
> >> > > @@ -10847,6 +10847,8 @@ update_dump_level(void)
> >> > >       }
> >> > >  }
> >> > >
> >> > > +void run_extensions(void);
> >> > > +
> >> > >  int
> >> > >  create_dumpfile(void)
> >> > >  {
> >> > > @@ -10884,6 +10886,8 @@ retry:
> >> > >       if (info->flag_refiltering)
> >> > >               update_dump_level();
> >> > >
> >> > > +     run_extensions();
> >> > > +
> >> > >       if ((info->name_filterconfig || info->name_eppic_config)
> >> > >                       && !gather_filter_info())
> >> > >               return FALSE;
> >> > > --
> >> > > 2.47.0
> >> >
>


