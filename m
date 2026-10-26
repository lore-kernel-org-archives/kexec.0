Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90DC606A327
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 10:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Gk8yuTtG;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TnrpnOtn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7KljSejtHSFaIj2i/cj6fMpCd01GmrjI2n9/9aXx/fs=; b=Gk8yuTtGEb75w5JHCFP1tUp3Jj
	YNj/k5QOt7Coa4tYtV7aLRetxpE6HMI1XOJZ3AeGEXMAUdQVzekxBh9c9a4HgNPbUL39NcXNynDLX
	URzhhpLKuxQBcHgYeK8f/62oPOlB8An/DjS05iZPMRSOaK8bQPZokjxlw/1bY8HD9YpLqSXcm1ME7
	ZhSb9qiHtTtod0FaPPZyW1unWZUe0HLibrBdWehPTOisWI7rUOx1DNltGxe3+veM1oT5iRqMefreH
	hmpcKSEf45+1hx4cjCL6zvVB+VxZmfntrU3aaMk8NbTCKDh9IRcTEC7fB+TgfRV6hISgtb3Cdk4vz
	1HR9LwBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLHpU-00000002FnJ-3YuX;
	Mon, 26 Oct 2026 10:21:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLHpT-00000002Fn6-3FhT
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 10:21:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0EEA440699;
	Mon, 26 Oct 2026 10:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDCB1F01825;
	Mon, 26 Oct 2026 10:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793010082;
	bh=7KljSejtHSFaIj2i/cj6fMpCd01GmrjI2n9/9aXx/fs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=TnrpnOtnhL/bguRt8/FxctF/EX5QQzYFwQbvbVQtl7FhD/Qq7ANFd+9c3CgojjUwU
	 RUXQ/YztTl+6DqbMBq9Wwh4xatM5R1kSq4sziKGSPiB011Xmvk5D6gxWR2L2O/5yMC
	 8RP1sLhQk+R72K4tLmEitFUm4J5ZuQkwVISfkXmoqI2FjgPDn3MyZWsHlZ0w0aGvy3
	 zpnYSAQwENnsiKALrAaxfs0PBvuegE/Li3sdcSdSATWoWU6CN6wOCWVWGkU7NI733H
	 Fp80HmJJoOCP8cLEjHViCCldnY0YnjyxHAsCJOUbCNz9NFvxCfW3X6fWHKcGIGcTfA
	 6jAy/dNac41Jw==
Message-ID: <sashiko-outbox-184926@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/15] LoongArch: kexec_file: Fix elf_headers memory
 leak in retry loop
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, thuth@redhat.com, leitao@debian.org, yeoreum.yun@arm.com, robh@kernel.org, sourabhjain@linux.ibm.com, kees@kernel.org, coiby.xu@gmail.com, Yeking@Red54.com, tangyouling@kylinos.cn, maqianga@uniontech.com, zhangtianyang@loongson.cn, guodongtai@kylinos.cn, blum@kernel.org, adityag@linux.ibm.com, hui.wang@canonical.com, sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn, kai.huang@intel.com, kas@kernel.org, vishal.l.verma@intel.co
 m, piliu@redhat.com, jbouron@amazon.com, mclapinski@google.com, me@linux.beauty, graf@amazon.com, bgwin@google.com, x86@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261026075201.699550-7-ruanjinjie@huawei.com>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
 <20261026075201.699550-7-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:21:20 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> A retry allocates new elf headers and overwrites image->elf_headers,
> leaking the previous buffer.  Free it before assigning.
>=20
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Youling Tang <tangyouling@kylinos.cn>
> Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: stable@vger.kernel.org
> Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%=
40huawei.com
> Fixes: 55d990f0084c ("LoongArch: Add EFI binary support for kexec_file")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026075201.6995=
50-1-ruanjinjie@huawei.com?part=3D6


