Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7B1F9D0C4
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 11:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XDdRK/7tCQSuBuCTutJQfamBPR3u24FrMn7huO5/67M=; b=zbQDODD00iqIBxsnSduzSTwM5Q
	YDUhtfP2zwioPbFGbNxVnABW20/txfdbkTAqpkSJDOGn7I2nrVyyjD9qSVXMtMmMmAAY03QCz7DGS
	f10JGGVtJS34PJ+40vYkg6bh0iiVL6bw7QWDleusNDX9IWPjT+YJD38oBEk10EA8o+Bi/8Bm5J7ey
	JIqA+NBO4G+s8XX7m17iHzt+AFLjACCrHqY6kLgEFzUhx8eLPWuEKoK0ipBhA7gyOqm4r2sDdLmhO
	rGcWYVTIV7hzna+wHW9+J4csZ47CVVXnsR85q9npsWR4qUp8dMppQSNUokMmleDb9HHI1/mfCC7+L
	7lQstO7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCcIc-0000000HGMM-1jbj;
	Tue, 14 Apr 2026 11:51:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCcIZ-0000000HGLo-23Vj
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 11:51:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776167478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDdRK/7tCQSuBuCTutJQfamBPR3u24FrMn7huO5/67M=;
	b=hZm0EwBdNLViloxOXYLoSm+zGhH5NY9bXszYZKHYdJKTvLp22kdBwBooC2Y1uyt04E4A9w
	Tv4wTH3tb2j3iAlZ4qjV2X25hjR/+qyjbugvhFbuxqOa2I34enzJvIw3sesyjgyxxCzGOM
	f/uak3z//8L2WpeApZcMYUZgFOTBSV8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-r9AxgsP5NnS7NS0oC20gHg-1; Tue, 14 Apr 2026 07:51:15 -0400
X-MC-Unique: r9AxgsP5NnS7NS0oC20gHg-1
X-Mimecast-MFC-AGG-ID: r9AxgsP5NnS7NS0oC20gHg_1776167475
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b31cff27fso15597451cf.3
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 04:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776167475; x=1776772275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XDdRK/7tCQSuBuCTutJQfamBPR3u24FrMn7huO5/67M=;
        b=YYw0bNrxFNpGvmAZKtIkQFTC1ZuxKsPsETIszT5GG9gbJe2IEfAnzI2lWQsaXdY5Er
         le2nxrfXqvJWDAgNdEc7lqgzEHv4kBMFYrJ1h/QvqzvHnUwsV5torX43OTqWw3+BUUqK
         b2oBNoW1xtvBoAGnNBUntZjaQAXaWLTlyY+A/vU5226+xKgYawOHSNF4zfKL+/9ghl9u
         syAZEFwlf6LTQqBdNu8/LsDucYZc3v4WawF4dQNdi3AMDLdneTR7CYQm/tl850fOzrzG
         Df0cjaHEx8PurvNj89PrBVwc7b+o2OtJymxIBZhF8Jwe0sxS85lUx6oNHszf32pgiwx4
         zsjg==
X-Forwarded-Encrypted: i=1; AFNElJ8kSXuJUVP8IalIh+AtAS8qFsfGq4I+zlnivu68c9DYsh+2HP38mMvmQA4Ud577sC81VtsKDA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzvsc9FZshrR0m2NSa0ThOXXkHuHnB02QieET6JcOKpgfwrNQHq
	De5jzhc0GBx9uQyqr3SK9PyboQZACZ0YQkyOgLSGumbmYBU0/0nCo7enH8hSQGQssloWLdGgBoU
	uF5G1u92dA6BGOD0vVBOgT7PfjlqsV3J4Q3w5N3TA3fnrNqcEb5KQ/zRQpelrz+RjYz7ol+PxPO
	AZN/YRhz5qtFpaFj2OkrAyPsSAKBCtXvFCe7kF
X-Gm-Gg: AeBDievKWUWXdYj8QeYMUmuiheHpO+0mHFozhBklCzgpD2d8vVJGqw/Qbq9kF2nBV+9
	bpBRed8lBcjc80MVcQ8B95C/KzwTyKLA+6tLBX/P2VGHC+crVQr6CbC0l8MTHGiFYZ24VoilJRb
	dao0OcEV5yrp9mkgZaCjtmKh/kOvIPIWb7uh+cn7KLuo/pcAUgAHuXWRacF0qbpU6R2MJMcmmMJ
	kMhg7XodRiodA==
