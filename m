Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840A0C624C6
	for <kexec@archiver.kernel.org>; Mon, 31 Aug 2026 14:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L1mNt+t9t3Mp1gIJn7MX5n0Mz44VISN4VLwL6b799Bs=; b=Cyq4oSLMPYoECNPis3P40hdmWn
	gPXJo/aaXMijuBMrzI3WJTF91x+N23Tnt2CqiuI3ET5YfDrKavMpgskeflyQrOFKp4Mvndp23zVZC
	Jcy8Aji6/tiwmE6Ur7uPye47tksOyjog1HLpusp1NqrMF0U1NdE6JxELTmoil0Eex9k4ByUBLKJBc
	dni3tNSBx56MIH5lZjYVQywHc9iJoSjLxWX2V3Sj6VE+AUrpWjkSyyyzUWMgAMH8VP58QuGmho9Jd
	W3FM7GPIDtgSmks7KcXlqh/DVRho3zHM4geSDocOCMasuUUUwewerwUACUXZ3UZWpEzJcNzBxh+bQ
	uAinjY3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x12hq-00000009avC-0Iou;
	Mon, 31 Aug 2026 14:09:50 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x12hl-00000009aup-23Yk
	for kexec@lists.infradead.org;
	Mon, 31 Aug 2026 14:09:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CF97644022
	for <kexec@lists.infradead.org>; Mon, 31 Aug 2026 14:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A501F00ACF
	for <kexec@lists.infradead.org>; Mon, 31 Aug 2026 14:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788185384;
	bh=L1mNt+t9t3Mp1gIJn7MX5n0Mz44VISN4VLwL6b799Bs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Vxa9oF/soWfIGx7X9eBymk6tUBTtSiGceTld0BHTg54XTE1uWopGPbiR5qAiDdjda
	 iaJ3uvNfpOPmsRf222g18ht0Km7pm/98QZ3tlJNQjiOp3SaGMmyhyw9p/XFbPew558
	 7tVYTzHuDm97oKg0HjVguFpsU2H9obvZ9W+/j6RGvcDs5jyZtgUqmkq8ESPWdMekxV
	 d3j0zvnb5rRn9HJxwu8ZTDe6GNqARHZsq8wRDUFaq7Cjd+jP3t4AjfNlQD+ricbfQY
	 t6b8GVYS/5XDQNQ+BqQfQROnn9n7hMkhuJImHAKQavStYE25THku2v1yfK8B7efNmp
	 4dNZYg3inseBw==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c250c6a6a9aso564454266b.1
        for <kexec@lists.infradead.org>; Mon, 31 Aug 2026 07:09:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpazYDyjDd9bBLw1RVIcHbrETGvKFsq+TLH3kzUtC84Rm5ecMaPpeCuR8PhteRXgT69dIJhKg==@lists.infradead.org
X-Gm-Message-State: AFuF++mFbAyqS/GBORszEh0VaX3Z65QJ03H0k3W0UvSnfDjoNQmMo0SA
	G+O+J8Jckt/ARP9jWbKnTEDq6i+4uUlqw2TWl3KT9v5rmTGOCGzzF5ePKgf7M1p5NOQIclnyak5
	4YiTsztM2IKIshkvK5ej/3RIFFrS0QUA=
X-Received: by 2002:a17:906:4ed4:b0:c25:6c9a:88bc with SMTP id
 a640c23a62f3a-c25b3d8a1d8mr44713366b.19.1788185382598; Mon, 31 Aug 2026
 07:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260826092541.3905933-1-ruanjinjie@huawei.com> <20260826092541.3905933-6-ruanjinjie@huawei.com>
In-Reply-To: <20260826092541.3905933-6-ruanjinjie@huawei.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 31 Aug 2026 22:09:30 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7+dO2rnb4KxRvVo1w_Mx8Vfsdq7LAbkzPfNYrwUhEtfg@mail.gmail.com>
X-Gm-Features: AcwNN1UnFQ4mMXEBOHuSLr0Mu3pUPtp_q9Do6p0Tl3kncID1TuZivoGd1AqJPW4
Message-ID: <CAAhV-H7+dO2rnb4KxRvVo1w_Mx8Vfsdq7LAbkzPfNYrwUhEtfg@mail.gmail.com>
Subject: Re: [PATCH v3 05/17] LoongArch: kexec: Fix CMA page leaks in segment
 placement retry loops
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, 
	baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, 
	pratyush@kernel.org, ruirui.yang@linux.dev, kees@kernel.org, thuth@redhat.com, 
	gshan@redhat.com, jic23@kernel.org, james.morse@arm.com, ardb@kernel.org, 
	leitao@debian.org, yeoreum.yun@arm.com, sourabhjain@linux.ibm.com, 
	coxu@redhat.com, tangyouling@kylinos.cn, hbathini@linux.ibm.com, 
	adityag@linux.ibm.com, ionut.nechita@windriver.com, liaoyuanhong@vivo.com, 
	seanjc@google.com, fuqiang.wang@easystack.cn, makb@juniper.net, 
	piliu@redhat.com, ebiggers@kernel.org, jbouron@amazon.com, 
	mclapinski@google.com, me@linux.beauty, graf@amazon.com, bgwin@google.com, 
	robh@kernel.org, takahiro.akashi@linaro.org, palmer@rivosinc.com, 
	x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
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

Why does the ARM64 version of this patch use "kexec_file" in the
subject line but the LoongArch version uses "kexec"? It is better to
keep consistency.

Huacai

On Wed, Aug 26, 2026 at 5:25=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com>=
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

