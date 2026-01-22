Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AEBD3EE67
	for <kexec@archiver.kernel.org>; Thu, 22 Jan 2026 13:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N2ug2OI629lOhuwxrw3rJzSf72jolaXUrcs8jm5o+hI=; b=KfCiGPUvfgUHLAy9624eFfaQsq
	WIi4NI9uk+oOhPvS/Uw1m426uxKJatJEBwOim6QtnL5APK0z4Zb/XWhhRryCqhiwkTKEIZgfwmjxw
	Qz6t6YKF34VzOmIuDpyDr9+o+bD1q9DEISa2Ynz78htFQvubi0kpa3FDV8zKnjRNRAb9lusiQ++YZ
	NqN0oHdnqQPm+Fo1a3nJGchFTiYNNGpmjIDijYp6Nz9EfGxggI6J6pXoGb4J94bNowI36hKtXCk1t
	GnZcuWElBmOAhLzPNeUso7ocFDe4jqwtMKo7hxTmusQAVu4hDngStx1vwGc/0+3r07y0fJPbLw3bk
	alMf0K7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viuz4-00000007AZr-1ot7;
	Thu, 22 Jan 2026 13:44:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viuz0-00000007AZF-1L0T
	for kexec@lists.infradead.org;
	Thu, 22 Jan 2026 13:44:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769089459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N2ug2OI629lOhuwxrw3rJzSf72jolaXUrcs8jm5o+hI=;
	b=Ke0kpfHR/GBjiCU3EpwFS1OqDxxS2bj5FW3p3R7+XLtIiEk0v3umKrBygKiZnDFsSjNtL3
	usDEHXs2cTPWdrDGDaYdItDJCwCRUPGlMA9bSE+0d/Z1lL2AMUo1lF2hIeZmjXGDb3JX9E
	i+7YWufjeP3oYbxWIcGZbZIuleSKisI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-PgDX0g3dM0eujn8qrLdSEA-1; Thu, 22 Jan 2026 08:44:17 -0500
X-MC-Unique: PgDX0g3dM0eujn8qrLdSEA-1
X-Mimecast-MFC-AGG-ID: PgDX0g3dM0eujn8qrLdSEA_1769089457
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5014d8b3ae0so23606421cf.1
        for <kexec@lists.infradead.org>; Thu, 22 Jan 2026 05:44:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769089457; x=1769694257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N2ug2OI629lOhuwxrw3rJzSf72jolaXUrcs8jm5o+hI=;
        b=Cijcu8aAMtMAzc0VSui9HtKnWfCPY+Wrn3p4D6+7JrqMSKTi3EM4rs5Y3aCK7SELye
         cIOE9witRk42UXPNBRcEcC3K206s0PPdndVPTpFDEqMyi3aHQWldy1jYGLoFn3nl2fnD
         6V8kWrNVzy8YvhcVFcwfEVvFWfTgjBlUGFnFdisGFhgI5bHRXQYr6TtdECqELe255xSG
         eqyBMO4+i4Smy47VOYBCqU1KAd+EoKCytai6M7ac90/5KeLPFUceWf8gfa17OOu5Plph
         hTaNFA5hQCVzs7tGOzloTO2kCYZC8F25Zn3P9A6+4e7wpO1fFKXRRTo3FvaxXj/7tDxL
         6svw==
X-Forwarded-Encrypted: i=1; AJvYcCUUWxn01tVNVkKUsZmF4B2NBgJvbZeMqmB5P+nIhp9jkdM+a+t+vxz+MhvZL8okvgvAog/h1w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxm+8jn9juSb/Gc46oJz7zx0M7zNSe7PvnhQXXEWTSbjocA52+8
	hgoGX7S5l+MZj/9JV3Ra1/06/EO+3bHmWQwtSbr4D2hrfZSaUlHrgdfrQq46zwJc39E1I32doCN
	rsd72vLY69VdMvRbxTy5qZtjd3reECi2JlvsEsF9vvIW9b7aq0MPUZiSex9TarySs+EdMFe/AKM
	7zPgG/7nlPBREefoXT498cFE7f+EyspqSJtEb4
