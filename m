Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC18606A895
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=08b2Wanm;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HpKzv5w/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ClknvAtgrJdBuv6Sudd10+WJu5qMSe7VsTZU/IZA1LI=; b=08b2WanmLggBfp8NQUPOpuhRT/
	Y1r2FolPsjxokA7X1rkabMRCHng2DQZ3aUB0Z5z2gppDMJLI3feDmn0y6DnYADWTfXK1tYcRYDb2r
	z7QhS15eCtOKKc5EbeEZjZgK5clog2sQHP+Myn6aRStTv266dlIt8uk2HCzjw8BvC9PHnaUVwi5YY
	3qyBE+KXVN4qVqN0dMyeWuOV+DvpfdaoLq8seESNPZlkDF/LAHPo8Am3+dRlLF+9FubPudNOiOU8y
	PVwNDyVk9nCjCwvg9U7XJHrK95aH6zdYIrM3CC6M6py7m4H5Qt7lz2K9vPp1pVSgxNTxynmLVK0Fx
	XWR/gdcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVa3-0000000ADeN-3tSE;
	Thu, 12 Nov 2026 14:15:11 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVa2-0000000ADdk-2vqT
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 14:15:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D9AE7431FE;
	Thu, 12 Nov 2026 14:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848751F00A14;
	Thu, 12 Nov 2026 14:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794492909;
	bh=ClknvAtgrJdBuv6Sudd10+WJu5qMSe7VsTZU/IZA1LI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=HpKzv5w/3ekNrvUJq/7kdBCkiqlkmVc+JyCERIyb7JOJULiaKWCTPUqoQ4CvykMBg
	 r9Z0Z0vUMIgutkadzlwbyKXQSzJFmQdsTYtFOPgsnqXiVpCGlxhAo/fD1D3B+FKQRD
	 a8LMeXeEg6k9pun35wDBU33CKstrJNU6ICiro7YMOaljw5CvU712C0YhsPgLzntjtu
	 XtJRPDrYAywj63+cJ5xv9O4zK+418sq/QT8NlrgxcjQSF/bLH/biOfU2cIkUUgVJf+
	 DRwkG1KTOzdUHMb9acFGDp7NKvs7HqVjPW7MFvIMMjOirZfZ4Z1VTrxV//SUhqN9fk
	 A9AIm2Krvmdhw==
Message-ID: <sashiko-outbox-211284@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/11] kexec: Add kexec_rollback_segments() helper
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, leitao@debian.org, yeoreum.yun@arm.com, mpilaniy@redhat.com, robh@kernel.org, coiby.xu@gmail.com, Yeking@Red54.com, prudo@redhat.com, brads@mainlining.org, sourabhjain@linux.ibm.com, mkchauras@gmail.com, blum@kernel.org, adityag@linux.ibm.com, qirui.001@bytedance.com, hui.wang@canonical.com, sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn, ionut.nechita@windriver.com, vishal.l.verma@intel.com, seanjc@google.com, ardb@kernel.
 org, richard.lyu@suse.com, arnd@arndb.de, tzimmermann@suse.de, rick.p.edgecombe@intel.com, kai.huang@intel.com, kas@kernel.org, piliu@redhat.com, thuth@redhat.com, shradhagupta@linux.microsoft.com, ebiggers@kernel.org, jbouron@amazon.com, me@linux.beauty, mclapinski@google.com, graf@amazon.com, tangyouling@kylinos.cn, x86@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261112133418.4044428-10-ruanjinjie@huawei.com>
References: <20261112133418.4044428-1-ruanjinjie@huawei.com>
 <20261112133418.4044428-10-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:15:07 +0000
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
- [Medium] kexec: missing elfcorehdr_index invalidation in
  kexec_rollback_segments()
--

commit 67c30192060172d9e9af6c0433ce26a5bea934f3
Author: Jinjie Ruan <ruanjinjie@huawei.com>

kexec: Add kexec_rollback_segments() helper

This commit adds a kexec_rollback_segments() helper to release CMA pages
and truncate image->nr_segments when rolling back a partial load attempt.

> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 25c9bef639d27..b4fe5c4188421 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -1419,3 +1419,15 @@ int kexec_purgatory_get_set_symbol(struct kimage *=
image, const char *name,
>  	return 0;
>  }
>  #endif /* CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY */
> +
> +/*
> + * Undo a partial load attempt: release the CMA pages backing
> + * the segments above @nr_segments and drop them from the image.
> + */
> +void kexec_rollback_segments(struct kimage *image, unsigned long nr_segm=
ents)
> +{
> +	while (image->nr_segments > nr_segments) {
> +		kexec_free_segment_cma(image, image->nr_segments - 1);
> +		image->nr_segments--;
> +	}
> +}

[Severity: Medium]
Does kexec_rollback_segments() leave a stale image->elfcorehdr_index when
the ELF core header segment is among the dropped segments?

The commit message notes that the helper invalidates the recorded
elfcorehdr segment index when dropped, but the implementation does not
reset image->elfcorehdr_index to -1.  Moreover, kexec_add_elf_core_header()
only records image->elfcorehdr_index when memsz > image->elf_headers_sz
and updates image->elf_headers_sz on the first attempt:

kernel/kexec_file.c:kexec_add_elf_core_header() {
	...
	if (memsz > image->elf_headers_sz) {
		image->elf_headers_sz =3D memsz;
#ifdef CONFIG_CRASH_HOTPLUG
		image->elfcorehdr_index =3D image->nr_segments - 1;
#endif
	}
	...
}

If a rollback drops the ELF core header segment, a retry sees
memsz =3D=3D image->elf_headers_sz and leaves the old index in place, causi=
ng
kexec_calculate_store_digests() and handle_hotplug_event() to skip or
reference the wrong segment.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112133418.4044=
428-1-ruanjinjie@huawei.com?part=3D9

