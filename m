Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E989A606A31E
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 17:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XiId3nlM;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q6/Qq0IL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=15t9h6LbDORtNn1gAMhfgttNYi823HLkELbTYPIIfW4=; b=XiId3nlMrs2bKWI7Dakb+OS7Z6
	7Wd+udSq4lWPorTchQml4RreYTOPx8+oWJlxea/deSBkwOFykfAQDfkF93Mgz6dNmdTRu4vO/zob+
	AdGK6hhVRTSvhHvFCeS3PIDDjI0imwjw+oCoFAazpJquELDGWulUi4pYvaiTp2euGVLZ8AUcX1Tv1
	ng4ZydlH1l7wWqkK+6A8sffV+2alvz4eVRqS+Sbg+H7VZHFmC5LdSPIiyfQ/R8FIUp3a+OfhqLzcO
	Y8LPqWhnD6oB63dmGYbTd0W1gUuEV5WowSv5H3LSiAC6PB3gAt1G2EgWO1cU5iMoZ6HrfR+Cy8lKd
	/4qsiJ0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMUDn-0000000A0TF-2bDH;
	Thu, 29 Oct 2026 17:47:27 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMUDi-0000000A0M7-3vSZ
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 17:47:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CD5716012A;
	Thu, 29 Oct 2026 17:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F311F01816;
	Thu, 29 Oct 2026 17:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793296041;
	bh=15t9h6LbDORtNn1gAMhfgttNYi823HLkELbTYPIIfW4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q6/Qq0ILfjGaNTPl1QKIsVV8AL0rTlYa7AhWa9HqK8RK7SvW5rwgjuhqrkMOkqaYm
	 BDPRg0GRzuNOb7AZ/fZ+zlnutPthFsBzZ4oJDMplKxGEo9Ea6xmsRArrtnfEWOnHdy
	 u2428NUeoo90JUElS6VebDiJJq2fqhnd5RdovbKTny4ODpTY9fp18IAvx5Be0f1dup
	 bUSaN+t2rmBGe6YZjRrg0AJ96Y1JR0Ii0jRqdIPS8V26r7VPs+PkQ0adGI7QqpnXCH
	 5/ST/c+WUTfuk+LtrCekcv0qpm/55vCZEbd8G9Md1/MhrqJ0ddp72+mWgH2Ng8Nmmj
	 g/YjHZLlbUCdw==
Message-ID: <sashiko-outbox-189751@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 8/8] selftests/liveupdate: Add LoongArch vmtest
 support
To: "George Guo" <dongtai.guo@linux.dev>, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, chenhuacai@kernel.org, ardb@kernel.org, shuah@kernel.org
Cc: ilias.apalodimas@linaro.org, akpm@linux-foundation.org, baoquan.he@linux.dev, ruirui.yang@linux.dev, guodongtai@kylinos.cn, kernel@xen0n.name, graf@amazon.com, liukexin@kylinos.cn, kexec@lists.infradead.org
In-Reply-To: <20261029172956.20791-9-dongtai.guo@linux.dev>
References: <20261029172956.20791-1-dongtai.guo@linux.dev>
 <20261029172956.20791-9-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 17:47:20 +0000
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> From: George Guo <guodongtai@kylinos.cn>
>=20
> Add the LoongArch kernel configuration, target and cross-compiler
> detection, and include loongarch64 in the VM test suite.
>=20
> Boot vmlinux.efi through EFI firmware so the EFI stub installs the KHO
> table. Allow the firmware path to be set with QEMU_EFI and skip the test
> if it is unavailable.
>=20
> Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029172956.2079=
1-1-dongtai.guo@linux.dev?part=3D8