X-Gm-Gg: AZuq6aKOieOr7K+YLZVFi2jdy7c23eY/oF0dYWQyt1IU63FTNCcMrGRDmmpIoKPAW++
	CTi2C7ENpwNFyU2x1YKEuqgvJ1s6a3SF/HTglcN+hKcqjTMbWs4C9qsyVQ2EEL3iEPhyiC+sX+y
	JTXGkFKQuwo/NaIYmDeiMA+J8hI8QhOEL91MWEc+Trw04mAjE8ERiLtdR6Uw3ZG8k7wdk=
X-Received: by 2002:ac8:5fd4:0:b0:501:863a:a887 with SMTP id d75a77b69052e-502d85c0b81mr104835281cf.79.1769089457104;
        Thu, 22 Jan 2026 05:44:17 -0800 (PST)
X-Received: by 2002:ac8:5fd4:0:b0:501:863a:a887 with SMTP id
 d75a77b69052e-502d85c0b81mr104835011cf.79.1769089456632; Thu, 22 Jan 2026
 05:44:16 -0800 (PST)
MIME-Version: 1.0
References: <20260120025500.25095-1-ltao@redhat.com> <20260120025500.25095-6-ltao@redhat.com>
 <87ikcuv5ag.fsf@oracle.com>
In-Reply-To: <87ikcuv5ag.fsf@oracle.com>
From: Tao Liu <ltao@redhat.com>
Date: Fri, 23 Jan 2026 02:43:40 +1300
X-Gm-Features: AZwV_QhgGhnU5T2rTvqSP0Vq0xpKhzieICbDD1zgDylvvvsSJiIgDo3Lt7PORsg
Message-ID: <CAO7dBbV-o4pTkaxaiZxfWHV7WDk=3fBc_XWVEs1XNWnvqJw46A@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] Add makedumpfile extension support
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org, 
	aravinda@linux.vnet.ibm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eIH3CSoy5FnjNv2nkW1rxjyS2oP8MTDxU0LTmuE1N_k_1769089457
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260122_054422_478092_66826C38 
X-CRM114-Status: GOOD (  56.58  )
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

Thanks a lot for your quick reply and detailed information, I really
appreciate it!

On Thu, Jan 22, 2026 at 1:51=E2=80=AFPM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Hi Tao,
>
> This series looks really great -- I'm excited to see the switch to
> native .so extensions instead of epicc. I've applied the series locally
> and I'll rebuild my userspace stack inclusion feature based on it, to
> try it out myself.

Awesome, looking forward to your feedback on the code/API designs etc...

>
> In the meantime, I'll share some of my feedback on the patches (though
> I'm not a makedumpfile developer). This seems like the most important
> patch in terms of design, so I'll start here.
>
> Tao Liu <ltao@redhat.com> writes:
> > This patch will add .so extension support to makedumpfile, similar to c=
rash
> > extension to crash utility. Currently only "/usr/lib64/makedumpfile/ext=
ensions"
> > and "./extensions" are searched for extensions. Once found, kallsyms an=
d btf
> > will be initialized so all extensions can benifit from it (Currently ma=
kedumpfile
> > doesn't use these info, we can move the kallsyms/btf init code else whe=
re later
> > if makedumpfile needs them).
> >
> > The makedumpfile extension is to help users to customize mm page filter=
ing upon
> > traditional mm page flag filtering, without make code modification on m=
akedumpfile
> > itself.
> >
> > Signed-off-by: Tao Liu <ltao@redhat.com>
> > ---
> >  Makefile            |  7 +++-
> >  extension.c         | 82 +++++++++++++++++++++++++++++++++++++++++++++
> >  extensions/Makefile | 10 ++++++
> >  makedumpfile.c      |  4 +++
> >  4 files changed, 102 insertions(+), 1 deletion(-)
> >  create mode 100644 extension.c
> >  create mode 100644 extensions/Makefile
> >
> > diff --git a/Makefile b/Makefile
> > index f3f4da8..7e29220 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -45,7 +45,7 @@ CFLAGS_ARCH +=3D -m32
> >  endif
> >
> >  SRC_BASE =3D makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h=
 sadump_info.h
