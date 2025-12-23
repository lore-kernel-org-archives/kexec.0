Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97421E6F086
	for <kexec@archiver.kernel.org>; Tue, 23 Dec 2025 18:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PVx2nAFksQg/a38aJdINFccCMXBBt8T+waa+FXWTYGk=; b=4rCHl+7L4hKal7MwQtsKKH2U7x
	rnZWTfE3jIdwllsCB+e0LBGPZK7OtQ566A5DZ78aFlo+yXu3NOugspOgeJF46JNJvazPf+gdzZlZ7
	1rgg1Gg5avru/vP5pnKCfKaaX3xJ3Vi9Paiy4sCAl/8jV4wDgkqXY95fKw+0sNtbk2KZnotaKYEw1
	yIFLE1iRLlgsBMQPzA2TtRWSkUMEkyI2D61RS8bvIFwdDWwMxLW+5xjzajBPRdbolBU9jnwElqTF9
	+ECAeEMOckvM3QkTqlV5CVNVd97PsdgfoMo/GYUFtrmzsWPcb6RZjTMadrQwFqUmt9ESH+mQs5ZJT
	KHhL8BqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vY6ve-0000000FwMN-24Q0;
	Tue, 23 Dec 2025 18:16:14 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vY6vb-0000000FwLw-0SH1
	for kexec@lists.infradead.org;
	Tue, 23 Dec 2025 18:16:12 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-64b5ed53d0aso7491031a12.3
        for <kexec@lists.infradead.org>; Tue, 23 Dec 2025 10:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1766513769; x=1767118569; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVx2nAFksQg/a38aJdINFccCMXBBt8T+waa+FXWTYGk=;
        b=lIMa3ecmjnIhzV/CnSBJ9gVRVqrEamUgHc367x24Z+YJsUjrhtF67pCMUMtKyvQDdy
         PZq+dy97xsy1NwJsA7BqujItXfTNHyDNNIQOI5tG3uJHujaR9T7SZFoGp4iVxTy1z3hb
         8B7X2G2Ci0Ft9HybxU9hHrLz6WM3qmFamlBkJyaOuCzXjwNgIeblMUdLNo1LVX/bKyqi
         gVaUfXHPpOYjuEDZ+lMw4Cuv7pn114RBQlNp6qm/cFGUEY/PK4xHximfDcxsFkjmtWw5
         lTQ5EGxOjm8waUTW9B0boC7KrtKAEy5pvulVN1591NPTXOqwRpTR5avMU1HYcGfwxrJ8
         ZxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766513769; x=1767118569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PVx2nAFksQg/a38aJdINFccCMXBBt8T+waa+FXWTYGk=;
        b=OSdiPFpsaI08eoe3t1LGmyaSW0uk/GnrQhdbo8hfU2mu/bb9dgvS/ZP/PY5BkoaNNt
         82E0xbtEBkIvVUlTbtj0wSDE1fiRQtPvWpuVfqgtbLMiR1UR7hQxZbhybvQYAPAy2wIb
         MZcniykYlSmUHmE+6FKDZT8k/Z/MhbAwhSVekhxYmeej9Z9FnT/roOGtFQ3c4gh/oKWs
         buQbnW1mfAoEd+7u3HvSU/St+/mZY32ffOIqqDT95MzdzHuPV+KFTg2u3qgCkS+hudrf
         wQjALmlcm+VqxmMiPUE9Nw7VBESicG6mSaUKS6AstH9D/8YWm+CgJmQ0d5bqK4dbrHre
         XqUg==
X-Forwarded-Encrypted: i=1; AJvYcCUSXjEarVWPXjaIUq5dsZdwi7Ka6dILzX98kH/cfxu99ijdcN5cQK6DOOkiSUrES121h3AX2A==@lists.infradead.org
X-Gm-Message-State: AOJu0YzAyto2Yogk1KMs2GoX3U2d/f5Cfd+lzSOyZA/Ynpa6xAuXiS4A
	oy/wNbvIuJS1AWywjryakuplWGNxTyrMGcLfDTfqK8ayDMPLVDMfTCLh7YR4Cn2owSCtTMUoz1C
	VOX36cNFVdCczUagd9aFOZ48Rpp1oB6TgRC914Gr2BQ==
