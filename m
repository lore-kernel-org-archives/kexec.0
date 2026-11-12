Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF990606A31C
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oCVTajx9;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h/COUZOG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UfrH1gBtH7ZyN7N6+3IzIfC2cj0SrceLRg/Bz31wjqg=; b=oCVTajx9IOynChcNgORx9p0xFS
	ET4NEu2FTj10JG0unv2ZiqOYjqMnm4lgVXAkFTKYrsPm+48ty2G+0PQ4Dp9UFHhE+4XDPh4Rxi7OE
	C/1xWLyWBrsbiSOYmcjDCBH2NkMDdQ+zG+WB9FHDdnJz7NNVu+52siNz5yGQvej5RBNo98RYI7nsZ
	5Jrm+nqMWQWwkkRzQk1nZ1YrssfzzTNFd4PsIOP1nXGhU7xOzdTvb4O5eCwxZg+PliPou9lJ6kX05
	oqRNoFkPhdrxCFrGekwXbfeaeQq56UUNPX3OoeN+ksuzu9T+wEbYIViXMnSJmeaBykb2yWGXGyKgs
	D9EtajLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVEj-0000000A9RS-2Gxa;
	Thu, 12 Nov 2026 13:53:09 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVEi-0000000A9RL-2Agm
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 13:53:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 443DB407E7;
	Thu, 12 Nov 2026 13:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F239B1F00A05;
	Thu, 12 Nov 2026 13:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794491588;
	bh=UfrH1gBtH7ZyN7N6+3IzIfC2cj0SrceLRg/Bz31wjqg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=h/COUZOGOIHQSJ/B7Uc3zED6KpWPyYVAFY6kHwgjy7jYmIftN5LGjQW7t0bYtRn2V
	 ri7z5z+CTYrOhpOjeZLpt/uX+Otcqy6jyx3EdOblIdcx933MnIiP0nrpHMk0ZF2wkM
	 IVwYxOmrL8TRYECvx6u+Z7efp/YFnZtWPyG8cX5dB3TaJX6pzsdzLdXEuw1lh0HBe1
	 m2Z8KPwbffyqz4N5Wqo5U3eGdND2AqiFlopyip6A1uOjkvB+9jTYRvqkzOFFN+10He
	 I0aZyTpDsZYBKprluQ7Xze47OJWAoEWcW1fSsC1/2iLcEYbAc1yFgtt1RuM8BBvB8/
	 qA5fzDoC9+6uA==
Message-ID: <sashiko-outbox-211237@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/11] riscv: kexec_file: Load the extra segments
 with common helpers
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, leitao@debian.org, yeoreum.yun@arm.com, mpilaniy@redhat.com, robh@kernel.org, coiby.xu@gmail.com, Yeking@Red54.com, prudo@redhat.com, brads@mainlining.org, sourabhjain@linux.ibm.com, mkchauras@gmail.com, blum@kernel.org, adityag@linux.ibm.com, qirui.001@bytedance.com, hui.wang@canonical.com, sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn, ionut.nechita@windriver.com, vishal.l.verma@intel.com, seanjc@google.com, ardb@kernel.
 org, richard.lyu@suse.com, arnd@arndb.de, tzimmermann@suse.de, rick.p.edgecombe@intel.com, kai.huang@intel.com, kas@kernel.org, piliu@redhat.com, thuth@redhat.com, shradhagupta@linux.microsoft.com, ebiggers@kernel.org, jbouron@amazon.com, me@linux.beauty, mclapinski@google.com, graf@amazon.com, tangyouling@kylinos.cn, x86@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261112133418.4044428-6-ruanjinjie@huawei.com>
References: <20261112133418.4044428-1-ruanjinjie@huawei.com>
 <20261112133418.4044428-6-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 13:53:05 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> Use the common segment helpers to load the elf core header, the initrd
> and the DTB instead of open coding them.  The initrd and the command line
> come from the image.
>=20
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112133418.4044=
428-1-ruanjinjie@huawei.com?part=3D5


