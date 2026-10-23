Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA5B606A31D
	for <kexec@archiver.kernel.org>; Fri, 23 Oct 2026 07:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZX4wVSDp;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mlS7bd1I
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3oh2Y/bemdz/uPhF3+vyo9YD4depuAT7LACG7spAd6o=; b=ZX4wVSDppYTeFqzkvlh+kR1wSC
	7L/1IVTxddMC9z+VCJnfArl0XdDg1BwgBGsgMhNW6ejVCfXHreagbihe6npwipgMRcVRu2QjwlWln
	kp/FKGCTSw/6ldqI3vwVI3YmAFJy6pe3DLHyPdekfz+VRjLLqNTUL8YustudgmB6h3Xy5RGI+8Nri
	5hqybko//ff3HuFOQozgqkeCpqRlK2dtiR1o3ibWsRZXbz9RxQDd9xS5O9ZmBxL318hTRxDegvc8W
	8xK7VmYCCywIpb7a6osq2TIaG3EddCvACF4T9pCmbsPdWGxaLTFLkuPaB9aagib9mwoRUP66sqxf6
	qx0UkKmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9xd-0000000FnFv-3sNc;
	Fri, 23 Oct 2026 07:45:09 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9xc-0000000FnFb-31GI
	for kexec@lists.infradead.org;
	Fri, 23 Oct 2026 07:45:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C949E600E2;
	Fri, 23 Oct 2026 07:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5081F01825;
	Fri, 23 Oct 2026 07:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792741507;
	bh=3oh2Y/bemdz/uPhF3+vyo9YD4depuAT7LACG7spAd6o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mlS7bd1IC4T3EWh1dIzIYnNNXtbfgyYupe+ENS+mIRDWlFhpcRs3Zsjk3IqMX/663
	 CMaSt9fHJhWOxuq1v4mmcdSqUq67+75TjoU9wVzulN2AMLxCkxaXGMCVknJ8eaMJ8c
	 /4EdAJe2fomgk2MPbQ60gpFIzj8PLpcEzbuU5+YZVHHWGZr5UrJxUYhTbiUwLnJNJd
	 vPJ6rib0IBtfWsFluftyAmtZ836YHyISGODRzCtKSndVDbjo7xJ88zVw6fK0gMK7ok
	 hZa/AJfW7TNIAap14hnTl/L+0p7tCGbZ01AQrEX+sgShoPH3UXz14cORbFmeJ47Xij
	 i0bGmDN29//RA==
Message-ID: <sashiko-outbox-182435@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] riscv: kexec_file: Pair PC-relative low parts with
 their high parts
To: "Han Gao" <gaohan@iscas.ac.cn>, "Paul Walmsley" <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>, "Nathan Chancellor" <nathan@kernel.org>, "Nick
 Desaulniers" <ndesaulniers@google.com>, "Bill Wendling" <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Yao
 Zi" <me@ziyao.cc>
Cc: "Han Gao" <rabenda.cn@gmail.com>, kexec@lists.infradead.org
In-Reply-To: <20261023-riscv-kexec-cma-fixes-v1-2-825b90ea23c4@iscas.ac.cn>
References: <20261023-riscv-kexec-cma-fixes-v1-0-825b90ea23c4@iscas.ac.cn>
 <20261023-riscv-kexec-cma-fixes-v1-2-825b90ea23c4@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 07:45:06 +0000
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> The purgatory relocation code applies R_RISCV_PCREL_HI20 to the auipc
> and to the instruction after it, and ignores R_RISCV_PCREL_LO12_I. This
> assumes that the low part immediately follows its high part. Compilers
> may schedule several auipc instructions before their users; clang does
> so in sha256_init(), which corrupts the hash and leaves purgatory
> spinning on a digest mismatch.
>=20
> Apply the high part to the auipc only. Resolve each R_RISCV_PCREL_LO12_I
> and R_RISCV_PCREL_LO12_S through the R_RISCV_PCREL_HI20 at the address
> its symbol labels, as the module loader does.
>=20
> Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-riscv-kexe=
c-cma-fixes-v1-0-825b90ea23c4@iscas.ac.cn?part=3D2


