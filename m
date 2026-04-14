Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E08F531E8
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 11:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uIqBdHGleBayBd6RqaDo/em7kxO8SnlaVAkvgImACpY=; b=Qp988cNy/0LCHFb+yOW2EzrLoa
	ZXfC/k+kFxZbSxAEJnYV+nN7QfbPX6HdqPmOnMosRRNwtXRrS8CuW4AXnAU+VTtV8Ke5itvYzDVms
	yi76O3cGDIwr6NnhUswaMgtdgbghZjfMh70B47qurmABGN6UI8RCSyeXSZiQSJH7YofjlICKiam00
	gfsrf7XCK3/kQIUYsMSENXpUidJ7a5FvHgl8hXenoJjGmuXcalD59u/ZCT0Dw7wxuqL2oMCuXykni
	DLRuUhSxpjwmXOwDu0E/Iu9tGe2weWjBA5MdTAYkO935Zp90DtiuijUWYxTp+9wr4aIe1SKY/LGr8
	M+WSxnHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCbg8-0000000HDJ7-1eT0;
	Tue, 14 Apr 2026 11:11:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCbg5-0000000HDIk-1DIb
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 11:11:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776165092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uIqBdHGleBayBd6RqaDo/em7kxO8SnlaVAkvgImACpY=;
	b=RdbXOX2PfG5LY6++IQSQeqdkhWEGjqTbqlWZ5SBvxwy59CuqsG4oU8JqbSfKERlJzRB31E
	esyq9jVGgthq5MoiSQovvR2/o2VWw97X/Kfq/IEBgu4l1M6cc6zcRrBRgMkiua74LQf0XI
	8mvaejs4jMQPIv6G5OjP3El7RNVEG9M=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-cJYfSXysO3aIVhTNDeUIfg-1; Tue, 14 Apr 2026 07:11:31 -0400
X-MC-Unique: cJYfSXysO3aIVhTNDeUIfg-1
X-Mimecast-MFC-AGG-ID: cJYfSXysO3aIVhTNDeUIfg_1776165090
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b4031b86dso147618451cf.0
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 04:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776165090; x=1776769890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uIqBdHGleBayBd6RqaDo/em7kxO8SnlaVAkvgImACpY=;
        b=T8bkj6dBvRWR4XFSUlX23CTjoC6n2zrsZs+oyk/THeKTUGPL5a/edrsXL1DHXGMwWN
         EnGj4y+uiwU6KnOb1oXlPx8lSs5KCeaXnBMTiEORuVlhcpJg+b6p53xLdoLP3PpqEBq4
         U4zq7FRHgdPTypajZ8HszAa06JO37L5/IDnsGXWZwGp0yIrHeP0qlYytQmMJGR1X+SGs
         ekfqVc7BwmHoIOXBQ8vZ5nsEPBS5DYt9mi92OwCU+Eb0ObcM4UeILl0UFuq9rBKFBruQ
         rMUKk2NBWNb6M58HzBBpDY0eAZsx9a8vJY4Ume3DfuZiRrfBDDuWwcDe2ibCI6AGeZTt
         EefQ==
X-Forwarded-Encrypted: i=1; AFNElJ90Orr+JLXla0QAaOfoJSQCb/DZi78FOXwBuHuh8FjsZYRQYWqPeBw+PRzWLHlO+PsVxqen2A==@lists.infradead.org
X-Gm-Message-State: AOJu0YzxTmfirdXwSM4G6rXvAuWJTXzp9+4uNPsZq7mRcM7kWpRCD3fj
	2yb9KJxW3ZxwvKs/ee4V/C+rW1GRFPzqzKLi8yt8Y5O7nUMRhkDi7cjh/rk5ZZmbRewjxWl3psA
	M1K8xwKEL7IhjDSWYOl3OtBiYimIMcgMI9w7Tl3jaJ5qVLGXTEM+T8mE5jl+TRkj8M8u+WpaGbi
	hxk0JYSJqEiyo0wuF2LuXueNsNOqPGVMPaSQqZN8Eo0BAnpWc=
X-Gm-Gg: AeBDieuWvrDxwHUo0W0VR6V+6MzrXJeGAKf1LFPbgKqOgsUNv3vGL71UY5FU5H2nDx1
	wO9+Y4TvoLI5Z4EvnokRMgjg9eWNdb9imsrm/BVCKuq0S0Rwh0PG1UYoh4XMCH2CHLb8arqo6Kw
	YFuyqzRgoFFmagnnJS8PDhLKdyCheek1mekC+P5zUvOr83WKO1KxIXsZuy49FJL/i4id6c2V8NU
	W+szgaescyFTQ==
