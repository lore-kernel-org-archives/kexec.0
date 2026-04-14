Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C0BF9D0C1
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 11:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kJpNfu1lxZlcuNt52Z58mzSycI95cFIJWF1/CsmyCgE=; b=dQIQy7hU4vTA8vh8LaTy7fQLD7
	6aIOsgirTMcAVPv6oREaZzhhhvLHVAQlZnfX5WE14e3pxpmw9QDoo7wynBrqicAe3BDwKcK3xtozS
	aHiTgYJGVwF6ciPq9X1f59igUA31fvbujoIQfKWR0j+eBsWw03IwoqV6KGd34JMm7GLWtElwetcod
	VL2AGHwHC5NFkOyQgjUKRZKfzmgxrQOSUjzLePwLYxkkdeyN3J5yq1wqnnkCGDoSUVsvSdBdQc2b1
	R677uiczP0KXI8NNjexdc+0JDIjdJmzjVb2CXczf/oQ09CJD3cWWXwR1ZA/RmInRU2ttkMuNiXAU5
	f13b8QzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCbmX-0000000HDxJ-0xNt;
	Tue, 14 Apr 2026 11:18:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCbmU-0000000HDwd-1n0u
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 11:18:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776165489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kJpNfu1lxZlcuNt52Z58mzSycI95cFIJWF1/CsmyCgE=;
	b=OEGPx8hL2rAIuShAk2/cdTxc4ZTh0Mti7oB2lqy62IsesiCoCK3ldyLWRBnfN5MrtWkZei
	BXvwFFT5roumFvt4Q/m9j389R0zKJASXZIXdG5Uan0ce8/aljqnh3oL6SbfDUx8U7R60QZ
	T1P5FDQcAizXwr2Iv0iDjmYJp7N6oW4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-8I8WFbqgM--aRxvYij8cVQ-1; Tue, 14 Apr 2026 07:18:07 -0400
X-MC-Unique: 8I8WFbqgM--aRxvYij8cVQ-1
X-Mimecast-MFC-AGG-ID: 8I8WFbqgM--aRxvYij8cVQ_1776165487
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d812c898cso140657131cf.1
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 04:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776165487; x=1776770287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kJpNfu1lxZlcuNt52Z58mzSycI95cFIJWF1/CsmyCgE=;
        b=o+YVvdH15kv1SXz59l6KJ/XiR1VNBobqoSLewaxqv9IZNQCkjAFw2Jyiguic/F3Ys+
         sDkF6LFNLmHcUCJrpE4vYra8Klfsbx4vlKzEL4a1CmDFh77O4ULhEmDwzZF8ylZk24D/
         56Gzh8GjiTW1KWqW6CIHgkc6OFfJj90M85YglW992Uw2M1+FGel3tgnHp8X/xQYdmYQT
         qmliFkzu9xXZPTqLW7jiSfcfqTAzJqGL4o2XhZq6CAcsKCnJEz1yTfRQoyZ4TmwMoQnx
         EyHVrYg5U8twMA8K2WmFo3iGE4C/LirYAiBWl/uLOt75ABKgE8lofvfKQM0q9JX2FbWH
         Uzrg==
X-Forwarded-Encrypted: i=1; AFNElJ95K/gK2SlPAhDdMpstoIXCuXR1k2pdaqk7G2Bx3HMM2vVfJACwp/fWnyZ+5O63dfAKYGmXsw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyr3qXgutr5VbUZJTLva0glxwL1+xgAmbH1NZWlE9c9iTxnG3e4
	+CwtNhr5rVpGRMq5Lw9RNy6FMuY+3+mEOM2mE+GyJMJuYgaftxEHz9ixZMhFWKWmdZ/uhiXWzgh
	9gn83UUSZPAm3lAe2sE8X4lHu7J5GXA591bW49PwZLV07pKAfIBavRmXxQDWEHorlxZKQzAjaGw
	QxwjKo5auoV2R3xlrrbldsGrMPZJvndPbpTVNR
