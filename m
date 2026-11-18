Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F3D606A31C
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zYgFPH6J;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ij+miuSd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1PUGNwQH3OsRQ1PYsXgSgQ+MYeE87BOtnxhiVn3nsD0=; b=zYgFPH6JJNC73QEfV3VdtoUG2v
	BF4zreeVaPnG1zrfrF/v7+pnUTiSXEh+GlhrlzXPlwLYM6NV6slJyMeVAle1PEBfzaohzCUTgYQ1m
	H5bpeYqPz3yrwRZVvqO/2MlUPsbSJypzEKuO/E8RyjiDGwxJk8Gv3tAJ5+AKQGeDTA769SAAKvImY
	TaIWBZ/FokWGWJte6LdbKZQ1pUPzWlOtHXbuSQO0j0mmiyhNU+9KJiTbHUMM98OxBbhSmpoDbrZnh
	4fiZLFXX5dF4a6OnQ1v/0qhYWYmpmMa3530Efl0HJnH2+owTuwfrD9UExSTgpxHAWMR9SyHjX5xFI
	7MgtZ65w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTcD2-00000008Prq-1doJ;
	Wed, 18 Nov 2026 09:44:08 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTcD2-00000008Prd-0FYx
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 09:44:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A8EA8437FD;
	Wed, 18 Nov 2026 09:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E2E1F000C4;
	Wed, 18 Nov 2026 09:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794995047;
	bh=1PUGNwQH3OsRQ1PYsXgSgQ+MYeE87BOtnxhiVn3nsD0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ij+miuSdCEy+efWXLx2Et/eAT9Ym9MXxHFc2fo8Gam8Fi4sdn+l2Vkct3U0BdnuEu
	 EtRE7B/ed9eMfm5efxP73jdhNpKD/0A3lAW2RmqNCNKlSKavAr9Lxjx67YBC5Ti6FD
	 mYtMlmjy//GOxbfrCa/4xWDQg6Mnl8Clb5QM8JagfCZlP/WyfUNd0jkicxtZ3NaRcM
	 3DgNUdJe56xBpvSoMsMQb7WmGtHi8t3azRlIddUKL3cdE/3SwWjU+Z9fO9s2e6rp48
	 QYhWWUtgOe95EjY4QqR9cUNRYAN1xgWLaa5UBwc7A2ICfyq0uw1+SBP6u4ZJQKcQ9B
	 H7nPgWTyB2YvQ==
Message-ID: <sashiko-outbox-220613@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] riscv: Call early_ioremap_setup() before parsing
 the DTB
To: "Chen Pei" <cp0613@linux.alibaba.com>, pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com, shuah@kernel.org
Cc: guoren@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261118091603.979-2-cp0613@linux.alibaba.com>
References: <20261118091603.979-1-cp0613@linux.alibaba.com>
 <20261118091603.979-2-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 09:44:06 +0000
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

> parse_dtb() can reach early_memremap(), whose return value is composed
> from the slot table that early_ioremap_setup() fills in - and on RISC-V
> that setup ran after the scan, so the mapping came back NULL. The DT
> based kexec handover parsing is the first caller to hit this:
> kho_populate() cannot map the handover FDT and the handover is dropped.
>=20
> Run early_ioremap_setup() before the DT is parsed.
>=20
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118091603.979-=
1-cp0613@linux.alibaba.com?part=3D1


