Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCE9E83EF5
	for <kexec@archiver.kernel.org>; Wed,  4 Feb 2026 08:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QYRTmwYrio7iz9WBc1cFG1FhGiErKU6XzyZS+9bbT+s=; b=clp8QfP6ZlunbodxFo8CnWRNTT
	GaJzjslX0R81cEYI/j12bk91akWdZtFx9+F73qYjfNeGT4b2k6bgk1u6gPL7zzTH/i/RurMeIbTpS
	KHOy2uPvZB0lVkQRFqfc3p/FLSO5hQy+1tXnUt8LOI9WusL2jRgkEHZ/nSKtuugkSCjOlgfaZ8Dzc
	zas1e1TG2mb2XDKi8MSssvyJKEk8GHnT0I5pMQhPvQwIqXCsjAhTGQk0fC+UnLjBAowH9PfolEYcu
	lKCNqFB+ZZSs1NvyjaHVyqikbrt2KsJNdLrsl2poCzbDRPpEsb0ZKbuKoI/kXry+QJlsJovVPIBx5
	e13/8WFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnYRq-000000088dG-1ziB;
	Wed, 04 Feb 2026 08:41:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnYRm-000000088cq-42Ma
	for kexec@lists.infradead.org;
	Wed, 04 Feb 2026 08:41:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770194472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QYRTmwYrio7iz9WBc1cFG1FhGiErKU6XzyZS+9bbT+s=;
	b=OTLieiBVThG/XiJv3GFdN/t2htkt7eSc2ZPnx7AYqQhgFhzeGfeuOsv2MOWJD/lkushp25
	yRBYRE1G9Xkbr0KBheFaLe2aS0BU+uFSBJjRILUzLHYFZE6gAshAHnz9q7Rt3fKmcD1mlR
	Xu9RU69DmdYE+R0vSv2pTYkhalwamfI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-yJi8WoldOoa7FmgSw4BijA-1; Wed, 04 Feb 2026 03:41:10 -0500
X-MC-Unique: yJi8WoldOoa7FmgSw4BijA-1
X-Mimecast-MFC-AGG-ID: yJi8WoldOoa7FmgSw4BijA_1770194470
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50355952ac2so21432851cf.0
        for <kexec@lists.infradead.org>; Wed, 04 Feb 2026 00:41:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770194470; x=1770799270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QYRTmwYrio7iz9WBc1cFG1FhGiErKU6XzyZS+9bbT+s=;
        b=xUGHRHVwcuIGu5wh4Ep0qG5rK6HgHuEUjXcm5MYe3l81LYgAVlaALtmcqO3Sb0bnbv
         TvFo3KRforOi4yszqkjOPtGsY+kOtazZF57pTAC5XZa6G/IKhzFBhQGvfARnupYxc/C8
         w5xoQVoqQKsI1AMZIyVaEJw144yqPcxnzjlIshVJRCPLoeiCCiooIqLAA/KzuzniQZad
         LTYt8pW0Il8mgm9cAWDtT7G5ytzw9PumCQYwVoWVstXuWXB0dUFpxW+QPNS6kCzGpIvY
         XdVH0kz9bdJr94eZZhIPWKXYnX4oWP6p8ReXUQTevRf3CeIqcoA9s3cAFW3gS8Jm/HZX
         +JWA==
X-Forwarded-Encrypted: i=1; AJvYcCV/uA4SWSol0UHZtfyzU/uLcUu0coa24v2f3SAq2BsfrwX5AajkpVWUCSoqD6OKOVsEuCVizw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzgFwAa1f+VjfNB7HgqCTchz43deJOKWA6ktkM45WEihdGaUzne
	3VWeQvX6Pmkh2ByinuJv672ARJ/u975Gt6wY5GiJjqG/s1pwoTTvb5m1IEcUek9vUHJ0AizYuT1
	P5E9+teNju3VqszDjkMMJEOnylxT/sILmWBAUXlEx5qQvSa5rbUmx7ppri8H9Cx03xU5H+p4GKc
	G3si2fimH/XucYnkyxz+FX+V3cRABp00H2IxJl
X-Gm-Gg: AZuq6aJJ2e0xVUKaVbmD0vVPhMnWrih+R9eGIEMG5lN3Drf1KY1ca5aIT0BtgKlhXmS
	KFCrtwloP+sxG4AdsvIPfx66ZFgxGOa0/nFjLR8vLYsv12HiEp/vsM7RPYBHwWICtOW5J2GwdKv
	up+9Y4BNqKxnfhh5fFS3kXMfX/3x/NNU7SCAg6oYPXvZTIJTiFFrMgEFqAX4Dwb4wO+y0=
X-Received: by 2002:a05:622a:19a4:b0:506:20bc:d566 with SMTP id d75a77b69052e-50620bcd8afmr6834351cf.27.1770194469613;
        Wed, 04 Feb 2026 00:41:09 -0800 (PST)
