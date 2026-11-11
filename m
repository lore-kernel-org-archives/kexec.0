Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DB660A260B
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 06:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Z9TdV5Uw;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lGLbcZWz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=d/MMAJz7fPUWKJ+xXRqo30isYkVkO2GdfsJRyXHUMBk=; b=Z9TdV5UwV0lhamag1kiABZzDxg
	MeyeS5yJxh1hRKGevlAnS/nRNk72P4m40yJ/mruoygNLt5LksFAVdeT1HHwFJA1Csyb6tVMrqlIYJ
	19DShLtZ7o99W3RScP61O+0KCDkifWNfElYE4uGr2A8IKvrXXtkHqIueobv/PCgZzKQGO9HgvR73F
	0kDhnDtyz+j8uD7Ij+Ghvq24rql/vPnBPac0Jwpb3+zjPjtI8JVKA+s8+nCOG9oeOXP0uedO5JBf+
	Os7maTneEUdjtEELQTLB5boISOZkNlJk5EtGwzB5aTgYEklSf3OL/aPmcXrMmApfMqyjofj/TFGS7
	XEcbmSog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1de-00000005jJK-0vNO;
	Wed, 11 Nov 2026 06:16:54 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1da-00000005jEg-3nuP
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 06:16:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A4C0844723;
	Wed, 11 Nov 2026 06:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5960E1F00A11;
	Wed, 11 Nov 2026 06:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377810;
	bh=d/MMAJz7fPUWKJ+xXRqo30isYkVkO2GdfsJRyXHUMBk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lGLbcZWzIQLNcILAgK9z4kCUV5DLibJug4MsbVCyGLhKi2DGgLvIn3yRlglWLeoR6
	 qyyr8lWnV6Ajl9JIFL/05z1O5740R4WOvnsM3duuNu5AOJ94RszFBqN0FtD/76C5Sc
	 TkVaViPFMCFvqqum+9sBD/VSQjy4dfqqwDp3eAAeb2AIJY44uLcOvCRNy7DLfVC35p
	 Hm+5CSft28qVyvl0Fn6iLasKGb/dD7pyPkjRQbaUUOjgO/A4LjDgzeWqfZ7HfI7ElP
	 XbLhyZNwBeP630X8MfewxinhrGEal+QcXLeni2GuzmF+XP1g+oYgtqDf8K8B/Zia3y
	 wJjsWdxSg9tMA==
Message-ID: <sashiko-outbox-208416@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/19] liveupdate: Add feature header to struct
 luo_flb_header_ser
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-14-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-14-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:48 +0000
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

> Precede struct luo_flb_header_ser with struct kho_ser_hdr via
> DECLARE_KHO_SER so future File-Lifecycle-Bound (FLB) header features can
> append fields to struct luo_flb_header_ser without breaking compatibility
> between adjacent kernels.
>=20
> Initialize the header in luo_flb_setup_outgoing() and place the outgoing
> entry array immediately after kho_ser_size(luo_flb_header_ser). On the
> incoming path in luo_flb_setup_incoming(), validate the feature header
> with kho_ser_validate() and locate the incoming entry array at
> fhdr->size so entries remain properly aligned even if the source kernel
> serialized a different header layout.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D13


