Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qw0-f49.google.com ([209.85.216.49])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OZe9y-0002wT-GB
	for kexec@lists.infradead.org; Fri, 16 Jul 2010 06:12:35 +0000
Received: by qwe4 with SMTP id 4so595500qwe.36
	for <kexec@lists.infradead.org>; Thu, 15 Jul 2010 23:12:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100713025819.GA23313@verge.net.au>
References: <AANLkTin0h-QftwCqLl0Yn7pi_JWlewC_VWSl01IPPwp-@mail.gmail.com>
	<1278948593.9525.3.camel@localhost>
	<20100713025819.GA23313@verge.net.au>
Date: Fri, 16 Jul 2010 11:42:32 +0530
Message-ID: <AANLkTimEjIx1lh7YJHg7-WeKZYNFYve73vl8k_C5KvAR@mail.gmail.com>
Subject: Re: kexec for powerpc mpc83xx processors
From: krish <radhakrishna.p@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0309336304=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Matthew McClintock <msm@freescale.com>, kexec@lists.infradead.org

--===============0309336304==
Content-Type: multipart/alternative; boundary=00c09f9b0939bb0684048b7b1a12

--00c09f9b0939bb0684048b7b1a12
Content-Type: text/plain; charset=ISO-8859-1

Thanks for the announcement of new release.

I have successfully compiled for mpc83xx, but execution was failed with
following message
"Symbol: mem_size found cannot set".

The root cause behind it was that pul_stack and mem_size symbols are not
defined in purgatory/arch/ppc/purgatory-ppc.c file.
Correct me if i am wrong.

As i am new to git, I am going through the git user manual to sync with the
latest sources and if possible to provide code changes in patch-format..


On Tue, Jul 13, 2010 at 8:28 AM, Simon Horman <horms@verge.net.au> wrote:

