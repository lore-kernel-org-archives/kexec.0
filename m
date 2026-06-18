Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6988DCD98ED
	for <kexec@archiver.kernel.org>; Thu, 18 Jun 2026 08:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qvsgWn11ElfAz4vvnjBrJn1s0KoN8wHMv14aN6kMz4E=; b=AbNJ2Q/RO89s2BH7x/dx+5NGOL
	aVy8cjUBlvRfuv3tRINQ6iveUrljb9guhZ3aeJCo0qbh612XyB4CVthjW6nzMclMiMaUUEJh0HH2X
	QWAEIKw/fJf8ul0B7NOpRiU8P4fP+tjftk8bvpMN7NnvZs4Xnt8o+zYJEKn1zjPeVvP3tFuiv37Jv
	uKPdflFyHWjmYgarjxkp/dyWZp/dYLXlkTvGcOTywZJP7EjRquypRwuMKTBbSEsSBBNMmqJp1FJ6A
	OyM+1fOaZAf3r0Jpdtk+hHXxXnVdbM7cXzl1liw0bwACerCj3WH8rHBhiyG1FfhrVTXPhA3J9jzHw
	PcoN+l7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wa8SW-00000000sfR-3kfx;
	Thu, 18 Jun 2026 08:50:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wa8ST-00000000sf1-3849
	for kexec@lists.infradead.org;
	Thu, 18 Jun 2026 08:50:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781772643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qvsgWn11ElfAz4vvnjBrJn1s0KoN8wHMv14aN6kMz4E=;
	b=An2SP7KZHQFHFAQm42yLFckuBWKojEm/cIf6fWfQ0kYUyS2YedXjYr5DtVebaAhOblD8EJ
	0pwb8szG9ohweudoiaMja2+2p4GlO500LEYYfACnkRBpL4wJEXQbSNvYGPjj32oUyLh3hi
	fM/TbiGJ3vu5Kfd1s3CFx1Kd46IEU0o=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-ORnrKPIrP2ebn58xqlYhHQ-1; Thu, 18 Jun 2026 04:50:41 -0400
X-MC-Unique: ORnrKPIrP2ebn58xqlYhHQ-1
X-Mimecast-MFC-AGG-ID: ORnrKPIrP2ebn58xqlYhHQ_1781772641
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-517ac42d958so17184741cf.0
        for <kexec@lists.infradead.org>; Thu, 18 Jun 2026 01:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781772641; x=1782377441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qvsgWn11ElfAz4vvnjBrJn1s0KoN8wHMv14aN6kMz4E=;
        b=YoO6kw6spLtUcFLlRqRwUJuRLTcuqaNNcs0L8YqySqOSFlEi8yxYuVAYjyEplB4Pb+
         ZgFDWy4GjxTRCgIrn8oLLT8A6CJIvR+2/8rMYwiPZ/WDvjA8qBWnGh/i3iZ37sL/d6Sl
         Ua7NttOfcRiG4qtYQR30QFLOmoY51z0XCwIgmfSJTq+SDEcPoB5WllTmAeYqhhSd/c4n
         bI9UN8GFWPfTFL9cE58ec93uQCgB41Pm1sxSEjtzkvs5ce4fWY6cecsFi63MO0isGPYg
         zUTDWTZl3SQAn8Q3dEQo5T/y4MvYg1aIvhfS6Q7XKUd79e1EXThMw+0Y5oufxnMUz12q
         8XhQ==
X-Forwarded-Encrypted: i=1; AFNElJ9JY4Ac0MuWjWF/Iav7tI+8BpPBdOvt2hfUNy5c5aPu1ZrhAd6C5Apofm1L0uAmP39/1evBSg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzJ+AQqDWG9+glbrWmJHqit+oEW0bZxW/XOkZd9EOSKsHPMPaJh
	g0i+BKPRdoIUchaahKnW75Pi14xSYD16FcSDPHYaQMvaHg/7yp7lyiBxxhlqXhFAqfAJBxVrzyQ
	lH3jAShvmSXUjZnPkRzggHXoWzXuPcXJiSwOfRxqkddqqQFqv3aFXh3rRbk1YyTnhEP7Zjv5X6T
	p11eCOzpLF/5r7HHiQR3GaiMeW/BBHoSjQL4o+PhT2wedu/ic=
X-Gm-Gg: Acq92OGsxRPIEbdwEjult6mbwPmUC+fnOaGD6tQVTHTZJDBFxDMtUESRLWN1P/k5PPl
	b+yNN5gXMx65N8z/muupoBrdtlUTgX3eUQaH3UXlOKUhLSch3y4MeFTTPP8JX5SM295m9DP+xKM
	dYt4Z72feHbJDj2TLDCkFApczVlPChu2iiMLcFH46DHBPhyjYgCll5GtEGzzEcZLDerdc=
X-Received: by 2002:a05:622a:5887:b0:517:7e26:36a9 with SMTP id d75a77b69052e-519ac4e517fmr102582601cf.39.1781772640773;
        Thu, 18 Jun 2026 01:50:40 -0700 (PDT)