X-Received: by 2002:a05:622a:3c8:b0:50b:4755:94b9 with SMTP id d75a77b69052e-50dd5c15d59mr264530411cf.56.1776167474470;
        Tue, 14 Apr 2026 04:51:14 -0700 (PDT)
X-Received: by 2002:a05:622a:3c8:b0:50b:4755:94b9 with SMTP id
 d75a77b69052e-50dd5c15d59mr264529731cf.56.1776167473772; Tue, 14 Apr 2026
 04:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260317150743.69590-1-ltao@redhat.com> <20260317150743.69590-7-ltao@redhat.com>
 <bda432f0-57a4-48a2-bc8e-bdd0a132824b@nec.com>
In-Reply-To: <bda432f0-57a4-48a2-bc8e-bdd0a132824b@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 14 Apr 2026 23:50:34 +1200
X-Gm-Features: AQROBzBXF9cN9HaTO8Es0bIfmEy24VNSvUUIP4WUSBrWXcWb7e-bV0JbmAHr5n4
Message-ID: <CAO7dBbUa_8H0fe+9bTNTQWjMVy9qCPiu0fo3g8XamiDS_Mr8eA@mail.gmail.com>
Subject: Re: [PATCH v4][makedumpfile 6/7] Add makedumpfile extensions support
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: "stephen.s.brennan@oracle.com" <stephen.s.brennan@oracle.com>, 
	=?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5gJbQzBOnj6_Jz-obtrbsNmlKhQlWFGwajEk8AAc-Mo_1776167475
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_045119_701527_623F8822 
X-CRM114-Status: GOOD (  41.74  )
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

Hi Kazu,

