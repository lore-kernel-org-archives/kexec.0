Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C73CCA0EE4
	for <kexec@archiver.kernel.org>; Sat, 23 Aug 2025 21:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XlJ8kmojnc5frOfQVVYbz5CdVJHYb5UepPbqTiauKpA=; b=E8U5/U2WxIsiC695yOu/T/ZxVs
	jIPHC4ybb5gEIHN4ihK8nrLixGr7WxaL6YlKJkrrml6oWKurtlbQRMdOpMEuyvygaGNdiZkmz6bwt
	3MvQAgCUmc+HLniRmHqpX5NwejdsVe+XHJaU6QlAFooYNc4vP9mKYQUmxWlWnoyM3L9X0QNGxkXQO
	bm+s8LY2jZ1E3Ss5JGnnAbIHWR+/48BWesGrlgdwuhtq4Bd/XEaA6wpp9yEfEWV4oStNv/c8xF6Ik
	aQBK4cPxy3iwJNZto2L478eGTSxNPYCd9eePX0zNd5qWSmnefXkGa8OZqO3Tp7G22wbMmQ0kQjR8e
	qPdOKxtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upw5n-00000005JD9-1JKj;
	Sat, 23 Aug 2025 21:48:07 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upw5m-00000005JD3-1W4M
	for kexec@lists.infradead.org;
	Sat, 23 Aug 2025 21:48:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7291E60052
	for <kexec@lists.infradead.org>; Sat, 23 Aug 2025 21:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0347C4CEE7
	for <kexec@lists.infradead.org>; Sat, 23 Aug 2025 21:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755985682;
	bh=f+2e1mjfdrM4u6c20rSZEJrXZ7DiDa0vXieudZxMy4s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=okdJjChS8xDJKozutDClByY1QI8HxqsxfRLN6XIOhW4F/CD2Vmv8revUE77i4D9b7
	 YLiPtKcKWgfl455V3ZjOLSEw02BJCLdhrnl5bIKjFB+nyPwFDemhrqxOFfdFBFy6r1
	 SW0aUch9FILfVp+0p24u5UAwhERO/pGUQViOJlqLu58EG72cNvs5Aiz1ifThpzFCQC
	 0wYPPkHothpsuuu0sPoBd/RDnfS1segsfiwrGEw7i9TeP1bnsvJp433DhH5bAz5axK
	 /xzW7BQTM6AA+njIvacRoJWNR4OQkq8PK/u3O877KELm4+FphSMcl9XeXSf4fgF95d
	 1IJ+hgeBIqE8A==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55ce52ab898so3636491e87.3
        for <kexec@lists.infradead.org>; Sat, 23 Aug 2025 14:48:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBxSfYUtkLWa8lEMJotyCjem8aXYscbBEwxoCXHMsfAaR6lOfKiJsz6TwYoRYEvo3CZT2Odw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzUbzwCiKLdzhr1Y2Dm17rxlIsbrKoBBWpge2h35eoA4h5/qyIB
	chcQl+lF0sIhHgkwyPeQGVSmCrk9E8+TsHVzP1rnH6AZr/itrw8QXbVtQsEwxjNhV2hj08Sy2KL
	MMiadR4mtTq2qs66ZlHTJvbeIj04kZPg=
X-Google-Smtp-Source: AGHT+IHpU7xCroubPXDWGgYJBrip4rxJYyc1NgWuY2GTM1r2YZ/KwreaPY1ko02JrW08q1BaBbIhh9myTEwFob0bbAM=
X-Received: by 2002:a05:6512:61d0:20b0:55f:34e8:b1b0 with SMTP id
 2adb3069b0e04-55f34e8ca18mr774083e87.15.1755985681198; Sat, 23 Aug 2025
 14:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1755721529.git.epetron@amazon.de> <b34da9fd50c89644cd4204136cfa6f5533445c56.1755721529.git.epetron@amazon.de>