> On Mon, Jul 12, 2010 at 10:29:53AM -0500, Matthew McClintock wrote:
> > On Mon, 2010-07-12 at 11:52 +0530, krish wrote:
> > > I have changed subject to "mpc83xx" instead "mpc85xx", and continue
> > > compile error in this email.
> > > I will post new request for "support of kexec for mpc85xx", if
> > > required.
> >
> > No this is fine, I'm just trying to make sure I understand exactly what
> > you are doing.
> >
> > >
> > > "Makefile.libfdt" file is not present in the package.
> > >
> > > I have used following link to download package.
> > >
> http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/testing/kexec-tools-2.0.2-rc1.tar.gz
> >
> > It looks like this package is missing stuff. My only advice here is to
> > use git instead. I just tested GIT HEAD and the file is included and the
> > complication works. Can you give that a shot?
>
> Sorry about that, I have resolved this problem by including the
> following change in 2.0.2-rc2.
>
>
> http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/testing/kexec-tools-2.0.2-rc2.tar.gz
>
> From 04b22ab9dda7e73064c9b20cf08308473a7b0951 Mon Sep 17 00:00:00 2001
> From: Simon Horman <horms@verge.net.au>
> Date: Tue, 13 Jul 2010 11:32:16 +0900
> Subject: [PATCH] build: Include missing files in tarball
>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
>  include/Makefile                      |    1 +
>  kexec/arch/arm/Makefile               |    4 ++--
>  kexec/arch/ppc/Makefile               |    5 ++++-
>  kexec/arch/ppc/libfdt/Makefile.libfdt |    5 +++++
>  kexec/arch/x86_64/Makefile            |    2 +-
>  purgatory/arch/ppc64/Makefile         |    1 +
>  6 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/include/Makefile b/include/Makefile
> index 12c1030..c26b503 100644
> --- a/include/Makefile
> +++ b/include/Makefile
> @@ -1,6 +1,7 @@
>  dist += include/Makefile               \
>        include/config.h                \
>        include/config.h.in             \
> +       include/kexec-uImage.h          \
>        include/x86/x86-linux.h         \
>        include/x86/mb_info.h           \
>        include/x86/mb_header.h         \
> diff --git a/kexec/arch/arm/Makefile b/kexec/arch/arm/Makefile
> index 7419621..3d07e59 100644
> --- a/kexec/arch/arm/Makefile
> +++ b/kexec/arch/arm/Makefile
> @@ -10,6 +10,6 @@ arm_KEXEC_SRCS+= kexec/kexec-uImage.c
>
>  arm_PHYS_TO_VIRT = kexec/arch/arm/phys_to_virt.c
>
> -dist += kexec/arch/arm/Makefile $(arm_KEXEC_SRCS)                      \
> -       kexec/arch/arm/kexec-arm.h                                      \
> +dist += kexec/arch/arm/Makefile $(arm_KEXEC_SRCS) $(arm_PHYS_TO_VIRT)  \
> +       kexec/arch/arm/crashdump-arm.h kexec/arch/arm/kexec-arm.h       \
>        kexec/arch/arm/include/arch/options.h
> diff --git a/kexec/arch/ppc/Makefile b/kexec/arch/ppc/Makefile
> index 5988213..d4f04ec 100644
> --- a/kexec/arch/ppc/Makefile
> +++ b/kexec/arch/ppc/Makefile
> @@ -23,5 +23,8 @@ CPPFLAGS+=-I$(srcdir)/kexec/arch/$(ARCH)/libfdt
>  ppc_KEXEC_SRCS += $(libfdt_SRCS)
>
>  dist += kexec/arch/ppc/Makefile $(ppc_KEXEC_SRCS)                      \
> -       kexec/arch/ppc/kexec-ppc.h kexec/arch/ppc/ppc_asm.h             \
> +       kexec/arch/ppc/crashdump-powerpc.h kexec/arch/ppc/fixup_dtb.h   \
> +       kexec/arch/ppc/kexec-ppc.h kexec/arch/ppc/ops.h                 \
> +       kexec/arch/ppc/ppc_asm.h                                        \
> +       kexec/arch/ppc/include/page.h kexec/arch/ppc/include/types.h    \
>        kexec/arch/ppc/include/arch/options.h
> diff --git a/kexec/arch/ppc/libfdt/Makefile.libfdt
> b/kexec/arch/ppc/libfdt/Makefile.libfdt
> index 6c42acf..1d1b295 100644
> --- a/kexec/arch/ppc/libfdt/Makefile.libfdt
> +++ b/kexec/arch/ppc/libfdt/Makefile.libfdt
> @@ -6,3 +6,8 @@
>  LIBFDT_INCLUDES = fdt.h libfdt.h
>  LIBFDT_SRCS = fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c
>  LIBFDT_OBJS = $(LIBFDT_SRCS:%.c=%.o)
> +
> +dist += kexec/arch/ppc/libfdt/Makefile.libfdt                          \
> +       kexec/arch/ppc/libfdt/fdt.h kexec/arch/ppc/libfdt/libfdt.h      \
> +       kexec/arch/ppc/libfdt/libfdt_env.h                              \
> +       kexec/arch/ppc/libfdt/libfdt_internal.h
> diff --git a/kexec/arch/x86_64/Makefile b/kexec/arch/x86_64/Makefile
> index e6a8d35..0f35a46 100644
> --- a/kexec/arch/x86_64/Makefile
> +++ b/kexec/arch/x86_64/Makefile
> @@ -15,6 +15,6 @@ x86_64_KEXEC_SRCS +=
> kexec/arch/x86_64/kexec-elf-rel-x86_64.c
>
>  x86_64_ARCH_INIT = kexec/arch/x86_64/arch_init.c
>
> -dist += kexec/arch/x86_64/Makefile $(x86_64_KEXEC_SRCS)
>      \
> +dist += kexec/arch/x86_64/Makefile $(x86_64_KEXEC_SRCS)
> $(x86_64_ARCH_INIT) \
>        kexec/arch/x86_64/kexec-x86_64.h
> kexec/arch/x86_64/crashdump-x86_64.h \
>        kexec/arch/x86_64/include/arch/options.h
> diff --git a/purgatory/arch/ppc64/Makefile b/purgatory/arch/ppc64/Makefile
> index 40a9e99..dc9c12e 100644
> --- a/purgatory/arch/ppc64/Makefile
> +++ b/purgatory/arch/ppc64/Makefile
> @@ -13,4 +13,5 @@ ppc64_PURGATORY_EXTRA_ASFLAGS += -m64 -mcall-aixdesc
>  ppc64_PURGATORY_EXTRA_LDFLAGS += -melf64ppc
>
>  dist += purgatory/arch/ppc64/Makefile $(ppc64_PURGATORY_SRCS)          \
> +       purgatory/arch/ppc64/hvCall.h                                   \
>        purgatory/arch/ppc64/purgatory-ppc64.h
> --
> 1.7.1
>
>