X-Received: by 2002:ac8:5f51:0:b0:50b:3831:417f with SMTP id d75a77b69052e-50dd5bbed2cmr236831951cf.45.1776165089952;
        Tue, 14 Apr 2026 04:11:29 -0700 (PDT)
X-Received: by 2002:ac8:5f51:0:b0:50b:3831:417f with SMTP id
 d75a77b69052e-50dd5bbed2cmr236831261cf.45.1776165089274; Tue, 14 Apr 2026
 04:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260317150743.69590-1-ltao@redhat.com> <20260317150743.69590-3-ltao@redhat.com>
 <308b1818-9f00-4806-aa4f-4868f39f330e@nec.com>
In-Reply-To: <308b1818-9f00-4806-aa4f-4868f39f330e@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 14 Apr 2026 23:10:52 +1200
X-Gm-Features: AQROBzB7NwO28GXZPIkfdZ_gkE49Hjct3Sqe7EfQQubak1iwy4ma-qET1XA5vuw
Message-ID: <CAO7dBbUz8rTVWHb75ONeB5Xg9GdJ=Z7eXkaq_Y2+npp4LwebsA@mail.gmail.com>
Subject: Re: [PATCH v4][makedumpfile 2/7] Implement kernel kallsyms resolving
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: "stephen.s.brennan@oracle.com" <stephen.s.brennan@oracle.com>, 
	=?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7y0oPy9L6jukhtIDqK4BKcYF8xTGvzHSbNrKCmZoj4E_1776165090
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_041133_507905_F9D4AFBD 
X-CRM114-Status: GOOD (  37.47  )
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

