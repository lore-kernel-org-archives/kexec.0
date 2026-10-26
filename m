Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FDC606A324
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=K3MC9Jld;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QBugq0EG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=eAoTNaLwL2E2edNXYKYZ6VDBmKUkoeqL+LbHU2JVfUw=; b=K3MC9JldtDDXW/PNWGcKMbe9g1
	lmOXNRKZOSpJF3AQrrRx/LyD6VW7QiW94EkJcfnu+T4xD+An/Zb0XMNinp5b2A6m8OR2Qh0dj4dI0
	O8A8Rox2HukFkfZptm8pqSRtsLG131wj0AexwKyHLqGqgob6l1CwE8bC03j9fE7DArKjc696uV7IE
	hrgfxTaX0/J3lV/t0xsGVklV3MHnENmIVIX/rDX1ctvdeUsWFH2/lhnw5lq6F52fJLQoiFVrFia75
	+DZSIXQXksO/L2wEQX9I7Bo6IM59K2W9vCoTUehLu5RVIFlGm/DARbbUIrohKIPCEqeQEeBkaCySe
	KF/eBXlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLHzr-00000002GjE-3FM4;
	Mon, 26 Oct 2026 10:32:07 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLHzp-00000002Git-2a17
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 10:32:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F27D1405DC;
	Mon, 26 Oct 2026 10:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB761F031E4;
	Mon, 26 Oct 2026 10:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793010724;
	bh=eAoTNaLwL2E2edNXYKYZ6VDBmKUkoeqL+LbHU2JVfUw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=QBugq0EGnUp9tf9wx47k9Ku8a/eOEl27Nsk2DOxX31d7CoQlMZpo8YpMtOb04ncNr
	 wpJwiSEG0ZDw/REIo/9xut5RH5SJD2tulMx5pBGvvpSvpB3FLUE1DYJ5vAvA/vlH6B
	 JU5cusdlZkGGeVXyiTkXAU8G8KUU2U4F5/MWbwKVZ/io7xI98wvctsRKK6KAqgrMpz
	 j7mHEa+AWxJH1QVDH6gjglP7oKFQJeqBQCY990GFkXyLuT+BFAgU20K6q04lvCewGI
	 tVcNdalmkrWZqua3n92GKkXOHrrq+e6ytYao2MbD5A9dJSJCT86vPoN41RF6IOu6Gn
	 +cNfg0bFUZpbg==
Message-ID: <sashiko-outbox-184955@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/15] arm64: kexec_file: Simplify
 load_other_segments()
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, thuth@redhat.com, leitao@debian.org, yeoreum.yun@arm.com, robh@kernel.org, sourabhjain@linux.ibm.com, kees@kernel.org, coiby.xu@gmail.com, Yeking@Red54.com, tangyouling@kylinos.cn, maqianga@uniontech.com, zhangtianyang@loongson.cn, guodongtai@kylinos.cn, blum@kernel.org, adityag@linux.ibm.com, hui.wang@canonical.com, sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn, kai.huang@intel.com, kas@kernel.org, vishal.l.verma@intel.co
 m, piliu@redhat.com, jbouron@amazon.com, mclapinski@google.com, me@linux.beauty, graf@amazon.com, bgwin@google.com, x86@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261026075201.699550-9-ruanjinjie@huawei.com>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
 <20261026075201.699550-9-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:32:01 +0000
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

> Pass the kbuf fields to crash_prepare_headers() and set elf_headers
> before kexec_add_buffer(), so the error path needs no vfree()
> because arch_kimage_file_post_load_cleanup() will do it.
>=20
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Breno Leitao <leitao@debian.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026075201.6995=
50-1-ruanjinjie@huawei.com?part=3D8


