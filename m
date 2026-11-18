Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCDE606A320
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XtUObOkL;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=id+XqXBl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=CzZ9Av/3wS7z6KydxH5rNyXx2HhScCX+vojD4NTXzJE=; b=XtUObOkLgIHNf0V/J45Iq/0zB4
	yABQlVDHGQ1WOpuZoRUiCvzEoO6v4cHuaw2+HaO4Ud89KaCDRoUYvkxLjxubqh9b8xapx++bRd20s
	ZDwAivXHWvuzT+CHK54KNPmom8Fk2OT1HaMZdlqrgWP7u0JI8S2Ve3EQQBUpMlO9AiQJyiVII0JNv
	eT0SV9TyirYnymjHjldZCXkvTepv2v++a12bUZHEyzieHBx86pzknncIBPCCgpapBPE+X9mXEj/qK
	TMH7La2oL8Jgnllz67Nihp6ds0nAArt9j6g4RgUoGVNGtt4GsVqqGHDb+oTIvRILDmtzobkflr6rP
	ORrcJ1jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTcD5-00000008Ptj-2v9m;
	Wed, 18 Nov 2026 09:44:11 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTcD4-00000008PsO-0nZB
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 09:44:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C0A0343F2B;
	Wed, 18 Nov 2026 09:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F101F000C4;
	Wed, 18 Nov 2026 09:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794995049;
	bh=CzZ9Av/3wS7z6KydxH5rNyXx2HhScCX+vojD4NTXzJE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=id+XqXBlLOt5LSBIS1KMRsH4q7DvdsNbyJMmpTo8+OPMBv0M7RkFmErIcQN0jSO/J
	 mqDgyuFvkdrVlJszDQpIzpfCafRiETrZnpZMMOkdoAsRxSHyNVOQ+328E3yPz80Dk4
	 sEjIV70qhWGIfLjHYORJW/snddcfUaP2ZMH2L70ajO/LrAYTEvw0iUJpPRpa/mi75C
	 wt6NVkUI3PmKQIkdMb5VGk6ZHrxgLSOovjIevVInwZBaxtu0JbcY2IfxxQgWJm+Ryz
	 T9NpmNZhZTnXDxclYpJTc4h6rsrnuZiboKjJl0gFVGAi4fTKpKJ3klLl+nmefLHVWr
	 LtwWnaqQsLy6w==
Message-ID: <sashiko-outbox-220615@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] selftests: kho: Add riscv support
To: "Chen Pei" <cp0613@linux.alibaba.com>, pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com, shuah@kernel.org
Cc: guoren@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261118091603.979-4-cp0613@linux.alibaba.com>
References: <20261118091603.979-1-cp0613@linux.alibaba.com>
 <20261118091603.979-4-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 09:44:08 +0000
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

> Describe the machine the KHO vmtest runner needs to boot riscv64, so the
> test stops being skipped on this architecture.
>=20
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118091603.979-=
1-cp0613@linux.alibaba.com?part=3D3


