Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1C6C36016
	for <kexec@archiver.kernel.org>; Thu, 27 Mar 2025 13:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KVFFcWh5dZoKRR9sK5sDoRV9h4cdUzLL2+BzZ81kSD4=; b=wZFxhFLUSUYY3FEjYy3U8Ndvml
	q53scCgEyDab8M638uZ4UhDNHxKH/sscIr5IqF+fkiNV/1udf9gKso/WFhAzENcGCIRW7PvAR0X+1
	KJn6Ax2E6IHoXdZKK/ZFfGVD8mBdT2bUrGjSb7OBEVlbVEXOYtn11IYsDEv1tTIHQfCg2hRpO0D0P
	5t7SMMtwcQ5qadVohHYucnUqyGfsmX4k1PwfSwl2tgTuVnZWKTF+Anx9tkI9SxS7qfzVyspKvWyx3
	DU8GsFLkXLwO6VaxbT78ryZnfy6ySvHZ/pG7AbEHkxNoi7sVj5EElZhpNhOOwxH9Dg7kU9zPYSYHc
	XTt9MeMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txnTr-0000000B60a-41sq;
	Thu, 27 Mar 2025 13:41:11 +0000
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twmjI-00000003y3n-43X2
	for kexec@lists.infradead.org;
	Mon, 24 Mar 2025 18:40:58 +0000
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-47666573242so81931cf.0
        for <kexec@lists.infradead.org>; Mon, 24 Mar 2025 11:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742841655; x=1743446455; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVFFcWh5dZoKRR9sK5sDoRV9h4cdUzLL2+BzZ81kSD4=;
        b=k40Ld3+PKsh2Dw9MEFJucJg6xRDcrjTHUIsuWpycKSJCCIsrgQl5QtiIiAvtxOjxTW
         FfilsXAvt+kgOpe/JQJHYv0R1d6PL+bG1DY7UWokXt0HKHnNDt0yYMRbtlWeXu2rbU9S
         QALlgPjwfMfuAb/a68OLkjZ7AUsEIITc0SD2FisbhlkPCO8jQmBW5N2oIQZ6a896vR5E
         3BhVJckZNmqNYDrjCQWw8nBbC3IcR825VEWPbkvi6PhgdiUL417CJmsqft+g07OB0/4r
         A2NS/DIDufvmaIRw9259Tq7qrIZCJUqZCCiBfndIzJT50si6ZcdAS10k2fYXLRSNaWtL
         5aXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742841655; x=1743446455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVFFcWh5dZoKRR9sK5sDoRV9h4cdUzLL2+BzZ81kSD4=;
        b=ek4i6Kwswjw7sWT/A8fKvN2fITGqpLYevEeJymT96kgcbINFx8ACehdS0C5qJaew3K
         PCiaxPj0mAel3ib+h4EJK5iBVc4lR/XcbxHQbnkTX+csutbx8VaP18jCVZuuqc3BB2i7
         2Ew0eq+JQEYY0VUEr96cu41EHHcJZgpZNnNyvwDD+mMMlT7pM+tJw7ODbRd5+qiJqvZz
         /UeagWzs2bzuUZWWv4dY7RqCki+c4H3gxFo6vgu3JH9859NQySktpOu3VCCRSnLNL1Ff
         A4PxRv+0wRZS3x/SoBkqkXxCVICcEpks5h85zUcgGK44+LCBA3M2u0Kk2EXS2Ng0CBZF
         3nXA==
X-Forwarded-Encrypted: i=1; AJvYcCXNxhXYb+nsWWOyBABZir13caFvND6EXVypWrZXArz0Uh45a7uSGWszwypBcRpFhGu7pSZH7g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxgl2+zL6I9Y3gynr7jhKtS0MjUa2ltkt3dFpgxNU84Kxf8ImZL
	ILipFjV62CAutF5tb/G1Z9c2nlwr+ZLWiColSvdvxGgM1K1r/JoNwqslh/juq8LebWTnPrxT14V
	veQP/Tgba66vj3mvy/jNOYPdAjEqjg/4d9iHb
X-Gm-Gg: ASbGncsUFNElb4FhnTP6VhyTvL5RDNNuzvmyCb8085Og2lo8hZNOIo7F1Q5LCRbA+Hx
	H8LqESdJWbyHJcVXv8QagjObHo6UMgljjVDWZSemoHfVCJ2ZMWGENnnamFeFRcdh13sIYIVtmbm
	z7XaT5ewJ/Kzi6EcghAtkn/tA=
