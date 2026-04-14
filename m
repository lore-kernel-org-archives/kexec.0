Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A953AF9D0C8
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 12:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=62B9koVc77QS12CmKS4aLOtsKKM8d3i6317wAAwhRmg=; b=uYRIoboii1LB4CottlM0C7Ar0t
	rFwanVC86aRlDY/WDI3JYkh0vitHOMPgbtbzSdUF6MivJV13eE0hzASCXhsbcNlDxrYfZcZz2mxAc
	8thrsQ1brlJSlTRyLs/nQDstWkkRphGAv7qHPh6o4BN12TYhF/7EZwvNvqmsb4wduUFPwSCeco1LE
	VHI0H4C8h16dnK6PAGLIQGTlgoJFbDBVn/KxNmI1YxCIfzmU/J8YonkZh2mUsr1pwEdM+GMAMTGBy
	Y/zg5x2fsk77xW5nSgMI1LZjxz8lKVU363FlGshTJ2AuPQbud8DmSMgEas7Dukqn52imT3gUBLZxW
	zhy7f5JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCcYE-0000000HHDe-49T0;
	Tue, 14 Apr 2026 12:07:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCcYC-0000000HHDG-0SIq
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 12:07:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776168446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62B9koVc77QS12CmKS4aLOtsKKM8d3i6317wAAwhRmg=;
	b=dw1WLuekc3QGtlcnreL76IwTJDwv1hpWlpRpU2KcK6OVZuTNa0ma5I3cT9Z/3QbEjRcDE4
	/Y1AnqsyJ/DhagAOwOsta8Rr5jux6aZS9tGyCBVdRdYcCkrD1a3Uux/SDRBS2uxH4mg83T
	WFh5OladfzgyiLHr6RTnFjQLixsTKI4=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-LlPR1Tk8PmelIdigJ-ZSwA-1; Tue, 14 Apr 2026 08:07:21 -0400
X-MC-Unique: LlPR1Tk8PmelIdigJ-ZSwA-1
X-Mimecast-MFC-AGG-ID: LlPR1Tk8PmelIdigJ-ZSwA_1776168441
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-953d479ea6eso6862547241.3
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 05:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776168441; x=1776773241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=62B9koVc77QS12CmKS4aLOtsKKM8d3i6317wAAwhRmg=;
        b=E2kqhTkp1U+pi87gS1GuQMXSET0obVLR01rkyRH8P72iq+PhqhFz66XyaQe2yc3B7A
         X5TvjHsYxAGDE6vxyWSXDN2R3MGvSwCTsf7bxLDtqwL/LPul495ngG7c1d5OXicIO4PJ
         t6kkMPbPz19n7Q3jhUutWkAUrVSB8ElCizOltWA84QB1cJzxElS69kdFFI6F/vxa+UoA
         KQlhSXCcmqvcxAgfze9yXhitkVix7eWtiXXRiUU2VBCHYUrV7S5nWj6/um9tQiY9b5wM
         f4y/lBKBuKL9+Fn2jZ74RPaeb5VRcxYjKc+EVbn7DICHTGZnuO0/DX4zuQ4Ftw3et45V
         oFTQ==
X-Forwarded-Encrypted: i=1; AFNElJ+LG4e6riWJxy+3ETWyRBUc4QZEmxfaOXvHyMLWgpS4IPK/WvejCQ+pzpgZXfCuOThiQB/sEg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyjRkBerxL1G1kLTlhF+U9/z6vvxeyDlyF8FKfphMpCjKrOlPXN
	TK0SzCjNxGwZxwozl5uBtSrO/g0rfLkGaxEo4Th8/UTP5e7YWN51wAVugNRZcEhjNN/lTEwYi/5
	reEeiGpLzJ1lWEJBElXY05sEwiNKfycpCg2YFzx2PXE9IlWW1wKSuUGdhmLrJutbZ1EuNJlzgGV
	Q8A9fbkpIfv4Jost6kYQP+4I7MA7YZArBSR+jz