--00c09f9b0939bb0684048b7b1a12
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for the announcement of new release.<br><br>I have successfully comp=
iled for mpc83xx, but execution was failed with following message<br>&quot;=
Symbol: mem_size found cannot set&quot;.<br><br>The root cause behind it wa=
s that pul_stack and mem_size symbols are not defined in purgatory/arch/ppc=
/purgatory-ppc.c file.<br>
Correct me if i am wrong.<br><br>As i am new to git, I am going through the=
 git user manual to sync with the latest sources and if possible to provide=
 code changes in patch-format..<br><br><br><div class=3D"gmail_quote">On Tu=
e, Jul 13, 2010 at 8:28 AM, Simon Horman <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:horms@verge.net.au">horms@verge.net.au</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><=
div class=3D"h5">On Mon, Jul 12, 2010 at 10:29:53AM -0500, Matthew McClinto=
ck wrote:<br>

&gt; On Mon, 2010-07-12 at 11:52 +0530, krish wrote:<br>
&gt; &gt; I have changed subject to &quot;mpc83xx&quot; instead &quot;mpc85=
xx&quot;, and continue<br>
&gt; &gt; compile error in this email.<br>
&gt; &gt; I will post new request for &quot;support of kexec for mpc85xx&qu=
ot;, if<br>
&gt; &gt; required.<br>
&gt;<br>
&gt; No this is fine, I&#39;m just trying to make sure I understand exactly=
 what<br>
&gt; you are doing.<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; &quot;Makefile.libfdt&quot; file is not present in the package.<b=
r>
&gt; &gt;<br>
&gt; &gt; I have used following link to download package.<br>
&gt; &gt; <a href=3D"http://www.kernel.org/pub/linux/kernel/people/horms/ke=
xec-tools/testing/kexec-tools-2.0.2-rc1.tar.gz" target=3D"_blank">http://ww=
w.kernel.org/pub/linux/kernel/people/horms/kexec-tools/testing/kexec-tools-=
2.0.2-rc1.tar.gz</a><br>

&gt;<br>
&gt; It looks like this package is missing stuff. My only advice here is to=
<br>
&gt; use git instead. I just tested GIT HEAD and the file is included and t=
he<br>
&gt; complication works. Can you give that a shot?<br>
<br>
</div></div>Sorry about that, I have resolved this problem by including the=
<br>
following change in 2.0.2-rc2.<br>
<br>
<a href=3D"http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/=
testing/kexec-tools-2.0.2-rc2.tar.gz" target=3D"_blank">http://www.kernel.o=
rg/pub/linux/kernel/people/horms/kexec-tools/testing/kexec-tools-2.0.2-rc2.=
tar.gz</a><br>