X-Gm-Gg: AeBDievzKl+3acS1PPZJhTVrjK4M78LIH1+XqBwW/Dndr7N6bZshlcp1cNKvfW8dMqw
	VEudv1oWejrK24sYPgJZrhOPtV0X4IDEVBE4TIsBdgWV/bQwH3b11HB3W2YJfKa9psWnQt2dQOL
	5yWtCTGSpQ69byka0j0w6ublNVXrPQEXbNcGwpHENDChhE4Rd01S4gC93HZYKXNwL8Jspl/ZqbS
	WjuktEu+fZeAA==
X-Received: by 2002:ac8:5708:0:b0:509:37d5:7a41 with SMTP id d75a77b69052e-50dd5cd7b7bmr230608081cf.63.1776165486886;
        Tue, 14 Apr 2026 04:18:06 -0700 (PDT)
X-Received: by 2002:ac8:5708:0:b0:509:37d5:7a41 with SMTP id
 d75a77b69052e-50dd5cd7b7bmr230607641cf.63.1776165486322; Tue, 14 Apr 2026
 04:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260317150743.69590-1-ltao@redhat.com> <20260317150743.69590-4-ltao@redhat.com>
 <2a4a6823-5dc7-46f9-8dee-89ca68285607@nec.com>
In-Reply-To: <2a4a6823-5dc7-46f9-8dee-89ca68285607@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 14 Apr 2026 23:17:30 +1200
X-Gm-Features: AQROBzCvovrlrDS07HXEWjzuREJ0Scc-kbmQKM0uNkybx33CfYSQR-DMV8B7sQ0
Message-ID: <CAO7dBbXwkuVywQDD3vxkU07npaWz-MGuD4kLGkB4uzP_zfMwvg@mail.gmail.com>
Subject: Re: [PATCH v4][makedumpfile 3/7] Implement kernel btf resolving
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: "stephen.s.brennan@oracle.com" <stephen.s.brennan@oracle.com>, 
	=?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0EHdI_-dOc38vZSoc3ydYN831W86kq_VnoFFWl5LKNE_1776165487
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_041810_614472_B37353A2 
X-CRM114-Status: GOOD (  35.97  )
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

On Fri, Apr 3, 2026 at 9:13=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=E3=
=80=80=E4=B8=80=E4=BB=81) <k-hagio-ab@nec.com> wrote:
>
> On 2026/03/18 0:07, Tao Liu wrote:
> > This patch will parse kernel's btf data using libbpf. The kernel's
> > btf data is located between __start_BTF and __stop_BTF symbols which
> > are resolved by kallsyms of the previous patch. Same as the previous
> > one, the .init_ktypes section of makedumpfile and the extensions will
> > be iterated, and any types which belongs to vmlinux can be resolved
> > at this time.
> >
> > Another primary function implemented in this patch, is recursively
> > diving into anonymous struct/union when encountered any, to find a
> > member by given its name.
> >
> > Suggested-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> > Signed-off-by: Tao Liu <ltao@redhat.com>
> > ---
> >   Makefile   |   4 +-
> >   btf_info.c | 233 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+
> >   btf_info.h |  90 +++++++++++++++++++++
> >   3 files changed, 325 insertions(+), 2 deletions(-)
> >   create mode 100644 btf_info.c
> >   create mode 100644 btf_info.h
> >
> > diff --git a/Makefile b/Makefile
> > index a57185e..320677d 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -45,12 +45,12 @@ CFLAGS_ARCH +=3D -m32
> >   endif
> >
> >   SRC_BASE =3D makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.=
h sadump_info.h
> > -SRC_PART =3D print_info.c dwarf_info.c elf_info.c erase_info.c sadump_=
info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c
> > +SRC_PART =3D print_info.c dwarf_info.c elf_info.c erase_info.c sadump_=
info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c btf_info.c
> >   OBJ_PART=3D$(patsubst %.c,%.o,$(SRC_PART))
> >   SRC_ARCH =3D arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia=
64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c arch=
/loongarch64.c arch/riscv64.c
> >   OBJ_ARCH=3D$(patsubst %.c,%.o,$(SRC_ARCH))
> >
> > -LIBS =3D -ldw -lbz2 -ldl -lelf -lz
> > +LIBS =3D -ldw -lbz2 -ldl -lelf -lz -lbpf
>
> Not all distributions may use the extension function or have libbpf.
> Also I would like to build makedumpfile on RHEL8 too, but it cannot be
> built due to the version of libbpf.  Could we introduce an option e.g.
> "EXTENSION=3Don" to use the function?

