Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E4CC79F9E
	for <kexec@archiver.kernel.org>; Mon,  7 Sep 2026 14:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J8wgTvZrkyOjbsQqIGG8z/GcZBW64PcNCuag9I7xU18=; b=NcokGJr/xknExDtLg9j4D+lsNF
	El8DjL7xA6+DuOdgC5jKsPVqL89/E02PnFdv79O84v9sOSFaXbgdqalTPtEEaeRIxzu+bTxelyrZn
	Agqp6IDaOQpH7USXRQmMkLyT6REx+hIUJoCZ681uK7XBYtZRkLgYpsg0tz70yvzp/qb+FBQ94Ubz7
	aVy0YDQiGhol+bbvgBZRt8MqMj0EsYZQWDeSnzdjqb3wp/lrQtmQv3ILFE+NJ9h2pKJJKwKLegODe
	I+pMyaUNvO2Yoj+tIocpX94+sMcIlZhPAdy7qTOtkb+ZpXMoh9ABTxgXQhSEkDAYu8yEcPlxcrjXa
	LtH1VOfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3Zyk-000000070Mf-2JQ5;
	Mon, 07 Sep 2026 14:05:46 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3Zyh-000000070MQ-1HqC
	for kexec@lists.infradead.org;
	Mon, 07 Sep 2026 14:05:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0C4AD447F7
	for <kexec@lists.infradead.org>; Mon,  7 Sep 2026 14:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049B21F00ACA
	for <kexec@lists.infradead.org>; Mon,  7 Sep 2026 14:05:43 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a61910369bso3802913a12.0
        for <kexec@lists.infradead.org>; Mon, 07 Sep 2026 07:05:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxkwQjNeVaQLvaekklNOL5RP/YLtjBCfjHoyiZ1TdoDbuTzfqxoOtAYbEtzyBPBHU6A9McXMA==@lists.infradead.org
X-Gm-Message-State: AFuF++kuhy9T1giIpiGO22c2b9j3c0ENov197CPQQ41dWIS9tszkvtbL
	1Zs7H74jjVz7NvUJBFxdjhBs1UU/XBaV93Q0TZyUF5uOKVptElxoNdwXfu7WLPQ/H2m4e4q7qKi
	8h6v5Tq8UXJ+7C9sUG256aFROsElzbY8=
X-Received: by 2002:a05:6402:44db:b0:6a6:7fa6:f0ac with SMTP id
 4fb4d7f45d1cf-6a7e8f9e843mr12416286a12.22.1788789941040; Mon, 07 Sep 2026
 07:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260907125404.922123-1-ruanjinjie@huawei.com> <20260907125404.922123-6-ruanjinjie@huawei.com>
In-Reply-To: <20260907125404.922123-6-ruanjinjie@huawei.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 7 Sep 2026 22:05:34 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7qjJ7BPnJ2KoQZSyMUvX_6i9H=EfdadXnmXtNiiB4ROA@mail.gmail.com>
X-Gm-Features: AcwNN1WbqzVfALnNIkIUg_l9MiYgRfsYFTxDDEyu_aV6t47lWMUK_7ZDBokn7zg
Message-ID: <CAAhV-H7qjJ7BPnJ2KoQZSyMUvX_6i9H=EfdadXnmXtNiiB4ROA@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] LoongArch: kexec_file: Fix CMA page leaks in
 segment placement retry loops
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, 
	baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, 
	pratyush@kernel.org, ruirui.yang@linux.dev, kees@kernel.org, thuth@redhat.com, 
	jic23@kernel.org, tan.shaopeng@jp.fujitsu.com, zengheng4@huawei.com, 
	james.morse@arm.com, ardb@kernel.org, leitao@debian.org, yeoreum.yun@arm.com, 
	sourabhjain@linux.ibm.com, robh@kernel.org, coxu@redhat.com, 
	tangyouling@kylinos.cn, hbathini@linux.ibm.com, adityag@linux.ibm.com, 
	djbw@kernel.org, seanjc@google.com, liaoyuanhong@vivo.com, 
	vishal.l.verma@intel.com, fuqiang.wang@easystack.cn, makb@juniper.net, 
	piliu@redhat.com, ebiggers@kernel.org, jbouron@amazon.com, 
	mclapinski@google.com, me@linux.beauty, graf@amazon.com, bgwin@google.com, 
	takahiro.akashi@linaro.org, palmer@rivosinc.com, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi, Jinjie,

On Mon, Sep 7, 2026 at 8:53=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com> =
wrote:
>
> During kexec image placement retry loops, any midway failure causes
> the loader to truncate `image->nr_segments` back to its initial state
> to purge the failed segments.
>
> However, this truncation introduces a memory leak. The CMA pages
> allocated via kexec_add_buffer() during the failed attempt are tracked
> in the `image->segment_cma` array. Because the subsequent cleanup paths
> only iterate up to the truncated `nr_segments` boundary, these allocated
> CMA pages outside the new boundary are permanently leaked.
>
> Fix this by explicitly releasing the associated CMA buffers in
> the failure paths before `image->nr_segments` is reduced.
I'm not sure but does the elf version have similar problems as the efi vers=
ion?

Huacai

>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Youling Tang <tangyouling@kylinos.cn>
> Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: stable@vger.kernel.org
> Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%=
40huawei.com
> Fixes: 55d990f0084c ("LoongArch: Add EFI binary support for kexec_file")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/loongarch/kernel/kexec_efi.c          | 1 +
>  arch/loongarch/kernel/machine_kexec_file.c | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/kexec_efi.c b/arch/loongarch/kernel/ke=
xec_efi.c
> index 5ee78ebb1546..15fd797ff3de 100644
> --- a/arch/loongarch/kernel/kexec_efi.c
> +++ b/arch/loongarch/kernel/kexec_efi.c
> @@ -86,6 +86,7 @@ static void *efi_kexec_load(struct kimage *image,
>                  * We couldn't find space for the other segments; erase t=
he
>                  * kernel segment and try the next available hole.
>                  */
> +               kexec_free_segment_cma(image, kernel_segment_number);
>                 image->nr_segments -=3D 1;
>                 kbuf.buf_min =3D kernel_segment->mem + kernel_segment->me=
msz;
>                 kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/=
kernel/machine_kexec_file.c
> index 5412aa9f3568..62a5be102065 100644
> --- a/arch/loongarch/kernel/machine_kexec_file.c
> +++ b/arch/loongarch/kernel/machine_kexec_file.c
> @@ -217,7 +217,11 @@ int load_other_segments(struct kimage *image,
>         return 0;
>
>  out_err:
> -       image->nr_segments =3D orig_segments;
> +       while (image->nr_segments > orig_segments) {
> +               kexec_free_segment_cma(image, image->nr_segments - 1);
> +               image->nr_segments--;
> +       }
> +
>         kfree(modified_cmdline);
>         return ret;
>  }
> --
> 2.34.1
>

