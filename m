Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36FF606A31B
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Z7YeHZLU;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VGbJp8G4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=O5guNzSKmFw6bVwzVonkH7658CLuGo9lOjrkd0PCJP4=; b=Z7YeHZLUAXmQNldvQKKbMz3l7O
	aJIrP08ga1CLOOelnDCUW82QQSCASNis581y64ATZZHCXEvBzRSKXT8o54KxfzBYZeygNAGlkL79/
	VrsOonTKedbKEFZRzOE5Z6aH1eDii8Qm4BZ1GaNt4mZgAOut3j3jqdacl5Taxq8QmLCezg3h9LhZg
	oQN1wYEZ3HwYxH8ilgLthecZ7eWrjQALq1tdzR+JgU6MP/zbigaNcDyeasnM+N9vJ6FFJOZFW/q3u
	mQ+NkkDRA80CAEqhgDoiOz9K2QsHrxWs53dZzkI8NvK7fjvVHPgTgEv+eMK5pwyQpbLBIpNA30p66
	/7y9lHWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLHOf-000000028dw-1cfn;
	Mon, 26 Oct 2026 09:53:41 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLHOe-000000028dQ-1bIg
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 09:53:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 768346025F;
	Mon, 26 Oct 2026 09:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F92D1F01825;
	Mon, 26 Oct 2026 09:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793008419;
	bh=O5guNzSKmFw6bVwzVonkH7658CLuGo9lOjrkd0PCJP4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=VGbJp8G45nABV0GrmC4iKbr7VFZjsLpswtGrtJ60lEOgKXMbqJ/gXQXyOAetwNSYz
	 m8+0UzO3Ixftsn7otN6qoHIiO34JUXeNJir+J+54UGlp7ooMiUqGzItU8WNM+HR7Kz
	 4HdCakWj8UIqxIZIBt9viZpsh3eur9rrajMXRkUu7owvUn+0J1MVxACzWnImyx/mjy
	 GG92TH24pStSQnR0Lu4wmCXsc/Tbxt7BWgHKZ9/MizmWyFKv6F3ouDS7FJDHTQCLvI
	 RlOQBOuToKdr67NzRfyXo9kY0VwNbsC6wGBim8fnAWfWrHrgM1Jxe58udm7Vgh0mEo
	 fUs53YI6yCnSw==
Message-ID: <sashiko-outbox-184847@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/15] arm64: kexec_file: Fix CMA page leaks in
 segment placement retry loops
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, thuth@redhat.com, leitao@debian.org, yeoreum.yun@arm.com, robh@kernel.org, sourabhjain@linux.ibm.com, kees@kernel.org, coiby.xu@gmail.com, Yeking@Red54.com, tangyouling@kylinos.cn, maqianga@uniontech.com, zhangtianyang@loongson.cn, guodongtai@kylinos.cn, blum@kernel.org, adityag@linux.ibm.com, hui.wang@canonical.com, sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn, kai.huang@intel.com, kas@kernel.org, vishal.l.verma@intel.co
 m, piliu@redhat.com, jbouron@amazon.com, mclapinski@google.com, me@linux.beauty, graf@amazon.com, bgwin@google.com, x86@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261026075201.699550-4-ruanjinjie@huawei.com>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
 <20261026075201.699550-4-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:53:35 +0000
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
- [Medium] arm64: kexec_file: image_load() skips RAM below CMA on non-CMA r=
etry
--

commit a177040c2457cfc0cd78f4ced8850ba0e9322a44
Author: Jinjie Ruan <ruanjinjie@huawei.com>

arm64: kexec_file: Fix CMA page leaks in segment placement retry loops

This commit frees CMA-backed segments when rewinding image->nr_segments in
image_load() and load_other_segments(), and sets image->no_cma when a
CMA-allocated kernel segment placement retry occurs.

> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_im=
age.c
> index 74d24c8aa2fad..6ed1991e31429 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -111,6 +111,14 @@ static void *image_load(struct kimage *image,
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
When falling back from a CMA allocation to a non-CMA search in image_load(),
does unconditionally advancing kbuf.buf_min to kernel_segment->mem +
kernel_segment->memsz skip all free RAM below the CMA region?

In image_load(), kbuf.buf_min starts at 0 with kbuf.top_down set to false:

arch/arm64/kernel/kexec_image.c:image_load() {
	kbuf.image =3D image;
	kbuf.buf_min =3D 0;
	kbuf.buf_max =3D ULONG_MAX;
	kbuf.top_down =3D false;
	...
	while ((ret =3D kexec_add_buffer(&kbuf)) =3D=3D 0) {

On the first iteration, kexec_add_buffer() -> kexec_locate_mem_hole() calls
kexec_alloc_contig() before walking memblock:

kernel/kexec_file.c:kexec_locate_mem_hole() {
	if (!kexec_alloc_contig(kbuf))
		return 0;

	if (!IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
		ret =3D kexec_walk_resources(kbuf, locate_mem_hole_callback);
	else
		ret =3D kexec_walk_memblock(kbuf, locate_mem_hole_callback);

Because kexec_alloc_contig() allocates from the CMA area without consulting
kbuf.buf_min, the bottom-up walk starting from 0 has not run yet.

If load_other_segments() then fails to place initrd or dtb above
kernel_segment->mem + kernel_segment->memsz (for example, when CMA is near
the top of RAM and lacks space for the remaining segments), setting
image->no_cma =3D true and advancing kbuf.buf_min to kernel_segment->mem +
kernel_segment->memsz causes the next iteration's kexec_walk_memblock() to
search only above the CMA region, where load_other_segments() already failed
to find space.

Should kbuf.buf_min only be updated to kernel_segment->mem +
kernel_segment->memsz when the failed kernel segment was not allocated from
CMA?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026075201.6995=
50-1-ruanjinjie@huawei.com?part=3D3

