Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85007D12689
	for <kexec@archiver.kernel.org>; Wed,  3 Dec 2025 00:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7zqpSbmRXh5YSbFWqiCvrsNB8Z4THXmGweIWsokBBPw=; b=FKnNYd/2+BspEHtyZYx19OdbV4
	KJFBaPOH/RYl+hspD0xTqBEZTbvHY/IgckryPl9fvhpnQ4BkMRYP/KHpIIVq9fhkb//Q5T7izmZtR
	cJYX5sslLWgoV6c9LR3qdkmUhy6z0dL1eZiBsEAhCho64S/A2gXbwsMhNMilIwBkqF0VRUfZhgJL2
	Az85Va2eHNZrpQ6kl68BJ6p10hv85VLmyYKwyGfZFnxKoBQnDBn/QIC1fklbnRyv4ttjx2M2vl350
	29yKCs0UABEDMEYRE3P/RKJ76AkgxB29H1z3D1eBsWiH+gMWsyiPo5g5CEpkmP62YbweCfKRXvsIJ
	RcPWZ3qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQb7A-00000005yoh-2Gs8;
	Wed, 03 Dec 2025 00:53:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQb75-00000005yoB-2HiU
	for kexec@lists.infradead.org;
	Wed, 03 Dec 2025 00:53:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764723173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7zqpSbmRXh5YSbFWqiCvrsNB8Z4THXmGweIWsokBBPw=;
	b=H3y3bcsCKOv+DmhKMy4ru/9Cx3a/Kj9826JgZjSBKxOBv2wTXDu4CemGjxD5idJtKJ5Mh4
	X/471w92wMGo0EKVlMYjhVjDs1P+SxZzieJndGl/Cc66f4UNrD0n55f4Qv8yTbroRNDkfd
	Xog+oldV7RUTNui9G+vy29hquWgB+e0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-8XsDC-zyNZmV-OBcucNK-A-1; Tue, 02 Dec 2025 19:52:51 -0500
X-MC-Unique: 8XsDC-zyNZmV-OBcucNK-A-1
X-Mimecast-MFC-AGG-ID: 8XsDC-zyNZmV-OBcucNK-A_1764723171
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ee3dfe072dso108663631cf.2
        for <kexec@lists.infradead.org>; Tue, 02 Dec 2025 16:52:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764723171; x=1765327971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7zqpSbmRXh5YSbFWqiCvrsNB8Z4THXmGweIWsokBBPw=;
        b=Qoi7tGOuAn/0pAjU145hnsZAz3WCoU7VTr+7fK79Zh2coic7yLlqvNjJvgVW3zqPbg
         CMVzMGF4lCv7U54fpliLrhRu2C923bN+QYWELUmbDP6SRIBJIRhz/BHhoXhKkhXDjhSq
         nx1JYXngrpi8ghPU2Ta2ozps9VmTZ/A4X0zKh+dNqKCMgwpHpKXqEFXHf3fgLMO5OUej
         Mzfl3WGdHn1VAIhWBShkqcH2rdS4Ify63uyl6QY3QKcByWIA/kRmtI68rexO9qzYX884
         7FhJpLjUq4gVHFPgXFNWKU/nCZUOtI2Cge4fdxfytQAza2029jpGpYCLl/MRGzPGye7w
         rtzA==
X-Forwarded-Encrypted: i=1; AJvYcCUnP898gprmSSQN213VO9qFHaW3g85o7i98f3bj7Tg5s/DsDILfB5vZCPhoBm3lad3WdyX5Qg==@lists.infradead.org
X-Gm-Message-State: AOJu0YywIJBPTLqTS8/x/btNiUH7tG+Td4H20sGiOPcgRrjMmMTo3S+A
	mfREw91qUBOkcsSPJfpWoS4Mv18bdacZ2vtuN3KH9ry3Wc+DkgH83N/oNKuiFxBI8Ai1GKyWYFR
	duh4TS2X2d1z3joEf1g3dDHxlLUPbdoKd1LD2H62h+6LJIjbKufp1JCcJmW32Xedrowe1xFpabr
	2jBin8FcqF7kQc5Rt1mIRdLGNkYaZJr9gXQAq5
X-Gm-Gg: ASbGncvJrr0mAaLoMYvGMTwiYqd37j4iH9qC6SUgAkg/0B/J/eyhFZ11edTv5OOgyaE
	X4hgg0UM7WY4jxo5k21Orn9bYjDNys7xthnePJhfWAPeG76I/j+OQtz7nVfHT07naLMVJF0i5eE
	hbB9FWw6D3dqVjke/6Wv4k93m6updEwx+NRMZ4z10E8k+rYR3uvYyTs9Cy70GZrKD39Qbr
X-Received: by 2002:ac8:598f:0:b0:4ec:ee04:8831 with SMTP id d75a77b69052e-4f017655ed6mr8634591cf.57.1764723170583;
        Tue, 02 Dec 2025 16:52:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGH0mCZ8nsVnKpNiGHDv9zwElxhJ+uCRLzQEbDyPC/ETES0idMnvuxzKrMMvGmYaqTv357ryJEe0cRuXwFMlF4=
X-Received: by 2002:ac8:598f:0:b0:4ec:ee04:8831 with SMTP id
 d75a77b69052e-4f017655ed6mr8634421cf.57.1764723170099; Tue, 02 Dec 2025
 16:52:50 -0800 (PST)
MIME-Version: 1.0
References: <20251020222410.8235-1-ltao@redhat.com> <20251020222410.8235-9-ltao@redhat.com>
 <87bjkgilxs.fsf@oracle.com>
In-Reply-To: <87bjkgilxs.fsf@oracle.com>
From: Tao Liu <ltao@redhat.com>
Date: Wed, 3 Dec 2025 13:52:13 +1300
X-Gm-Features: AWmQ_bl1fRDcr20syxB-aMpqPV1GUrYagw2KuVxKgszy79lWqz8LoqmvTSoc8Cs
Message-ID: <CAO7dBbVck88aKxrk2sZ5Si_PJH1mvLbjx+92+xEcB9SM8kRcjQ@mail.gmail.com>
Subject: Re: [PATCH v2][makedumpfile 08/14] Implement kernel btf resolving
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org, 
	aravinda@linux.vnet.ibm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e078cioizZwImoRh_sRW7ORd5x74Sy1GoQeOLoe96Ko_1764723171
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251202_165259_845708_F2CF8AA1 
X-CRM114-Status: GOOD (  51.84  )
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