X-Google-Smtp-Source: AGHT+IE5+gZ94fZfEMa4/mu+5y69Keqgf6GYglfVDQZk9TGfgwTjD/V2nGDREwNflvI0c0qaa+IqDh+lZikxQgFL/jU=
X-Received: by 2002:a05:622a:17c4:b0:475:1410:2ca3 with SMTP id
 d75a77b69052e-4772be23f26mr9607281cf.15.1742841654660; Mon, 24 Mar 2025
 11:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com> <20250320015551.2157511-8-changyuanl@google.com>
In-Reply-To: <20250320015551.2157511-8-changyuanl@google.com>
From: Frank van der Linden <fvdl@google.com>
Date: Mon, 24 Mar 2025 11:40:43 -0700
X-Gm-Features: AQ5f1JqgK3t9nzg4mdWiXWpH_sA43D2BNXiBuTZpvx6PAjAQCpPGjdYAtW64c_s
Message-ID: <CAPTztWbFXajArSN8yKu32eSoR=xsk1CHM_4V7MJ0eQxydFqPUQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/16] kexec: add Kexec HandOver (KHO) generation helpers
To: Changyuan Lyu <changyuanl@google.com>
Cc: linux-kernel@vger.kernel.org, graf@amazon.com, akpm@linux-foundation.org, 
	luto@kernel.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, dave.hansen@linux.intel.com, dwmw2@infradead.org, 
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, 
	krzk@kernel.org, rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org, tglx@linutronix.de, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, will@kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_114057_006533_20E15FFE 
X-CRM114-Status: GOOD (  26.49  )
X-Mailman-Approved-At: Thu, 27 Mar 2025 06:41:08 -0700
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

On Wed, Mar 19, 2025 at 6:56=E2=80=AFPM Changyuan Lyu <changyuanl@google.co=
m> wrote:
>
> From: Alexander Graf <graf@amazon.com>
>
> Add the core infrastructure to generate Kexec HandOver metadata. Kexec
> HandOver is a mechanism that allows Linux to preserve state - arbitrary
> properties as well as memory locations - across kexec.
>
> It does so using 2 concepts:
>
>   1) State Tree - Every KHO kexec carries a state tree that describes the
>      state of the system. The state tree is represented as hash-tables.
>      Device drivers can add/remove their data into/from the state tree at
>      system runtime. On kexec, the tree is converted to FDT (flattened
>      device tree).
>
>   2) Scratch Regions - CMA regions that we allocate in the first kernel.
>      CMA gives us the guarantee that no handover pages land in those
>      regions, because handover pages must be at a static physical memory
>      location. We use these regions as the place to load future kexec
>      images so that they won't collide with any handover data.
>
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Co-developed-by: Pratyush Yadav <ptyadav@amazon.de>
> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Co-developed-by: Changyuan Lyu <changyuanl@google.com>
> Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> ---
>  MAINTAINERS                    |   2 +-
>  include/linux/kexec_handover.h | 109 +++++
>  kernel/Makefile                |   1 +
>  kernel/kexec_handover.c        | 865 +++++++++++++++++++++++++++++++++
>  mm/mm_init.c                   |   8 +
>  5 files changed, 984 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/kexec_handover.h
>  create mode 100644 kernel/kexec_handover.c
[...]
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 04441c258b05..757659b7a26b 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -30,6 +30,7 @@
>  #include <linux/crash_dump.h>
>  #include <linux/execmem.h>
>  #include <linux/vmstat.h>
> +#include <linux/kexec_handover.h>
>  #include "internal.h"
>  #include "slab.h"
>  #include "shuffle.h"
> @@ -2661,6 +2662,13 @@ void __init mm_core_init(void)
>         report_meminit();
>         kmsan_init_shadow();
>         stack_depot_early_init();
> +
> +       /*
> +        * KHO memory setup must happen while memblock is still active, b=
ut
> +        * as close as possible to buddy initialization
> +        */
> +       kho_memory_init();
> +
>         mem_init();
>         kmem_cache_init();
>         /*


Thanks for the work on this.

Obviously it needs to happen while memblock is still active - but why
as close as possible to buddy initialization?

Ordering is always a sticky issue when it comes to doing things during
boot, of course. In this case, I can see scenarios where code that
runs a little earlier may want to use some preserved memory. The
current requirement in the patch set seems to be "after sparse/page
init", but I'm not sure why it needs to be as close as possibly to
buddy init.

- Frank

