Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FA8606A327
	for <kexec@archiver.kernel.org>; Sat, 14 Nov 2026 03:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jThNX3YL;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NUY7JL1n
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GkSfmbD2YBZQajWcIiu7fpby40IrMSPQ3GDDx7zbFTc=; b=jThNX3YL67Y61mYewnzp0CRe0M
	O7nTho/3jenwbOHCm/bk91EufOg/AYp6UB2CZywnhSfRc9ydI6ss/WIB45HGm8zfwM5akS4SlEbJh
	i8YeofUzMAiuKc8ddEQU6rKU3Bpdl9gCk2yq/KUDh64hs+rpicy8EfM416jEI3gR4RzFC+6d2M0ic
	Y7tE9I4veyco7sLMd4mgc9w2WCAJeoAdt7x/jB7iEjehPpAxjuYODATrYw+u5Cha00v242h4Q8dCY
	PA6veEyqy0OWfWIoHLQcIF3Ms3T2yvP+D0LG48Mo4+S0ZH0r02mAUx7yI2RcbUN9LveGASFYTG2SH
	iGwjKOpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4uj-0000000FKiu-2l9G;
	Sat, 14 Nov 2026 03:58:53 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4uh-0000000FKic-2Js5
	for kexec@lists.infradead.org;
	Sat, 14 Nov 2026 03:58:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 476DB4047E;
	Sat, 14 Nov 2026 03:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7711F000C4;
	Sat, 14 Nov 2026 03:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794628730;
	bh=GkSfmbD2YBZQajWcIiu7fpby40IrMSPQ3GDDx7zbFTc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NUY7JL1n1czoojhZ+kdedpFeB97zqPDBNx3eKFPLMzDa/t95/ic93mzn7O8z6ck7P
	 Da2Kc2Oz/KicihD86fnx2MXlnWV63Po/md8uqF1kX82SOC8LucfSQsqGhdMbtAH+/F
	 kxQLIwVLsjjRNNuCINz73sTAumCjnYIQxy3Hwg/UeAtvPrTVyfmq8bVu0v48XCV2/q
	 3pMUJp7Yvo2Kt63JIZXakMnAfNq+NeYHcsvazME1IRI/lm6HGuSesgpcQjeRsyekWX
	 /bKRkx4ufurgUAnKr6reIH/8k4NQ5H7gNwdo/jEcs89LvS3LiktToifs52weqWnUZt
	 WklS8OQG7D/YA==
Message-ID: <sashiko-outbox-214131@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] riscv: kexec_file: Keep segments out of the new
 kernel's PMD padding
To: "Cong Wang" <xiyou.wangcong@gmail.com>, "Paul Walmsley" <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>
Cc: "Song Shuai" <songshuaishuai@tinylab.org>, =?utf-8?b?QmrDtnJuIFTDtnBl?=
 =?utf-8?b?bA==?= <bjorn@kernel.org>, "Han Gao" <gaohan@iscas.ac.cn>, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, "Mike Rapoport" <rppt@kernel.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Guo Ren" <guoren@kernel.org>, kexec@lists.infradead.org, "Cong
 Wang" <cwang@multikernel.io>
In-Reply-To: <20261114034901.107028-1-xiyou.wangcong@gmail.com>
References: <20261114034901.107028-1-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 03:58:49 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] kexec_file: missing placement bounds checks in
  kexec_alloc_contig() [1]
--

commit e91ae0bea9270620f64704189d1d94046334bdb0
Author: Cong Wang <cwang@multikernel.io>

riscv: kexec_file: Keep segments out of the new kernel's PMD padding

This commit aligns kbuf.buf_min in load_extra_segments() to PMD_SIZE so
extra kexec segments are not placed inside the new kernel's PMD padding.

> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/m=
achine_kexec_file.c
> index 26cd2a8bd0cd3..0d2d43a7dbfaa 100644
> --- a/arch/riscv/kernel/machine_kexec_file.c
> +++ b/arch/riscv/kernel/machine_kexec_file.c
> @@ -251,7 +251,8 @@ int load_extra_segments(struct kimage *image, unsigne=
d long kernel_start,
>  	char *modified_cmdline =3D NULL;
> =20
>  	kbuf.image =3D image;
> -	kbuf.buf_min =3D kernel_start + kernel_len;
> +	/* The new kernel reserves itself up to the next PMD boundary */
> +	kbuf.buf_min =3D ALIGN(kernel_start + kernel_len, PMD_SIZE);
>  	kbuf.buf_max =3D PFN_PHYS(max_low_pfn);
> =20
>  #ifdef CONFIG_CRASH_DUMP

[Severity: High]
This problem wasn't introduced by this patch, but can kexec_alloc_contig()
bypass kbuf.buf_min and kbuf.buf_max when allocating a CMA segment for a
non-crash kexec_file_load() [1]?

Unlike locate_mem_hole_top_down() and locate_mem_hole_bottom_up(), which
check kbuf->buf_min, kbuf->buf_max, and arch_check_excluded_range(),
kexec_alloc_contig() only checks kimage_is_destination_range() (and passes
the exclusive end mem + kbuf->memsz rather than mem + kbuf->memsz - 1):

kernel/kexec_file.c:kexec_alloc_contig() {
	...
	p =3D dma_alloc_from_contiguous(NULL, nr_pages, get_order(kbuf->buf_align)=
, true);
	if (!p)
		return -ENOMEM;
	...
	mem =3D page_to_boot_pfn(p) << PAGE_SHIFT;

	if (kimage_is_destination_range(kbuf->image, mem, mem + kbuf->memsz)) {
		...
		dma_release_from_contiguous(NULL, p, nr_pages);
		return -EBUSY;
	}

	kbuf->mem =3D page_to_boot_pfn(p) << PAGE_SHIFT;
	kbuf->cma =3D p;
	...
}

When CMA is enabled, kexec_add_buffer() -> kexec_locate_mem_hole() ->
kexec_alloc_contig() can place the initrd, DTB, or purgatory below
kbuf.buf_min, Above kbuf.buf_max, or inside an architecture-excluded range,
causing the new kernel to fail to boot or crash on kexec.

[1] https://sashiko.dev/#/bug/linux-83c15bd9-0ce0-4413-9330-a4e797594079

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114034901.1070=
28-1-xiyou.wangcong@gmail.com?part=3D1