On Fri, Apr 3, 2026 at 9:14=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=E3=
=80=80=E4=B8=80=E4=BB=81) <k-hagio-ab@nec.com> wrote:
>
> On 2026/03/18 0:07, Tao Liu wrote:
> > The extensions can be specified by makedumpfile cmdline parameter as
> > "--extension", followed by extension's filename or absolute path. If
> > filename is give, then "./extenisons" and "/usr/lib64/makedumpfile/exte=
nsions/"
> > will be searched.
> >
> > The procedures of extensions are as follows:
> >
> > Step 0: Every extensions will declare which kernel symbol/types they ne=
eded
> > during programming. This info will be stored within .init_ksyms/ktypes =
section.
> > Also extension will have a callback function for makedumpfile to call.
> >
> > Step 1: Register .init_ksyms and .init_ktypes sections of makedumpfile
> > itself and extension's .so files, then tell kallsyms/btf subcomponent t=
hat which
> > kernel symbols/types will be resolved. And callbacks are also registere=
d.
> >
> > Step 2: Init kernel/module's btf/kallsyms on demand. Any un-needed kenr=
el
> > modules will be skipped.
> >
> > Step 3: During btf/kallsyms parsing, the needed info will be filled. Fo=
r
> > syms/types which are defined via INIT_OPT(...) macro, these are optinal
> > syms/types, it won't fail at parsing step if any are missing, instead, =
they
> > need to be checked within extension_init() of each extensions; For
> > syms/types which defined via INIT_(...) macro, these are must-have syms=
/types,
> > if any missing, the extension will fail at this step and as a result
> > this extension will be skipped.
> >
> > After this step, required kernel symbol value and kernel types size/off=
set
> > are resolved, the extensions are ready to go.
> >
> > Step 4: When makedumpfile doing page filtering, in addition to its
> > original filtering mechanism, it will call extensions callbacks for adv=
ice
> > whether the page should be included/excluded.
> >
> > Suggested-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> > Signed-off-by: Tao Liu <ltao@redhat.com>
> > ---
> >   Makefile            |   7 +-
> >   extension.c         | 300 +++++++++++++++++++++++++++++++++++++++++++=
+
> >   extension.h         |  12 ++
> >   extensions/Makefile |  10 ++
> >   makedumpfile.c      |  38 +++++-
> >   makedumpfile.h      |   2 +
> >   6 files changed, 363 insertions(+), 6 deletions(-)
> >   create mode 100644 extension.c
> >   create mode 100644 extension.h
> >   create mode 100644 extensions/Makefile
> >
> > diff --git a/Makefile b/Makefile
> > index 320677d..1bb67d9 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -45,7 +45,7 @@ CFLAGS_ARCH +=3D -m32
> >   endif
> >
> >   SRC_BASE =3D makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.=
h sadump_info.h
> > -SRC_PART =3D print_info.c dwarf_info.c elf_info.c erase_info.c sadump_=
info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c btf_info.c
> > +SRC_PART =3D print_info.c dwarf_info.c elf_info.c erase_info.c sadump_=
info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c btf_info.c extens=
ion.c
> >   OBJ_PART=3D$(patsubst %.c,%.o,$(SRC_PART))
> >   SRC_ARCH =3D arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia=
64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c arch=
/loongarch64.c arch/riscv64.c
> >   OBJ_ARCH=3D$(patsubst %.c,%.o,$(SRC_ARCH))
> > @@ -126,6 +126,7 @@ eppic_makedumpfile.so: extension_eppic.c
> >
> >   clean:
> >       rm -f $(OBJ) $(OBJ_PART) $(OBJ_ARCH) makedumpfile makedumpfile.8 =
makedumpfile.conf.5
> > +     $(MAKE) -C extensions clean
> >
> >   install:
> >       install -m 755 -d ${DESTDIR}/${SBINDIR} ${DESTDIR}/usr/share/man/=
man5 ${DESTDIR}/usr/share/man/man8
> > @@ -135,3 +136,7 @@ install:
> >       mkdir -p ${DESTDIR}/usr/share/makedumpfile/eppic_scripts
> >       install -m 644 -D $(VPATH)makedumpfile.conf ${DESTDIR}/usr/share/=
makedumpfile/makedumpfile.conf.sample
> >       install -m 644 -t ${DESTDIR}/usr/share/makedumpfile/eppic_scripts=
/ $(VPATH)eppic_scripts/*
> > +
> > +.PHONY: extensions
> > +extensions:
> > +     $(MAKE) -C extensions CC=3D$(CC)
> > \ No newline at end of file
> > diff --git a/extension.c b/extension.c
> > new file mode 100644
> > index 0000000..35e2756
> > --- /dev/null
> > +++ b/extension.c
> > @@ -0,0 +1,300 @@
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <dirent.h>
> > +#include <dlfcn.h>
> > +#include <stdbool.h>
> > +#include <unistd.h>
> > +#include "kallsyms.h"
> > +#include "btf_info.h"
> > +#include "extension.h"
> > +
> > +typedef int (*callback_fn)(unsigned long, const void *);
> > +
> > +struct extension_handle_cb {
> > +     void *handle;
> > +     callback_fn cb;
> > +};
> > +
> > +/* Extension .so extension_handle_cb array */
> > +static struct extension_handle_cb **handle_cbs =3D NULL;
> > +static int handle_cbs_len =3D 0;
> > +static int handle_cbs_cap =3D 0;
> > +
> > +/* Extension option array */
> > +static char **extension_opts =3D NULL;
> > +static int extension_opts_len =3D 0;
> > +static int extension_opts_cap =3D 0;
> > +
> > +static const char *dirs[] =3D {
> > +     "/usr/lib64/makedumpfile/extensions/",
> > +     "./extensions/",
> > +};
>
> I think we should add "./" to the first and arrange them in this order:
>
>    "./",
>    "./extensions/",
>    "/usr/lib64/makedumpfile/extensions/"
>
> Without this, we cannot use a relative path like this, it's not natural.
>
>    $ ls
>    amdgpu_filter.so  makedumpfile  vmcore
>    $ ./makedumpfile -ld31 --extension amdgpu_filter.so vmcore dump
>    load_extensions: Not found amdgpu_filter.so
>    Copying data                                      : [ 26.5 %]