On Fri, Apr 3, 2026 at 9:12=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=E3=
=80=80=E4=B8=80=E4=BB=81) <k-hagio-ab@nec.com> wrote:
>
> On 2026/03/18 0:07, Tao Liu wrote:
> > This patch will parse kernel's kallsyms data. During the parsing
> > process, the .init_ksyms sections of makedumpfile and the
> > extensions will be iterated, so the kallsyms symbols which belongs
> > to vmlinux can be resolved at this moment.
> >
> > Suggested-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> > Signed-off-by: Tao Liu <ltao@redhat.com>
> > ---
> >   Makefile       |   2 +-
> >   kallsyms.c     | 350 ++++++++++++++++++++++++++++++++++++++++++++++++=
+
> >   kallsyms.h     |  91 +++++++++++++
> >   makedumpfile.c |   3 +
> >   makedumpfile.h |  11 ++
> >   5 files changed, 456 insertions(+), 1 deletion(-)
> >   create mode 100644 kallsyms.c
> >   create mode 100644 kallsyms.h
> >
> > diff --git a/Makefile b/Makefile
> > index 15a4ba0..a57185e 100644
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
> > index 0000000..f7737cb
> > --- /dev/null
> > +++ b/kallsyms.c
> > @@ -0,0 +1,350 @@
> > +#include <stdint.h>
> > +#include <stdbool.h>
> > +#include <string.h>
> > +#include "makedumpfile.h"
> > +#include "kallsyms.h"
> > +
> > +static uint32_t *kallsyms_offsets =3D NULL;
> > +static uint16_t *kallsyms_token_index =3D NULL;
> > +static uint8_t  *kallsyms_token_table =3D NULL;
> > +static uint8_t  *kallsyms_names =3D NULL;
> > +static unsigned long kallsyms_relative_base =3D 0;
> > +static unsigned int kallsyms_num_syms =3D 0;
> > +
> > +/* makedumpfile & extensions' .init_ksyms section range array */
> > +static struct section_range **sr =3D NULL;
> > +static int sr_len =3D 0;
> > +static int sr_cap =3D 0;
> > +
> > +/* Which mod's kallsyms should be inited? */
> > +static char **mods =3D NULL;
> > +static int mods_len =3D 0;
> > +static int mods_cap =3D 0;
> > +
> > +INIT_KERN_SYM(_stext);
> > +
> > +/*
> > + * Utility: add elem to arr, which can auto extend its capacity.
> > + * (*arr) is a pointer array, holding pointers of elem
> > +*/
> > +bool add_to_arr(void ***arr, int *arr_len, int *arr_cap, void *elem)
> > +{
> > +     void *tmp;
> > +     int new_cap =3D 0;
> > +
> > +     if (*arr =3D=3D NULL) {
> > +             *arr_len =3D 0;
> > +             new_cap =3D 4;
> > +     } else if (*arr_len >=3D *arr_cap) {
> > +             new_cap =3D (*arr_cap) + ((*arr_cap) >> 1);
> > +     }
> > +
> > +     if (new_cap) {
> > +             tmp =3D reallocarray(*arr, new_cap, sizeof(void *));
> > +             if (!tmp)
> > +                     goto no_mem;
> > +             *arr =3D tmp;
> > +             *arr_cap =3D new_cap;
> > +     }
> > +
> > +     (*arr)[(*arr_len)++] =3D elem;
> > +     return true;
> > +
> > +no_mem:
> > +     fprintf(stderr, "%s: Not enough memory!\n", __func__);
>
> Could you use ERRMSG() or MSG() instead of fprintf/printf for message
> control, through the patchset?

Fixed in v5.

>
>
> > +     return false;
> > +}
> > +
> > +/*
> > + * Utility: add uniq string to arr, which can auto extend its capacity=
.
> > +*/
> > +bool push_uniq_str(void ***arr, int *arr_len, int *arr_cap, char *str)
> > +{
> > +     for (int i =3D 0; i < (*arr_len); i++) {
> > +             if (!strcmp((*arr)[i], str))
> > +                     /* String already exists, skip it */
> > +                     return true;
> > +     }
> > +     return add_to_arr(arr, arr_len, arr_cap, str);
> > +}
> > +
> > +static bool add_ksym_modname(char *modname)
> > +{
> > +     return push_uniq_str((void ***)&mods, &mods_len, &mods_cap, modna=
me);
> > +}
> > +
> > +bool check_ksyms_require_modname(char *modname, int *total)
> > +{
> > +     if (total)
> > +             *total =3D mods_len;
> > +     for (int i =3D 0; i < mods_len; i++) {
> > +             if (!strcmp(modname, mods[i]))
> > +                     return true;
> > +     }
> > +     return false;
> > +}
> > +
> > +static void cleanup_ksyms_modname(void)
> > +{
> > +     if (mods) {
> > +             free(mods);
> > +             mods =3D NULL;
> > +     }
> > +     mods_len =3D 0;
> > +     mods_cap =3D 0;
> > +}
> > +
> > +/*
> > + * Used by makedumpfile and extensions, to register their .init_ksyms =
section.
> > + * so kallsyms can know which module/sym should be inited.
> > +*/
> > +REGISTER_SECTION(ksym)
> > +
> > +static void cleanup_ksyms_section_range(void)
> > +{
> > +     for (int i =3D 0; i < sr_len; i++) {
> > +             free(sr[i]);
> > +     }
> > +     if (sr) {
> > +             free(sr);
> > +             sr =3D NULL;
> > +     }
> > +     sr_len =3D 0;
> > +     sr_cap =3D 0;
> > +}
> > +
> > +static uint64_t absolute_percpu(uint64_t base, int32_t val)
> > +{
> > +     if (val >=3D 0)
> > +             return (uint64_t)val;
> > +     else
> > +             return base - 1 - val;
> > +}
> > +
> > +static uint64_t calc_addr_absolute_percpu(struct ksym_info *p)
> > +{
> > +     return absolute_percpu(kallsyms_relative_base, p->value);
> > +}
> > +
> > +static uint64_t calc_addr_relative_base(struct ksym_info *p)
> > +{
> > +     return p->value + kallsyms_relative_base;
> > +}
> > +
> > +static uint64_t calc_addr_place_relative(struct ksym_info *p)
> > +{
> > +     return SYMBOL(kallsyms_offsets) + p->index * sizeof(uint32_t) +
> > +             (int32_t)kallsyms_offsets[p->index];
> > +}
> > +
> > +#define BUFLEN 1024
> > +static bool parse_kernel_kallsyms(void)
> > +{
> > +     char buf[BUFLEN];
>
> There already is BUFSIZE, which is the same value.
>
I have removed it and used BUFSIZE instead.

>
> > +     int index =3D 0, i, j;
> > +     uint8_t *compressd_data;
> > +     uint8_t *uncompressd_data;
> > +     uint8_t len, len_old;
> > +     struct ksym_info **p;
> > +     uint64_t (*calc_addr)(struct ksym_info *);
> > +     struct ksym_info *stext_p;
> > +
> > +     for (i =3D 0; i < kallsyms_num_syms; i++) {
> > +             memset(buf, 0, BUFLEN);
> > +             len =3D kallsyms_names[index];
> > +             if (len & 0x80) {
> > +                     index++;
> > +                     len_old =3D len;
> > +                     len =3D kallsyms_names[index];
> > +                     if (len & 0x80) {
> > +                             fprintf(stderr, "%s: BUG! Unexpected 3-by=
te length,"
> > +                                     " should be detected in init_kern=
el_kallsyms()\n",
> > +                                     __func__);
> > +                             goto out;
> > +                     }
> > +                     len =3D (len_old & 0x7F) | (len << 7);
> > +             }
> > +             index++;
> > +
> > +             compressd_data =3D &kallsyms_names[index];
> > +             index +=3D len;
> > +             while (len--) {
> > +                     uncompressd_data =3D &kallsyms_token_table[kallsy=
ms_token_index[*compressd_data]];
> > +                     if (strlen(buf) + strlen((char *)uncompressd_data=
) >=3D BUFLEN) {
> > +                             goto next_symbol;
> > +                     }
> > +                     strcat(buf, (char *)uncompressd_data);
> > +                     compressd_data++;
> > +             }
> > +
> > +             /* Now check if the symbol is we wanted */
> > +             for (j =3D 0; j < sr_len; j++) {
> > +                     for (p =3D (struct ksym_info **)(sr[j]->start);
> > +                          p < (struct ksym_info **)(sr[j]->stop);
> > +                          p++) {
> > +                             if (!strcmp((*p)->modname, "vmlinux") &&
> > +                                 !strcmp((*p)->symname, &buf[1])) {
> > +                                     (*p)->value =3D kallsyms_offsets[=
i];
> > +                                     (*p)->index =3D i;
> > +                             }
> > +                     }
> > +             }
> > +next_symbol:
>
> gcc-8.5.0 rejects this style, how about adding ";" here to avoid this?
>
> kallsyms.c: In function =E2=80=98parse_kernel_kallsyms=E2=80=99:
> kallsyms.c:193:1: error: label at end of compound statement
>   next_symbol:
>   ^~~~~~~~~~~
> make: *** [Makefile:109: kallsyms.o] Error 1

I reproduced the error in rhel8 compiling. Sorry I didn't test the
compiling against rhel8 before so missed this. Removed the next_symbol
tag in v5.

>
>
> > +     }
> > +
> > +     /* Check the approach for calc absolute kallsyms address
> > +      *
> > +      * A complete comment of each approaches please refer to:
> > +      * https://github.com/osandov/drgn/commit/744f36ec3c3f64d7e1323a0=
037898158698585c4
> > +      */
> > +     if (!KERN_SYM_EXIST(_stext)) {
> > +             fprintf(stderr, "%s: symbol _stext not found!\n", __func_=
_);
> > +             goto out;
> > +     }
> > +
> > +     stext_p =3D GET_KERN_SYM_PTR(_stext);
> > +
> > +     if (SYMBOL(_stext) =3D=3D calc_addr_absolute_percpu(stext_p)) {
> > +             calc_addr =3D calc_addr_absolute_percpu;
> > +     } else if (SYMBOL(_stext) =3D=3D calc_addr_relative_base(stext_p)=
) {
> > +             calc_addr =3D calc_addr_relative_base;
> > +     } else if (SYMBOL(_stext) =3D=3D calc_addr_place_relative(stext_p=
)) {
> > +             calc_addr =3D calc_addr_place_relative;
> > +     } else {
> > +             fprintf(stderr, "%s: Wrong calculate kallsyms symbol valu=
e!\n", __func__);
> > +             goto out;
> > +     }
> > +
> > +     /* Now do the calc */
> > +     for (j =3D 0; j < sr_len; j++) {
> > +             for (p =3D (struct ksym_info **)(sr[j]->start);
> > +                  p < (struct ksym_info **)(sr[j]->stop);
> > +                  p++) {
> > +                     if (!strcmp((*p)->modname, "vmlinux") &&
> > +                         SYM_EXIST(*p)) {
> > +                             (*p)->value =3D calc_addr(*p);
> > +                     }
> > +             }
> > +     }
> > +
> > +     return true;
> > +out:
> > +     return false;
> > +}
> > +
> > +static bool vmcore_info_ready =3D false;
> > +
> > +bool read_vmcoreinfo_kallsyms(void)
> > +{
> > +     READ_SYMBOL("kallsyms_names", kallsyms_names);
> > +     READ_SYMBOL("kallsyms_num_syms", kallsyms_num_syms);
> > +     READ_SYMBOL("kallsyms_token_table", kallsyms_token_table);
> > +     READ_SYMBOL("kallsyms_token_index", kallsyms_token_index);
> > +     READ_SYMBOL("kallsyms_offsets", kallsyms_offsets);
> > +     READ_SYMBOL("kallsyms_relative_base", kallsyms_relative_base);
> > +     vmcore_info_ready =3D true;
> > +     return true;
> > +}
> > +
> > +/*
> > + * Makedumpfile's .init_ksyms section
> > +*/
> > +extern struct ksym_info *__start_init_ksyms[];
> > +extern struct ksym_info *__stop_init_ksyms[];
> > +
> > +bool init_kernel_kallsyms(void)
> > +{
> > +     const int token_index_size =3D (UINT8_MAX + 1) * sizeof(uint16_t)=
;
> > +     uint64_t last_token, len;
> > +     unsigned char data, data_old;
> > +     int i;
> > +     bool ret =3D false;
> > +
> > +     if (vmcore_info_ready =3D=3D false) {
> > +             fprintf(stderr, "%s: vmcoreinfo not ready for kallsyms!\n=
",
> > +                     __func__);
> > +             return ret;
> > +     }
> > +
> > +     if (!register_ksym_section((char *)__start_init_ksyms,
> > +                                (char *)__stop_init_ksyms))
> > +             return ret;
> > +
> > +     readmem(VADDR, SYMBOL(kallsyms_num_syms), &kallsyms_num_syms,
> > +             sizeof(kallsyms_num_syms));
> > +     if (SYMBOL(kallsyms_relative_base) !=3D NOT_FOUND_SYMBOL)
> > +             readmem(VADDR, SYMBOL(kallsyms_relative_base),
> > +                     &kallsyms_relative_base, sizeof(kallsyms_relative=
_base));
> > +
> > +     kallsyms_offsets =3D malloc(sizeof(uint32_t) * kallsyms_num_syms)=
;
> > +     if (!kallsyms_offsets)
> > +             goto no_mem;
> > +     readmem(VADDR, SYMBOL(kallsyms_offsets), kallsyms_offsets,
> > +             kallsyms_num_syms * sizeof(uint32_t));
> > +
> > +     kallsyms_token_index =3D malloc(token_index_size);
> > +     if (!kallsyms_token_index)
> > +             goto no_mem;
> > +     readmem(VADDR, SYMBOL(kallsyms_token_index), kallsyms_token_index=
,
> > +             token_index_size);
> > +
> > +     last_token =3D SYMBOL(kallsyms_token_table) + kallsyms_token_inde=
x[UINT8_MAX];
> > +     do {
> > +             readmem(VADDR, last_token++, &data, 1);
> > +     } while(data);
> > +     len =3D last_token - SYMBOL(kallsyms_token_table);
> > +     kallsyms_token_table =3D malloc(len);
> > +     if (!kallsyms_token_table)
> > +             goto no_mem;
> > +     readmem(VADDR, SYMBOL(kallsyms_token_table), kallsyms_token_table=
, len);
> > +
> > +     for (len =3D 0, i =3D 0; i < kallsyms_num_syms; i++) {
> > +             readmem(VADDR, SYMBOL(kallsyms_names) + len, &data, 1);
> > +             /*
> > +              * The 2-byte representation was added in commit 73bbb944=
66fd3
> > +              * ("kallsyms: support "big" kernel symbols") in v6.1, th=
us for
> > +              * v6.1+, they indicate a long symbol, but for kernel ver=
sions
> > +              * prior to v6.1, they might be ambiguous.
> > +              */
> > +             if (data & 0x80) {
> > +                     len +=3D 1;
> > +                     data_old =3D data;
> > +                     readmem(VADDR, SYMBOL(kallsyms_names) + len, &dat=
a, 1);
> > +                     if (data & 0x80) {
> > +                             fprintf(stderr, "%s: BUG! Unexpected 3-by=
te length"
> > +                                     " encoding in kallsyms names\n", =
__func__);
> > +                             goto out;
> > +                     }
> > +                     data =3D (data_old & 0x7F) | (data << 7);
> > +             }
> > +             len +=3D data + 1;
> > +     }
> > +     kallsyms_names =3D malloc(len);
> > +     if (!kallsyms_names)
> > +             goto no_mem;
> > +     readmem(VADDR, SYMBOL(kallsyms_names), kallsyms_names, len);
> > +
> > +     ret =3D parse_kernel_kallsyms();
> > +     goto out;
> > +
> > +no_mem:
> > +     fprintf(stderr, "%s: Not enough memory!\n", __func__);
> > +out:
> > +     if (kallsyms_offsets) {
> > +             free(kallsyms_offsets);
> > +             kallsyms_offsets =3D NULL;
> > +     }
> > +     if (kallsyms_token_index) {
> > +             free(kallsyms_token_index);
> > +             kallsyms_token_index =3D NULL;
> > +     }
> > +     if (kallsyms_token_table) {
> > +             free(kallsyms_token_table);
> > +             kallsyms_token_table =3D NULL;
> > +     }
> > +     if (kallsyms_names) {
> > +             free(kallsyms_names);
> > +             kallsyms_names =3D NULL;
> > +     }
> > +     return ret;
> > +}
> > \ No newline at end of file
> > diff --git a/kallsyms.h b/kallsyms.h
> > new file mode 100644
> > index 0000000..3791284
> > --- /dev/null
> > +++ b/kallsyms.h
> > @@ -0,0 +1,91 @@
> > +#ifndef _KALLSYMS_H
> > +#define _KALLSYMS_H
> > +
> > +#include <stdint.h>
> > +#include <stdbool.h>
> > +
> > +struct ksym_info {
> > +     /********in******/
> > +     char *modname;
> > +     char *symname;
> > +     bool sym_required;
> > +     /********out*****/
> > +     uint64_t value;
> > +     int index;      // -1 if sym not found
> > +};
> > +
> > +#define QUATE(x) #x
>
> Is this intended?  I think what this does is "quote"..

I removed QUATE(x) macro, but use #x directly in v5 macros.

>
> Thanks,
> Kazu
>
>
> > +#define INIT_MOD_SYM_RQD(MOD, SYM, R)                        \
> > +     struct ksym_info _##MOD##_##SYM =3D {             \
> > +             QUATE(MOD), QUATE(SYM), R, 0, -1        \
> > +     };                                              \
> > +     __attribute__((section(".init_ksyms"), used))   \
> > +     struct ksym_info * _ptr_##MOD##_##SYM =3D &_##MOD##_##SYM
> > +
> > +#define GET_MOD_SYM(MOD, SYM) (_##MOD##_##SYM.value)
> > +#define GET_MOD_SYM_PTR(MOD, SYM) (&_##MOD##_##SYM)
> > +#define MOD_SYM_EXIST(MOD, SYM) (_##MOD##_##SYM.index >=3D 0)
> > +#define SYM_EXIST(p) ((p)->index >=3D 0)
> > +
> > +#define GET_KERN_SYM(SYM) GET_MOD_SYM(vmlinux, SYM)
> > +#define GET_KERN_SYM_PTR(SYM) GET_MOD_SYM_PTR(vmlinux, SYM)
> > +#define KERN_SYM_EXIST(SYM) MOD_SYM_EXIST(vmlinux, SYM)
> > +
> > +/*
> > + * Required syms will be checked automatically before extension runnin=
g.
> > + * Optinal syms should be checked manually at extension runtime.
> > + */
> > +#define INIT_MOD_SYM(MOD, SYM) INIT_MOD_SYM_RQD(MOD, SYM, 1)
> > +#define INIT_OPT_MOD_SYM(MOD, SYM) INIT_MOD_SYM_RQD(MOD, SYM, 0)
> > +
> > +#define INIT_KERN_SYM(SYM) INIT_MOD_SYM(vmlinux, SYM)
> > +#define INIT_OPT_KERN_SYM(SYM) INIT_OPT_MOD_SYM(vmlinux, SYM)
> > +
> > +struct section_range {
> > +     char *start;
> > +     char *stop;
> > +};
> > +
> > +#define REGISTER_SECTION(T)                                          \
> > +bool register_##T##_section(char *start, char *stop)                 \
> > +{                                                                    \
> > +     struct section_range *new_sr;                                   \
> > +     struct T##_info **p;                                            \
> > +     bool ret =3D false;                                              =
 \
> > +                                                                     \
> > +     if (!start || !stop) {                                          \
> > +             fprintf(stderr, "%s: Invalid section start/stop\n",     \
> > +                     __func__);                                      \
> > +             goto out;                                               \
> > +     }                                                               \
> > +                                                                     \
> > +     for (p =3D (struct T##_info **)start;                            =
 \
> > +          p < (struct T##_info **)stop;                              \
> > +          p++) {                                                     \
> > +             if (!add_##T##_modname((*p)->modname))                  \
> > +                     goto out;                                       \
> > +     }                                                               \
> > +                                                                     \
> > +     new_sr =3D malloc(sizeof(struct section_range));                 =
 \
> > +     if (!new_sr) {                                                  \
> > +             fprintf(stderr, "%s: Not enough memory!\n", __func__);  \
> > +             goto out;                                               \
> > +     }                                                               \
> > +     new_sr->start =3D start;                                         =
 \
> > +     new_sr->stop =3D stop;                                           =
 \
> > +     if (!add_to_arr((void ***)&sr, &sr_len, &sr_cap, new_sr)) {     \
> > +             free(new_sr);                                           \
> > +             goto out;                                               \
> > +     }                                                               \
> > +     ret =3D true;                                                    =
 \
> > +out:                                                                 \
> > +     return ret;                                                     \
> > +}
> > +
> > +bool add_to_arr(void ***arr, int *arr_len, int *arr_cap, void *elem);
> > +bool push_uniq_str(void ***arr, int *arr_len, int *arr_cap, char *str)=
;
> > +bool check_ksyms_require_modname(char *modname, int *total);
> > +bool register_ksym_section(char *start, char *stop);
> > +bool read_vmcoreinfo_kallsyms(void);
> > +bool init_kernel_kallsyms(void);
> > +#endif /* _KALLSYMS_H */
> > \ No newline at end of file
> > diff --git a/makedumpfile.c b/makedumpfile.c
> > index 12fb0d8..dba3628 100644
> > --- a/makedumpfile.c
> > +++ b/makedumpfile.c
> > @@ -27,6 +27,7 @@
> >   #include <limits.h>
> >   #include <assert.h>
> >   #include <zlib.h>
> > +#include "kallsyms.h"
> >
> >   struct symbol_table symbol_table;
> >   struct size_table   size_table;
> > @@ -3105,6 +3106,8 @@ read_vmcoreinfo_from_vmcore(off_t offset, unsigne=
d long size, int flag_xen_hv)
> >               if (!read_vmcoreinfo())
> >                       goto out;
> >       }
> > +     read_vmcoreinfo_kallsyms();
> > +
> >       close_vmcoreinfo();
> >
> >       ret =3D TRUE;
> > diff --git a/makedumpfile.h b/makedumpfile.h
> > index 134eb7a..0f13743 100644
> > --- a/makedumpfile.h
> > +++ b/makedumpfile.h
> > @@ -259,6 +259,7 @@ static inline int string_exists(char *s) { return (=
s ? TRUE : FALSE); }
> >   #define UINT(ADDR)  *((unsigned int *)(ADDR))
> >   #define ULONG(ADDR) *((unsigned long *)(ADDR))
> >   #define ULONGLONG(ADDR)     *((unsigned long long *)(ADDR))
> > +#define VOID_PTR(ADDR)       *((void **)(ADDR))
> >
> >
> >   /*
> > @@ -1919,6 +1920,16 @@ struct symbol_table {
> >        * symbols on sparc64 arch
> >        */
> >       unsigned long long              vmemmap_table;
> > +
> > +     /*
> > +      * kallsyms related
> > +      */
> > +     unsigned long long              kallsyms_names;
> > +     unsigned long long              kallsyms_num_syms;
> > +     unsigned long long              kallsyms_token_table;
> > +     unsigned long long              kallsyms_token_index;
> > +     unsigned long long              kallsyms_offsets;
> > +     unsigned long long              kallsyms_relative_base;
> >   };
> >
> >   struct size_table {