X-Gm-Gg: AY/fxX6gDOykoIzPqC7d09Iv2AmOv1qDxQuRl5Kk0PBWmRIYCWVBNr3nkxM24yRh57d
	dHa7ShwQdnLdWsh9rRoBFIrpWt5vwgrxCti/IfBq8pflJGKqRSgS9nAv5lNlzUWYdqYsvD6nMMA
	EzawuFX9Csezbx3lU5IKYB1nE4oxNU5UxiKdqR/6GIJPUve11O005xI84OxD7f5AuSAIsKQqCta
	dWK0u+09K/0OXyNwJDMTusQPw+g60Ar7cc/Y7TyGFkM7a4ZEZJpCN+2vy4GneuRtGMpjyurZJcM
	b4/5rf2h/4dKui0J/gN56vCFZA==
X-Google-Smtp-Source: AGHT+IH7NSdBnLF6TNPXxp4bPGpzdnQpcj48wXHwYTRov5CK03y4EL2fqzNjRMqQQnS2tZUtsrORdwiJxz0bGlkJiQE=
X-Received: by 2002:a05:6402:2685:b0:64b:5f4e:9e6d with SMTP id
 4fb4d7f45d1cf-64b8eddd07bmr14477839a12.18.1766513768796; Tue, 23 Dec 2025
 10:16:08 -0800 (PST)
MIME-Version: 1.0
References: <20251206230222.853493-1-pratyush@kernel.org> <20251206230222.853493-7-pratyush@kernel.org>
In-Reply-To: <20251206230222.853493-7-pratyush@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 23 Dec 2025 13:15:31 -0500
X-Gm-Features: AQt7F2oTu0JP78Rjz5J87zm4iVmLuL0S_zgWsfkEAAAVgXqABRjbHoos4xXesRU
Message-ID: <CA+CK2bAVuHG1cVPQz8Wafe8o2TtitrqJjqfHOT7Xun=zWMoo2Q@mail.gmail.com>
Subject: Re: [RFC PATCH 06/10] liveupdate: hugetlb subsystem FLB state preservation
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Alexander Graf <graf@amazon.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251223_101611_328759_1A0F0BCC 
X-CRM114-Status: GOOD (  48.74  )
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