Sure, fixed in v5.
>
>
> > +
> > +void add_extension_opts(char *opt)
> > +{
> > +     if (!add_to_arr((void ***)&extension_opts, &extension_opts_len,
> > +                     &extension_opts_cap, opt))
> > +             /*
> > +              * If fail, print error info and skip the extension.
> > +             */
> > +              fprintf(stderr, "%s: Fail to add extension %s\n", __func=
__, opt);
> > +}
> > +
> > +static bool init_kallsyms_btf(void)
> > +{
> > +     int count;
> > +     bool ret =3D false;
> > +     /* We will load module's btf/kallsyms on demand */
> > +     bool init_ksyms_module =3D false;
> > +     bool init_ktypes_module =3D false;
> > +
> > +     if (check_ksyms_require_modname("vmlinux", &count)) {
> > +             if (!init_kernel_kallsyms())
> > +                     goto out;
> > +             if (count >=3D 2)
> > +                     init_ksyms_module =3D true;
>
> I may have misread, if an extension depends only a module's symbols, no
> init functions are run?  or it can't be such a situation?

The sequence of kallsyms/btf resolving is:

step 1) Starting from vmcoreinfo, we know basic kallsyms info such as
kallsyms_names/num_syms/token_table/.. etc. Then based on those info,
we construct the whole kernel's kallsyms info, but only kernel's, not
kernel modules'.

step 2) From step1, we have resolved __start_BTF/__stop_BTF symbol
value, which are critical for btf info parsing. So in step 2, we can
construct the while kernel's btf info, but only kernel's, not kernel
modules'.

step 3) By kernel's kallsyms and btf info, we can understand kernel
symbol address and data structures, so we can resolve module struct
and iterate all kernel modules linked list. By which we can resolve
each kernel modules' kallsyms & btf info.

As you can see, the kallsyms/btf info resolving of kernel module is
relying on the kallsyms/btf info resolving of kernel itself. So if an
extension only relies on kernel modules symbol, the kernel, or
vmlinux's kallsyms/btf info are still resolved first. So
init_kernel_kallsyms() will always be called if kernel modules'
kallsyms are needed.

