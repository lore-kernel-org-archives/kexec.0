Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A43C5DF84
	for <kexec@archiver.kernel.org>; Sat, 15 Aug 2026 07:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2SGF5N2MQo78vGzqyV7/apPuXFO2rP32pwgUlpuOhCM=; b=3MR8Npok0AejCRogZEww1AR0EH
	jiGBkX71sjrUR5AM9eCtLfy1e2w30bFJj6xVgvRuFwEmhRlfoI92joC5tYeJJd8YcvBvRZV/yVoug
	gaYnRIjKK/SzyLoG4TVZPwL1FymXjh39b7K9cqV8HqHTGjalKQRYFr5s1yZCmRog7t9v8eUjC39jt
	20K0ElqfQvKxRqZ99LHh/3wuiaweri1SIRaQ+XPYYE7kuLA5mvO8/kiR+2luS2SUEOSq65bgF9bUY
	tMikcFwGIHbdVxBHaD9FUj6HL0OyjoTZAd7WR72cSRmVV7GaVLCg+BeVYSLb8bT88+i00RC6cg+xA
	IS85n2Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wv95M-00000003cyx-1zoV;
	Sat, 15 Aug 2026 07:45:44 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weAAP-0000000ERAU-2Z3o
	for kexec@lists.infradead.org;
	Mon, 29 Jun 2026 11:28:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3F71B43BC3
	for <kexec@lists.infradead.org>; Mon, 29 Jun 2026 11:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274BF1F00A3E
	for <kexec@lists.infradead.org>; Mon, 29 Jun 2026 11:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782732525;
	bh=2SGF5N2MQo78vGzqyV7/apPuXFO2rP32pwgUlpuOhCM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Z+0/8IVNPNzLaX+cAHumKXyLIGetyMOrlba45W400NLvAFGsm1b4czPFceeKYdEUa
	 g8HgTaWUDgmu+CZyz3EYnoBr6ox7+YRsFbnFoiNC8XayyFYh0MRYaWjMrn6l3LeZT8
	 pKJ0WR8FO6dz/tYWm5ULT+k33cQLB7RhKgRnIXSyXT3zQ9EEmyaIaMeuCH8hyerZ4S
	 g4rRsM3VRgwuReJJdH3T8aVxHhqwOStoWfx5LYMYR1pit6hvseU0QkJaex3qBeJIPn
	 /SMntij8ibUAP9GYL5bpLF5RJkODA334aMwug2ZyKIGeZnOJRRtFLZstcI9XaBpo/b
	 ih6xxN0jsRAtA==
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-46ed4f66256so2682577f8f.3
        for <kexec@lists.infradead.org>; Mon, 29 Jun 2026 04:28:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq9QPWyK5cis+6+ARBD6LA8c9m8GzK0GuurAbDdOGSDcRd4K+XZjCRafpshhOSPN1GtA+xAvg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy6+y03RIl7Fq89dibgqr2ULmICivdj9bFQhqnUQUp59zM4Pm85
	W9LWUTQQltWYqkCkhWOXsAQhtZ4DjaHaPvJfuYkmD01YeIdZgU26gh26u1zuKew82VqC8R2zuGZ
	0YKOItI/w0bCBLBy/DSznrgPMQe+RRfs=
X-Received: by 2002:a05:6000:2c03:b0:464:79f0:9162 with SMTP id
 ffacd0b85a97d-474ff09dd29mr78407f8f.19.1782732523175; Mon, 29 Jun 2026
 04:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260629094746.191843-1-ruanjinjie@huawei.com> <20260629094746.191843-7-ruanjinjie@huawei.com>
In-Reply-To: <20260629094746.191843-7-ruanjinjie@huawei.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 29 Jun 2026 19:28:27 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS5xMdFcuYBd2d+jvZTTSAJ_A6Eid0LqB-3WVAcT4NptA@mail.gmail.com>
X-Gm-Features: AVVi8Cfb_YoOBZUDhpGGsfHfl7o1RJdl6tur8fEdDE_oRtNsU4-e7q_E2QvES68
Message-ID: <CAJF2gTS5xMdFcuYBd2d+jvZTTSAJ_A6Eid0LqB-3WVAcT4NptA@mail.gmail.com>
Subject: Re: [PATCH v17 06/10] riscv: kexec_file: Use crash_prepare_headers()
 helper to simplify code
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com, 
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org, 
	saravanak@kernel.org, akpm@linux-foundation.org, baoquan.he@linux.dev, 
	rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	ruirui.yang@linux.dev, rdunlap@infradead.org, peterz@infradead.org, 
	feng.tang@linux.alibaba.com, dapeng1.mi@linux.intel.com, elver@google.com, 
	enelsonmoore@gmail.com, kuba@kernel.org, ebiggers@kernel.org, 
	lirongqing@baidu.com, leitao@debian.org, kees@kernel.org, coxu@redhat.com, 
	cfsworks@gmail.com, jbohac@suse.cz, osandov@fb.com, ryan.roberts@arm.com, 
	tangyouling@kylinos.cn, sourabhjain@linux.ibm.com, ritesh.list@gmail.com, 
	gaohan@iscas.ac.cn, david@kernel.org, wangruikang@iscas.ac.cn, 
	muchun.song@linux.dev, vishal.moola@gmail.com, junhui.liu@pigmoral.tech, 
	namcao@linutronix.de, rick.p.edgecombe@intel.com, djbw@kernel.org, 
	liaoyuanhong@vivo.com, fuqiang.wang@easystack.cn, vishal.l.verma@intel.com, 
	chenjiahao16@huawei.com, x86@kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 15 Aug 2026 00:45:40 -0700
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

