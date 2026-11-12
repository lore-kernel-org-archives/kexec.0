Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7D1606B5AF
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=d6tlyt4W;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QknDstmT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=HcSyYyL1aI9yVXJRMG+8rB80N8c/m6fAmhL+0qfSOuA=; b=d6tlyt4W+V3aXBnHJqIUcD1pHf
	c/lJVyBzPmdA0IuaQG7Jj1P3JAdXE/Uekw9GNgIrXK39X+LfU96Ff0uqxsyNCCQNQtGyDW+g8Q3Rd
	mlLn+CqTFg6ODj07C2MtljRvUNg9zbmpmwW8j1pXjyw9CmHrri3f9DIajdt/2dD4VtERODoXQTgfx
	yql4HFmr8Uv5O5ZDu/H12WqvKb20WM/SJ1A5k9xS0EZoyavzYSiUxQdi5U9wEwdCeNXvNGyXXQvws
	+KQ9z0jFrLu/T/CfcBRwivNsF9ekAGtfdZhlwuB97Mjsz4fZhq2yCCqgCwrQIpjxatxDRsJS7WHkD
	Z3LZ+9hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRT17-00000009jFa-07Vg;
	Thu, 12 Nov 2026 11:30:57 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRT10-00000009jC4-1Nrx
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 11:30:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CDC5B47A28;
	Thu, 12 Nov 2026 11:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2626C1F00A06;
	Thu, 12 Nov 2026 11:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794483049;
	bh=HcSyYyL1aI9yVXJRMG+8rB80N8c/m6fAmhL+0qfSOuA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QknDstmTjHUe2g2R+kyYKGlBriyS2a4Uaeq26iu0MVr7nAqXkBqRJm95OllgWyogK
	 2pshuhOVzvX7a0eVzPcPG+abvrFTlZnOh3J8M1tUTUpLDBIa/8/Ydoeiw+PXTeeAHl
	 R/lkZV0xGNBwFy1qGt9egZrBHDMlPxGgncLhKcdRUWAMflnChj5Qow6i9c9D4CEiIo
	 2Xwo0g7g93CRBm7A0cT5OS1V1C67/MdvyEVBFLMosVN8HJTnYmDGlrOoXL+NtbVzO/
	 2XYQQyIvvzR678w2Fm1bNPVA5piWw4nFE+DulCO95qryAHbmWL5uz5jac1F321YcEy
	 kDCMN/TNt3yNw==
Message-ID: <sashiko-outbox-211019@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/8] s390/kdump: Exclude crashkernel CMA memory from
 vmcore
To: "Mikhail Zaslonko" <zaslonko@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Ilya Leoshkevich" <iii@linux.ibm.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Dave
 Young" <ruirui.yang@linux.dev>, "Jiri Bohac" <jbohac@suse.cz>, "Jonathan
 Corbet" <corbet@lwn.net>, "Usama Arif" <usama.arif@linux.dev>, linux-s390@vger.kernel.org, kexec@lists.infradead.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112112105.1169118-6-zaslonko@linux.ibm.com>
References: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
 <20261112112105.1169118-6-zaslonko@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 11:30:48 +0000
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

> The kdump kernel will be using the crashkernel CMA memory of the
> crashed kernel, so it must not be a part of the dump.
>=20
> Keep the CMA ranges handed over by the crashed kernel in oldmem_data.
> Add them to oldmem_type next to the crashkernel memory, so that no
> PT_LOAD headers are created for them.
>=20
> Merge adjacent regions, such as CMA areas placed back to back or next
> to the crashkernel memory. Otherwise for_each_physmem_range() returns an
> empty range between them, which ends up as an empty PT_LOAD header.
>=20
> Use the original ranges even if mem=3D limits usable memory in the kdump
> kernel. Build the list without depending on CONFIG_CMA in that kernel.
>=20
> Co-developed-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112112105.1169=
118-1-zaslonko@linux.ibm.com?part=3D5


