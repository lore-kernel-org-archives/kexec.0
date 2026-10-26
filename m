Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8230D606A332
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kCdbYYda;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JmXG/nTD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=20C8QRAnXyKPo4F6AMeKu/8wF3DSsIxF7LV6yIhf3j8=; b=kCdbYYdaAZcJ5Xp94ME0odSRhR
	zP4D50Hrt/vL75fvNOHXfpYmkQu9XqOYvhNUr2Z0q38HFnqnkIONXXLJRgpsTwr4s+JgPT7/DsqrS
	Y0kD7WFFhLBbq3Xgs62v70mJfrq7yTafLCMvsTpvd1gXU3Oq8OW+rczRjtXdxQ+K2fZzUcajipgIt
	7rVlu5O2qRlE29+DCGn9Y82CJJy4C7QVUGzOd06uhEbUL4Uo9rpwNfobbu27ZYRzXn3p2r2Es8zSG
	aLTeTiXQ3r+YvMpVP7JEevZDa3TxlZgYgnmY8zNEfaOYBGOqKnDIrnbCaMD2ZIUwD/HCQNlCYuy8c
	Tb0CFZMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLHVf-00000002BB0-08bG;
	Mon, 26 Oct 2026 10:00:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLHVd-00000002BAg-1Yr2
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 10:00:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id ECCB8412EC;
	Mon, 26 Oct 2026 10:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7931F01825;
	Mon, 26 Oct 2026 10:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793008852;
	bh=20C8QRAnXyKPo4F6AMeKu/8wF3DSsIxF7LV6yIhf3j8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=JmXG/nTDJ0bRiIlht/KBjjJtxqizf6r9IVEWvrQ9bZkrfLOB2UZ2ZZKFwz9Ma20vZ
	 xzLvHUGbzmtFM9do54nllIQmdVtHL8NIxp123IVk6kQioQNfYWq/v9kdmktyYu7+Yz
	 Fa26GxsEo6pdaWg5rmXYMPn8+3i+TTV5ffOjP/eni0ZPGDVQh34svg/ooNvoM4q3sa
	 uIpY9NB87NS0XatzAv0u3jqMbmSib5JxNhfH1K2by+Nc05ZaCB6QutaMnkAkeqf2P0
	 JBoJfpcr5A2RlTLy04aTdw/3uvpQOwQzOcvUQWODb5E2ldYGW1UVqcJR/ps+tUNE/3
	 bvWtr7uTtgukA==
Message-ID: <sashiko-outbox-184863@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/15] arm64: kexec_file: Fix elf_headers memory leak
 in retry loop
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, thuth@redhat.com, leitao@debian.org, yeoreum.yun@arm.com, robh@kernel.org, sourabhjain@linux.ibm.com, kees@kernel.org, coiby.xu@gmail.com, Yeking@Red54.com, tangyouling@kylinos.cn, maqianga@uniontech.com, zhangtianyang@loongson.cn, guodongtai@kylinos.cn, blum@kernel.org, adityag@linux.ibm.com, hui.wang@canonical.com, sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn, kai.huang@intel.com, kas@kernel.org, vishal.l.verma@intel.co
 m, piliu@redhat.com, jbouron@amazon.com, mclapinski@google.com, me@linux.beauty, graf@amazon.com, bgwin@google.com, x86@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261026075201.699550-5-ruanjinjie@huawei.com>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
 <20261026075201.699550-5-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:00:50 +0000
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
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Yeoreum Yun <yeoreum.yun@arm.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 108aa503657e ("arm64: kexec_file: try more regions if loading segm=
ents fails")
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026075201.6995=
50-1-ruanjinjie@huawei.com?part=3D4