<br>
From 04b22ab9dda7e73064c9b20cf08308473a7b0951 Mon Sep 17 00:00:00 2001<br>
From: Simon Horman &lt;<a href=3D"mailto:horms@verge.net.au">horms@verge.ne=
t.au</a>&gt;<br>
Date: Tue, 13 Jul 2010 11:32:16 +0900<br>
Subject: [PATCH] build: Include missing files in tarball<br>
<div class=3D"im"><br>
Signed-off-by: Simon Horman &lt;<a href=3D"mailto:horms@verge.net.au">horms=
@verge.net.au</a>&gt;<br>
</div>---<br>
=A0include/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +=
<br>
=A0kexec/arch/arm/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A04 ++--<br>
=A0kexec/arch/ppc/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A05 ++++-<br>
=A0kexec/arch/ppc/libfdt/Makefile.libfdt | =A0 =A05 +++++<br>
=A0kexec/arch/x86_64/Makefile =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-<br>
=A0purgatory/arch/ppc64/Makefile =A0 =A0 =A0 =A0 | =A0 =A01 +<br>
=A06 files changed, 14 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/include/Makefile b/include/Makefile<br>
index 12c1030..c26b503 100644<br>
--- a/include/Makefile<br>
+++ b/include/Makefile<br>
@@ -1,6 +1,7 @@<br>
=A0dist +=3D include/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
 =A0 =A0 =A0 =A0include/config.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
 =A0 =A0 =A0 =A0include/<a href=3D"http://config.h.in" target=3D"_blank">co=
nfig.h.in</a> =A0 =A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 include/kexec-uImage.h =A0 =A0 =A0 =A0 =A0\<br>
 =A0 =A0 =A0 =A0include/x86/x86-linux.h =A0 =A0 =A0 =A0 \<br>
 =A0 =A0 =A0 =A0include/x86/mb_info.h =A0 =A0 =A0 =A0 =A0 \<br>
 =A0 =A0 =A0 =A0include/x86/mb_header.h =A0 =A0 =A0 =A0 \<br>
diff --git a/kexec/arch/arm/Makefile b/kexec/arch/arm/Makefile<br>
index 7419621..3d07e59 100644<br>
--- a/kexec/arch/arm/Makefile<br>
+++ b/kexec/arch/arm/Makefile<br>
@@ -10,6 +10,6 @@ arm_KEXEC_SRCS+=3D kexec/kexec-uImage.c<br>
<br>
=A0arm_PHYS_TO_VIRT =3D kexec/arch/arm/phys_to_virt.c<br>
<br>
-dist +=3D kexec/arch/arm/Makefile $(arm_KEXEC_SRCS) =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0\<br>
- =A0 =A0 =A0 kexec/arch/arm/kexec-arm.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+dist +=3D kexec/arch/arm/Makefile $(arm_KEXEC_SRCS) $(arm_PHYS_TO_VIRT) =
=A0\<br>
+ =A0 =A0 =A0 kexec/arch/arm/crashdump-arm.h kexec/arch/arm/kexec-arm.h =A0=
 =A0 =A0 \<br>
 =A0 =A0 =A0 =A0kexec/arch/arm/include/arch/options.h<br>
diff --git a/kexec/arch/ppc/Makefile b/kexec/arch/ppc/Makefile<br>
index 5988213..d4f04ec 100644<br>
--- a/kexec/arch/ppc/Makefile<br>
+++ b/kexec/arch/ppc/Makefile<br>
@@ -23,5 +23,8 @@ CPPFLAGS+=3D-I$(srcdir)/kexec/arch/$(ARCH)/libfdt<br>
=A0ppc_KEXEC_SRCS +=3D $(libfdt_SRCS)<br>
<br>
=A0dist +=3D kexec/arch/ppc/Makefile $(ppc_KEXEC_SRCS) =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0\<br>
- =A0 =A0 =A0 kexec/arch/ppc/kexec-ppc.h kexec/arch/ppc/ppc_asm.h =A0 =A0 =
=A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 kexec/arch/ppc/crashdump-powerpc.h kexec/arch/ppc/fixup_dtb.h=
 =A0 \<br>
