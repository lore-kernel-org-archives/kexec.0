Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA032606A31A
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 10:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yLMAqIH+;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hst+uhkS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=g4DN24j40brmrN4uBgQiFGu/cWdEdzrddp4v+1GkqBo=; b=yLMAqIH+il+rqLEIuouPJr0NeY
	DcCb8s7xzz+1RCT+02u9iyjOhs72peGZX3bZ68Do4CEOQ3TlUajza9/HONF/x/oLtA1NB0QZDkTxv
	3FiWStWaEOCTGbZO8BxGVBNfmJdHPNhZuRVFiCrFCqLm8WecBVQDJUbL4XZOLqMK1QRp9e2e8uKDb
	dySd00f7N1CN5hJjaoe1E/gGql4rcEnRcW7XvBIAR5Xat8Czp8rK/6hRRaj/ocB7PeHq0nChihSKT
	E22kaZpauugyutxaFi21oUVuD54V92ap8sTeJBKHuUbFL7/nDxrqOLdloSo6b1nfl4NIz1fteF+7u
	SQD0FZSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLIA8-00000002HL8-0q2y;
	Mon, 26 Oct 2026 10:42:44 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLIA6-00000002HKx-3c12
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 10:42:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4C36E600CB;
	Mon, 26 Oct 2026 10:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C103C1F01825;
	Mon, 26 Oct 2026 10:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793011362;
	bh=g4DN24j40brmrN4uBgQiFGu/cWdEdzrddp4v+1GkqBo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=hst+uhkSptOm36lVsjnRKTAfAhZGCHBlDrq0S22VN7FrEMQOBUTRzrLfI3a98NxN/
	 +ZvgGeQ2DKjajlDLRmxNNqmZhSVWXEObeK0DzFu5S6by0zCB/8TyPJKMqcuktX4lta
	 KKISF75oDGXxQeFqm1QGcu8qL1ywtdEfQtoLyY+7wvoiG7q0GnH0FjTzA7bM08n3qW
	 7dPyRWVYs8J6LixPZ/EaR7uM75CFrGgafEf5j+rf+dFhRuYk3SUwlrJ7/QDsoL/5x1
	 HmgY+7/UOj0yP4yrpUS5B8jIhv/5myQozwIOg/KfqFa167W8iEEJFL8z1/5f5roYzJ
	 OMUEbfcll2s2Q==
Message-ID: <sashiko-outbox-184994@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/15] riscv: kexec_file: Simplify
 load_extra_segments()
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, thuth@redhat.com, leitao@debian.org, yeoreum.yun@arm.com, robh@kernel.org, sourabhjain@linux.ibm.com, kees@kernel.org, coiby.xu@gmail.com, Yeking@Red54.com, tangyouling@kylinos.cn, maqianga@uniontech.com, zhangtianyang@loongson.cn, guodongtai@kylinos.cn, blum@kernel.org, adityag@linux.ibm.com, hui.wang@canonical.com, sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn, kai.huang@intel.com, kas@kernel.org, vishal.l.verma@intel.co
 m, piliu@redhat.com, jbouron@amazon.com, mclapinski@google.com, me@linux.beauty, graf@amazon.com, bgwin@google.com, x86@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261026075201.699550-11-ruanjinjie@huawei.com>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
 <20261026075201.699550-11-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:42:39 +0000
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
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026075201.6995=
50-1-ruanjinjie@huawei.com?part=3D10