Thanks for your comments!

On Wed, Dec 3, 2025 at 11:00=E2=80=AFAM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Tao Liu <ltao@redhat.com> writes:
> > This patch will parse kernel's btf data. The data can be located via
> > __start_BTF and __stop_BTF symbols which have been resolved by kallsyms=
 of
> > the previous patch.
> >
> > The btf data is organized as follows: each one of kernel modules, inclu=
ding
> > vmlinux itself, will have a btf_file struct describing its btf data, an=
d
> > holding an array of struct name_entry. By given the btf type id, we can=
 resolve
> > its name_entry fast by array index. In addition, name_entry can also be
> > organized in hash table. So given a type name, we can also resolve its
> > name_entry in a fast speed. In other words, both btf type id and btf
> > type name can we get it resolved fast. Once we get the name_entry struc=
ture of
> > the btf type, we can resolve its member/size etc easily.
> >
> > Since all name_entry array starting from index 0, which cannot identify=
 a btf
> > type globally. So a uniq id is used, its value is accumulated by the lo=
cation
> > of the btf_file within btf_file_array and total quantity of btf types w=
ithin
> > each btf_file.
> >
> > Signed-off-by: Tao Liu <ltao@redhat.com>
>
> Hi Tao,
>
> I haven't read this patch in detail, but I wanted to ask if you had any
> particular reason to avoid using libbpf for parsing the BTF?

Actually I manually parse BTF data due to the following concerns:

1) Learn BTF data structure by manually parsing. I haven't worked on
BTF previously, and I prefer the way of doing things from scratch in
order to learn as fast and as deeply. I didn't do any project prior to
this one relating to BTF. So I started manual parsing and kept it in
the  patchset.

2) Let everything be under control. Before actually working on this, I
know that the BTF/kallsyms parsing will be running in 2nd kernel, so
it should have a good balance of 1) as fast, 2) less memory
consumption. So I created 2 ways for BTF resolving: 1) Given id of btf
type, resolve it by array index(some meta data of BTF types are
organized in array, so easy to resolve the corresponding BTF type by
the meta data); 2) Given name of btf type, resolve it by hash table.
Like I said, only necessary data is stored within memory, others are
left as disk files to read when needed. I'm not saying I did a better
job than libbpf, my approach is more white-box to me, and easy to
improve.

3) I'm happy to improve the patchset, if libbpf is better in 2nd
kernel + eppic case, I can replace all those into libbpf APIs.

>
> For my implementation of BTF parsing for drgn I was not aware of it, so
> I did the parsing entirely manually, similar to this. But for my recent
> attempt[1] at adding BTF support to makedumpfile (unaware of this patch),=
 I
> used libbpf and found that it did reduce the amount of required code by
> a lot. These are specific functions I found useful:
>
> - btf__new() -> returns a "struct btf *" for use with the library
> - btf__type_by_id() -> returns the "struct btf_type *". Then, the
>   linux/btf.h header provides several inline functions to work with it:
>   - btf_members(), btf_vlen()
>   - btf_member_bit_offset()
> - btf__pointer_size()
> - btf__name_by_offset() -> returns the name for a string offset
> - btf__find_by_name() & btf__find_by_name_kind() -> looks up a type by
>   name. Note that this does a linear search, so your hash table approach
>   is better for random lookups.
> - btf__resolve_size()
>
> So with libbpf, the only thing you'd really need to implement is
> resolving member offsets (supporting anonyomus structs, recursively,
> etc), and a hash table for string lookups, if you feel it's necessary.
> For module BTF, btf__new_split() is available as well.

Thanks for providing the info, I can give it a try and do a
performance/memory consumption measurement. In the meantime, I'm keen
for any suggestions on the whole BTF/kallsyms + eppic approach for
makedumpfile customization. I guess there are cases other than GPU mm
filtering which are demanding for extending the current page-flag
filtering of makedumpfile.

Thanks,
Tao Liu

>
> Thanks,
> Stephen
>
> [1]: https://github.com/brenns10/makedumpfile/commit/98129399a3a10ae72408=
bc4aaec2485f7d220626#diff-e1e6bd59ae956df7d2d42ad3580bd3c04da533f1b90827a04=
e2cc27bbf24b2a7
>
> > ---
> >  Makefile |   2 +-
> >  btf.c    | 798 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  btf.h    | 175 ++++++++++++
> >  3 files changed, 974 insertions(+), 1 deletion(-)
> >  create mode 100644 btf.c
> >  create mode 100644 btf.h
> >
> > diff --git a/Makefile b/Makefile
> > index 2bb17f9..fbc9f5b 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -45,7 +45,7 @@ CFLAGS_ARCH +=3D -m32
> >  endif
> >
> >  SRC_BASE =3D makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h=
 sadump_info.h