+ =A0 =A0 =A0 kexec/arch/ppc/kexec-ppc.h kexec/arch/ppc/ops.h =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 \<br>
+ =A0 =A0 =A0 kexec/arch/ppc/ppc_asm.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 kexec/arch/ppc/include/page.h kexec/arch/ppc/include/types.h =
=A0 =A0\<br>
 =A0 =A0 =A0 =A0kexec/arch/ppc/include/arch/options.h<br>
diff --git a/kexec/arch/ppc/libfdt/Makefile.libfdt b/kexec/arch/ppc/libfdt/=
Makefile.libfdt<br>
index 6c42acf..1d1b295 100644<br>
--- a/kexec/arch/ppc/libfdt/Makefile.libfdt<br>
+++ b/kexec/arch/ppc/libfdt/Makefile.libfdt<br>
@@ -6,3 +6,8 @@<br>
=A0LIBFDT_INCLUDES =3D fdt.h libfdt.h<br>
=A0LIBFDT_SRCS =3D fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.=
c<br>
=A0LIBFDT_OBJS =3D $(LIBFDT_SRCS:%.c=3D%.o)<br>
+<br>
+dist +=3D kexec/arch/ppc/libfdt/Makefile.libfdt =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 kexec/arch/ppc/libfdt/fdt.h kexec/arch/ppc/libfdt/libfdt.h =
=A0 =A0 =A0\<br>
+ =A0 =A0 =A0 kexec/arch/ppc/libfdt/libfdt_env.h =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+ =A0 =A0 =A0 kexec/arch/ppc/libfdt/libfdt_internal.h<br>
diff --git a/kexec/arch/x86_64/Makefile b/kexec/arch/x86_64/Makefile<br>
index e6a8d35..0f35a46 100644<br>
--- a/kexec/arch/x86_64/Makefile<br>
+++ b/kexec/arch/x86_64/Makefile<br>
@@ -15,6 +15,6 @@ x86_64_KEXEC_SRCS +=3D kexec/arch/x86_64/kexec-elf-rel-x8=
6_64.c<br>
<br>
=A0x86_64_ARCH_INIT =3D kexec/arch/x86_64/arch_init.c<br>
<br>
-dist +=3D kexec/arch/x86_64/Makefile $(x86_64_KEXEC_SRCS) =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
+dist +=3D kexec/arch/x86_64/Makefile $(x86_64_KEXEC_SRCS) $(x86_64_ARCH_IN=
IT) \<br>
 =A0 =A0 =A0 =A0kexec/arch/x86_64/kexec-x86_64.h kexec/arch/x86_64/crashdum=
p-x86_64.h \<br>
 =A0 =A0 =A0 =A0kexec/arch/x86_64/include/arch/options.h<br>
diff --git a/purgatory/arch/ppc64/Makefile b/purgatory/arch/ppc64/Makefile<=
br>
index 40a9e99..dc9c12e 100644<br>
--- a/purgatory/arch/ppc64/Makefile<br>
+++ b/purgatory/arch/ppc64/Makefile<br>
@@ -13,4 +13,5 @@ ppc64_PURGATORY_EXTRA_ASFLAGS +=3D -m64 -mcall-aixdesc<br=
>
=A0ppc64_PURGATORY_EXTRA_LDFLAGS +=3D -melf64ppc<br>
<br>
=A0dist +=3D purgatory/arch/ppc64/Makefile $(ppc64_PURGATORY_SRCS) =A0 =A0 =
=A0 =A0 =A0\<br>
+ =A0 =A0 =A0 purgatory/arch/ppc64/hvCall.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
 =A0 =A0 =A0 =A0purgatory/arch/ppc64/purgatory-ppc64.h<br>
<font color=3D"#888888">--<br>
1.7.1<br>
<br>
</font></blockquote></div><br>

--00c09f9b0939bb0684048b7b1a12--


--===============0309336304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0309336304==--

