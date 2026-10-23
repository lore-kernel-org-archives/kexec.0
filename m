Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D65E606A31F
	for <kexec@archiver.kernel.org>; Fri, 23 Oct 2026 07:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WtwKV3ih;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EitsfFzC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YQM4e21MJzT+25iXYwTywyRRRv9frrL/S2mOl0F2TQ0=; b=WtwKV3ih27JodqcGh665AT0Wuz
	Rh1MIYoOuSUH1IOat0EZWnMcRhGKQ0LF/yvuqk7XjFiDR0z/jppBZUaN78X+m1aNGkn/Ia8uRMXls
	J5hRBgRpogF+KcuNil1ktSeCs90eNUSEkiy7Cgftt0x07o96WaIb057hUFih4V7BWIYPfl6Phh7Zg
	u30XU8oQVx2dQGu4yXJU0+PSeULxNq1htkkycURtUqWbjqzMmLq71sZkLhreOkNjtEVnjpdpZVxHr
	GrlztXOf96nR/jGCiAQZ/LDRag7F2PA7vtFexU7AOIHVMkRPQ8npRKc4CRz41mI/OHbN/VINsH/iH
	7/7RikbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9sM-0000000FmkC-0Ctu;
	Fri, 23 Oct 2026 07:39:42 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9sL-0000000Fmk4-02fF
	for kexec@lists.infradead.org;
	Fri, 23 Oct 2026 07:39:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 18374602CC;
	Fri, 23 Oct 2026 07:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE63C1F01825;
	Fri, 23 Oct 2026 07:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792741179;
	bh=YQM4e21MJzT+25iXYwTywyRRRv9frrL/S2mOl0F2TQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EitsfFzCyRniRAkX5Eca7r5+5Swu1VFhsUNOXdKLxC00cQQzMqofwGLQKAvGG8O60
	 S49hwgaOMb0hCezmQIgYO9GfFv9bwpF/PusHgRaUHYkZ66KLolLQ+tyGt5nStJcWw+
	 07lxe0uzEFvM7LmzTTFzCOi7kUNtC/qmEDhEwjU6Hnhf4SYKCWU0G4a7gGujDTWfDd
	 FvFKgqHU1Zb7mu55BMHISPNtlvk15MJi4NQqU9f5EARqNeFHkt4H5ZV0/OhrCVscmB
	 uVT5Sk081o7wHQVIj9m7X3ML0hphcm+5F6z43OpAjtVb0/CmcrouO46kFre47UC2C1
	 4Lr4vSdFRNQBA==
Message-ID: <sashiko-outbox-182424@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] riscv: kexec: Disable the MMU before walking the
 entry list
To: "Han Gao" <gaohan@iscas.ac.cn>, "Paul Walmsley" <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>, "Nathan Chancellor" <nathan@kernel.org>, "Nick
 Desaulniers" <ndesaulniers@google.com>, "Bill Wendling" <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Yao
 Zi" <me@ziyao.cc>
Cc: "Han Gao" <rabenda.cn@gmail.com>, kexec@lists.infradead.org
In-Reply-To: <20261023-riscv-kexec-cma-fixes-v1-1-825b90ea23c4@iscas.ac.cn>
References: <20261023-riscv-kexec-cma-fixes-v1-0-825b90ea23c4@iscas.ac.cn>
 <20261023-riscv-kexec-cma-fixes-v1-1-825b90ea23c4@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 07:39:38 +0000
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
> riscv_kexec_relocate() only switches satp to Bare when it meets an
> IND_INDIRECTION entry. Since segments may be allocated from CMA at their
> destination, an image can have no indirection pages, and its list then
> holds only IND_DONE. The relocation code jumps to the physical entry
> point with the MMU still enabled and loops on instruction page faults.
>=20
> Switch to Bare mode before reading the first entry, converting the list
> pointer from its linear-map address.
>=20
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-riscv-kexe=
c-cma-fixes-v1-0-825b90ea23c4@iscas.ac.cn?part=3D1