> > -SRC_PART =3D print_info.c dwarf_info.c elf_info.c erase_info.c sadump_=
info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c
> > +SRC_PART =3D print_info.c dwarf_info.c elf_info.c erase_info.c sadump_=
info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c btf.c
> >  OBJ_PART=3D$(patsubst %.c,%.o,$(SRC_PART))
> >  SRC_ARCH =3D arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia6=
4.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c arch/=
loongarch64.c arch/riscv64.c
> >  OBJ_ARCH=3D$(patsubst %.c,%.o,$(SRC_ARCH))
> > diff --git a/btf.c b/btf.c
> > new file mode 100644
> > index 0000000..ba376cf
> > --- /dev/null
> > +++ b/btf.c
> > @@ -0,0 +1,775 @@
> > +#include "btf.h"
> > +#include <stdio.h>
> > +#include <assert.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <sys/mman.h>
> > +#include <sys/stat.h>
> > +#include <fcntl.h>
> > +#include <libelf.h>
> > +#include <gelf.h>
> > +#include <dirent.h>
> > +#include "kallsyms.h"
> > +#include "makedumpfile.h"
> > +
> > +// btf_files_array[0] must be kernel itself
> > +// btf_files_array[1..] are kernel modules
> > +static struct btf_file **btf_files_array =3D NULL;
> > +static int btf_files_array_index =3D 0;
> > +
> > +static inline uint16_t btf_vlen(uint32_t info)
> > +{
> > +     return info & 0xFFFF;
> > +}
> > +
> > +static inline uint32_t btf_kind_flag(uint32_t info)
> > +{
> > +     return info & (1 << 31);
> > +}
> > +
> > +static inline uint32_t btf_member_bit_offset(uint32_t value)
> > +{
> > +     return value & 0xffffff;
> > +}
> > +
> > +static inline uint32_t btf_member_bitfield_size(uint32_t value)
> > +{
> > +     return value >> 24;
> > +}
> > +
> > +static struct btf_type *btf_next(struct btf_type *tp)
> > +{
> > +     uintptr_t next =3D (uintptr_t)&tp[1];
> > +
> > +     switch (btf_kind(tp->info)) {
> > +     case BTF_KIND_INT:
> > +             next +=3D sizeof(uint32_t);
> > +             break;
> > +
> > +     case BTF_KIND_ARRAY:
> > +             next +=3D sizeof(struct btf_array);
> > +             break;
> > +
> > +     case BTF_KIND_STRUCT:
> > +     case BTF_KIND_UNION:
> > +             next +=3D btf_vlen(tp->info) * sizeof(struct btf_member);
> > +             break;
> > +
> > +     case BTF_KIND_ENUM:
> > +             next +=3D btf_vlen(tp->info) * sizeof(struct btf_enum);
> > +             break;
> > +
> > +     case BTF_KIND_FUNC_PROTO:
> > +             next +=3D btf_vlen(tp->info) * sizeof(struct btf_param);
> > +             break;
> > +
> > +     case BTF_KIND_VAR:
> > +             next +=3D sizeof(struct btf_var);
> > +             break;
> > +
> > +     case BTF_KIND_DATASEC:
> > +             next +=3D btf_vlen(tp->info) * sizeof(struct btf_var_seci=
nfo);
> > +             break;
> > +
> > +     case BTF_KIND_DECL_TAG:
> > +             next +=3D sizeof(struct btf_decl_tag);
> > +             break;
> > +
> > +     case BTF_KIND_ENUM64:
> > +             next +=3D btf_vlen(tp->info) * sizeof(struct btf_enum64);
> > +             break;
> > +
> > +     case BTF_KIND_PTR:
> > +     case BTF_KIND_FWD:
> > +     case BTF_KIND_TYPEDEF:
> > +     case BTF_KIND_VOLATILE:
> > +     case BTF_KIND_CONST:
> > +     case BTF_KIND_RESTRICT:
> > +     case BTF_KIND_FUNC:
> > +     case BTF_KIND_FLOAT:
> > +     case BTF_KIND_TYPE_TAG:
> > +             break; // no extra data
> > +
> > +     default:
> > +             __builtin_unreachable();
> > +     }
> > +     return (struct btf_type *)next;
> > +}
> > +
> > +#define NAME_HASH 512
> > +static struct name_entry *name_hash_table[NAME_HASH] =3D {0};
> > +
> > +static void *get_name_entry_next(void *entry)
> > +{
> > +     return ((struct name_entry *)entry)->name_hash_next;
> > +}
> > +
> > +static void set_name_entry_next(void *entry, void *next)
> > +{
> > +     ((struct name_entry *)entry)->name_hash_next =3D next;
> > +}
> > +
> > +static void name_hash_install(struct name_entry *en)
> > +{
> > +     hash_install((void **)name_hash_table, NAME_HASH, en, en->name,
> > +                     get_name_entry_next, set_name_entry_next);
> > +}
> > +
> > +static unsigned int name_hash_index(char *name)
> > +{
> > +     return hash_index(name, NAME_HASH);
> > +}
> > +
> > +int read_file_at_offset(char *f, int f_off, int r_size, void *buf)
> > +{
> > +     int got =3D 0;
> > +     int r, fd, ret =3D -1;
> > +
> > +     fd =3D open(f, O_RDONLY);
> > +     if (fd < 0) {
> > +             fprintf(stderr, "%s: Failed to open file %s\n", __func__,=
 f);
> > +             goto out;
> > +     }
> > +
> > +     while (got < r_size) {
> > +             r =3D pread(fd, buf + got, r_size - got, f_off + got);
> > +             if (r < 0) {
> > +                     fprintf(stderr, "%s: Failed to read file %s\n", _=
_func__, f);
> > +                     goto clean_fd;
> > +             }
> > +             got +=3D r;
> > +     }
> > +     ret =3D got;
> > +
> > +clean_fd:
> > +     close(fd);
> > +out:
> > +     return ret;
> > +}
> > +
> > +static char *get_str_by_name_off(struct btf_file *bf, uint32_t name_of=
f)
> > +{
> > +     struct btf_file *bf_vmlinux =3D btf_files_array[0];
> > +
> > +     if (bf !=3D bf_vmlinux && name_off >=3D bf_vmlinux->str_cache_len=
)
> > +             return bf->str_cache + name_off - bf_vmlinux->str_cache_l=
en;
> > +     else
> > +             return bf_vmlinux->str_cache + name_off;
> > +}
> > +
> > +int get_btf_type_by_type_id(struct btf_file *bf_in, uint32_t id_in,
> > +                         struct btf_type *bt_out, struct name_entry **=
en_out)
> > +{
> > +     struct name_entry *en;
> > +     struct btf_file *bf_vmlinux =3D btf_files_array[0];
> > +
> > +     if (bf_in !=3D bf_vmlinux && id_in > bf_vmlinux->array_len) {
> > +             en =3D bf_in->array[id_in - bf_vmlinux->array_len - 1];
> > +     } else {
> > +             en =3D bf_vmlinux->array[id_in - 1];
> > +     }
> > +     if (en_out)
> > +             *en_out =3D en;
> > +     return read_file_at_offset(en->bf->file_name,
> > +             en->btf_type_offset + en->bf->types_data_offset,
> > +             sizeof(*bt_out), bt_out);
> > +}
> > +
> > +/*
> > +* Parse the btf data and install elements into hashtable and array for=
 quick
> > +* reference.
> > +*/
> > +static int parse_btf_data(char *file_path, char *data_start, uint32_t =
data_len)
> > +{
> > +     struct btf_header *hdr =3D (struct btf_header *)data_start;
> > +     struct btf_file *bf =3D NULL;
> > +     void *type_start;
> > +     char *str_start;
> > +     struct btf_type *tp;
> > +     struct name_entry *en;
> > +     int i, j, scale;
> > +
> > +     /* We do some check first */
> > +     if (hdr->magic !=3D BTF_MAGIC) {
> > +             fprintf(stderr, "%s: Invalid BTF magic in %s\n",
> > +                     __func__, file_path);
> > +             goto out;
> > +     }
> > +     if (hdr->hdr_len !=3D sizeof(*hdr)) {
> > +             fprintf(stderr, "%s: Invalid BTF header length in %s\n",
> > +                     __func__, file_path);
> > +             goto out;
> > +     }
> > +     if (hdr->hdr_len + hdr->str_off + hdr->str_len > data_len) {
> > +             fprintf(stderr, "%s: String section exceeds data length i=
n %s\n",
> > +                     __func__, file_path);
> > +             goto out;
> > +     }
> > +     if (hdr->hdr_len + hdr->type_off + hdr->type_len > data_len) {
> > +             fprintf(stderr, "%s: Type section exceeds data length in =
%s\n",
> > +                     __func__, file_path);
> > +             goto out;
> > +     }
> > +
> > +     /* Let's start parsing */
> > +     bf =3D (struct btf_file *)malloc(sizeof(*bf));
> > +     if (!bf)
> > +             goto no_mem;
> > +     memset(bf, 0, sizeof(*bf));
> > +
> > +     /* Enlarge array when reach power of 2 */
> > +     btf_files_array[btf_files_array_index++] =3D bf;
> > +     if ((btf_files_array_index & (btf_files_array_index - 1)) =3D=3D =
0) {
> > +             struct btf_file **tmp =3D (struct btf_file **)reallocarra=
y(btf_files_array,
> > +                                             btf_files_array_index << =
1,
> > +                                             sizeof(struct btf_file *)=
);
> > +             if (!tmp)
> > +                     goto no_mem;
> > +             btf_files_array =3D tmp;
> > +     }
> > +
> > +     type_start =3D data_start + hdr->hdr_len + hdr->type_off;
> > +     str_start =3D data_start + hdr->hdr_len + hdr->str_off;
> > +
> > +     bf->str_cache =3D malloc(hdr->str_len);
> > +     if (!bf->str_cache)
> > +             goto no_mem;
> > +     memcpy(bf->str_cache, str_start, hdr->str_len);
> > +     bf->str_cache_len =3D hdr->str_len;
> > +
> > +     bf->array_len =3D 64;
> > +     bf->array =3D (struct name_entry **)calloc(bf->array_len,
> > +                     sizeof(struct name_entry *));
> > +     if (!bf->array)
> > +             goto no_mem;
> > +
> > +     bf->file_name =3D strdup(file_path);
> > +     if (!bf->file_name)
> > +             goto no_mem;
> > +     bf->types_data_offset =3D (char *)type_start - data_start;
> > +
> > +     for (tp =3D (struct btf_type *)type_start, i =3D 0;
> > +          (void *)tp < type_start + hdr->type_len;
> > +          tp =3D btf_next(tp), i++) {
> > +             en =3D (struct name_entry *)malloc(sizeof(struct name_ent=
ry));
> > +             if (!en) {
> > +                     bf->array_len =3D i;
> > +                     goto no_mem;
> > +             }
> > +             memset(en, 0, sizeof(struct name_entry));
> > +
> > +             en->btf_type_offset =3D (void *)tp - type_start;
> > +             en->id =3D i + 1;
> > +             en->bf =3D bf;
> > +             if (tp->name_off) {
> > +                     en->name =3D get_str_by_name_off(bf, tp->name_off=
);
> > +                     if (en->name[0])
> > +                             name_hash_install(en);
> > +             }
> > +             bf->array[i] =3D en;
> > +
> > +             /* Now deal with sub elements which also have a name */
> > +             if (btf_kind(tp->info) =3D=3D BTF_KIND_ENUM ||
> > +                 btf_kind(tp->info) =3D=3D BTF_KIND_ENUM64) {
> > +                     scale =3D btf_kind(tp->info) =3D=3D BTF_KIND_ENUM=
 ?
> > +                             sizeof(struct btf_enum) : sizeof(struct b=
tf_enum64);
> > +                     for (j =3D 0; j < btf_vlen(tp->info); j++) {
> > +                             en =3D (struct name_entry *)malloc(sizeof=
(struct name_entry));
> > +                             if (!en) {
> > +                                     bf->array_len =3D i + 1;
> > +                                     goto no_mem;
> > +                             }
> > +                             memset(en, 0, sizeof(struct name_entry));
> > +                             en->id =3D 0;
> > +                             en->p_id =3D i + 1;
> > +                             en->p_id +=3D btf_files_array_index =3D=
=3D 1 ?
> > +                                     0 : btf_files_array[0]->array_len=
;
> > +                             en->bf =3D bf;
> > +                             en->name =3D get_str_by_name_off(bf,
> > +                                     *(uint32_t *)((char *)&tp[1] + j =
* scale));
> > +                             // printf("%s\n", en->name);
> > +                             name_hash_install(en);
> > +                     }
> > +             }
> > +
> > +             /* Enlarge array when over 3/4 */
> > +             if (i > (bf->array_len >> 2) * 3) {
> > +                     struct name_entry **tmp =3D (struct name_entry **=
)reallocarray(bf->array,
> > +                             bf->array_len << 1, sizeof(struct name_en=
try *));
> > +                     if (!tmp)
> > +                             goto no_mem;
> > +                     bf->array =3D tmp;
> > +                     bf->array_len <<=3D 1;
> > +             }
> > +     }
> > +     bf->array_len =3D i;
> > +     return 0;
> > +no_mem:
> > +     /* All the memory free will be dealed later. */
> > +     fprintf(stderr, "%s: Not enough memory!\n", __func__);
> > +out:
> > +     return -1;
> > +}
> > +
> > +/*
> > + * Used by search_name_by_cond() for searching specific type:
> > + * such as struct/union/typedef
> > + */
> > +static bool is_type(struct name_entry *sp, void *data_in, void *data_o=
ut)
> > +{
> > +     struct btf_type *bt =3D (struct btf_type *)data_out;
> > +     int type =3D *(int *)data_in;
> > +     if (sp->id) {
> > +             read_file_at_offset(sp->bf->file_name,
> > +                     sp->btf_type_offset + sp->bf->types_data_offset,
> > +                     sizeof(*bt), bt);
> > +             return btf_kind(bt->info) =3D=3D type;
> > +     }
> > +     return false;
> > +}
> > +
> > +static struct name_entry *search_name_by_cond(char *name,
> > +                     bool (*fn)(struct name_entry *, void *, void *),
> > +                     void *data_in, void *data_out)
> > +{
> > +     unsigned int index;
> > +     struct name_entry *sp;
> > +
> > +     index =3D name_hash_index(name);
> > +     for (sp =3D name_hash_table[index]; sp; sp =3D sp->name_hash_next=
) {
> > +             if (!strcmp(name, sp->name) && fn(sp, data_in, data_out))=
 {
> > +                     return sp;
> > +             }
> > +     }
> > +     return sp;
> > +}
> > +
> > +// caller should prepare bt
> > +void resolve_typedef(struct name_entry *en_in, struct name_entry **en_=
out,
> > +                  struct btf_type *bt)
> > +{
> > +     uint32_t id;
> > +     struct name_entry *en;
> > +
> > +     read_file_at_offset(en_in->bf->file_name,
> > +             en_in->btf_type_offset + en_in->bf->types_data_offset,
> > +             sizeof(*bt), bt);
> > +     if (btf_kind(bt->info) =3D=3D BTF_KIND_TYPEDEF) {
> > +             id =3D bt->type;
> > +             get_btf_type_by_type_id(en_in->bf, id, bt, &en);
> > +             return resolve_typedef(en, en_out, bt);
> > +     } else {
> > +             *en_out =3D en_in;
> > +     }
> > +}
> > +
> > +struct cond_args {
> > +     int index;
> > +     char *name;
> > +};
> > +
> > +static bool cond(struct cond_args *c1, struct cond_args *c2)
> > +{
> > +     if (c1->name && c2->name)
> > +             /* Check if the member name is what we want */
> > +             return !strcmp(c1->name, c2->name);
> > +     else
> > +             /* Check if the member index is what we want */
> > +             return c1->index =3D=3D c2->index;
> > +}
> > +
> > +static bool get_internal_member_info(struct name_entry *en, int base_p=
osition,
> > +                                  int *global_index, struct cond_args =
*tar_arg,
> > +                                  struct member_info *mi, bool initial=
_dive)
> > +{
> > +     struct btf_type bt, sub_bt;
> > +     int member_num;
> > +     char *member_array_buf =3D NULL;
> > +     int i;
> > +     struct btf_member *bm;
> > +     struct btf_array *ba;
> > +     int bm_position;
> > +     struct name_entry *sub_en;
> > +     bool res;
> > +     struct cond_args cur_arg =3D {0};
> > +
> > +     read_file_at_offset(en->bf->file_name,
> > +             en->btf_type_offset + en->bf->types_data_offset,
> > +             sizeof(bt), &bt); // this struct
> > +     if (initial_dive ||
> > +         ((!en->name || en->name[0] =3D=3D '\0') &&
> > +          ((btf_kind(bt.info) =3D=3D BTF_KIND_STRUCT) ||
> > +           (btf_kind(bt.info) =3D=3D BTF_KIND_UNION)))) {
> > +             /* anonymous struct/union, dive into */
> > +             member_num =3D btf_vlen(bt.info);
> > +             member_array_buf =3D calloc(member_num, sizeof(struct btf=
_member));
> > +             if (!member_array_buf) {
> > +                     fprintf(stderr, "%s: Not enough memory!\n", __fun=
c__);
> > +                     return false;
> > +             }
> > +             read_file_at_offset(en->bf->file_name,
> > +                     en->btf_type_offset + en->bf->types_data_offset +=
 sizeof(bt),
> > +                     member_num *sizeof(struct btf_member), member_arr=
ay_buf);
> > +             for (i =3D 0, bm =3D (struct btf_member *)member_array_bu=
f;
> > +             i < member_num; i++) {
> > +                     if (btf_kind_flag(bt.info)) {
> > +                             bm_position =3D base_position +
> > +                                     btf_member_bit_offset(bm[i].offse=
t);
> > +                             mi->bits =3D btf_member_bitfield_size(bm[=
i].offset);
> > +                     } else {
> > +                             bm_position =3D base_position +
> > +                                     bm[i].offset;
> > +                     }
> > +                     mi->sname =3D get_str_by_name_off(en->bf, bm[i].n=
ame_off);
> > +                     get_btf_type_by_type_id(en->bf, bm[i].type,
> > +                                             &sub_bt, &sub_en);
> > +                     // Dive into this member
> > +                     res =3D get_internal_member_info(sub_en, bm_posit=
ion, global_index,
> > +                                             tar_arg, mi, false);
> > +                     if (res) {
> > +                             free(member_array_buf);
> > +                             return res;
> > +                     }
> > +             }
> > +             free(member_array_buf);
> > +             return false;
> > +     }
> > +
> > +     cur_arg.index =3D *global_index;
> > +     cur_arg.name =3D mi->sname;
> > +     if (cond(&cur_arg, tar_arg)) {
> > +             mi->bit_pos =3D base_position;
> > +             resolve_typedef(en, &sub_en, &bt);
> > +             mi->uniq_id =3D id_to_uniq_id(sub_en->id, sub_en->bf);
> > +             if (btf_kind(bt.info) =3D=3D BTF_KIND_PTR) {
> > +                     /*
> > +                      * BUG? No pointer size in btf,
> > +                      * 32bit btf target on 64bit machine
> > +                      */
> > +                     mi->size =3D sizeof(void *);
> > +                     mi->type =3D "char *";
> > +             } else if (btf_kind(bt.info) =3D=3D BTF_KIND_ARRAY) {
> > +                     en =3D sub_en;
> > +                     ba =3D (struct btf_array *)malloc(sizeof(struct b=
tf_array));
> > +                     if (!ba) {
> > +                             fprintf(stderr, "%s: Not enough memory!\n=
", __func__);
> > +                             return false;
> > +                     }
> > +                     read_file_at_offset(en->bf->file_name,
> > +                             en->btf_type_offset + en->bf->types_data_=
offset + sizeof(bt),
> > +                             sizeof(struct btf_array), ba);
> > +                     mi->size =3D ba->nelems; // array elements
> > +                     get_btf_type_by_type_id(en->bf, ba->type, &sub_bt=
, &sub_en);
> > +                     resolve_typedef(sub_en, &en, &bt);
> > +                     free(ba);
> > +                     mi->size *=3D bt.size; // element size
> > +                     mi->type =3D NULL; // "char [64]? Leave it NULL f=
or now"
> > +             } else {
> > +                     mi->size =3D bt.size;
> > +                     mi->type =3D get_str_by_name_off(sub_en->bf, bt.n=
ame_off);
> > +             }
> > +             return true;
> > +     } else {
> > +             (*global_index)++;
> > +             return false;
> > +     }
> > +}
> > +
> > +static bool get_member_info_by_index(struct name_entry *en, int target=
_index,
> > +                                  struct member_info *mi)
> > +{
> > +     int g_index =3D 1;
> > +     struct cond_args args =3D {0};
> > +     args.index =3D target_index;
> > +     memset(mi, 0, sizeof(*mi));
> > +     return get_internal_member_info(en, 0, &g_index, &args, mi, true)=
;
> > +}
> > +
> > +static bool get_member_info_by_member_name(struct name_entry *en, char=
 *member_name,
> > +                                        struct member_info *mi)
> > +{
> > +     int g_index =3D 1;
> > +     struct cond_args args =3D {0};
> > +     args.name =3D member_name;
> > +     memset(mi, 0, sizeof(*mi));
> > +     return get_internal_member_info(en, 0, &g_index, &args, mi, true)=
;
> > +}
> > +
> > +/*
> > + * Entry for query struct members
> > + * Return: struct size, mi_out: member details
> > + */
> > +uint32_t get_struct_member_by_name(char *struct_name, char *member_nam=
e,
> > +                                struct member_info *mi_out)
> > +{
> > +     struct name_entry *en;
> > +     struct btf_type bt =3D {0};
> > +     int type =3D BTF_KIND_STRUCT;
> > +
> > +     en =3D search_name_by_cond(struct_name, is_type, (void *)&type, (=
void *)&bt);
> > +     if (!en)
> > +             goto out;
> > +     if (get_member_info_by_member_name(en, member_name, mi_out))
> > +             return bt.size;
> > +out:
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Entry for query type members, similar as above
> > + * Return: found-the-type, mi_out: member details
> > + */
> > +static uint32_t uniq_id_to_id(uint32_t, struct btf_file **);
> > +bool get_type_member_by_index(uint64_t type_uniq_id, int member_index,
> > +                           struct member_info *mi_out)
> > +{
> > +     uint32_t id;
> > +     struct btf_file *bf;
> > +
> > +     id =3D uniq_id_to_id((uint32_t)type_uniq_id, &bf);
> > +     return get_member_info_by_index(bf->array[id - 1], member_index, =
mi_out);
> > +}
> > +
> > +uint32_t id_to_uniq_id(uint32_t id, struct btf_file *bf)
> > +{
> > +     int i;
> > +     uint32_t uniq_id =3D 0;
> > +     for (i =3D 0; i < btf_files_array_index; i++) {
> > +             if (btf_files_array[i] !=3D bf)
> > +                     uniq_id +=3D btf_files_array[i]->array_len;
> > +             else
> > +                     return id + uniq_id;
> > +     }
> > +     __builtin_unreachable();
> > +     assert(false);
> > +}
> > +
> > +static uint32_t uniq_id_to_id(uint32_t uid, struct btf_file **bf)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < btf_files_array_index; i++) {
> > +             if (uid > btf_files_array[i]->array_len) {
> > +                     uid -=3D btf_files_array[i]->array_len;
> > +             } else {
> > +                     if (bf)
> > +                             *bf =3D btf_files_array[i];
> > +                     return uid;
> > +             }
> > +
> > +     }
> > +     __builtin_unreachable();
> > +     assert(false);
> > +}
> > +
> > +// api for eppic
> > +uint32_t get_type_size_by_name(char *type_name, int type, uint32_t *un=
iq_id)
> > +{
> > +     struct name_entry *en;
> > +     struct btf_type bt =3D {0};
> > +
> > +     en =3D search_name_by_cond(type_name, is_type, (void *)&type, (vo=
id *)&bt);
> > +     if (!en)
> > +             goto out;
> > +     if (uniq_id)
> > +             *uniq_id =3D id_to_uniq_id(en->id, en->bf);
> > +     return bt.size;
> > +out:
> > +     return 0;
> > +}
> > +
> > +// Caller should prepare bt_out
> > +struct name_entry *get_en_by_uniq_id(uint32_t uniq_id, struct btf_type=
 *bt_out)