Great suggestion! The EXTENSION=3Don switch will be much more helpful to
OSs that don't support the makedumpfile extension, such as rhel8. This
was already improved in v5.

>
>
> >   ifneq ($(LINKTYPE), dynamic)
> >   LIBS :=3D -static $(LIBS) -llzma
> >   endif
> > diff --git a/btf_info.c b/btf_info.c
> > new file mode 100644
> > index 0000000..1cb66e2
> > --- /dev/null
> > +++ b/btf_info.c
> > @@ -0,0 +1,233 @@
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <bpf/btf.h>
> > +#include <bpf/libbpf_legacy.h>
> > +#include "makedumpfile.h"
> > +#include "kallsyms.h"
> > +#include "btf_info.h"
> > +
> > +struct btf_arr_elem {
> > +     struct btf *btf;
> > +     char *module;
> > +};
> > +
> > +static struct btf_arr_elem **btf_arr =3D NULL;
> > +static int btf_arr_len =3D 0;
> > +static int btf_arr_cap =3D 0;
> > +
> > +/* makedumpfile & extensions' .init_ktypes section range array */
> > +static struct section_range **sr =3D NULL;
> > +static int sr_len =3D 0;
> > +static int sr_cap =3D 0;
> > +
> > +/* Which mod's btf should be inited? */
> > +static char **mods =3D NULL;
> > +static int mods_len =3D 0;
> > +static int mods_cap =3D 0;
> > +
> > +static bool add_ktype_modname(char *modname)
> > +{
> > +     return push_uniq_str((void ***)&mods, &mods_len, &mods_cap, modna=
me);
> > +}
> > +
> > +bool check_ktypes_require_modname(char *modname, int *total)
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
> > +static void cleanup_ktypes_modname(void)
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
> > + * Used by makedumpfile and extensions, to register their .init_ktypes=
 section,
