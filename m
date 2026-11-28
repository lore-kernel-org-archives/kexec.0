Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30793606A324
	for <kexec@archiver.kernel.org>; Sat, 28 Nov 2026 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=E8SeS7YK;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KDGxkGV+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/B15Sp5D9QEclNjSRfRpvgxUrFjuq5ek0G2Pp9pnvv8=; b=E8SeS7YKdLhqMdJhznZ1mCUr5g
	aNV1RcQ6aJSwrI6bN/ymlaUZjnja7wjGg7gTqs33rY4D0E3l+b/A9MML84DvPRnU4PKiqOUwgfKtS
	XkAY46AaCC2MEFGe06pymZ56dNPWKIVTKI6jWhz/ZwqOnd06gRA/MaUutFDzwh7f1FX+PdkBDFNOu
	vauzu10+fgjGTXGDHCQDlywbICsieTaRdHTrnOdkw8SVse5GGO0GwMGTK2g5auMhwJEHUznJ1dxxD
	2VpYw28iRApT2rjQ9OjYQngtU2X6bt6fNFCRJOhFi03jn9YXUUVhpJsAPGe8yEqsavG+nJ/NGK9Yl
	QWdXuGnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXEWv-00000000ZOB-0N0v;
	Sat, 28 Nov 2026 09:15:37 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXEWt-00000000ZNy-1czL
	for kexec@lists.infradead.org;
	Sat, 28 Nov 2026 09:15:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E80AF4482D;
	Sat, 28 Nov 2026 09:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A18E1F00899;
	Sat, 28 Nov 2026 09:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795857334;
	bh=/B15Sp5D9QEclNjSRfRpvgxUrFjuq5ek0G2Pp9pnvv8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KDGxkGV+4/kxi6rvKGzSvwO6FFCRMWmWMsqX1Q+KdBuYJ2LGNhLrgrHS3jvLe/n07
	 cwf/ZCLrr5uzTsExXJHDkVwYlGLAiizbaR+YkDH6pSRoLyZyEPqMrggPq9SNqoIp0f
	 b9yTCVdW3VbpFQix4M5riE00D0C+1qUfxPzH6vtANNGte0ISZ8abFvY3JZmATOI7eb
	 QMGuzv+b/aHBNbTgfb2+E870KJhhvQpPJmhmTQrr2/RCGbT44v7Rdi/WGZNrQnXap5
	 EjbEiIhkxT25pgr/gxTY82/4Feq/tl7IBavMenlbYn4dEbRxhNBfV2ftaqN2E1Z7Kr
	 fEzQzxXb1cIIw==
Message-ID: <sashiko-outbox-238580@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 0/8] kdump: reduce vmcore size and capture time
To: "Wandun Chen" <chenwandun1@gmail.com>, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, robh@kernel.org, baoquan.he@linux.dev, rppt@kernel.org, m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, saravanak@kernel.org, akpm@linux-foundation.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, robin.murphy@arm.com, ruanjinjie@huawei.com, kexec@lists.infradead.org
In-Reply-To: <20261127090723.741253-1-chenwandun1@gmail.com>
References: <20261127090723.741253-1-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 09:15:33 +0000
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Sashiko has finished reviewing this 8-patch series:

- Patches 1-6 and 8: no issues found.
- Patch 7 ("of: reserved_mem: mark /reserved-memory entries with..."): 2
  potential issues (1 High, 1 Medium)

A detailed review has been sent as a separate reply to patch 7.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127090723.7412=
53-1-chenwandun1@gmail.com

