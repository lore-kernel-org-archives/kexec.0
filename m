Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C6C606C715
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IgYA0Au4;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAoc3kyH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DJmMV+2d5vRUbthYKWyI4r6H1mM3j4Rw/JeDMUmFNd4=; b=IgYA0Au4dCvVT5aCV5J7qxmUoZ
	YB/uO78WIaVn3U/N0Lpc9uNmZFAkbcHrcEOHbPwrKVg1kInML2nbYUkFsjl3hja1zRxWhT5dd0DI8
	SLjGW2PzrIiDI2o7FeK3M0XrKUM0HaSukkQ2gx2qbVPW5WrcIy2o7RmN4VbmmgdIlfGmD2vTn8fxM
	umCeRrl+n34zzq6k2kIVq6sKiBqmv0GpRl/AtTigMQ4dxw/Pm0El6iBaDCCH777o0VOdaXq6/AdcO
	L2tRIDwQHnBfk5+mQ1qyjUeWl3g65/t42xKo3ev9kjxHGLW591lvmJs2CjLQlFjJ3BgxAWHxVpPfq
	8qzAbO9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVKw-0000000AA8q-3Jxk;
	Thu, 12 Nov 2026 13:59:34 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVKv-0000000AA82-0Ojt
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 13:59:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D170143A72;
	Thu, 12 Nov 2026 13:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C781F00A06;
	Thu, 12 Nov 2026 13:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794491972;
	bh=DJmMV+2d5vRUbthYKWyI4r6H1mM3j4Rw/JeDMUmFNd4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=UAoc3kyHlGHcJ8eOlXNkfWQnzerdmEbz1uBjQ8ITQ3gEG5hpit7tooPWfqW3rAFFk
	 XpKIQ5vWRSWYG4VseJUl/g9TTE6bhFBn5MYGKPKqL0ii4/u1RpnGmXm0VfT8eT3g2r
	 mOUSoxTvG1Nntxrz+jWM0L2SsxPEg9IwBd/D/nLGLXrZoqMA59gvkF9R99jU5xx1Fu
	 admYy4M00moXV0lzdCq4WFxOFztAH3vaBJUCd4CIfcOK/Gzk0lUDoLJoBDvkM2CUA9
	 LjGUpVHgjXlTZY9f48GU0XWItbETiu2Dno7iakImWAgLd5BJ3JFRwQfKU4vFYF/oih
	 PDaQEmNAOsm5w==
Message-ID: <sashiko-outbox-211244@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/11] kexec: Add helpers to load the elf core
 header, initrd and FDT
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, leitao@debian.org, yeoreum.yun@arm.com, mpilaniy@redhat.com, robh@kernel.org, coiby.xu@gmail.com, Yeking@Red54.com, prudo@redhat.com, brads@mainlining.org, sourabhjain@linux.ibm.com, mkchauras@gmail.com, blum@kernel.org, adityag@linux.ibm.com, qirui.001@bytedance.com, hui.wang@canonical.com, sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn, ionut.nechita@windriver.com, vishal.l.verma@intel.com, seanjc@google.com, ardb@kernel.
 org, richard.lyu@suse.com, arnd@arndb.de, tzimmermann@suse.de, rick.p.edgecombe@intel.com, kai.huang@intel.com, kas@kernel.org, piliu@redhat.com, thuth@redhat.com, shradhagupta@linux.microsoft.com, ebiggers@kernel.org, jbouron@amazon.com, me@linux.beauty, mclapinski@google.com, graf@amazon.com, tangyouling@kylinos.cn, x86@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261112133418.4044428-3-ruanjinjie@huawei.com>
References: <20261112133418.4044428-1-ruanjinjie@huawei.com>
 <20261112133418.4044428-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 13:59:29 +0000
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
- [High] kexec: conditional elfcorehdr_index update in
  kexec_add_elf_core_header()
--

commit 4a8f51d9037324bff5c93a895d13b625ecd6ac57
Author: Jinjie Ruan <ruanjinjie@huawei.com>

kexec: Add helpers to load the elf core header, initrd and FDT

This commit adds generic kexec_file helpers to prepare and place the ELF
core header, initrd, and flattened device tree segments.

Link: https://lore.kernel.org/all/179430504583.425130.15302016434972990362.=
b4-review@b4/

> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 1f128c6e6fa39..25c9bef639d27 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c

[ ... ]

> +int kexec_add_elf_core_header(struct kimage *image, struct kexec_buf *kb=
uf)
> +{
> +	unsigned long memsz =3D kbuf->memsz;
> +	int ret;
> +
> +	kbuf->buffer =3D image->elf_headers;
> +	kbuf->bufsz =3D image->elf_headers_sz;
> +	kbuf->mem =3D KEXEC_BUF_MEM_UNKNOWN;
> +
> +	ret =3D kexec_add_buffer(kbuf);
> +	if (ret)
> +		return ret;
> +
> +	image->elf_load_addr =3D kbuf->mem;
> +
> +	/* The crash hotplug reservation can exceed the header size. */
> +	if (memsz > image->elf_headers_sz) {
> +		image->elf_headers_sz =3D memsz;
> +#ifdef CONFIG_CRASH_HOTPLUG
> +		image->elfcorehdr_index =3D image->nr_segments - 1;
> +#endif
> +	}

[Severity: High]
Should image->elfcorehdr_index be set unconditionally under
CONFIG_CRASH_HOTPLUG rather than only when memsz > image->elf_headers_sz?

When a caller passes kbuf->memsz <=3D image->elf_headers_sz (such as when
kbuf->memsz equals image->elf_headers_sz, or when an unaligned hotplug
size fits within the page-aligned image->elf_headers_sz),
image->elfcorehdr_index remains -1.  kexec_calculate_store_digests() then
hashes the elfcorehdr segment into the purgatory digest, so any later CPU
or memory hotplug update in crash_handle_hotplug_event() rewrites the
header in crash memory and causes purgatory SHA verification to fail on
panic.

Also, if a caller passes kbuf->memsz smaller than image->elf_headers_sz,
clamping kbuf->memsz =3D max(kbuf->memsz, image->elf_headers_sz) before
kexec_add_buffer() is needed so the segment cannot end up with
memsz < bufsz and fail sanity_check_segment_list() with -EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112133418.4044=
428-1-ruanjinjie@huawei.com?part=3D2