X-Received: by 2002:a05:622a:19a4:b0:506:20bc:d566 with SMTP id
 d75a77b69052e-50620bcd8afmr6834171cf.27.1770194469210; Wed, 04 Feb 2026
 00:41:09 -0800 (PST)
MIME-Version: 1.0
References: <20260120025500.25095-1-ltao@redhat.com> <20260120025500.25095-6-ltao@redhat.com>
 <87ikcuv5ag.fsf@oracle.com> <CAO7dBbV-o4pTkaxaiZxfWHV7WDk=3fBc_XWVEs1XNWnvqJw46A@mail.gmail.com>
In-Reply-To: <CAO7dBbV-o4pTkaxaiZxfWHV7WDk=3fBc_XWVEs1XNWnvqJw46A@mail.gmail.com>
From: Tao Liu <ltao@redhat.com>
Date: Wed, 4 Feb 2026 21:40:33 +1300
X-Gm-Features: AZwV_QjbcsSR5A2nwaf71ubJrEJDAHl9nBWiTr9FOSuonRcxRv7al-Q8ixpxFw8
Message-ID: <CAO7dBbW34=+DQMZ8NyPqPtm83nr2DYfa_z0Huf=NS8bzrh053w@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] Add makedumpfile extension support
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org, 
	aravinda@linux.vnet.ibm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3SkI2Rr8sU2VwMGshagZb_n2fPUjbNW752EyZ8KAmjs_1770194470
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260204_004115_170310_523D955D 
X-CRM114-Status: GOOD (  66.27  )
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

Sorry I took some time to make modifications on v3 code. Please see a
drafted v4 [1] for a preview.

I followed your suggestion to let extensions declare the kallsyms
symbol/btf types it needed, then during kallsyms/btf initialization,
it will only resolve the declared symbol/types, thus getting rid of
the hash table. Extensions now don't need to initial needed
symbols/types by itself.

In addition, users can specify which extensions to load at
makedumpfile cmdline as:

$ ./makedumpfile -d 31 -l
/var/crash/127.0.0.1-2025-06-10-18\:03\:12/vmcore /tmp/out --extension
amdgpu_filter.so

Also "--extension" can be used several times, and amdgpu_filter.so can
be an absolute path as well. If no extensions are specified, the
btf/kallsyms of makedumpfile will not initialize.

I don't know if this is what you wanted, or any suggestions for this?
Thanks in advance!

Thanks,
Tao Liu







[1]: https://github.com/liutgnu/makedumpfile/commits/v4/

On Fri, Jan 23, 2026 at 2:43=E2=80=AFAM Tao Liu <ltao@redhat.com> wrote:
>
> Hi Stephen,
>
> Thanks a lot for your quick reply and detailed information, I really
> appreciate it!
>
> On Thu, Jan 22, 2026 at 1:51=E2=80=AFPM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
> >
> > Hi Tao,
> >
> > This series looks really great -- I'm excited to see the switch to
> > native .so extensions instead of epicc. I've applied the series locally
> > and I'll rebuild my userspace stack inclusion feature based on it, to
> > try it out myself.
>
> Awesome, looking forward to your feedback on the code/API designs etc...
>
> >
> > In the meantime, I'll share some of my feedback on the patches (though
> > I'm not a makedumpfile developer). This seems like the most important
> > patch in terms of design, so I'll start here.
> >
> > Tao Liu <ltao@redhat.com> writes:
> > > This patch will add .so extension support to makedumpfile, similar to=
 crash
> > > extension to crash utility. Currently only "/usr/lib64/makedumpfile/e=
xtensions"
> > > and "./extensions" are searched for extensions. Once found, kallsyms =
and btf
> > > will be initialized so all extensions can benifit from it (Currently =
makedumpfile
> > > doesn't use these info, we can move the kallsyms/btf init code else w=
here later
> > > if makedumpfile needs them).
> > >
> > > The makedumpfile extension is to help users to customize mm page filt=
ering upon
> > > traditional mm page flag filtering, without make code modification on=
 makedumpfile