In-Reply-To: <b34da9fd50c89644cd4204136cfa6f5533445c56.1755721529.git.epetron@amazon.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 24 Aug 2025 07:47:49 +1000
X-Gmail-Original-Message-ID: <CAMj1kXFQwOHyQg2LtabMA3qxiBn_AVV_JNfki2WPSg8u_XbBcg@mail.gmail.com>
X-Gm-Features: Ac12FXzn0qCCniv9JuLvANrQaphyB7rl0h7KLf3cn0PE7oJ7DT-dRyUUwZAdnF8
Message-ID: <CAMj1kXFQwOHyQg2LtabMA3qxiBn_AVV_JNfki2WPSg8u_XbBcg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] efi: Support booting with kexec handover (KHO)
To: Evangelos Petrongonas <epetron@amazon.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Changyuan Lyu <changyuanl@google.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
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

(cc Ilias)

Note to akpm: please drop this series for now.

On Fri, 22 Aug 2025 at 04:00, Evangelos Petrongonas <epetron@amazon.de> wrote:
>
> When KHO (Kexec HandOver) is enabled, it sets up scratch memory regions
> early during device tree scanning. After kexec, the new kernel
> exclusively uses this region for memory allocations during boot up to
> the initialization of the page allocator
>
> However, when booting with EFI, EFI's reserve_regions() uses
> memblock_remove(0, PHYS_ADDR_MAX) to clear all memory regions before
> rebuilding them from EFI data. This destroys KHO scratch regions and
> their flags, thus causing a kernel panic, as there are no scratch
> memory regions.
>
> Instead of wholesale removal, iterate through memory regions and only
> remove non-KHO ones. This preserves KHO scratch regions, which are
> good known memory, while still allowing EFI to rebuild its memory map.
>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> ---
> Changes in v3:
>         - Improve the code comments, by stating that the scratch regions are
>         good known memory
>
> Changes in v2:
>         - Replace the for loop with for_each_mem_region
>         - Fix comment indentation
>         - Amend commit message to specify that scratch regions
>         are known good regions
>
>  drivers/firmware/efi/efi-init.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>

I'd rather drop the memblock_remove() entirely if possible. Could we
get some insight into whether memblocks are generally already
populated at this point during the boot?


> diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
> index a00e07b853f2..a65c2d5b9e7b 100644
> --- a/drivers/firmware/efi/efi-init.c
> +++ b/drivers/firmware/efi/efi-init.c
> @@ -12,6 +12,7 @@
>  #include <linux/efi.h>
>  #include <linux/fwnode.h>
>  #include <linux/init.h>
> +#include <linux/kexec_handover.h>
>  #include <linux/memblock.h>
>  #include <linux/mm_types.h>
>  #include <linux/of.h>
> @@ -164,12 +165,32 @@ static __init void reserve_regions(void)
>                 pr_info("Processing EFI memory map:\n");
>
>         /*
> -        * Discard memblocks discovered so far: if there are any at this
> -        * point, they originate from memory nodes in the DT, and UEFI
> -        * uses its own memory map instead.
> +        * Discard memblocks discovered so far except for KHO scratch
> +        * regions. Most memblocks at this point originate from memory nodes
> +        * in the DT and UEFI uses its own memory map instead. However, if
> +        * KHO is enabled, scratch regions, which are good known memory
> +        * must be preserved.
>          */
>         memblock_dump_all();
> -       memblock_remove(0, PHYS_ADDR_MAX);
> +
> +       if (is_kho_boot()) {
> +               struct memblock_region *r;
> +
> +               /* Remove all non-KHO regions */
> +               for_each_mem_region(r) {
> +                       if (!memblock_is_kho_scratch(r)) {
> +                               memblock_remove(r->base, r->size);
> +                               r--;
> +                       }
> +               }
> +       } else {
> +               /*
> +                * KHO is disabled. Discard memblocks discovered so far:
> +                * if there are any at this point, they originate from memory
> +                * nodes in the DT, and UEFI uses its own memory map instead.
> +                */
> +               memblock_remove(0, PHYS_ADDR_MAX);
> +       }
>
>         for_each_efi_memory_desc(md) {
>                 paddr = md->phys_addr;
> --
> 2.47.3
>
>
>
>
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597
>