X-Gm-Gg: AeBDievt4qrvdkU2OcEqs9QOX6DGS4dygT+Vc7v6EMwGt+sJZfFK/xKP0njVvuK0bbC
	kNV5d+Hu5/5W/ZPs9vSBQa50sGO6CI351/Sa7wkXGaZdIDM9Ptiwp3QXtX6g3cjehAGQnq/vWMm
	qsr1gF5FRA2j5ak4uXEN5zVBv9Q549LR88wi26tWbV0A/RMWzF7qgs6mwV/vWMZ7PGSCqUJEF1g
	3BkyYtZ8OeFYA==
X-Received: by 2002:a05:6102:5b:b0:60f:c9ba:b992 with SMTP id ada2fe7eead31-60fc9bad7bbmr2221067137.16.1776168440436;
        Tue, 14 Apr 2026 05:07:20 -0700 (PDT)
X-Received: by 2002:a05:6102:5b:b0:60f:c9ba:b992 with SMTP id
 ada2fe7eead31-60fc9bad7bbmr2221030137.16.1776168439835; Tue, 14 Apr 2026
 05:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260317150743.69590-1-ltao@redhat.com> <20260317150743.69590-8-ltao@redhat.com>
 <87o6k0ew4k.fsf@oracle.com>
In-Reply-To: <87o6k0ew4k.fsf@oracle.com>
From: Tao Liu <ltao@redhat.com>
Date: Wed, 15 Apr 2026 00:06:43 +1200
X-Gm-Features: AQROBzCV2bbpNbz2AFJN5tMA0BpzrHShcnCGvh6hb_MO_dXAF601J9wunBTf2Q4
Message-ID: <CAO7dBbXLvYGhwW7BuKVBiSLMd7M4Ek0WWJz8sZm1ev9wyH29WA@mail.gmail.com>
Subject: Re: [PATCH v4][makedumpfile 7/7] Filter amdgpu mm pages
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org, 
	aravinda@linux.vnet.ibm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xueTQovgZZoK4Kd8Z0ohKJ6QQnKmSV-Mivyhah9pE8c_1776168441
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_050728_292157_034067A0 
X-CRM114-Status: GOOD (  32.30  )
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

On Fri, Apr 3, 2026 at 1:16=E2=80=AFPM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Tao Liu <ltao@redhat.com> writes:
>
> > This patch will introduce maple_tree & amdgpu mm page filtering extensi=
on,
> > those mm pages allocated to amdgpu will be discarded from vmcore, in or=
der
> > to shrink vmcore size since mm pages allocated to amdgpu are useless to=
 kernel
