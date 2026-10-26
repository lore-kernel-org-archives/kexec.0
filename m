Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B893606A31A
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 10:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yR581D5L;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E1B+L8gw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7WwnpFjPMEKaCJtdpOsUj4lnxgOpMsABb+yQKE+nUEc=; b=yR581D5LC8zXY59idXhYVliLLs
	Ow0EMvj5gQYDYyyWl7+MuJP+dJ8D8cxZL9/5HC7h8Ug3LEQcAwP/CYC6scWbwZjYqpkZVQy1vKJUF
	uc17/BugUxYw8u0XXW2ogjma1LN3u4bF3DjEMv+8IluQXEkIYTwH45CeTi1XmR4kjfQgPrY1p4SXr
	6Up4lmBnrKkQZpX6LjWJUwL+fU2RFoMj41UqnYnR3zd0fPoJiFfTNc11Shk476jUrrMtXjM43Y4j7
	wOV+KOYYeb7onpk7nY3V7FC3M9A8LGdV7PRBB3QD92SOsac2mKp96MDY7RJMqlt+8PQM5cMcoKbFJ
	veK2HBaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLHiG-00000002F4M-1viy;
	Mon, 26 Oct 2026 10:13:56 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLHiE-00000002F3I-40bc
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 10:13:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DD53560A68;
	Mon, 26 Oct 2026 10:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FCA1F01825;
	Mon, 26 Oct 2026 10:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793009633;
	bh=7WwnpFjPMEKaCJtdpOsUj4lnxgOpMsABb+yQKE+nUEc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=E1B+L8gwF63LFjKAzleNH4ChGHjkDqqtNBBhv7wjIb8IoEUkR3t7JQCs88yy/5O9N
	 dvQ6eghQUax/bLQf4NPgpJqMZfvNX1pR2qS9BJNAaBZ+Exn4U0xrgU5RKUMqgBf3UD
	 /HVBUxOy4Vo8/qVsRPCQbmZEpceHRm/Dw2pzUSl97N7dutb/Ygt3jA6oUa8TcRdSal
	 1kpwPbhJ3WDcPc2f1FVfvXcN5YQpuu4H9m9pFCNHwlsJSw3yfydvBjh7AkuMw6sQ/v
	 o51OP/iZEp3iUq+dh+6Hb0w/8b8XAXPUn6WJ5BQzWyKkOGcd9chmI4pJ3RElKesB24
	 NaZ9nHtnix6KQ==
Message-ID: <sashiko-outbox-184901@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/15] LoongArch: kexec_file: Fix CMA page leaks in
 segment placement retry loops
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, thuth@redhat.com, leitao@debian.org, yeoreum.yun@arm.com, robh@kernel.org, sourabhjain@linux.ibm.com, kees@kernel.org, coiby.xu@gmail.com, Yeking@Red54.com, tangyouling@kylinos.cn, maqianga@uniontech.com, zhangtianyang@loongson.cn, guodongtai@kylinos.cn, blum@kernel.org, adityag@linux.ibm.com, hui.wang@canonical.com, sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn, kai.huang@intel.com, kas@kernel.org, vishal.l.verma@intel.co
 m, piliu@redhat.com, jbouron@amazon.com, mclapinski@google.com, me@linux.beauty, graf@amazon.com, bgwin@google.com, x86@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261026075201.699550-6-ruanjinjie@huawei.com>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
 <20261026075201.699550-6-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:13:51 +0000
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] LoongArch: kexec_file: efi_kexec_load() skips RAM below CMA on r=
etry
--

commit f502069414c135fd39705a4caf6f9bdd9bb1a976
Author: Jinjie Ruan <ruanjinjie@huawei.com>

LoongArch: kexec_file: Fix CMA page leaks in segment placement retry loops

This commit fixes CMA page leaks in efi_kexec_load() and
load_other_segments() when segment placement fails, and disables CMA on
retry so kexec_add_buffer() does not repeatedly allocate the same CMA
region.

Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%40=
huawei.com

> diff --git a/arch/loongarch/kernel/kexec_efi.c b/arch/loongarch/kernel/ke=
xec_efi.c
> index 5ee78ebb1546e..d42711b895a2c 100644
> --- a/arch/loongarch/kernel/kexec_efi.c
> +++ b/arch/loongarch/kernel/kexec_efi.c
> @@ -86,6 +86,14 @@ static void *efi_kexec_load(struct kimage *image,
>  		 * We couldn't find space for the other segments; erase the
>  		 * kernel segment and try the next available hole.
>  		 */
> +		/*
> +		 * kexec_alloc_contig() ignores buf_min, so disable CMA to
> +		 * let the retry make progress.
> +		 */
> +		if (image->segment_cma[kernel_segment_number])
> +			image->no_cma =3D true;
> +
> +		kexec_free_segment_cma(image, kernel_segment_number);
>  		image->nr_segments -=3D 1;
>  		kbuf.buf_min =3D kernel_segment->mem + kernel_segment->memsz;
>  		kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;

[Severity: Medium]
When falling back from a CMA allocation to a normal bottom-up System RAM
search in efi_kexec_load(), does advancing kbuf.buf_min skip valid System
RAM located below the CMA region?

Before the retry loop in efi_kexec_load(), kbuf is set up for a bottom-up
search starting at text_offset:

    kbuf.top_down =3D false;
    ...
    kbuf.buf_min =3D text_offset;

On the first iteration, kexec_add_buffer() -> kexec_locate_mem_hole() ->
kexec_alloc_contig() allocates the kernel segment from CMA, which ignores
kbuf.buf_min and may place the kernel high in physical memory (for example,
near the top of DRAM or above 4GB).

If load_other_segments() then fails to place the initrd because there is
not enough space above the CMA kernel segment, the retry path sets
image->no_cma =3D true so the next iteration falls back to
kexec_walk_memblock(). However, it still updates kbuf.buf_min:

    kbuf.buf_min =3D kernel_segment->mem + kernel_segment->memsz;

Because the first attempt came from CMA rather than a bottom-up walk from
text_offset, won't advancing kbuf.buf_min past the CMA allocation skip all
System RAM in [text_offset, kernel_segment->mem + kernel_segment->memsz)
and cause kexec_file_load() to fail with -EADDRNOTAVAIL?

Should kbuf.buf_min only be advanced when the failed kernel segment was not
allocated from CMA?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026075201.6995=
50-1-ruanjinjie@huawei.com?part=3D5