On Mon, Jun 29, 2026 at 5:48=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> Use the newly introduced crash_prepare_headers() function to replace
> the existing prepare_elf_headers(), allocate cmem and exclude crash kerne=
l
> memory in the crash core, which reduce code duplication.
>
> Only the following two architecture functions need to be implemented:
> - arch_get_system_nr_ranges(). Call get_nr_ram_ranges_callback()
>   to pre-counts the max number of memory ranges.
>
> - arch_crash_populate_cmem(). Use prepare_elf64_ram_headers_callback()
>   to collects the memory ranges and fills them into cmem.
>
> Cc: Paul Walmsley <pjw@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Alexandre Ghiti <alex@ghiti.fr>
> Cc: Guo Ren <guoren@kernel.org>
> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/riscv/kernel/machine_kexec_file.c | 47 +++++++-------------------
>  1 file changed, 12 insertions(+), 35 deletions(-)
>
> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/m=
achine_kexec_file.c
> index fa2946aa9b8f..1dfb1d9eb691 100644
> --- a/arch/riscv/kernel/machine_kexec_file.c
> +++ b/arch/riscv/kernel/machine_kexec_file.c
> @@ -45,6 +45,15 @@ static int get_nr_ram_ranges_callback(struct resource =
*res, void *arg)
>         return 0;
>  }
>
> +unsigned int arch_get_system_nr_ranges(void)
> +{
> +       unsigned int nr_ranges =3D 2; /* For exclusion of crashkernel reg=
ion */
> +
> +       walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback=
);
> +
> +       return nr_ranges;
> +}
> +
>  static int prepare_elf64_ram_headers_callback(struct resource *res, void=
 *arg)
>  {
>         struct crash_mem *cmem =3D arg;
> @@ -56,41 +65,9 @@ static int prepare_elf64_ram_headers_callback(struct r=
esource *res, void *arg)
>         return 0;
>  }
>
> -static int prepare_elf_headers(void **addr, unsigned long *sz)
I agree to make arch_crash_populate_cmem more generic, and leave
arch_crash_populate_cmem & prepare_elf64_ram_headers_callback here as
callbacks.

Reviewed-by: Guo Ren <guoren@kernel.org>

> +int arch_crash_populate_cmem(struct crash_mem *cmem)
>  {
> -       struct crash_mem *cmem;
> -       unsigned int nr_ranges;
> -       int ret;
> -
> -       nr_ranges =3D 2; /* For exclusion of crashkernel region */
> -       walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback=
);
> -
> -       cmem =3D kmalloc_flex(*cmem, ranges, nr_ranges);
> -       if (!cmem)
> -               return -ENOMEM;
> -
> -       cmem->max_nr_ranges =3D nr_ranges;
> -       cmem->nr_ranges =3D 0;
> -       ret =3D walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_header=
s_callback);
> -       if (ret)
> -               goto out;
> -
> -       /* Exclude crashkernel region */
> -       ret =3D crash_exclude_mem_range(cmem, crashk_res.start, crashk_re=
s.end);
> -       if (ret)
> -               goto out;
> -
> -       if (crashk_low_res.end) {
> -               ret =3D crash_exclude_mem_range(cmem, crashk_low_res.star=
t, crashk_low_res.end);
> -               if (ret)
> -                       goto out;
> -       }
> -
> -       ret =3D crash_prepare_elf64_headers(cmem, true, addr, sz);
> -
> -out:
> -       kfree(cmem);
> -       return ret;
> +       return walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers=
_callback);
>  }
>
>  static char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
> @@ -282,7 +259,7 @@ int load_extra_segments(struct kimage *image, unsigne=
d long kernel_start,
>         if (image->type =3D=3D KEXEC_TYPE_CRASH) {
>                 void *headers;
>                 unsigned long headers_sz;
> -               ret =3D prepare_elf_headers(&headers, &headers_sz);
> +               ret =3D crash_prepare_headers(true, &headers, &headers_sz=
, NULL);
>                 if (ret) {
>                         pr_err("Preparing elf core header failed\n");
>                         goto out;
> --
> 2.34.1
>


--=20
Best Regards
 Guo Ren