> > > itself.
> > >
> > > Signed-off-by: Tao Liu <ltao@redhat.com>
> > > ---
> > >  Makefile            |  7 +++-
> > >  extension.c         | 82 +++++++++++++++++++++++++++++++++++++++++++=
++
> > >  extensions/Makefile | 10 ++++++
> > >  makedumpfile.c      |  4 +++
> > >  4 files changed, 102 insertions(+), 1 deletion(-)
> > >  create mode 100644 extension.c
> > >  create mode 100644 extensions/Makefile
> > >
> > > diff --git a/Makefile b/Makefile
> > > index f3f4da8..7e29220 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -45,7 +45,7 @@ CFLAGS_ARCH +=3D -m32
> > >  endif
> > >
> > >  SRC_BASE =3D makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod=
.h sadump_info.h
> > > -SRC_PART =3D print_info.c dwarf_info.c elf_info.c erase_info.c sadum=
p_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c btf_info.c
> > > +SRC_PART =3D print_info.c dwarf_info.c elf_info.c erase_info.c sadum=
p_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c btf_info.c exte=
nsion.c
> > >  OBJ_PART=3D$(patsubst %.c,%.o,$(SRC_PART))
> > >  SRC_ARCH =3D arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/i=
a64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c arc=
h/loongarch64.c arch/riscv64.c
> > >  OBJ_ARCH=3D$(patsubst %.c,%.o,$(SRC_ARCH))
> > > @@ -126,6 +126,7 @@ eppic_makedumpfile.so: extension_eppic.c
> > >
> > >  clean:
> > >       rm -f $(OBJ) $(OBJ_PART) $(OBJ_ARCH) makedumpfile makedumpfile.=
8 makedumpfile.conf.5
> > > +     $(MAKE) -C extensions clean
> > >
> > >  install:
> > >       install -m 755 -d ${DESTDIR}/${SBINDIR} ${DESTDIR}/usr/share/ma=
n/man5 ${DESTDIR}/usr/share/man/man8
> > > @@ -135,3 +136,7 @@ install:
> > >       mkdir -p ${DESTDIR}/usr/share/makedumpfile/eppic_scripts
> > >       install -m 644 -D $(VPATH)makedumpfile.conf ${DESTDIR}/usr/shar=
e/makedumpfile/makedumpfile.conf.sample
> > >       install -m 644 -t ${DESTDIR}/usr/share/makedumpfile/eppic_scrip=
ts/ $(VPATH)eppic_scripts/*
> > > +
> > > +.PHONY: extensions
> > > +extensions:
> > > +     $(MAKE) -C extensions CC=3D$(CC)
> > > \ No newline at end of file
> > > diff --git a/extension.c b/extension.c
> > > new file mode 100644
> > > index 0000000..6ee7f4e
> > > --- /dev/null
> > > +++ b/extension.c
> > > @@ -0,0 +1,82 @@
> > > +#include <stdio.h>
> > > +#include <stdlib.h>
> > > +#include <string.h>
> > > +#include <dirent.h>
> > > +#include <dlfcn.h>
> > > +#include <stdbool.h>
> > > +#include "kallsyms.h"
> > > +#include "btf_info.h"
> > > +
> > > +static const char *dirs[] =3D {
> > > +     "/usr/lib64/makedumpfile/extensions",
> > > +     "./extensions",
> > > +};
> > > +
> > > +/* Will only init once */
> > > +static bool init_kallsyms_btf(void)
> > > +{
> > > +     static bool ret =3D false;
> > > +     static bool has_inited =3D false;
> > > +
> > > +     if (has_inited)
> > > +             goto out;
> > > +     if (!init_kernel_kallsyms())
> > > +             goto out;
> > > +     if (!init_kernel_btf())
> > > +             goto out;
> > > +     if (!init_module_kallsyms())
> > > +             goto out;
> > > +     if (!init_module_btf())
> > > +             goto out;
> > > +     ret =3D true;
> >
> > I feel it would be good practice to load as little information as is
> > necessary for the task. If "amdgpu" module is required, then load kerne=
l
> > kallsyms, BTF, and then the amdgpu module kallsyms & BTF. If no module
> > debuginfo is required, then just the kernel would suffice.
> >
> > This would reduce memory usage and runtime, though I don't know if it
> > would show up in profiling. The main benefit could be reliability: by
> > handling less data, there are fewer chances to hit an error.
>
> OK, I agree, mandatory kernel btf/kallsyms info + optional kernel
> module btf/kallsyms info is a reasonable design. So kernel modules'
> info can be loaded on demand.
>
> >
> > > +out:
> > > +     has_inited =3D true;
> > > +     return ret;
> > > +}
> > > +
> > > +static void cleanup_kallsyms_btf(void)
> > > +{
> > > +     cleanup_kallsyms();
> > > +     cleanup_btf();
> > > +}
> > > +
> > > +void run_extensions(void)
> > > +{
> > > +     DIR *dir;
> > > +     struct dirent *entry;
> > > +     size_t len;
> > > +     int i;
> > > +     void *handle;
> > > +     char path[512];
> > > +
> > > +     for (i =3D 0; i < sizeof(dirs) / sizeof(char *); i++) {
> > > +             if ((dir =3D opendir(dirs[i])) !=3D NULL)
> > > +                     break;
> > > +     }
> > > +
> > > +     if (!dir || i >=3D sizeof(dirs) / sizeof(char *))
> > > +             /* No extensions found */
> > > +             return;
> >
> > It could be confusing that makedumpfile would behave differently with
> > the same command-line arguments depending on the presence or absence of
> > these extensions on the filesystem.
> >
> > I think it may fit users' expectations better if they are required to
> > specify extensions on the command line. Then we could load them by
> > searching each directory in order. This allows:
> >
> > (a) more expected behavior
> > (b) multiple extensions can exist without all being enabled, thus more
> >     flexibility
> > (c) extensions can be present in the local "extensions/" directory, or
> >     in the system directory
>
> Sure, it also sounds reasonable. My original thoughts are, user
> customization on mm filtering are specified in .so, and if user don't
> need one .so, e.g. amdgpu mm filtering for a nvidia machine, then he
> doesn't pack the amdgpu_filter.so into kdump's initramfs. I agree
> adding extra makedumpfile cmdline option to receive those needed .so
> is a better design.
>
> >
> > > +     while ((entry =3D readdir(dir)) !=3D NULL) {
> > > +             len =3D strlen(entry->d_name);
> > > +             if (len > 3 && strcmp(entry->d_name + len - 3, ".so") =
=3D=3D 0) {
> > > +                     /* Will only init when .so exist */
> > > +                     if (!init_kallsyms_btf())
> > > +                             goto out;
> > > +
> > > +                     snprintf(path, sizeof(path), "%s/%s", dirs[i], =
entry->d_name);
> > > +                     handle =3D dlopen(path, RTLD_NOW);
> > > +                     if (!handle) {
> > > +                             fprintf(stderr, "%s: Failed to load %s:=
 %s\n",
> > > +                                     __func__, path, dlerror());
> > > +                             continue;
> > > +                     }
> > > +                     printf("Loaded extension: %s\n", path);
> > > +                     dlclose(handle);
> >
> > Using the constructor/destructor of the shared object is clever! But we
> > lose some flexibility: by the time the dlopen() returns, the constructo=
r
> > has executed and the plugin has thus executed.
> >
> > What if we instead use dlsym() to load some symbols from the DSO? In
> > particular, I think it would be useful if extensions could declare a
> > list of symbols and a list of structure information which they are
> > interested in receiving. We could use these lists to know which
> > kernel/module kallsyms & BTF we should load. We could even load the
> > information into the local variables of the extension, so the extension
> > would not need to manually load it.
> >
> > Of course this is more complex, but the benefit is:
> >
> > 1. Extensions can be written more simply, and would not need to manuall=
y
> > load each symbol & type.
> > 2. We could eliminate the hash tables for kallsyms & BTF, and eliminate
> > the loading of unnecessary module information. Instead, we'd just
> > populate the symbol addresses, struct offsets, and type sizes directly
> > into the local variables which request them.
>
> It is a clever idea! Though complex for code, I think it is doable.
>
> >
> > Again, while I don't want to prematurely optimize -- it's good to avoid
> > loading unnecessary information. I hope I've described my idea well. I
> > would be happy to work on an implementation of it based on your patches
> > here, if you're interested.
>
> Thanks again for your suggestions! I got your points and I think I can
> improve the code while waiting for maintainers ideas at the same time.
> I will let you know when done or encounter blockers if any.
>
> Thanks,
> Tao Liu
>
> >
> > Thanks,
> > Stephen
> >
> > > +             }
> > > +     }
> > > +out:
> > > +     closedir(dir);
> > > +     cleanup_kallsyms_btf();
> > > +}
> > > \ No newline at end of file
> > > diff --git a/extensions/Makefile b/extensions/Makefile
> > > new file mode 100644
> > > index 0000000..afbc61e
> > > --- /dev/null
> > > +++ b/extensions/Makefile
> > > @@ -0,0 +1,10 @@
> > > +CC ?=3D gcc
> > > +CONTRIB_SO :=3D
> > > +
> > > +all: $(CONTRIB_SO)
> > > +
> > > +$(CONTRIB_SO): %.so: %.c
> > > +     $(CC) -O2 -g -fPIC -shared -o $@ $^
> > > +
> > > +clean:
> > > +     rm -f $(CONTRIB_SO)
> > > diff --git a/makedumpfile.c b/makedumpfile.c
> > > index dba3628..ca8ed8a 100644
> > > --- a/makedumpfile.c
> > > +++ b/makedumpfile.c
> > > @@ -10847,6 +10847,8 @@ update_dump_level(void)
> > >       }
> > >  }
> > >
> > > +void run_extensions(void);
> > > +
> > >  int
> > >  create_dumpfile(void)
> > >  {
> > > @@ -10884,6 +10886,8 @@ retry:
> > >       if (info->flag_refiltering)
> > >               update_dump_level();
> > >
> > > +     run_extensions();
> > > +
> > >       if ((info->name_filterconfig || info->name_eppic_config)
> > >                       && !gather_filter_info())
> > >               return FALSE;
> > > --
> > > 2.47.0
> >