> > + * so btf_info can know which module/type should be inited.
> > +*/
> > +REGISTER_SECTION(ktype)
> > +
> > +static void cleanup_ktypes_section_range(void)
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
> > +static void find_member_recursive(struct btf *btf, int struct_typeid,
> > +                               int base_offset, struct ktype_info *ki)
> > +{
> > +     const struct btf_type *st;
> > +     struct btf_member *bm;
> > +     int i, vlen;
> > +
> > +     struct_typeid =3D btf__resolve_type(btf, struct_typeid);
> > +     st =3D btf__type_by_id(btf, struct_typeid);
> > +
> > +     if (!st)
> > +             return;
> > +
> > +     if (BTF_INFO_KIND(st->info) !=3D BTF_KIND_STRUCT &&
> > +         BTF_INFO_KIND(st->info) !=3D BTF_KIND_UNION)
> > +             return;
> > +
> > +     vlen =3D BTF_INFO_VLEN(st->info);
> > +     bm =3D btf_members(st);
> > +
> > +     for (i =3D 0; i < vlen; i++, bm++) {
> > +             const char *name =3D btf__name_by_offset(btf, bm->name_of=
f);
> > +             int member_bit_offset =3D btf_member_bit_offset(st, i) + =
base_offset;
> > +             int member_typeid =3D btf__resolve_type(btf, bm->type);
> > +             const struct btf_type *mt =3D btf__type_by_id(btf, member=
_typeid);
> > +
> > +             if (name && strcmp(name, ki->member_name) =3D=3D 0) {
> > +                     ki->member_bit_offset =3D member_bit_offset;
> > +                     ki->member_bit_sz =3D btf_member_bitfield_size(st=
, i);
> > +                     ki->member_size =3D btf__resolve_size(btf, member=
_typeid);
> > +                     ki->index =3D i;
> > +                     return;
> > +             }
> > +
> > +             if (!name || !name[0]) {
> > +                     if (BTF_INFO_KIND(mt->info) =3D=3D BTF_KIND_STRUC=
T ||
> > +                         BTF_INFO_KIND(mt->info) =3D=3D BTF_KIND_UNION=
) {
> > +                             find_member_recursive(btf, member_typeid,
> > +                                                   member_bit_offset, =
ki);
> > +                     }
> > +             }
> > +     }
> > +}
> > +
> > +static void get_ktype_info(struct ktype_info *ki, char *mod_to_resolve=
)
> > +{
> > +     int i, j, start_id;
> > +
> > +     if (mod_to_resolve !=3D NULL) {
> > +             if (strcmp(ki->modname, mod_to_resolve) !=3D 0)
> > +                     /* Exit safely */
> > +                     return;
> > +     }
> > +
> > +     for (i =3D 0; i < btf_arr_len; i++) {
> > +             if (strcmp(btf_arr[i]->module, ki->modname) !=3D 0)
> > +                     continue;
> > +             /*
> > +              * vmlinux(btf_arr[0])'s typeid is 1~vmlinux_type_cnt,
> > +              * modules(btf_arr[1...])'s typeid is vmlinux_type_cnt~bt=
f__type_cnt
> > +              */
> > +             start_id =3D (i =3D=3D 0 ? 1 : btf__type_cnt(btf_arr[0]->=
btf));
> > +
> > +             for (j =3D start_id; j < btf__type_cnt(btf_arr[i]->btf); =
j++) {
> > +                     const struct btf_type *bt =3D
> > +                             btf__type_by_id(btf_arr[i]->btf, j);
> > +                     const char *name =3D
> > +                             btf__name_by_offset(btf_arr[i]->btf, bt->=
name_off);
> > +
> > +                     if (name && strcmp(ki->struct_name, name) =3D=3D =
0) {
> > +                             if (ki->member_name !=3D NULL) {
> > +                                     /* Retrieve member info */
> > +                                     find_member_recursive(btf_arr[i]-=
>btf, j, 0, ki);
> > +                             } else {
> > +                                     ki->index =3D j;
> > +                             }
> > +                             ki->struct_size =3D btf__resolve_size(btf=
_arr[i]->btf, j);
> > +                             return;
> > +                     }
> > +             }
> > +     }
> > +}
> > +
> > +static bool add_to_btf_arr(struct btf *btf, char *module_name)
> > +{
> > +     struct btf_arr_elem *new_p;
> > +
> > +     new_p =3D malloc(sizeof(struct btf_arr_elem));
> > +     if (!new_p)
> > +             goto no_mem;
> > +
> > +     new_p->btf =3D btf;
> > +     new_p->module =3D module_name;
> > +
> > +     return add_to_arr((void ***)&btf_arr, &btf_arr_len, &btf_arr_cap,=
 new_p);
> > +
> > +no_mem:
> > +     fprintf(stderr, "%s: Not enough memory!\n", __func__);
> > +     return false;
> > +}
> > +
> > +INIT_KERN_SYM(__start_BTF);
> > +INIT_KERN_SYM(__stop_BTF);
> > +
> > +/*
> > + * Makedumpfile's .init_ktypes section
> > +*/
> > +extern struct ktype_info *__start_init_ktypes[];
> > +extern struct ktype_info *__stop_init_ktypes[];
> > +
> > +bool init_kernel_btf(void)
> > +{
> > +     uint64_t size;
> > +     struct btf *btf;
> > +     int i;
> > +     struct ktype_info **p;
> > +     char *buf =3D NULL;
> > +     bool ret =3D false;
> > +
> > +     uint64_t start_btf =3D GET_KERN_SYM(__start_BTF);
> > +     uint64_t stop_btf =3D GET_KERN_SYM(__stop_BTF);
> > +     if (!KERN_SYM_EXIST(__start_BTF) ||
> > +         !KERN_SYM_EXIST(__stop_BTF)) {
> > +             fprintf(stderr, "%s: symbol __start/stop_BTF not found!\n=
", __func__);
> > +             goto out;
> > +     }
> > +
> > +     if (!register_ktype_section((char *)__start_init_ktypes,
> > +                                 (char *)__stop_init_ktypes))
> > +             return ret;
> > +
> > +     size =3D stop_btf - start_btf;
> > +     buf =3D (char *)malloc(size);
> > +     if (!buf) {
> > +             fprintf(stderr, "%s: Not enough memory!\n", __func__);
> > +             goto out;
> > +     }
> > +     readmem(VADDR, start_btf, buf, size);
> > +     btf =3D btf__new(buf, size);
> > +
> > +     if (libbpf_get_error(btf) !=3D 0 ||
> > +         add_to_btf_arr(btf, strdup("vmlinux")) =3D=3D false) {
> > +             fprintf(stderr, "%s: init vmlinux btf fail\n", __func__);
> > +             goto out;
> > +     }
> > +
> > +     for (i =3D 0; i < sr_len; i++) {
> > +             for (p =3D (struct ktype_info **)(sr[i]->start);
> > +                  p < (struct ktype_info **)(sr[i]->stop);
> > +                  p++) {
> > +                     get_ktype_info(*p, "vmlinux");
> > +             }
> > +     }
> > +
> > +     ret =3D true;
> > +out:
> > +     if (buf)
> > +             free(buf);
> > +     return ret;
> > +}
> > \ No newline at end of file
> > diff --git a/btf_info.h b/btf_info.h
> > new file mode 100644
> > index 0000000..2cf6b07
> > --- /dev/null
> > +++ b/btf_info.h
> > @@ -0,0 +1,90 @@
> > +#ifndef _BTF_INFO_H
> > +#define _BTF_INFO_H
> > +#include <stdint.h>
> > +#include <stdbool.h>
> > +
> > +struct ktype_info {
> > +     /********in******/
> > +     char *modname;          // Set to search within the module, in ca=
se
> > +                             // name conflict of different modules
> > +     char *struct_name;      // Search by struct name
> > +     char *member_name;      // Search by member name
> > +     bool struct_required : 1;
> > +     bool member_required : 1;
> > +     /********out*****/
> > +     uint32_t member_bit_offset;     // member offset in bits
> > +     uint32_t member_bit_sz; // member width in bits
> > +     uint32_t member_size;   // member size in bytes
> > +     uint32_t struct_size;   // struct size in bytes
> > +     int index;              // -1 if type not found
> > +};
> > +
> > +bool check_ktypes_require_modname(char *modname, int *total);
> > +bool register_ktype_section(char *start, char *stop);
> > +bool init_kernel_btf(void);
> > +
> > +#define QUATE(x) #x
> > +#define INIT_MOD_STRUCT_MEMBER_RQD(MOD, S, M, R)                     \
> > +     struct ktype_info _##MOD##_##S##_##M =3D {                       =
 \
> > +             QUATE(MOD), QUATE(S), QUATE(M), R, R, 0, 0, 0, 0, -1    \
> > +     };                                                              \
> > +     __attribute__((section(".init_ktypes"), used))                  \
> > +     struct ktype_info * _ptr_##MOD##_##S##_##M =3D &_##MOD##_##S##_##=
M
> > +
> > +/*
> > + * Required types will be checked automatically before extension runni=
ng.
> > + * Optinal types should be checked manually at extension runtime.
> > + */
> > +#define INIT_MOD_STRUCT_MEMBER(MOD, S, M) \
> > +     INIT_MOD_STRUCT_MEMBER_RQD(MOD, S, M, 1)
> > +#define INIT_OPT_MOD_STRUCT_MEMBER(MOD, S, M) \
> > +     INIT_MOD_STRUCT_MEMBER_RQD(MOD, S, M, 0)
> > +
> > +#define DECLARE_MOD_STRUCT_MEMBER(MOD, S, M) \
> > +     extern struct ktype_info _##MOD##_##S##_##M
> > +
> > +#define GET_MOD_STRUCT_MEMBER_MOFF(MOD, S, M)  (_##MOD##_##S##_##M.mem=
ber_bit_offset)
> > +#define GET_MOD_STRUCT_MEMBER_MSIZE(MOD, S, M) (_##MOD##_##S##_##M.mem=
ber_size)
> > +#define GET_MOD_STRUCT_MEMBER_SSIZE(MOD, S, M) (_##MOD##_##S##_##M.str=
uct_size)
> > +#define MOD_STRUCT_MEMBER_EXIST(MOD, S, M) (_##MOD##_##S##_##M.index >=
=3D 0)
> > +#define TYPE_EXIST(p) ((p)->index >=3D 0)
> > +
> > +#define INIT_KERN_STRUCT_MEMBER(S, M) \
> > +     INIT_MOD_STRUCT_MEMBER(vmlinux, S, M)
> > +#define INIT_OPT_KERN_STRUCT_MEMBER(S, M) \
> > +     INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, S, M)
> > +
> > +#define DECLARE_KERN_STRUCT_MEMBER(S, M) \
> > +     DECLARE_MOD_STRUCT_MEMBER(vmlinux, S, M)
> > +
> > +#define GET_KERN_STRUCT_MEMBER_MOFF(S, M)  GET_MOD_STRUCT_MEMBER_MOFF(=
vmlinux, S, M)
> > +#define GET_KERN_STRUCT_MEMBER_MSIZE(S, M) GET_MOD_STRUCT_MEMBER_MSIZE=
(vmlinux, S, M)
> > +#define GET_KERN_STRUCT_MEMBER_SSIZE(S, M) GET_MOD_STRUCT_MEMBER_SSIZE=
(vmlinux, S, M)
> > +#define KERN_STRUCT_MEMBER_EXIST(S, M) MOD_STRUCT_MEMBER_EXIST(vmlinux=
, S, M)
> > +
> > +#define INIT_MOD_STRUCT_RQD(MOD, S, R)                               \
> > +     struct ktype_info _##MOD##_##S =3D {                      \
> > +             QUATE(MOD), QUATE(S), 0, R, 0, 0, 0, 0, 0, -1   \
> > +     };                                                      \
> > +     __attribute__((section(".init_ktypes"), used))          \
> > +     struct ktype_info * _ptr_##MOD##_##S =3D &_##MOD##_##S
> > +
> > +#define INIT_MOD_STRUCT(MOD, S) INIT_MOD_STRUCT_RQD(MOD, S, 1)
> > +#define INIT_OPT_MOD_STRUCT(MOD, S) INIT_MOD_STRUCT_RQD(MOD, S, 0)
> > +
> > +#define DECLARE_MOD_STRUCT(MOD, S) \
> > +     extern struct ktype_info _##MOD##_##S;
> > +
> > +#define GET_MOD_STRUCT_SSIZE(MOD, S) (_##MOD##_##S.struct_size)
> > +#define MOD_STRUCT_EXIST(MOD, S) (_##MOD##_##S.index >=3D 0)
> > +
> > +#define INIT_KERN_STRUCT(S) INIT_MOD_STRUCT(vmlinux, S)
> > +#define INIT_OPT_KERN_STRUCT(S) INIT_OPT_MOD_STRUCT(vmlinux, S)
> > +
> > +#define DECLARE_KERN_STRUCT(S) \
> > +     DECLARE_MOD_STRUCT(vmlinux, S)
> > +
> > +#define GET_KERN_STRUCT_SSIZE(S) GET_MOD_STRUCT_SSIZE(vmlinux, S)
> > +#define KERN_STRUCT_EXIST(S) MOD_STRUCT_EXIST(vmlinux, S)
>
> I feel these macros are a bit messy.. "KERN" macros multiply the number
> of macros.  Does this need both KERN/MOD macros, i.e. how about uniting
> them and describe that "vmlinux" is used for kernel on a manual?

I removed the "KERN" macros from btf_info.h, which looks much cleaner.

>
> Thanks,
> Kazu
>
>
> > +
> > +#endif /* _BTF_INFO_H */
> > \ No newline at end of file