>
>
> > +     }
> > +     if (check_ktypes_require_modname("vmlinux", &count)) {
> > +             if (!init_kernel_btf())
> > +                     goto out;
> > +             if (count >=3D 2)
> > +                     init_ktypes_module =3D true;
> > +     }
> > +     if (init_ksyms_module && !init_module_kallsyms())
> > +             goto out;
> > +     if (init_ktypes_module && !init_module_btf())
> > +             goto out;
> > +     ret =3D true;
> > +out:
> > +     return ret;
> > +}
> > +
> > +static void cleanup_kallsyms_btf(void)
> > +{
> > +     cleanup_kallsyms();
> > +     cleanup_btf();
> > +}
> > +
> > +static void load_extensions(void)
> > +{
> > +     char path[512];
> > +     int len, i, j;
> > +     void *handle;
> > +     struct extension_handle_cb *ehc;
> > +
> > +     for (i =3D 0; i < extension_opts_len; i++) {
> > +             handle =3D NULL;
> > +             if (!extension_opts[i])
> > +                     continue;
> > +             if ((len =3D strlen(extension_opts[i])) <=3D 3 ||
> > +                 (strcmp(extension_opts[i] + len - 3, ".so") !=3D 0)) =
{
> > +                     fprintf(stderr, "%s: Skip invalid extension: %s\n=
",
> > +                             __func__, extension_opts[i]);
> > +                     continue;
> > +             }
> > +
> > +             if (extension_opts[i][0] =3D=3D '/') {
> > +                     /* Path & filename */
> > +                     snprintf(path, sizeof(path), "%s", extension_opts=
[i]);
> > +                     handle =3D dlopen(path, RTLD_NOW);
> > +                     if (!handle) {
> > +                             fprintf(stderr, "%s: Failed to load %s\n"=
,
> > +                                     __func__, dlerror());
> > +                             continue;
> > +                     }
> > +             } else {
> > +                     /* Only filename */
> > +                     for (j =3D 0; j < sizeof(dirs) / sizeof(char *); =
j++) {
> > +                             snprintf(path, sizeof(path), "%s", dirs[j=
]);
> > +                             len =3D strlen(path);
> > +                             snprintf(path + len, sizeof(path) - len, =
"%s",
> > +                                     extension_opts[i]);
> > +                             if (access(path, F_OK) =3D=3D 0) {
> > +                                     handle =3D dlopen(path, RTLD_NOW)=
;
> > +                                     if (handle)
> > +                                             break;
> > +                                     else
> > +                                             fprintf(stderr, "%s: Fail=
ed to load %s\n",
> > +                                                     __func__, dlerror=
());
> > +                             }
> > +                     }
> > +                     if (!handle && j >=3D sizeof(dirs) / sizeof(char =
*)) {
> > +                             fprintf(stderr, "%s: Not found %s\n",
> > +                                     __func__, extension_opts[i]);
> > +                             continue;
> > +                     }
> > +             }
> > +
> > +             if (dlsym(handle, "extension_init") =3D=3D NULL) {
> > +                     fprintf(stderr, "%s: Skip extension %s: No extens=
ion_init()\n",
> > +                             __func__, path);
> > +                     dlclose(handle);
> > +                     continue;
> > +             }
> > +
> > +             if ((ehc =3D malloc(sizeof(struct extension_handle_cb))) =
=3D=3D NULL) {
> > +                     fprintf(stderr, "%s: Skip extension %s: No memory=
\n",
> > +                             __func__, path);
> > +                     dlclose(handle);
> > +                     continue;
>
> Some lines have spaces at the end of line, please remove them.

Fixed the formatting issue in v5.

>
> Thanks,
> Kazu
>
> > +             }
> > +
> > +             ehc->handle =3D handle;
> > +             ehc->cb =3D dlsym(handle, "extension_callback");
> > +
> > +             if (!add_to_arr((void ***)&handle_cbs, &handle_cbs_len, &=
handle_cbs_cap, ehc)) {
> > +                     fprintf(stderr, "%s: Failed to load %s\n", __func=
__,
> > +                             extension_opts[i]);
> > +                     free(ehc);
> > +                     dlclose(handle);
> > +                     continue;
> > +             }
> > +             printf("Loaded extension: %s\n", path);
> > +     }
> > +}
> > +
> > +static bool register_extension_sections(void)
> > +{
> > +     char *start, *stop;
> > +     int i;
> > +     bool ret =3D false;
> > +
> > +     for (i =3D 0; i < handle_cbs_len; i++) {
> > +             start =3D dlsym(handle_cbs[i]->handle, "__start_init_ksym=
s");
> > +             stop =3D dlsym(handle_cbs[i]->handle, "__stop_init_ksyms"=
);
> > +             if (!register_ksym_section(start, stop))
> > +                     goto out;
> > +
> > +             start =3D dlsym(handle_cbs[i]->handle, "__start_init_ktyp=
es");
> > +             stop =3D dlsym(handle_cbs[i]->handle, "__stop_init_ktypes=
");
> > +             if (!register_ktype_section(start, stop))
> > +                     goto out;
> > +     }
> > +     ret =3D true;
> > +out:
> > +     return ret;
> > +}
> > +
> > +void cleanup_extensions(void)
> > +{
> > +     for (int i =3D 0; i < handle_cbs_len; i++) {
> > +             dlclose(handle_cbs[i]->handle);
> > +             free(handle_cbs[i]);
> > +     }
> > +     if (handle_cbs) {
> > +             free(handle_cbs);
> > +             handle_cbs =3D NULL;
> > +     }
> > +     handle_cbs_len =3D 0;
> > +     handle_cbs_cap =3D 0;
> > +     if (extension_opts) {
> > +             free(extension_opts);
> > +             extension_opts =3D NULL;
> > +     }
> > +     extension_opts_len =3D 0;
> > +     extension_opts_cap =3D 0;
> > +
> > +     cleanup_kallsyms_btf();
> > +}
> > +
> > +static bool check_required_ksyms_all_resolved(void *handle)
> > +{
> > +     char *start, *stop;
> > +     struct ksym_info **p;
> > +     bool ret =3D true;
> > +
> > +     start =3D dlsym(handle, "__start_init_ksyms");
> > +     stop =3D dlsym(handle, "__stop_init_ksyms");
> > +
> > +     for (p =3D (struct ksym_info **)start;
> > +          p < (struct ksym_info **)stop;
> > +          p++) {
> > +             if ((*p)->sym_required && !SYM_EXIST(*p)) {
> > +                     ret =3D false;
> > +                     fprintf(stderr, "Symbol %s in %s not found\n",
> > +                             (*p)->symname, (*p)->modname);
> > +             }
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static bool check_required_ktypes_all_resolved(void *handle)
> > +{
> > +     char *start, *stop;
> > +     struct ktype_info **p;
> > +     bool ret =3D true;
> > +
> > +     start =3D dlsym(handle, "__start_init_ktypes");
> > +     stop =3D dlsym(handle, "__stop_init_ktypes");
> > +
> > +     for (p =3D (struct ktype_info **)start;
> > +          p < (struct ktype_info **)stop;
> > +          p++) {
> > +             if (!TYPE_EXIST(*p)) {
> > +                     if ((*p)->member_required) {
> > +                             ret =3D false;
> > +                             fprintf(stderr, "Member %s of struct %s i=
n %s not found\n",
> > +                                     (*p)->member_name, (*p)->struct_n=
ame, (*p)->modname);
> > +                     } else if ((*p)->struct_required) {
> > +                             ret =3D false;
> > +                             fprintf(stderr, "Struct %s in %s not foun=
d\n",
> > +                                     (*p)->struct_name, (*p)->modname)=
;
> > +                     }
> > +             }
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static bool extension_runnable(void *handle)
> > +{
> > +     return check_required_ksyms_all_resolved(handle) &&
> > +             check_required_ktypes_all_resolved(handle);
> > +}
> > +
> > +void init_extensions(void)
> > +{
> > +     /* Entry of extension init */
> > +     void (*init)(void);
> > +
> > +     load_extensions();
> > +     if (!register_extension_sections())
> > +             goto fail;
> > +     if (!init_kallsyms_btf())
> > +             goto fail;
> > +     for (int i =3D 0; i < handle_cbs_len; i++) {
> > +             if (extension_runnable(handle_cbs[i]->handle)) {
> > +                     init =3D dlsym(handle_cbs[i]->handle, "extension_=
init");
> > +                     init();
> > +             } else {
> > +                     fprintf(stderr, "%s: Skip %dth extension\n",
> > +                             __func__, i + 1);
> > +             }
> > +     }
> > +     return;
> > +fail:
> > +     fprintf(stderr, "%s: fail & skip all extensions\n", __func__);
> > +     cleanup_extensions();
> > +}
> > +
> > +int run_extension_callback(unsigned long pfn, const void *pcache)
> > +{
> > +     int result;
> > +     int ret =3D PG_UNDECID;
> > +
> > +     for (int i =3D 0; i < handle_cbs_len; i++) {
> > +             if (handle_cbs[i]->cb) {
> > +                     result =3D handle_cbs[i]->cb(pfn, pcache);
> > +                     if (result =3D=3D PG_INCLUDE) {
> > +                             ret =3D result;
> > +                             goto out;
> > +                     } else if (result =3D=3D PG_EXCLUDE) {
> > +                             ret =3D result;
> > +                     }
> > +             }
> > +     }
> > +out:
> > +     return ret;
> > +}
> > \ No newline at end of file
> > diff --git a/extension.h b/extension.h
> > new file mode 100644
> > index 0000000..dc5902e
> > --- /dev/null
> > +++ b/extension.h
> > @@ -0,0 +1,12 @@
> > +#ifndef _EXTENSION_H
> > +#define _EXTENSION_H
> > +
> > +enum {
> > +     PG_INCLUDE,     // Exntesion will keep the page
> > +     PG_EXCLUDE,     // Exntesion will discard the page
> > +     PG_UNDECID,     // Exntesion makes no decision
> > +};
> > +int run_extension_callback(unsigned long pfn, const void *pcache);
> > +void init_extensions(void);
> > +void cleanup_extensions(void);
> > +#endif /* _EXTENSION_H */
> > \ No newline at end of file
> > diff --git a/extensions/Makefile b/extensions/Makefile
> > new file mode 100644
> > index 0000000..b8bbfbc
> > --- /dev/null
> > +++ b/extensions/Makefile
> > @@ -0,0 +1,10 @@
> > +CC ?=3D gcc
> > +CONTRIB_SO :=3D
> > +
> > +all: $(CONTRIB_SO)
> > +
> > +$(CONTRIB_SO): %.so: %.c
> > +     $(CC) -O2 -g -fPIC -shared -Wl,-T,../makedumpfile.ld -o $@ $^
> > +
> > +clean:
> > +     rm -f $(CONTRIB_SO)
> > \ No newline at end of file
> > diff --git a/makedumpfile.c b/makedumpfile.c
> > index dba3628..ef7468f 100644
> > --- a/makedumpfile.c
> > +++ b/makedumpfile.c
> > @@ -28,6 +28,7 @@
> >   #include <assert.h>
> >   #include <zlib.h>
> >   #include "kallsyms.h"
> > +#include "extension.h"
> >
> >   struct symbol_table symbol_table;
> >   struct size_table   size_table;
> > @@ -102,6 +103,7 @@ mdf_pfn_t pfn_free;
> >   mdf_pfn_t pfn_hwpoison;
> >   mdf_pfn_t pfn_offline;
> >   mdf_pfn_t pfn_elf_excluded;
> > +mdf_pfn_t pfn_extension;
> >
> >   mdf_pfn_t num_dumped;
> >
> > @@ -6459,6 +6461,7 @@ __exclude_unnecessary_pages(unsigned long mem_map=
,
> >       unsigned int order_offset, dtor_offset;
> >       unsigned long flags, mapping, private =3D 0;
> >       unsigned long compound_dtor, compound_head =3D 0;
> > +     int filter_pg;
> >
> >       /*
> >        * If a multi-page exclusion is pending, do it first
> > @@ -6531,6 +6534,14 @@ __exclude_unnecessary_pages(unsigned long mem_ma=
p,
> >                       pfn_read_end   =3D pfn + pfn_mm - 1;
> >               }
> >
> > +             /*
> > +              * Include pages that specified by user via
> > +              * makedumpfile extensions
> > +              */
> > +             filter_pg =3D run_extension_callback(pfn, pcache);
> > +             if (filter_pg =3D=3D PG_INCLUDE)
> > +                     continue;
> > +
> >               flags   =3D ULONG(pcache + OFFSET(page.flags));
> >               _count  =3D UINT(pcache + OFFSET(page._refcount));
> >               mapping =3D ULONG(pcache + OFFSET(page.mapping));
> > @@ -6687,6 +6698,14 @@ check_order:
> >               else if (isOffline(flags, _mapcount)) {
> >                       pfn_counter =3D &pfn_offline;
> >               }
> > +             /*
> > +              * Exclude pages that specified by user via
> > +              * makedumpfile extensions
> > +              */
> > +             else if (filter_pg =3D=3D PG_EXCLUDE) {
> > +                     nr_pages =3D 1;
> > +                     pfn_counter =3D &pfn_extension;
> > +             }
> >               /*
> >                * Unexcludable page
> >                */
> > @@ -8234,7 +8253,7 @@ write_elf_pages_cyclic(struct cache_data *cd_head=
er, struct cache_data *cd_page)
> >        */
> >       if (info->flag_cyclic) {
> >               pfn_zero =3D pfn_cache =3D pfn_cache_private =3D 0;
> > -             pfn_user =3D pfn_free =3D pfn_hwpoison =3D pfn_offline =
=3D 0;
> > +             pfn_user =3D pfn_free =3D pfn_hwpoison =3D pfn_offline =
=3D pfn_extension =3D 0;
> >               pfn_memhole =3D info->max_mapnr;
> >       }
> >
> > @@ -9579,7 +9598,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_=
data *cd_header, struct cache_d
> >                * Reset counter for debug message.
> >                */
> >               pfn_zero =3D pfn_cache =3D pfn_cache_private =3D 0;
> > -             pfn_user =3D pfn_free =3D pfn_hwpoison =3D pfn_offline =
=3D 0;
> > +             pfn_user =3D pfn_free =3D pfn_hwpoison =3D pfn_offline =
=3D pfn_extension =3D 0;
> >               pfn_memhole =3D info->max_mapnr;
> >
> >               /*
> > @@ -10528,7 +10547,7 @@ print_report(void)
> >       pfn_original =3D info->max_mapnr - pfn_memhole;
> >
> >       pfn_excluded =3D pfn_zero + pfn_cache + pfn_cache_private
> > -         + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
> > +         + pfn_user + pfn_free + pfn_hwpoison + pfn_offline + pfn_exte=
nsion;
> >
> >       REPORT_MSG("\n");
> >       REPORT_MSG("Original pages  : 0x%016llx\n", pfn_original);
> > @@ -10544,6 +10563,7 @@ print_report(void)
> >       REPORT_MSG("    Free pages              : 0x%016llx\n", pfn_free)=
;
> >       REPORT_MSG("    Hwpoison pages          : 0x%016llx\n", pfn_hwpoi=
son);
> >       REPORT_MSG("    Offline pages           : 0x%016llx\n", pfn_offli=
ne);
> > +     REPORT_MSG("    Extension filter pages  : 0x%016llx\n", pfn_exten=
sion);
> >       REPORT_MSG("  Remaining pages  : 0x%016llx\n",
> >           pfn_original - pfn_excluded);
> >
> > @@ -10584,7 +10604,7 @@ print_mem_usage(void)
> >       pfn_original =3D info->max_mapnr - pfn_memhole;
> >
> >       pfn_excluded =3D pfn_zero + pfn_cache + pfn_cache_private
> > -         + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
> > +         + pfn_user + pfn_free + pfn_hwpoison + pfn_offline + pfn_exte=
nsion;
> >       shrinking =3D (pfn_original - pfn_excluded) * 100;
> >       shrinking =3D shrinking / pfn_original;
> >       total_size =3D info->page_size * pfn_original;
> > @@ -10878,6 +10898,7 @@ create_dumpfile(void)
> >       }
> >
> >       print_vtop();
> > +     init_extensions();
> >
> >       num_retry =3D 0;
> >   retry:
> > @@ -10888,8 +10909,11 @@ retry:
> >                       && !gather_filter_info())
> >               return FALSE;
> >
> > -     if (!create_dump_bitmap())
> > +     if (!create_dump_bitmap()) {
> > +             cleanup_extensions();
> >               return FALSE;
> > +     }
> > +     cleanup_extensions();
> >
> >       if (info->flag_split) {
> >               if ((status =3D writeout_multiple_dumpfiles()) =3D=3D FAL=
SE)
> > @@ -12130,6 +12154,7 @@ static struct option longopts[] =3D {
> >       {"check-params", no_argument, NULL, OPT_CHECK_PARAMS},
> >       {"dry-run", no_argument, NULL, OPT_DRY_RUN},
> >       {"show-stats", no_argument, NULL, OPT_SHOW_STATS},
> > +     {"extension", required_argument, NULL, OPT_EXTENSION},
> >       {0, 0, 0, 0}
> >   };
> >
> > @@ -12317,6 +12342,9 @@ main(int argc, char *argv[])
> >               case OPT_SHOW_STATS:
> >                       flag_show_stats =3D TRUE;
> >                       break;
> > +             case OPT_EXTENSION:
> > +                     add_extension_opts(optarg);
> > +                     break;
> >               case '?':
> >                       MSG("Commandline parameter is invalid.\n");
> >                       MSG("Try `makedumpfile --help' for more informati=
on.\n");
> > diff --git a/makedumpfile.h b/makedumpfile.h
> > index 0f13743..d880ae7 100644
> > --- a/makedumpfile.h
> > +++ b/makedumpfile.h
> > @@ -2747,6 +2747,7 @@ struct elf_prstatus {
> >   #define OPT_CHECK_PARAMS        OPT_START+18
> >   #define OPT_DRY_RUN             OPT_START+19
> >   #define OPT_SHOW_STATS          OPT_START+20
> > +#define OPT_EXTENSION           OPT_START+21
> >
> >   /*
> >    * Function Prototype.
> > @@ -2777,5 +2778,6 @@ int write_and_check_space(int fd, void *buf, size=
_t buf_size,
> >   int open_dump_file(void);
> >   int dump_lockless_dmesg(void);
> >   unsigned long long memparse(char *ptr, char **retptr);
> > +void add_extension_opts(char *opt);
> >
> >   #endif /* MAKEDUMPFILE_H */