On Sat, Dec 6, 2025 at 6:03=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
>
> HugeTLB manages its own pages. It allocates them on boot and uses those
> to fulfill hugepage requests.
>
> To support live update for a hugetlb-backed memfd, it is necessary to
> track how many pages of each hstate are coming from live update. This is
> needed to ensure the boot time allocations don't over-allocate huge
> pages, causing the rest of the system unexpected memory pressure.
>
> For example, say the system has 100G memory and it uses 90 1G huge
> pages, with 10G put aside for other processes. Now say 5 of those pages
> are preserved via KHO for live updating a huge memfd.
>
> But during boot, the system will still see that it needs 90 huge pages,
> so it will attempt to allocate those. When the file is later retrieved,
> those 5 pages also get added to the huge page pool, resulting in 95
> total huge pages. This exceeds the original expectation of 90 pages, and
> ends up wasting memory.
>
> LUO has file-lifecycle-bound (FLB) data to keep track of global state of
> a subsystem. Use it to track how many huge pages are used up for each
> hstate. When a file is preserved, it will increment to the counter, and
> when it is unpreserved, it will decrement it. During boot time
> allocations, this data can be used to calculate how many hugepages
> actually need to be allocated.
>
> Design note: another way of doing this would be to preserve the entire
> set of hugepages using the FLB, skip boot time allocation, and restore
> them all on FLB retrieve. The pain problem with that approach is that it
> would need to freeze all hstates after serializing them. This will need
> a lot more invasive changes in hugetlb since there are many ways folios
> can be added to or removed from a hstate. Doing it this way is simpler
> and less invasive.
>
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
> ---
>  Documentation/mm/memfd_preservation.rst |   9 ++
>  MAINTAINERS                             |   1 +
>  include/linux/kho/abi/hugetlb.h         |  66 +++++++++
>  kernel/liveupdate/Kconfig               |  12 ++
>  mm/Makefile                             |   1 +
>  mm/hugetlb.c                            |   1 +
>  mm/hugetlb_internal.h                   |  15 ++
>  mm/hugetlb_luo.c                        | 179 ++++++++++++++++++++++++
>  8 files changed, 284 insertions(+)
>  create mode 100644 include/linux/kho/abi/hugetlb.h
>  create mode 100644 mm/hugetlb_luo.c
>
> diff --git a/Documentation/mm/memfd_preservation.rst b/Documentation/mm/m=
emfd_preservation.rst
> index 66e0fb6d5ef0..6068dd55f4fb 100644
> --- a/Documentation/mm/memfd_preservation.rst
> +++ b/Documentation/mm/memfd_preservation.rst
> @@ -16,6 +16,15 @@ Memfd Preservation ABI
>  .. kernel-doc:: include/linux/kho/abi/memfd.h
>     :internal:
>
> +HugeTLB-backed memfd Preservation ABI
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. kernel-doc:: include/linux/kho/abi/hugetlb.h
> +   :doc: hugetlb-backed memfd live update ABI
> +
> +.. kernel-doc:: include/linux/kho/abi/hugetlb.h
> +   :internal:
> +
>  See Also
>  =3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fc23a0381e19..55ef24e80ae5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14481,6 +14481,7 @@ F:      include/linux/liveupdate/
>  F:     include/uapi/linux/liveupdate.h
>  F:     kernel/liveupdate/
>  F:     lib/tests/liveupdate.c
> +F:     mm/hugetlb_luo.c
>  F:     mm/memfd_luo.c
>  F:     tools/testing/selftests/liveupdate/
>
> diff --git a/include/linux/kho/abi/hugetlb.h b/include/linux/kho/abi/huge=
tlb.h
> new file mode 100644
> index 000000000000..55e833569c48
> --- /dev/null
> +++ b/include/linux/kho/abi/hugetlb.h
> @@ -0,0 +1,66 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (C) 2025 Amazon.com Inc. or its affiliates.
> + * Pratyush Yadav <pratyush@kernel.org>
> + */
> +
> +#ifndef _LINUX_KHO_ABI_HUGETLB_H
> +#define _LINUX_KHO_ABI_HUGETLB_H
> +
> +#include <linux/hugetlb.h>
> +
> +/**
> + * DOC: hugetlb-backed memfd live update ABI
> + *
> + * This header defines the ABI for preserving the state of the hugetlb s=
ubsystem
> + * and a hugetlb-backed memfd across a kexec reboot using LUO.
> + *
> + * This interface is a contract. Any modification to the structure layou=
t
> + * constitutes a breaking change. Such changes require incrementing the =
version
> + * number in the HUGETLB_FLB_COMPATIBLE or HUGE_MEMFD_COMPATIBLE strings=
 for
> + * hugetlb FLB or hugetlb-backed memfd, respectively.
> + */
> +
> +/*
> + * Keep the serialized max hstates separate from the kernel's HUGE_MAX_H=
STATE to
> + * keep the value stable.
> + *
> + * Currently x86 and arm64 are supported. x86 has HUGE_MAX_HSTATE as 2 a=
nd arm64
> + * has 4. Pick 4 as the number to start with.
> + */
> +#define HUGETLB_SER_MAX_HSTATES                4
> +
> +static_assert(HUGETLB_SER_MAX_HSTATES >=3D HUGE_MAX_HSTATE);
> +
> +/**
> + * struct hugetlb_hstate_ser: Serialized state of a hstate.
> + * @nr_pages:     Number of preserved pages in the hstate.
> + * @order:        Order of the hstate this struct describes.
> + *
> + * The only state needed for hstates is the number of pages that are pre=
served
> + * from this hstate. The preserved pages are added to the hstate when th=
e file
> + * is retrieved. This information gets used in early boot to calculate t=
he
> + * remaining pages that must be allocated by the normal path.
> + */
> +struct hugetlb_hstate_ser {
> +       /* Number of _preserved_ pages in the hstate. */
> +       u64 nr_pages;
> +       u8 order;
> +} __packed;
> +
> +/**
> + * struct hugetlb_ser - The main serialization structure for HugeTLB FLB=
.
> + * @hstates:      Array of serialized hstates.
> + * @nr_hstates:   Number of serialized hstates in the array.
> + */
> +struct hugetlb_ser {
> +       struct hugetlb_hstate_ser hstates[HUGETLB_SER_MAX_HSTATES];
> +       u8 nr_hstates;
> +} __packed;
> +
> +static_assert(sizeof(struct hugetlb_ser) <=3D PAGE_SIZE);
> +
> +#define HUGETLB_FLB_COMPATIBLE "hugetlb-v1"
> +
> +#endif /* _LINUX_KHO_ABI_HUGETLB_H */
> diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> index 9b2515f31afb..86e76aed8a93 100644
> --- a/kernel/liveupdate/Kconfig
> +++ b/kernel/liveupdate/Kconfig
> @@ -72,4 +72,16 @@ config LIVEUPDATE
>
>           If unsure, say N.
>
> +config LIVEUPDATE_HUGETLB
> +       bool "Live update support for HugeTLB"
> +       depends on LIVEUPDATE && HUGETLBFS
> +       help
> +
> +         Enable live update support for the HugeTLB subsystem. This allo=
ws live
> +         updating memfd backed by huge pages. This can be used by hyperv=
isors that
> +         use hugetlb memfd to back VM memory, or for other user workload=
s needing
> +         to live update huge pages.
> +
> +         If unsure, say N.
> +
>  endmenu
> diff --git a/mm/Makefile b/mm/Makefile
> index 7738ec416f00..753bc1e3f3fd 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -101,6 +101,7 @@ obj-$(CONFIG_DEVICE_MIGRATION) +=3D migrate_device.o
>  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) +=3D huge_memory.o khugepaged.o
>  obj-$(CONFIG_PAGE_COUNTER) +=3D page_counter.o
>  obj-$(CONFIG_LIVEUPDATE) +=3D memfd_luo.o
> +obj-$(CONFIG_LIVEUPDATE_HUGETLB) +=3D hugetlb_luo.o
>  obj-$(CONFIG_MEMCG_V1) +=3D memcontrol-v1.o
>  obj-$(CONFIG_MEMCG) +=3D memcontrol.o vmpressure.o
>  ifdef CONFIG_SWAP
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 0f818086bf4f..ff90ceacf62c 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4702,6 +4702,7 @@ static int __init hugetlb_init(void)
>         hugetlb_sysfs_init();
>         hugetlb_cgroup_file_init();
>         hugetlb_sysctl_init();
> +       hugetlb_luo_init();
>
>  #ifdef CONFIG_SMP
>         num_fault_mutexes =3D roundup_pow_of_two(8 * num_possible_cpus())=
;
> diff --git a/mm/hugetlb_internal.h b/mm/hugetlb_internal.h
> index edfb4eb75828..b7b149c56567 100644
> --- a/mm/hugetlb_internal.h
> +++ b/mm/hugetlb_internal.h
> @@ -9,6 +9,7 @@
>  #include <linux/hugetlb.h>
>  #include <linux/hugetlb_cgroup.h>
>  #include <linux/list.h>
> +#include <linux/liveupdate.h>
>
>  void init_new_hugetlb_folio(struct folio *folio);
>  void account_new_hugetlb_folio(struct hstate *h, struct folio *folio);
> @@ -32,4 +33,18 @@ static inline struct resv_map *inode_resv_map(struct i=
node *inode)
>         return (struct resv_map *)(&inode->i_data)->i_private_data;
>  }
>
> +#ifdef CONFIG_LIVEUPDATE_HUGETLB
> +void hugetlb_luo_init(void);
> +unsigned long hstate_liveupdate_pages(struct hstate *h);
> +#else
> +static inline void hugetlb_luo_init(void)
> +{
> +}
> +
> +static inline unsigned long hstate_liveupdate_pages(struct hstate *h)
> +{
> +       return 0;
> +}
> +#endif /* CONFIG_LIVEUPDATE_HUGETLB */
> +
>  #endif /* __HUGETLB_INTERNAL_H */
> diff --git a/mm/hugetlb_luo.c b/mm/hugetlb_luo.c
> new file mode 100644
> index 000000000000..80e3e015eca5
> --- /dev/null
> +++ b/mm/hugetlb_luo.c
> @@ -0,0 +1,179 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Amazon.com Inc. or its affiliates.
> + * Copyright (C) 2025 Pratyush Yadav <pratyush@kernel.org>
> + */
> +
> +/* The documentation for this is in mm/memfd_luo.c */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/liveupdate.h>
> +#include <linux/kexec_handover.h>
> +#include <linux/hugetlb.h>
> +#include <linux/kho/abi/hugetlb.h>
> +#include <linux/spinlock.h>
> +
> +#include "hugetlb_internal.h"
> +
> +struct hugetlb_flb_obj {
> +       /* Serializes access to ser and its hstates. */
> +       spinlock_t lock;
> +       struct hugetlb_ser *ser;
> +};
> +
> +static int hugetlb_flb_preserve(struct liveupdate_flb_op_args *args)
> +{
> +       struct hugetlb_ser *hugetlb_ser;
> +       struct hugetlb_flb_obj *obj;
> +       u8 nr_hstates =3D 0;
> +       struct hstate *h;
> +
> +       obj =3D kmalloc(sizeof(*obj), GFP_KERNEL);
> +       if (!obj)
> +               return -ENOMEM;
> +
> +       hugetlb_ser =3D kho_alloc_preserve(sizeof(*hugetlb_ser));
> +       if (!hugetlb_ser) {
> +               kfree(obj);
> +               return -ENOMEM;
> +       }
> +
> +       spin_lock_init(&obj->lock);
> +       obj->ser =3D hugetlb_ser;
> +
> +       for_each_hstate(h) {
> +               struct hugetlb_hstate_ser *hser =3D &hugetlb_ser->hstates=
[nr_hstates];
> +
> +               hser->nr_pages =3D 0;
> +               hser->order =3D h->order;
> +               nr_hstates++;
> +       }
> +
> +       hugetlb_ser->nr_hstates =3D nr_hstates;
> +
> +       args->obj =3D obj;
> +       args->data =3D virt_to_phys(hugetlb_ser);
> +
> +       return 0;
> +}
> +
> +static void hugetlb_flb_unpreserve(struct liveupdate_flb_op_args *args)
> +{
> +       kho_unpreserve_free(phys_to_virt(args->data));
> +       kfree(args->obj);
> +}
> +
> +static void hugetlb_flb_finish(struct liveupdate_flb_op_args *args)
> +{
> +       /* No live state on the retrieve side. */
> +}
> +
> +static int hugetlb_flb_retrieve(struct liveupdate_flb_op_args *args)
> +{
> +       /*
> +        * The FLB is only needed for boot-time calculation of how many
> +        * hugepages are needed. This is done by early boot handlers alre=
ady.
> +        * Free the serialized state now.
> +        */

It should be done in this function.

> +       kho_restore_free(phys_to_virt(args->data));

This should be moved to finish() after blackout.

> +
> +       /*
> +        * HACK: But since LUO FLB still needs an obj, use ZERO_SIZE_PTR =
to
> +        * satisfy it.
> +        */
> +       args->obj =3D ZERO_SIZE_PTR;

Hopefully this is not needed any more with the updated FLB, please check :-=
)