> > +{
> > +     uint32_t id;
> > +     struct btf_file *bf;
> > +     struct name_entry *en;
> > +     struct name_entry *en_sub;
> > +
> > +     id =3D uniq_id_to_id((uint32_t)uniq_id, &bf);
> > +     en =3D bf->array[id - 1];
> > +     resolve_typedef(en, &en_sub, bt_out);
> > +     return en_sub;
> > +}
> > +
> > +/* Deal with btf file */
> > +static int btf_file_init(int fd)
> > +{
> > +     struct stat f_stat;
> > +     char *buf =3D NULL;
> > +     char proc_path[32];
> > +     char real_path[512];
> > +     int ret =3D -1;
> > +
> > +     memset(real_path, 0, sizeof(real_path));
> > +     if (fstat(fd, &f_stat) < 0) {
> > +             fprintf(stderr, "%s: fstat fail!\n", __func__);
> > +             goto out;
> > +     }
> > +     buf =3D malloc(f_stat.st_size);
> > +     if (!buf) {
> > +             fprintf(stderr, "%s: Not enough memory!\n", __func__);
> > +             goto out;
> > +     }
> > +
> > +     snprintf(proc_path, sizeof(proc_path), "/proc/self/fd/%d", fd);
> > +     readlink(proc_path, real_path, sizeof(real_path) - 1);
> > +     if (read_file_at_offset(real_path, 0, f_stat.st_size, buf) < 0)
> > +             goto out;
> > +
> > +     ret =3D parse_btf_data(real_path, buf, f_stat.st_size);
> > +out:
> > +     if (buf)
> > +             free(buf);
> > +     return ret;
> > +}
> > +
> > +/* Deal with elf file which contains .BTF section */
> > +static int elf_file_init(int fd)
> > +{
> > +     char proc_path[32];
> > +     char real_path[512];
> > +     Elf *elf =3D NULL;
> > +     Elf_Scn *scn =3D NULL;
> > +     size_t shstrndx;
> > +     GElf_Shdr shdr;
> > +     Elf_Data *data =3D NULL;
> > +     char *str, *databuf =3D NULL;
> > +     int ret =3D -1;
> > +
> > +     snprintf(proc_path, sizeof(proc_path), "/proc/self/fd/%d", fd);
> > +     readlink(proc_path, real_path, sizeof(real_path) - 1);
> > +
> > +     if (elf_version(EV_CURRENT) =3D=3D EV_NONE)
> > +             goto elf_err;
> > +     elf =3D elf_begin(fd, ELF_C_READ, NULL);
> > +     if (!elf || elf_getshdrstrndx(elf, &shstrndx))
> > +             goto elf_err;
> > +     while ((scn =3D elf_nextscn(elf, scn)) !=3D NULL) {
> > +             if (!gelf_getshdr(scn, &shdr))
> > +                     continue;
> > +             str =3D elf_strptr(elf, shstrndx, shdr.sh_name);
> > +             if (!strcmp(str, ".BTF"))
> > +                     break;
> > +     }
> > +     if (!scn) {
> > +             fprintf(stderr, "%s: No .BTF found in %s!\n", __func__, r=
eal_path);
> > +             goto out;
> > +     }
> > +
> > +     data =3D elf_rawdata(scn, data);
> > +     databuf =3D malloc(data->d_size);
> > +     if (!databuf) {
> > +             fprintf(stderr, "%s: Not enough memory!\n", __func__);
> > +             goto out;
> > +     }
> > +     memcpy(databuf, data->d_buf, data->d_size);
> > +     elf_end(elf);
> > +     elf =3D NULL;
> > +     ret =3D parse_btf_data(real_path, databuf, data->d_size);
> > +     goto out;
> > +
> > +elf_err:
> > +     fprintf(stderr, "%s: elf error in %s!\n", __func__, real_path);
> > +out:
> > +     if (databuf)
> > +             free(databuf);
> > +     if (elf)
> > +             elf_end(elf);
> > +     return ret;
> > +}
> > +
> > +/*
> > + * Entry for parse btf file and elf file.
> > + */
> > +static int file_init(char *name)
> > +{
> > +     int fd =3D 0, ret =3D -1;
> > +     char buf[4] =3D {0};
> > +
> > +     /* Will be enlarged automatically */
> > +     if (!btf_files_array) {
> > +             btf_files_array =3D calloc(1, sizeof(struct btf_file *));
> > +             if (!btf_files_array) {
> > +                     fprintf(stderr, "%s: Not enough memory!\n", __fun=
c__);
> > +                     goto out;
> > +             }
> > +     }
> > +
> > +     fd =3D open(name, O_RDONLY);
> > +     if (read_file_at_offset(name, 0, sizeof(buf), buf) < 0)
> > +             goto out;
> > +     if (*(u_int16_t *)&buf =3D=3D BTF_MAGIC) {
> > +             ret =3D btf_file_init(fd);
> > +     } else if (*(u_int32_t *)&buf =3D=3D (((u_int32_t)ELFMAG0 << 24) =
|
> > +                                       ((u_int32_t)ELFMAG1 << 16) |
> > +                                       ((u_int32_t)ELFMAG2 << 8)  |
> > +                                       ((u_int32_t)ELFMAG3 << 0))) {
> > +             ret =3D elf_file_init(fd);
> > +     } else {
> > +             __builtin_unreachable();
> > +     }
> > +
> > +out:
> > +     if (fd)
> > +             close(fd);
> > +     return ret;
> > +}
> > +
> > +/* For pure buffer data, wrap it as a file, and handover to file_init(=
) */
> > +char temp[] =3D "/tmp/btf_XXXXXX";
> > +static int init_btf_from_buf(char *mod_name, char *buf, int size)
> > +{
> > +     int fd;
> > +     char name_buf[64];
> > +     int w, got =3D 0;
> > +     static char *temp_dir =3D NULL;
> > +
> > +     if (!temp_dir)
> > +             temp_dir =3D mkdtemp(temp);
> > +     snprintf(name_buf, sizeof(name_buf), "%s/%s", temp_dir, mod_name)=
;
> > +     fd =3D open(name_buf, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
> > +     if (fd < 0) {
> > +             fprintf(stderr, "%s: open fail in %s!\n", __func__, name_=
buf);
> > +             return -1;
> > +     }
> > +
> > +     while (got < size) {
> > +             w =3D pwrite(fd, buf + got, size - got, got);
> > +             if (w < 0) {
> > +                     fprintf(stderr, "%s: pwrite fail in %s!\n", __fun=
c__, name_buf);
> > +                     return -1;
> > +             }
> > +             got +=3D w;
> > +     }
> > +     close(fd);
> > +     return file_init(name_buf);
> > +}
> > +
> > +int init_kernel_btf(void)
> > +{
> > +     uint64_t size;
> > +     char *buf;
> > +     int ret;
> > +
> > +     uint64_t start_btf =3D get_kallsyms_value_by_name("__start_BTF");
> > +     uint64_t stop_btf =3D get_kallsyms_value_by_name("__stop_BTF");
> > +     if (!start_btf || !stop_btf) {
> > +             fprintf(stderr, "%s: symbol __start/stop_BTF not found!\n=
", __func__);
> > +             return -1;
> > +     }
> > +
> > +     size =3D stop_btf - start_btf;
> > +     buf =3D (char *)malloc(size);
> > +     if (!buf) {
> > +             fprintf(stderr, "%s: Not enough memory!\n", __func__);
> > +             return -1;
> > +     }
> > +     readmem(VADDR, start_btf, buf, size);
> > +     ret =3D init_btf_from_buf("vmlinux", buf, size);
> > +     free(buf);
> > +
> > +     return ret;
> > +}
> > +
> > diff --git a/btf.h b/btf.h
> > new file mode 100644
> > index 0000000..424e9e0
> > --- /dev/null
> > +++ b/btf.h
> > @@ -0,0 +1,175 @@
> > +#ifndef _BTF_H
> > +#define _BTF_H
> > +#include <stdint.h>
> > +#include <stdbool.h>
> > +
> > +typedef uint8_t  __u8;
> > +typedef uint16_t __u16;
> > +typedef uint32_t __u32;
> > +typedef int32_t __s32;
> > +
> > +#define BTF_MAGIC    0xeb9f
> > +
> > +enum {
> > +     BTF_KIND_UNKN           =3D 0,    /* Unknown      */
> > +     BTF_KIND_INT            =3D 1,    /* Integer      */
> > +     BTF_KIND_PTR            =3D 2,    /* Pointer      */
> > +     BTF_KIND_ARRAY          =3D 3,    /* Array        */
> > +     BTF_KIND_STRUCT         =3D 4,    /* Struct       */
> > +     BTF_KIND_UNION          =3D 5,    /* Union        */
> > +     BTF_KIND_ENUM           =3D 6,    /* Enumeration  */
> > +     BTF_KIND_FWD            =3D 7,    /* Forward      */
> > +     BTF_KIND_TYPEDEF        =3D 8,    /* Typedef      */
> > +     BTF_KIND_VOLATILE       =3D 9,    /* Volatile     */
> > +     BTF_KIND_CONST          =3D 10,   /* Const        */
> > +     BTF_KIND_RESTRICT       =3D 11,   /* Restrict     */
> > +     BTF_KIND_FUNC           =3D 12,   /* Function     */
> > +     BTF_KIND_FUNC_PROTO     =3D 13,   /* Function Proto       */
> > +     BTF_KIND_VAR            =3D 14,   /* Variable     */
> > +     BTF_KIND_DATASEC        =3D 15,   /* Section      */
> > +     BTF_KIND_FLOAT          =3D 16,   /* Floating point       */
> > +     BTF_KIND_DECL_TAG       =3D 17,   /* Decl Tag */
> > +     BTF_KIND_TYPE_TAG       =3D 18,   /* Type Tag */
> > +     BTF_KIND_ENUM64 =3D 19,   /* Enumeration up to 64-bit values */
> > +
> > +     NR_BTF_KINDS,
> > +     BTF_KIND_MAX            =3D NR_BTF_KINDS - 1,
> > +};
> > +
> > +struct btf_type {
> > +     __u32 name_off;
> > +
> > +     /* "info" bits arrangement
> > +      * bits  0-15: vlen (e.g. # of struct's members)
> > +      * bits 16-23: unused
> > +      * bits 24-27: kind (e.g. int, ptr, array...etc)
> > +      * bits 28-30: unused
> > +      * bit     31: kind_flag, currently used by
> > +      *             struct, union and fwd
> > +      */
> > +     __u32 info;
> > +
> > +     /* "size" is used by INT, ENUM, STRUCT, UNION and DATASEC.
> > +      * "size" tells the size of the type it is describing.
> > +      *
> > +      * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
> > +      * FUNC, FUNC_PROTO, VAR, DECL_TAG and TYPE_TAG.
> > +      * "type" is a type_id referring to another type.
> > +      */
> > +     union {
> > +             __u32 size;
> > +             __u32 type;
> > +     };
> > +};
> > +
> > +struct btf_header {
> > +     __u16   magic;
> > +     __u8    version;
> > +     __u8    flags;
> > +     __u32   hdr_len;
> > +
> > +     /* All offsets are in bytes relative to the end of this header */
> > +     __u32   type_off;       /* offset of type section       */
> > +     __u32   type_len;       /* length of type section       */
> > +     __u32   str_off;        /* offset of string section     */
> > +     __u32   str_len;        /* length of string section     */
> > +};
> > +
> > +struct btf_array {
> > +     __u32   type;
> > +     __u32   index_type;
> > +     __u32   nelems;
> > +};
> > +
> > +struct btf_member {
> > +     __u32   name_off;
> > +     __u32   type;
> > +     /* If the type info kind_flag is set, the btf_member offset
> > +      * contains both member bitfield size and bit offset. The
> > +      * bitfield size is set for bitfield members. If the type
> > +      * info kind_flag is not set, the offset contains only bit
> > +      * offset.
> > +      */
> > +     __u32   offset;
> > +};
> > +
> > +struct btf_enum {
> > +     __u32   name_off;
> > +     __s32   val;
> > +};
> > +
> > +struct btf_enum64 {
> > +     __u32   name_off;
> > +     __u32   val_lo32;
> > +     __u32   val_hi32;
> > +};
> > +
> > +struct btf_param {
> > +     __u32   name_off;
> > +     __u32   type;
> > +};
> > +
> > +struct btf_var {
> > +     __u32   linkage;
> > +};
> > +
> > +struct btf_var_secinfo {
> > +     __u32   type;
> > +     __u32   offset;
> > +     __u32   size;
> > +};
> > +
> > +struct btf_decl_tag {
> > +     __s32   component_idx;
> > +};
> > +
> > +/*************************************/
> > +struct btf_file {
> > +     char *file_name;
> > +     char *str_cache;
> > +     uint32_t str_cache_len;
> > +     uint32_t types_data_offset;
> > +     uint32_t array_len;
> > +     struct name_entry **array;
> > +};
> > +
> > +struct name_entry {
> > +     union {
> > +             uint32_t btf_type_offset;
> > +             uint32_t p_id;
> > +     };
> > +
> > +     uint32_t id;
> > +     char *name;
> > +     struct btf_file *bf;
> > +     struct name_entry *name_hash_next;
> > +};
> > +
> > +struct member_info {
> > +     char *sname;    // member name
> > +     char *type;     // member type: int, long etc
> > +     uint32_t bit_pos;       // member position in bits
> > +     uint32_t bits;  // member width in bits
> > +     uint32_t size;  // member size in bytes
> > +     int uniq_id;    // uniq_id of btf
> > +};
> > +
> > +/*************************************/
> > +
> > +int read_file_at_offset(char *, int, int, void *);
> > +int init_kernel_btf(void);
> > +uint32_t get_struct_member_by_name(char *, char *, struct member_info =
*);
> > +bool get_type_member_by_index(uint64_t, int, struct member_info *);
> > +uint32_t get_type_size_by_name(char *, int, uint32_t *);
> > +struct name_entry *get_en_by_uniq_id(uint32_t, struct btf_type *);
> > +void resolve_typedef(struct name_entry *, struct name_entry **, struct=
 btf_type *);
> > +int get_btf_type_by_type_id(struct btf_file *, uint32_t,
> > +                         struct btf_type *, struct name_entry **);
> > +uint32_t id_to_uniq_id(uint32_t, struct btf_file *);
> > +
> > +static inline uint32_t btf_kind(uint32_t info)
> > +{
> > +     return (info & 0x1F000000) >> 24;
> > +}
> > +
> > +#endif /* _BTF_H */
> > --
> > 2.47.0
>