> > -SRC_PART =3D print_info.c dwarf_info.c elf_info.c erase_info.c sadump_=
info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c btf_info.c
> > +SRC_PART =3D print_info.c dwarf_info.c elf_info.c erase_info.c sadump_=
info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c btf_info.c extens=
ion.c
> >  OBJ_PART=3D$(patsubst %.c,%.o,$(SRC_PART))
> >  SRC_ARCH =3D arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia6=
4.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c arch/=
loongarch64.c arch/riscv64.c
> >  OBJ_ARCH=3D$(patsubst %.c,%.o,$(SRC_ARCH))
> > @@ -126,6 +126,7 @@ eppic_makedumpfile.so: extension_eppic.c
> >
> >  clean:
> >       rm -f $(OBJ) $(OBJ_PART) $(OBJ_ARCH) makedumpfile makedumpfile.8 =
makedumpfile.conf.5
> > +     $(MAKE) -C extensions clean
> >
> >  install:
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
> > index 0000000..6ee7f4e
> > --- /dev/null
> > +++ b/extension.c
> > @@ -0,0 +1,82 @@
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <dirent.h>
> > +#include <dlfcn.h>
> > +#include <stdbool.h>
> > +#include "kallsyms.h"
> > +#include "btf_info.h"
> > +
> > +static const char *dirs[] =3D {
> > +     "/usr/lib64/makedumpfile/extensions",
> > +     "./extensions",
> > +};
> > +
> > +/* Will only init once */
> > +static bool init_kallsyms_btf(void)
> > +{
> > +     static bool ret =3D false;
> > +     static bool has_inited =3D false;
> > +
> > +     if (has_inited)
> > +             goto out;
> > +     if (!init_kernel_kallsyms())
> > +             goto out;
> > +     if (!init_kernel_btf())
> > +             goto out;
> > +     if (!init_module_kallsyms())
> > +             goto out;
> > +     if (!init_module_btf())
> > +             goto out;
> > +     ret =3D true;
>
> I feel it would be good practice to load as little information as is
> necessary for the task. If "amdgpu" module is required, then load kernel
> kallsyms, BTF, and then the amdgpu module kallsyms & BTF. If no module
> debuginfo is required, then just the kernel would suffice.
>
> This would reduce memory usage and runtime, though I don't know if it
> would show up in profiling. The main benefit could be reliability: by
> handling less data, there are fewer chances to hit an error.

OK, I agree, mandatory kernel btf/kallsyms info + optional kernel
module btf/kallsyms info is a reasonable design. So kernel modules'
info can be loaded on demand.

>
> > +out:
> > +     has_inited =3D true;
> > +     return ret;
> > +}
> > +
> > +static void cleanup_kallsyms_btf(void)
> > +{
> > +     cleanup_kallsyms();
> > +     cleanup_btf();
> > +}
> > +
> > +void run_extensions(void)
> > +{
> > +     DIR *dir;
> > +     struct dirent *entry;
> > +     size_t len;
> > +     int i;
> > +     void *handle;
> > +     char path[512];
> > +
> > +     for (i =3D 0; i < sizeof(dirs) / sizeof(char *); i++) {
> > +             if ((dir =3D opendir(dirs[i])) !=3D NULL)
> > +                     break;
> > +     }
> > +
> > +     if (!dir || i >=3D sizeof(dirs) / sizeof(char *))
> > +             /* No extensions found */
> > +             return;
>
> It could be confusing that makedumpfile would behave differently with
> the same command-line arguments depending on the presence or absence of
> these extensions on the filesystem.
>
> I think it may fit users' expectations better if they are required to
> specify extensions on the command line. Then we could load them by
> searching each directory in order. This allows:
>
> (a) more expected behavior
> (b) multiple extensions can exist without all being enabled, thus more
>     flexibility
> (c) extensions can be present in the local "extensions/" directory, or
>     in the system directory

Sure, it also sounds reasonable. My original thoughts are, user
customization on mm filtering are specified in .so, and if user don't
need one .so, e.g. amdgpu mm filtering for a nvidia machine, then he
doesn't pack the amdgpu_filter.so into kdump's initramfs. I agree
adding extra makedumpfile cmdline option to receive those needed .so
is a better design.

>
> > +     while ((entry =3D readdir(dir)) !=3D NULL) {
> > +             len =3D strlen(entry->d_name);
> > +             if (len > 3 && strcmp(entry->d_name + len - 3, ".so") =3D=
=3D 0) {
> > +                     /* Will only init when .so exist */
> > +                     if (!init_kallsyms_btf())
> > +                             goto out;
> > +
> > +                     snprintf(path, sizeof(path), "%s/%s", dirs[i], en=
try->d_name);
> > +                     handle =3D dlopen(path, RTLD_NOW);
> > +                     if (!handle) {
> > +                             fprintf(stderr, "%s: Failed to load %s: %=
s\n",
> > +                                     __func__, path, dlerror());
> > +                             continue;
> > +                     }
> > +                     printf("Loaded extension: %s\n", path);
> > +                     dlclose(handle);
>
> Using the constructor/destructor of the shared object is clever! But we
> lose some flexibility: by the time the dlopen() returns, the constructor
> has executed and the plugin has thus executed.
>
> What if we instead use dlsym() to load some symbols from the DSO? In
> particular, I think it would be useful if extensions could declare a
> list of symbols and a list of structure information which they are
> interested in receiving. We could use these lists to know which
> kernel/module kallsyms & BTF we should load. We could even load the
> information into the local variables of the extension, so the extension
> would not need to manually load it.
>
> Of course this is more complex, but the benefit is:
>
> 1. Extensions can be written more simply, and would not need to manually
> load each symbol & type.
> 2. We could eliminate the hash tables for kallsyms & BTF, and eliminate
> the loading of unnecessary module information. Instead, we'd just
> populate the symbol addresses, struct offsets, and type sizes directly
> into the local variables which request them.

It is a clever idea! Though complex for code, I think it is doable.

>
> Again, while I don't want to prematurely optimize -- it's good to avoid
> loading unnecessary information. I hope I've described my idea well. I
> would be happy to work on an implementation of it based on your patches
> here, if you're interested.

Thanks again for your suggestions! I got your points and I think I can
improve the code while waiting for maintainers ideas at the same time.
I will let you know when done or encounter blockers if any.

Thanks,
Tao Liu

>
> Thanks,
> Stephen
>
> > +             }
> > +     }
> > +out:
> > +     closedir(dir);
> > +     cleanup_kallsyms_btf();
> > +}
> > \ No newline at end of file
> > diff --git a/extensions/Makefile b/extensions/Makefile
> > new file mode 100644
> > index 0000000..afbc61e
> > --- /dev/null
> > +++ b/extensions/Makefile
> > @@ -0,0 +1,10 @@
> > +CC ?=3D gcc
> > +CONTRIB_SO :=3D
> > +
> > +all: $(CONTRIB_SO)
> > +
> > +$(CONTRIB_SO): %.so: %.c
> > +     $(CC) -O2 -g -fPIC -shared -o $@ $^
> > +
> > +clean:
> > +     rm -f $(CONTRIB_SO)
> > diff --git a/makedumpfile.c b/makedumpfile.c
> > index dba3628..ca8ed8a 100644
> > --- a/makedumpfile.c
> > +++ b/makedumpfile.c
> > @@ -10847,6 +10847,8 @@ update_dump_level(void)
> >       }
> >  }
> >
> > +void run_extensions(void);
> > +
> >  int
> >  create_dumpfile(void)
> >  {
> > @@ -10884,6 +10886,8 @@ retry:
> >       if (info->flag_refiltering)
> >               update_dump_level();
> >
> > +     run_extensions();
> > +
> >       if ((info->name_filterconfig || info->name_eppic_config)
> >                       && !gather_filter_info())
> >               return FALSE;
> > --
> > 2.47.0
>