> +       return 0;
> +}
> +
> +static struct liveupdate_flb_ops hugetlb_luo_flb_ops =3D {
> +       .preserve =3D hugetlb_flb_preserve,
> +       .unpreserve =3D hugetlb_flb_unpreserve,
> +       .finish =3D hugetlb_flb_finish,
> +       .retrieve =3D hugetlb_flb_retrieve,
> +};
> +
> +static struct liveupdate_flb hugetlb_luo_flb =3D {
> +       .ops =3D &hugetlb_luo_flb_ops,
> +       .compatible =3D HUGETLB_FLB_COMPATIBLE,
> +};
> +
> +static struct hugetlb_hstate_ser
> +*hugetlb_flb_get_hser(struct hugetlb_ser *hugetlb_ser, unsigned int orde=
r)
> +{
> +       for (u8 i =3D 0; i < hugetlb_ser->nr_hstates; i++) {
> +               if (hugetlb_ser->hstates[i].order =3D=3D order)
> +                       return &hugetlb_ser->hstates[i];
> +       }
> +
> +       return NULL;
> +}
> +
> +static int hugetlb_flb_add_folio(struct hstate *h)
> +{
> +       struct hugetlb_ser *hugetlb_ser;
> +       struct hugetlb_hstate_ser *hser;
> +       struct hugetlb_flb_obj *obj;
> +       int err;
> +
> +       err =3D liveupdate_flb_get_outgoing(&hugetlb_luo_flb, (void **)&o=
bj);
> +       if (err)
> +               return err;
> +
> +       hugetlb_ser =3D obj->ser;
> +
> +       guard(spinlock)(&obj->lock);
> +       hser =3D hugetlb_flb_get_hser(hugetlb_ser, h->order);
> +       if (!hser)
> +               return -ENOENT;
> +
> +       hser->nr_pages++;
> +       return 0;
> +}
> +
> +static int hugetlb_flb_del_folio(struct hstate *h)
> +{
> +       struct hugetlb_ser *hugetlb_ser;
> +       struct hugetlb_hstate_ser *hser;
> +       struct hugetlb_flb_obj *obj;
> +       int err;
> +
> +       err =3D liveupdate_flb_get_outgoing(&hugetlb_luo_flb, (void **)&o=
bj);
> +       if (err)
> +               return err;
> +
> +       hugetlb_ser =3D obj->ser;
> +
> +       guard(spinlock)(&obj->lock);
> +       hser =3D hugetlb_flb_get_hser(hugetlb_ser, h->order);
> +       if (!hser)
> +               return -ENOENT;
> +
> +       hser->nr_pages--;
> +       return 0;
> +}
> +
> +unsigned long __init hstate_liveupdate_pages(struct hstate *h)
> +{
> +       struct hugetlb_hstate_ser *hser;
> +       struct hugetlb_ser *hugetlb_ser;
> +       u64 data;
> +       int err;
> +
> +       err =3D liveupdate_flb_incoming_early(&hugetlb_luo_flb, &data);
> +       if (err)
> +               /* If FLB can't be fetched, assume no pages from liveupda=
te. */
> +               return 0;
> +
> +       hugetlb_ser =3D phys_to_virt(data);
> +
> +       /* NOTE: No need for locking since this is read-only on incoming =
side. */
> +       hser =3D hugetlb_flb_get_hser(hugetlb_ser, h->order);
> +       return hser ? hser->nr_pages : 0;
> +}
> +
> +void __init hugetlb_luo_init(void)
> +{
> +       if (!liveupdate_enabled())
> +               return;
> +}
> --
> 2.43.0
>