X-Received: by 2002:a05:622a:5887:b0:517:7e26:36a9 with SMTP id
 d75a77b69052e-519ac4e517fmr102582321cf.39.1781772640320; Thu, 18 Jun 2026
 01:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260617051834.95404-1-ltao@redhat.com> <20260617051834.95404-3-ltao@redhat.com>
 <30fe770e-286e-4272-bb7e-0e9ad01cecc5@nec.com>
In-Reply-To: <30fe770e-286e-4272-bb7e-0e9ad01cecc5@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Thu, 18 Jun 2026 20:50:03 +1200
X-Gm-Features: AVVi8CdjuEVeIOMGPsrxPgd6afXD8qo7-76e-48dCSaUpqF513d0cDjPwpr3Rhs
Message-ID: <CAO7dBbWUpZDRhKLG7XB7qcMONo-GuwBmhTZxnax+cNdmRYtU8g@mail.gmail.com>
Subject: Re: [PATCH v6][makedumpfile 02/10] Implement kernel kallsyms resolving
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: =?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"aravinda@linux.vnet.ibm.com" <aravinda@linux.vnet.ibm.com>, 
	"stephen.s.brennan@oracle.com" <stephen.s.brennan@oracle.com>, 
	"kjlx@templeofstupid.com" <kjlx@templeofstupid.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: js-DmvXm_u4CcS0ONdjsOhxEKJ-KofFCbE-F35mwoc0_1781772641
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260618_015045_887063_F81BCB6B 
X-CRM114-Status: GOOD (  22.16  )
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

Yes, it is needed for reallocarray() in kallsyms.c. For "man
reallocarray" gives:

       reallocarray():
           Since glibc 2.29:
               _DEFAULT_SOURCE
           glibc 2.28 and earlier:
               _GNU_SOURCE

For glibc <=3D 2.28, we need to use _GNU_SOURCE in order to use
reallocarray(). E.g I can encounter the compiling warning in rhel8
once removed.

kallsyms.c: In function =E2=80=98add_to_arr=E2=80=99:
kallsyms.c:46:9: warning: implicit declaration of function
=E2=80=98reallocarray=E2=80=99; did you mean =E2=80=98realloc=E2=80=99?
[-Wimplicit-function-declaration]
   tmp =3D reallocarray(*arr, new_cap, sizeof(void *));
         ^~~~~~~~~~~~
         realloc
kallsyms.c:46:7: warning: assignment to =E2=80=98void *=E2=80=99 from =E2=
=80=98int=E2=80=99 makes
pointer from integer without a cast [-Wint-conversion]
   tmp =3D reallocarray(*arr, new_cap, sizeof(void *));
       ^

Thanks,
Tao Liu

On Thu, Jun 18, 2026 at 8:28=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=
=E3=80=80=E4=B8=80=E4=BB=81)
<k-hagio-ab@nec.com> wrote:
>
> Hi Tao,
>
> On 2026/06/17 14:18, Tao Liu wrote:
> > This patch will parse kernel's kallsyms data. During the parsing
> > process, the .init_ksyms sections of makedumpfile and the
> > extensions will be iterated, so the kallsyms symbols which belongs
> > to vmlinux can be resolved at this moment.
> >
> > Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> > Signed-off-by: Tao Liu <ltao@redhat.com>
> > ---
> >   Makefile       |   2 +-
> >   kallsyms.c     | 392 ++++++++++++++++++++++++++++++++++++++++++++++++=
+
> >   kallsyms.h     |  83 +++++++++++
> >   makedumpfile.c |   3 +
> >   makedumpfile.h |  11 ++
> >   5 files changed, 490 insertions(+), 1 deletion(-)
> >   create mode 100644 kallsyms.c
> >   create mode 100644 kallsyms.h
> >
> > diff --git a/Makefile b/Makefile
> > index 9482332..3cd729f 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -45,7 +45,7 @@ CFLAGS_ARCH +=3D -m32
> >   endif
> >
> >   SRC_BASE =3D makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.=
h sadump_info.h
> > -SRC_PART =3D print_info.c dwarf_info.c elf_info.c erase_info.c sadump_=
info.c cache.c tools.c printk.c detect_cycle.c
> > +SRC_PART =3D print_info.c dwarf_info.c elf_info.c erase_info.c sadump_=
info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c
> >   OBJ_PART=3D$(patsubst %.c,%.o,$(SRC_PART))
> >   SRC_ARCH =3D arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia=
64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c arch=
/loongarch64.c arch/riscv64.c
> >   OBJ_ARCH=3D$(patsubst %.c,%.o,$(SRC_ARCH))
> > diff --git a/kallsyms.c b/kallsyms.c
> > new file mode 100644
> > index 0000000..a55dcc6
> > --- /dev/null
> > +++ b/kallsyms.c
> > @@ -0,0 +1,392 @@
> > +#define _GNU_SOURCE
>
> Just for confirmation, is this for what?  I can build without this line.
>
> $ git grep _GNU_SOURCE
> kallsyms.c:#define _GNU_SOURCE
>
> If unnecessary, I would not like to add something new for compatibility.
> is it ok to remove this when merging?
>
> Thanks,
> Kazu


