Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6E7606A31C
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DhuVWaj0;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A5q3SYIV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=s7i6JdBwQQPMq7nuqWGD2TbVytoZLm3o9kopwugOm/g=; b=DhuVWaj02Us32Wn6ae08OZGoGW
	124kPG2563OFBFXfWUr0hNKg7Jca9L5I9TgoQ8MN5/OECcc8/3vtOYfejqpKM60+J0Dg9foy/NzFa
	6NtFNHL5RlxHf4gG3iYB8cYllERlMSs9O/cQM4jkSm5HZ3v4V3xcNx3ZcBkaKWOsFcqd8MKOhWhZH
	VnxM1vGY4F5z1Jr4Q5PraWObj/Y0JN6acl8xfkffzzu2TTrV6XYdDxQdPB5Lg5+7q1i469+7Cipg8
	iCsFFNCOFSbXOT4Yb0kEZGnl3Bg2EByAyBTQFJ/vfaQ4AWKiSXnukVKFC7MTFgnzXk2im++FKW3ka
	BiZxl+/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTcD9-00000008PxC-3Tel;
	Wed, 18 Nov 2026 09:44:15 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTcD5-00000008Pt5-3RkR
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 09:44:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 15ACC62055;
	Wed, 18 Nov 2026 09:44:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284591F000C5;
	Wed, 18 Nov 2026 09:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794995050;
	bh=s7i6JdBwQQPMq7nuqWGD2TbVytoZLm3o9kopwugOm/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A5q3SYIVLhT6ViCgKmwHt4snBTBXfDf55t5yArPoGF4dO5V/7/REFhvRxrcDdlGGT
	 vNbs553NZL2LhVerceGY78MDn+8phuqaJETuSgLYyiI+xyp3+Am2nb4ciS0mmN7HwZ
	 p1XwWyN1cBhFiaLLegGQF8YuWr9vC0TqBE0A5lGwAowphCJTW2moNpW1BEVgCmW9gC
	 /xWcd+yRYaEXDCWu/Tx03mjFOmCSkZ3hEkBKS/jfKDozNy+XZ0PHdE34fY2vXI23xP
	 q52hsYmCg3RkfFXf43IZdu8MI0W9xXddawkiGAS33mow2DhJchso6Z7YLNFR9EgAQA
	 3mIvWz4H4Mq3A==
Message-ID: <sashiko-outbox-220616@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] selftests: liveupdate: Add riscv support
To: "Chen Pei" <cp0613@linux.alibaba.com>, pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com, shuah@kernel.org
Cc: guoren@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261118091603.979-5-cp0613@linux.alibaba.com>
References: <20261118091603.979-1-cp0613@linux.alibaba.com>
 <20261118091603.979-5-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 09:44:09 +0000
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

> Teach the live update vmtest runners about riscv64, so the LUO tests can
> be run on this architecture.
>=20
> LIVEUPDATE depends only on KEXEC_HANDOVER, enabled for riscv64 by the
> previous commit, so nothing in the tests stood in the way.
>=20
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118091603.979-=
1-cp0613@linux.alibaba.com?part=3D4


