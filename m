Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00404606A323
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2nEZOujU;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bga7n/hv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jiFOlPOcIDKI7UX9OrL8crfSUH8GlVM6/6pFH8QAAuA=; b=2nEZOujUzVR4+TQW3qVHIQ+ZyP
	TpKFql9fXANWjzhtguBtFR4wYZKpMtvnVvW4TjKMQCPERi+sPCh8PulyIpuxZ0Vgr0mcbnM9mTjj8
	vMgp+qfocx63gR4C0wuSsel63kGhJsx3iSSfMcbLdhmnKsspNeP6f8TxSYjfY7F0FakBEeogp0Bng
	a+lLYTXqXRFq2BcyoJ9lQEeemaY7o9lRRLdVUgTshlXLT40UyfqRlkkh2pneBpguGgk9BQJOld7EM
	B778sNcfnSt3J+LxKcfXTLZAAoH0epKplhAiDm7ME9Yfj9vFOZREczIdptV8G5zd7xadVzmY/XJ0B
	IuMDklzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVTV-0000000AC7q-2xAN;
	Thu, 12 Nov 2026 14:08:25 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVTV-0000000AC7i-0VKX
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 14:08:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 895B161282;
	Thu, 12 Nov 2026 14:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDA51F00A05;
	Thu, 12 Nov 2026 14:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794492504;
	bh=jiFOlPOcIDKI7UX9OrL8crfSUH8GlVM6/6pFH8QAAuA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Bga7n/hvndNbg6asohnTVI7AfpCQL0DaGO9pOaFmGLGq2chq1E1QynN2Cc4ErKteQ
	 JQ9ccbagnZK9lj2eufZX8L19q659IAXlrdYuyYIbGvMhhOwqDC91fVeelFbMnFz1EM
	 jH2RjsGyG7YtyU0aY3wuC1iX+Ny52qmm8DSJL9GLh88faC3Vi3lM17xIVpkA47Xe2u
	 XidX7ZPgs8a2+Kwg3EKbVVOhoFoqO1PfJU/EetuV4M65/Wld09+H4pNhKGS2dqI5cd
	 MM5uqcET/NtKKUQX2yeXJLZ7WmPbUmB+HkMA9/s9HAZGHxcwa0MIFt5fD+3sPEwxis
	 O+aQty1eEgTAg==
Message-ID: <sashiko-outbox-211269@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/11] x86: kexec_file: Use the common segment
 helpers
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, leitao@debian.org, yeoreum.yun@arm.com, mpilaniy@redhat.com, robh@kernel.org, coiby.xu@gmail.com, Yeking@Red54.com, prudo@redhat.com, brads@mainlining.org, sourabhjain@linux.ibm.com, mkchauras@gmail.com, blum@kernel.org, adityag@linux.ibm.com, qirui.001@bytedance.com, hui.wang@canonical.com, sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn, ionut.nechita@windriver.com, vishal.l.verma@intel.com, seanjc@google.com, ardb@kernel.
 org, richard.lyu@suse.com, arnd@arndb.de, tzimmermann@suse.de, rick.p.edgecombe@intel.com, kai.huang@intel.com, kas@kernel.org, piliu@redhat.com, thuth@redhat.com, shradhagupta@linux.microsoft.com, ebiggers@kernel.org, jbouron@amazon.com, me@linux.beauty, mclapinski@google.com, graf@amazon.com, tangyouling@kylinos.cn, x86@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261112133418.4044428-7-ruanjinjie@huawei.com>
References: <20261112133418.4044428-1-ruanjinjie@huawei.com>
 <20261112133418.4044428-7-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:08:21 +0000
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] x86/crash: unset elfcorehdr_index in crash_load_segments()
  breaks hotplug
--

commit 1b8e09baefdcc28fe15998b5723b09d361d15f6e
Author: Jinjie Ruan <ruanjinjie@huawei.com>

x86: kexec_file: Use the common segment helpers

This commit replaces open-coded ELF core header and initrd segment loading
in x86 kexec_file with the common kexec_prepare_elf_core_header(),
kexec_add_elf_core_header(), and kexec_add_initrd() helpers.

> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index e6f23933a6df2..8d56d39ebbd53 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -354,14 +354,12 @@ int crash_load_segments(struct kimage *image)
>  				  .buf_max =3D ULONG_MAX, .top_down =3D false };
> =20
>  	/* Prepare elf headers and add a segment */
> -	ret =3D crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &kbuf.buffer,
> -				    &kbuf.bufsz, &pnum);
> +	ret =3D kexec_prepare_elf_core_header(image, IS_ENABLED(CONFIG_X86_64),
> +					    &pnum);
>  	if (ret)
>  		return ret;
> =20
> -	image->elf_headers	=3D kbuf.buffer;
> -	image->elf_headers_sz	=3D kbuf.bufsz;
> -	kbuf.memsz		=3D kbuf.bufsz;
> +	kbuf.memsz =3D image->elf_headers_sz;
> =20
>  #ifdef CONFIG_CRASH_HOTPLUG
>  	/*
> @@ -374,28 +372,15 @@ int crash_load_segments(struct kimage *image)
>  		pnum +=3D 2 + CONFIG_NR_CPUS;
> =20
>  	if (pnum < (unsigned long)PN_XNUM) {
> -		kbuf.memsz =3D pnum * sizeof(Elf64_Phdr);
> -		kbuf.memsz +=3D sizeof(Elf64_Ehdr);
> -
> -		image->elfcorehdr_index =3D image->nr_segments;
> -
> -		/* Mark as usable to crash kernel, else crash kernel fails on boot */
> -		image->elf_headers_sz =3D kbuf.memsz;
> +		kbuf.memsz =3D pnum * sizeof(Elf64_Phdr) + sizeof(Elf64_Ehdr);
>  	} else {
>  		pr_err("number of Phdrs %lu exceeds max\n", pnum);
>  	}
>  #endif
> =20
>  	kbuf.buf_align =3D ELF_CORE_HEADER_ALIGN;
> -	kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> -	ret =3D kexec_add_buffer(&kbuf);
> -	if (ret)
> -		return ret;
> -	image->elf_load_addr =3D kbuf.mem;
> -	kexec_dprintk("Loaded ELF headers at 0x%lx bufsz=3D0x%lx memsz=3D0x%lx\=
n",
> -		      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
> =20
> -	return ret;
> +	return kexec_add_elf_core_header(image, &kbuf);
>  }

[Severity: High]
Can this leave image->elfcorehdr_index unset (-1) when CONFIG_CRASH_HOTPLUG
is enabled?

kexec_prepare_elf_core_header() -> crash_prepare_headers() ->
crash_prepare_elf64_headers() aligns image->elf_headers_sz up to
ELF_CORE_HEADER_ALIGN (4096), whereas crash_load_segments() computes an
unaligned kbuf.memsz for the hotplug reservation.  In
kexec_add_elf_core_header(), image->elfcorehdr_index is only updated when
memsz strictly exceeds image->elf_headers_sz:

kernel/kexec_file.c:kexec_add_elf_core_header() {
	...
	/* The crash hotplug reservation can exceed the header size. */
	if (memsz > image->elf_headers_sz) {
		image->elf_headers_sz =3D memsz;
#ifdef CONFIG_CRASH_HOTPLUG
		image->elfcorehdr_index =3D image->nr_segments - 1;
#endif
	}
	...
}

Whenever the unaligned hotplug kbuf.memsz fits within the same 4096-byte
multiple as the initial header (for example, when CONFIG_MEMORY_HOTPLUG is
disabled and CONFIG_NR_CPUS equals num_possible_cpus()), memsz <=3D
image->elf_headers_sz and image->elfcorehdr_index remains -1.
kexec_calculate_store_digests() then includes the elfcorehdr segment in the
purgatory SHA-256 digest, so any later CPU or memory hotplug update to
elfcorehdr causes purgatory digest verification to fail on crash.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112133418.4044=
428-1-ruanjinjie@huawei.com?part=3D6