> > crash and may contain sensitive data.
> >
> > Signed-off-by: Tao Liu <ltao@redhat.com>
> > ---
> >  extensions/Makefile        |   4 +-
> >  extensions/amdgpu_filter.c | 190 +++++++++++++++++++++++
> >  extensions/maple_tree.c    | 307 +++++++++++++++++++++++++++++++++++++
> >  extensions/maple_tree.h    |   6 +
> >  4 files changed, 506 insertions(+), 1 deletion(-)
> >  create mode 100644 extensions/amdgpu_filter.c
> >  create mode 100644 extensions/maple_tree.c
> >  create mode 100644 extensions/maple_tree.h
> >
> > diff --git a/extensions/Makefile b/extensions/Makefile
> > index b8bbfbc..55b789b 100644
> > --- a/extensions/Makefile
> > +++ b/extensions/Makefile
> > @@ -1,8 +1,10 @@
> >  CC ?=3D gcc
> > -CONTRIB_SO :=3D
> > +CONTRIB_SO :=3D amdgpu_filter.so
> >
> >  all: $(CONTRIB_SO)
> >
> > +amdgpu_filter.so: maple_tree.c
> > +
> >  $(CONTRIB_SO): %.so: %.c
> >       $(CC) -O2 -g -fPIC -shared -Wl,-T,../makedumpfile.ld -o $@ $^
> >
> > diff --git a/extensions/amdgpu_filter.c b/extensions/amdgpu_filter.c
> > new file mode 100644
> > index 0000000..3a1e9f2
> > --- /dev/null
> > +++ b/extensions/amdgpu_filter.c
> > @@ -0,0 +1,190 @@
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include "maple_tree.h"
> > +#include "../makedumpfile.h"
> > +#include "../btf_info.h"
> > +#include "../kallsyms.h"
> > +#include "../extension.h"
> > +
> > +/*
> > + * These syms/types are must-have for the extension.
> > +*/
> > +INIT_KERN_STRUCT_MEMBER(task_struct, tasks);
> > +INIT_KERN_STRUCT_MEMBER(task_struct, mm);
> > +INIT_KERN_STRUCT_MEMBER(mm_struct, mm_mt);
> > +INIT_KERN_STRUCT_MEMBER(vm_area_struct, vm_ops);
> > +INIT_KERN_STRUCT_MEMBER(vm_area_struct, vm_private_data);
> > +INIT_MOD_STRUCT_MEMBER(amdgpu, ttm_buffer_object, ttm);
> > +INIT_MOD_STRUCT_MEMBER(amdgpu, ttm_tt, pages);
> > +INIT_MOD_STRUCT_MEMBER(amdgpu, ttm_tt, num_pages);
> > +INIT_KERN_STRUCT(page);
> > +
> > +INIT_KERN_SYM(init_task);
> > +INIT_KERN_SYM(vmemmap_base);
> > +INIT_MOD_SYM(amdgpu, amdgpu_gem_vm_ops);
> > +
> > +struct ft_page_info {
> > +     unsigned long pfn;
> > +     unsigned long num;
> > +     struct ft_page_info *next;
> > +};
> > +
> > +static struct ft_page_info *ft_head_discard =3D NULL;
> > +
> > +static void update_filter_pages_info(unsigned long pfn, unsigned long =
num)
> > +{
> > +     struct ft_page_info *p, **ft_head;
> > +     struct ft_page_info *new_p =3D malloc(sizeof(struct ft_page_info)=
);
> > +
> > +     ft_head =3D &ft_head_discard;
> > +
> > +     if (!new_p) {
> > +             fprintf(stderr, "%s: Can't allocate memory for ft_page_in=
fo\n",
> > +                     __func__);
> > +             return;
> > +     }
> > +     new_p->pfn =3D pfn;
> > +     new_p->num =3D num;
> > +     new_p->next =3D NULL;
> > +
> > +     if (!(*ft_head) || (*ft_head)->pfn > new_p->pfn) {
> > +             new_p->next =3D (*ft_head);
> > +             (*ft_head) =3D new_p;
> > +             return;
> > +     }
> > +
> > +     p =3D (*ft_head);
> > +     while (p->next !=3D NULL && p->next->pfn < new_p->pfn) {
> > +             p =3D p->next;
> > +     }
> > +
> > +     new_p->next =3D p->next;
> > +     p->next =3D new_p;
> > +}
> > +
> > +static int filter_page(unsigned long pfn, struct ft_page_info **p)
> > +{
> > +     struct ft_page_info *ft_head =3D ft_head_discard;
> > +
> > +     if (ft_head =3D=3D NULL)
> > +             return PG_UNDECID;
> > +
> > +     if (*p =3D=3D NULL)
> > +             *p =3D ft_head;
> > +
> > +     /* The gap before 1st block */
> > +     if (pfn >=3D 0 && pfn < ft_head->pfn)
> > +             return PG_UNDECID;
> > +
> > +     /* Handle 1~(n-1) blocks and following gaps */
> > +     while ((*p)->next) {
> > +             if (pfn >=3D (*p)->pfn && pfn < (*p)->pfn + (*p)->num)
> > +                     return PG_EXCLUDE; // hit the block
> > +             if (pfn >=3D (*p)->pfn + (*p)->num && pfn < (*p)->next->p=
fn)
> > +                     return PG_UNDECID; // the gap after the block
> > +             *p =3D (*p)->next;
> > +     }
> > +
> > +     /* The last block and gap */
> > +     if (pfn >=3D (*p)->pfn + (*p)->num)
> > +             return PG_UNDECID;
> > +     else
> > +             return PG_EXCLUDE;
> > +}
> > +
> > +static void do_cleanup(struct ft_page_info **ft_head)
> > +{
> > +     struct ft_page_info *p, *p_tmp;
> > +
> > +     for (p =3D *ft_head; p;) {
> > +             p_tmp =3D p;
> > +             p =3D p->next;
> > +             free(p_tmp);
> > +     }
> > +     *ft_head =3D NULL;
> > +}
> > +
> > +#define KERN_MEMBER_OFF(S, M) \
> > +     GET_KERN_STRUCT_MEMBER_MOFF(S, M) / 8
> > +#define MOD_MEMBER_OFF(MOD, S, M) \
> > +     GET_MOD_STRUCT_MEMBER_MOFF(MOD, S, M) / 8
> > +
> > +static void gather_amdgpu_mm_range_info(void)
> > +{
> > +     uint64_t init_task, list, list_offset, amdgpu_gem_vm_ops;
> > +     uint64_t mm, vm_ops, tbo, ttm, num_pages, pages, pfn, vmemmap_bas=
e;
> > +     int array_len;
> > +     unsigned long *array_out;
> > +     init_task =3D GET_KERN_SYM(init_task);
> > +     amdgpu_gem_vm_ops =3D GET_MOD_SYM(amdgpu, amdgpu_gem_vm_ops);
> > +
> > +     list =3D init_task + KERN_MEMBER_OFF(task_struct, tasks);
> > +
> > +     do {
> > +             readmem(VADDR, list - KERN_MEMBER_OFF(task_struct, tasks)=
 +
> > +                             KERN_MEMBER_OFF(task_struct, mm),
> > +                     &mm, sizeof(uint64_t));
> > +             if (!mm) {
> > +                     list =3D next_list(list);
> > +                     continue;
> > +             }
> > +
> > +             array_out =3D mt_dump(mm + KERN_MEMBER_OFF(mm_struct, mm_=
mt), &array_len);
> > +             if (!array_out)
> > +                     return;
> > +
> > +             for (int i =3D 0; i < array_len; i++) {
> > +                     num_pages =3D 0;
> > +                     readmem(VADDR, array_out[i] + KERN_MEMBER_OFF(vm_=
area_struct, vm_ops),
> > +                             &vm_ops, GET_KERN_STRUCT_MEMBER_MSIZE(vm_=
area_struct, vm_ops));
> > +                     if (vm_ops =3D=3D amdgpu_gem_vm_ops) {
> > +                             readmem(VADDR, array_out[i] +
> > +                                     KERN_MEMBER_OFF(vm_area_struct, v=
m_private_data),
> > +                                     &tbo, GET_KERN_STRUCT_MEMBER_MSIZ=
E(vm_area_struct, vm_private_data));
> > +                             readmem(VADDR, tbo + MOD_MEMBER_OFF(amdgp=
u, ttm_buffer_object, ttm),
> > +                                     &ttm, GET_MOD_STRUCT_MEMBER_MSIZE=
(amdgpu, ttm_buffer_object, ttm));
> > +                             if (ttm) {
> > +                                     readmem(VADDR, ttm + MOD_MEMBER_O=
FF(amdgpu, ttm_tt, num_pages),
> > +                                             &num_pages, GET_MOD_STRUC=
T_MEMBER_MSIZE(amdgpu, ttm_tt, num_pages));
> > +                                     readmem(VADDR, ttm + MOD_MEMBER_O=
FF(amdgpu, ttm_tt, pages),
> > +                                             &pages, GET_MOD_STRUCT_ME=
MBER_MSIZE(amdgpu, ttm_tt, pages));
>
> Are these pages guaranteed to be contiguous?
> If not, you're applying the page filter rule based on just the first
> element of the pages array.
> If they are guaranteed contiguous, maybe a comment would be helpful?

Hmm, frankly I'm not sure if all the pages are contiguous. All I saw was:

struct ttm_tt {
/** @pages: Array of pages backing the data. */
struct page **pages;
/** @num_pages: Number of pages in the page array. */
uint32_t num_pages;
...
};

So if I know ttm_tt, I can resolve pages & num_pages, and I can
convert pages into pfn. Since the makedumpfile callback will give pfn
one by one, I can know if one specific pfn is located within
pages(pfn) ~ pages(pfn + num_pages). Honestly I didn't take page
contiguous into consideration. I'm not an expert to kernel mm, is page
contiguity an essential issue here?

Thanks,
Tao Liu

>
> Thanks,
> Stephen
>
> > +                                     readmem(VADDR, pages, &pages, siz=
eof(unsigned long));
> > +                                     readmem(VADDR, GET_KERN_SYM(vmemm=
ap_base),
> > +                                             &vmemmap_base, sizeof(uns=
igned long));
> > +                                     pfn =3D (pages - vmemmap_base) / =
GET_KERN_STRUCT_SSIZE(page);
> > +                                     update_filter_pages_info(pfn, num=
_pages);
> > +                             }
> > +                     }
> > +             }
> > +
> > +             free(array_out);
> > +             list =3D next_list(list);
> > +     } while (list !=3D init_task + KERN_MEMBER_OFF(task_struct, tasks=
));
> > +
> > +     return;
> > +}
> > +
> > +/* Extension callback when makedumpfile do page filtering */
> > +int extension_callback(unsigned long pfn, const void *pcache)
> > +{
> > +     struct ft_page_info *cur =3D NULL;
> > +
> > +     return filter_page(pfn, &cur);
> > +}
> > +
> > +/* Entry of extension */
> > +void extension_init(void)
> > +{
> > +     if (!maple_init()) {
> > +             goto out;
> > +     }
> > +     gather_amdgpu_mm_range_info();
> > +out:
> > +     return;
> > +}
> > +
> > +__attribute__((destructor))
> > +void extension_cleanup(void)
> > +{
> > +     do_cleanup(&ft_head_discard);
> > +}
> > diff --git a/extensions/maple_tree.c b/extensions/maple_tree.c
> > new file mode 100644
> > index 0000000..e367940
> > --- /dev/null
> > +++ b/extensions/maple_tree.c
> > @@ -0,0 +1,307 @@
> > +#include <stdio.h>
> > +#include <stdbool.h>
> > +#include "../btf_info.h"
> > +#include "../kallsyms.h"
> > +#include "../makedumpfile.h"
> > +
> > +static unsigned char mt_slots[4] =3D {0};
> > +static unsigned char mt_pivots[4] =3D {0};
> > +static unsigned long mt_max[4] =3D {0};
> > +
> > +INIT_OPT_KERN_SYM(mt_slots);
> > +INIT_OPT_KERN_SYM(mt_pivots);
> > +
> > +INIT_OPT_KERN_STRUCT(maple_tree);
> > +INIT_OPT_KERN_STRUCT(maple_node);
> > +INIT_OPT_KERN_STRUCT_MEMBER(maple_tree, ma_root);
> > +INIT_OPT_KERN_STRUCT_MEMBER(maple_node, ma64);
> > +INIT_OPT_KERN_STRUCT_MEMBER(maple_node, mr64);
> > +INIT_OPT_KERN_STRUCT_MEMBER(maple_node, slot);
> > +INIT_OPT_KERN_STRUCT_MEMBER(maple_arange_64, pivot);
> > +INIT_OPT_KERN_STRUCT_MEMBER(maple_arange_64, slot);
> > +INIT_OPT_KERN_STRUCT_MEMBER(maple_range_64, pivot);
> > +INIT_OPT_KERN_STRUCT_MEMBER(maple_range_64, slot);
> > +
> > +#define MEMBER_OFF(S, M) \
> > +     GET_KERN_STRUCT_MEMBER_MOFF(S, M) / 8
> > +
> > +#define MAPLE_BUFSIZE                        512
> > +
> > +enum {
> > +     maple_dense_enum,
> > +     maple_leaf_64_enum,
> > +     maple_range_64_enum,
> > +     maple_arange_64_enum,
> > +};
> > +
> > +#define MAPLE_NODE_MASK                      255UL
> > +#define MAPLE_NODE_TYPE_MASK         0x0F
> > +#define MAPLE_NODE_TYPE_SHIFT                0x03
> > +#define XA_ZERO_ENTRY                        xa_mk_internal(257)
> > +
> > +static unsigned long xa_mk_internal(unsigned long v)
> > +{
> > +     return (v << 2) | 2;
> > +}
> > +
> > +static bool xa_is_internal(unsigned long entry)
> > +{
> > +     return (entry & 3) =3D=3D 2;
> > +}
> > +
> > +static bool xa_is_node(unsigned long entry)
> > +{
> > +     return xa_is_internal(entry) && entry > 4096;
> > +}
> > +
> > +static bool xa_is_value(unsigned long entry)
> > +{
> > +     return entry & 1;
> > +}
> > +
> > +static bool xa_is_zero(unsigned long entry)
> > +{
> > +     return entry =3D=3D XA_ZERO_ENTRY;
> > +}
> > +
> > +static unsigned long xa_to_internal(unsigned long entry)
> > +{
> > +     return entry >> 2;
> > +}
> > +
> > +static unsigned long xa_to_value(unsigned long entry)
> > +{
> > +     return entry >> 1;
> > +}
> > +
> > +static unsigned long mte_to_node(unsigned long entry)
> > +{
> > +        return entry & ~MAPLE_NODE_MASK;
> > +}
> > +
> > +static unsigned long mte_node_type(unsigned long maple_enode_entry)
> > +{
> > +     return (maple_enode_entry >> MAPLE_NODE_TYPE_SHIFT) &
> > +             MAPLE_NODE_TYPE_MASK;
> > +}
> > +
> > +static unsigned long mt_slot(void **slots, unsigned char offset)
> > +{
> > +       return (unsigned long)slots[offset];
> > +}
> > +
> > +static bool ma_is_leaf(unsigned long type)
> > +{
> > +     return type < maple_range_64_enum;
> > +}
> > +
> > +static bool mte_is_leaf(unsigned long maple_enode_entry)
> > +{
> > +       return ma_is_leaf(mte_node_type(maple_enode_entry));
> > +}
> > +
> > +static void mt_dump_entry(unsigned long entry, unsigned long min,
> > +                     unsigned long max, unsigned int depth,
> > +                     unsigned long **array_out, int *array_len,
> > +                     int *array_cap)
> > +{
> > +     if (entry =3D=3D 0)
> > +             return;
> > +
> > +     add_to_arr((void ***)array_out, array_len, array_cap, (void *)ent=
ry);
> > +}
> > +
> > +static void mt_dump_node(unsigned long entry, unsigned long min,
> > +                     unsigned long max, unsigned int depth,
> > +                     unsigned long **array_out, int *array_len,
> > +                     int *array_cap);
> > +
> > +static void mt_dump_range64(unsigned long entry, unsigned long min,
> > +                     unsigned long max, unsigned int depth,
> > +                     unsigned long **array_out, int *array_len,
> > +                     int *array_cap)
> > +{
> > +     unsigned long maple_node_m_node =3D mte_to_node(entry);
> > +     char node_buf[MAPLE_BUFSIZE];
> > +     bool leaf =3D mte_is_leaf(entry);
> > +     unsigned long first =3D min, last;
> > +     int i;
> > +     char *mr64_buf;
> > +
> > +     readmem(VADDR, maple_node_m_node, node_buf, GET_KERN_STRUCT_SSIZE=
(maple_node));
> > +     mr64_buf =3D node_buf + MEMBER_OFF(maple_node, mr64);
> > +
> > +     for (i =3D 0; i < mt_slots[maple_range_64_enum]; i++) {
> > +             last =3D max;
> > +
> > +             if (i < (mt_slots[maple_range_64_enum] - 1))
> > +                     last =3D ULONG(mr64_buf + MEMBER_OFF(maple_range_=
64, pivot) +
> > +                                  sizeof(ulong) * i);
> > +
> > +             else if (!VOID_PTR(mr64_buf + MEMBER_OFF(maple_range_64, =
slot) +
> > +                       sizeof(void *) * i) &&
> > +                      max !=3D mt_max[mte_node_type(entry)])
> > +                     break;
> > +             if (last =3D=3D 0 && i > 0)
> > +                     break;
> > +             if (leaf)
> > +                     mt_dump_entry(mt_slot((void **)(mr64_buf +
> > +                                                   MEMBER_OFF(maple_ra=
nge_64, slot)), i),
> > +                             first, last, depth + 1, array_out, array_=
len, array_cap);
> > +             else if (VOID_PTR(mr64_buf + MEMBER_OFF(maple_range_64, s=
lot) +
> > +                               sizeof(void *) * i)) {
> > +                     mt_dump_node(mt_slot((void **)(mr64_buf +
> > +                                                  MEMBER_OFF(maple_ran=
ge_64, slot)), i),
> > +                             first, last, depth + 1, array_out, array_=
len, array_cap);
> > +             }
> > +
> > +             if (last =3D=3D max)
> > +                     break;
> > +             if (last > max) {
> > +                     printf("node %p last (%lu) > max (%lu) at pivot %=
d!\n",
> > +                             mr64_buf, last, max, i);
> > +                     break;
> > +             }
> > +             first =3D last + 1;
> > +     }
> > +}
> > +
> > +static void mt_dump_arange64(unsigned long entry, unsigned long min,
> > +                     unsigned long max, unsigned int depth,
> > +                     unsigned long **array_out, int *array_len,
> > +                     int *array_cap)
> > +{
> > +     unsigned long maple_node_m_node =3D mte_to_node(entry);
> > +     char node_buf[MAPLE_BUFSIZE];
> > +     unsigned long first =3D min, last;
> > +     int i;
> > +     char *ma64_buf;
> > +
> > +     readmem(VADDR, maple_node_m_node, node_buf, GET_KERN_STRUCT_SSIZE=
(maple_node));
> > +     ma64_buf =3D node_buf + MEMBER_OFF(maple_node, ma64);
> > +
> > +     for (i =3D 0; i < mt_slots[maple_arange_64_enum]; i++) {
> > +             last =3D max;
> > +
> > +             if (i < (mt_slots[maple_arange_64_enum] - 1))
> > +                     last =3D ULONG(ma64_buf + MEMBER_OFF(maple_arange=
_64, pivot) +
> > +                                  sizeof(void *) * i);
> > +             else if (!VOID_PTR(ma64_buf + MEMBER_OFF(maple_arange_64,=
 slot) +
> > +                                sizeof(void *) * i))
> > +                     break;
> > +             if (last =3D=3D 0 && i > 0)
> > +                     break;
> > +
> > +             if (ULONG(ma64_buf + MEMBER_OFF(maple_arange_64, slot) + =
sizeof(void *) * i))
> > +                     mt_dump_node(mt_slot((void **)(ma64_buf +
> > +                                                   MEMBER_OFF(maple_ar=
ange_64, slot)), i),
> > +                             first, last, depth + 1, array_out, array_=
len, array_cap);
> > +
> > +             if (last =3D=3D max)
> > +                     break;
> > +             if (last > max) {
> > +                     printf("node %p last (%lu) > max (%lu) at pivot %=
d!\n",
> > +                             ma64_buf, last, max, i);
> > +                     break;
> > +             }
> > +             first =3D last + 1;
> > +     }
> > +}
> > +
> > +static void mt_dump_node(unsigned long entry, unsigned long min,
> > +                     unsigned long max, unsigned int depth,
> > +                     unsigned long **array_out, int *array_len,
> > +                     int *array_cap)
> > +{
> > +     unsigned long maple_node =3D mte_to_node(entry);
> > +     unsigned long type =3D mte_node_type(entry);
> > +     int i;
> > +     char node_buf[MAPLE_BUFSIZE];
> > +
> > +     readmem(VADDR, maple_node, node_buf, GET_KERN_STRUCT_SSIZE(maple_=
node));
> > +
> > +     switch (type) {
> > +     case maple_dense_enum:
> > +             for (i =3D 0; i < mt_slots[maple_dense_enum]; i++) {
> > +                     if (min + i > max)
> > +                             printf("OUT OF RANGE: ");
> > +                     mt_dump_entry(mt_slot((void **)(node_buf + MEMBER=
_OFF(maple_node, slot)), i),
> > +                             min + i, min + i, depth, array_out, array=
_len, array_cap);
> > +             }
> > +             break;
> > +     case maple_leaf_64_enum:
> > +     case maple_range_64_enum:
> > +             mt_dump_range64(entry, min, max, depth, array_out, array_=
len, array_cap);
> > +             break;
> > +     case maple_arange_64_enum:
> > +             mt_dump_arange64(entry, min, max, depth, array_out, array=
_len, array_cap);
> > +             break;
> > +     default:
> > +             printf(" UNKNOWN TYPE\n");
> > +     }
> > +}
> > +
> > +unsigned long *mt_dump(unsigned long mt, int *array_len)
> > +{
> > +     char tree_buf[MAPLE_BUFSIZE];
> > +     unsigned long entry;
> > +     unsigned long *array_out =3D NULL;
> > +     int array_cap =3D 0;
> > +     *array_len =3D 0;
> > +
> > +     readmem(VADDR, mt, tree_buf, GET_KERN_STRUCT_SSIZE(maple_tree));
> > +     entry =3D ULONG(tree_buf + MEMBER_OFF(maple_tree, ma_root));
> > +
> > +     if (xa_is_node(entry))
> > +             mt_dump_node(entry, 0, mt_max[mte_node_type(entry)], 0,
> > +                             &array_out, array_len, &array_cap);
> > +     else if (entry)
> > +             mt_dump_entry(entry, 0, 0, 0, &array_out, array_len, &arr=
ay_cap);
> > +     else
> > +             printf("(empty)\n");
> > +
> > +     return array_out;
> > +}
> > +
> > +bool maple_init(void)
> > +{
> > +     unsigned long mt_slots_ptr;
> > +     unsigned long mt_pivots_ptr;
> > +
> > +     if (!KERN_SYM_EXIST(mt_slots) ||
> > +         !KERN_SYM_EXIST(mt_pivots) ||
> > +         !KERN_STRUCT_EXIST(maple_tree) ||
> > +         !KERN_STRUCT_EXIST(maple_node) ||
> > +         !KERN_STRUCT_MEMBER_EXIST(maple_tree, ma_root) ||
> > +         !KERN_STRUCT_MEMBER_EXIST(maple_node, ma64) ||
> > +         !KERN_STRUCT_MEMBER_EXIST(maple_node, mr64) ||
> > +         !KERN_STRUCT_MEMBER_EXIST(maple_node, slot) ||
> > +         !KERN_STRUCT_MEMBER_EXIST(maple_arange_64, pivot) ||
> > +         !KERN_STRUCT_MEMBER_EXIST(maple_arange_64, slot) ||
> > +         !KERN_STRUCT_MEMBER_EXIST(maple_range_64, pivot) ||
> > +         !KERN_STRUCT_MEMBER_EXIST(maple_range_64, slot)) {
> > +             printf("%s: Missing required maple tree syms/types\n",
> > +                     __func__);
> > +             return false;
> > +     }
> > +
> > +     mt_slots_ptr =3D GET_KERN_SYM(mt_slots);
> > +     mt_pivots_ptr =3D GET_KERN_SYM(mt_pivots);
> > +
> > +     if (GET_KERN_STRUCT_SSIZE(maple_tree) > MAPLE_BUFSIZE ||
> > +         GET_KERN_STRUCT_SSIZE(maple_node) > MAPLE_BUFSIZE) {
> > +             printf("%s: MAPLE_BUFSIZE should be larger than maple_nod=
e/tree struct\n",
> > +                     __func__);
> > +             return false;
> > +     }
> > +
> > +     readmem(VADDR, mt_slots_ptr, mt_slots, sizeof(mt_slots));
> > +     readmem(VADDR, mt_pivots_ptr, mt_pivots, sizeof(mt_pivots));
> > +
> > +     mt_max[maple_dense_enum]           =3D mt_slots[maple_dense_enum]=
;
> > +     mt_max[maple_leaf_64_enum]         =3D ULONG_MAX;
> > +     mt_max[maple_range_64_enum]        =3D ULONG_MAX;
> > +     mt_max[maple_arange_64_enum]       =3D ULONG_MAX;
> > +
> > +     return true;
> > +}
> > \ No newline at end of file
> > diff --git a/extensions/maple_tree.h b/extensions/maple_tree.h
> > new file mode 100644
> > index 0000000..c96624c
> > --- /dev/null
> > +++ b/extensions/maple_tree.h
> > @@ -0,0 +1,6 @@
> > +#ifndef _MAPLE_TREE_H
> > +#define _MAPLE_TREE_H
> > +#include <stdbool.h>
> > +unsigned long *mt_dump(unsigned long mt, int *array_len);
> > +bool maple_init(void);
> > +#endif /* _MAPLE_TREE_H */
> > \ No newline at end of file
> > --
> > 2.47.0
>


