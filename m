Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7788606A332
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sWqOIie5;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lRWyLjuc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XpUjgykRN0vFDha3zJ8L+z/s5zYun/eYAgoPua1NoMA=; b=sWqOIie5Cg5n8NPL8mianagjHt
	UwsdpfI7W2e2aDqkDCj5Zg5fG2ZDStJnlGoIPWVb8a6lIFUqHCW0bFaj6GrfGRPcjwmcaSlt2hMol
	bbdqb5x6+tV/ZvCIuKcJGimxjzRHPepNYHEKM63c/MTfl6ENo7gHCZ3hK28TtIclBO8CFkTvzelZU
	6EWSFsEMj23hKr5XZOmyslWg4mOqLQLeIhlCTW0HlHsdcGeaC9Uoj0V2V47qxBL4Ocf2A1CmF4CFo
	kfkUBlFrAbG81oSNg6tFPIYhkuVK3oxub4DsPLKLw1+0j9eFC8WQE1P4BiO2LOrbbEGAmbtILM7N+
	ronPDQ8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dO-00000005j0x-2hyz;
	Wed, 11 Nov 2026 06:16:38 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dN-00000005izj-11H2
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 06:16:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6389F630B6;
	Wed, 11 Nov 2026 06:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D372B1F00A0B;
	Wed, 11 Nov 2026 06:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377796;
	bh=XpUjgykRN0vFDha3zJ8L+z/s5zYun/eYAgoPua1NoMA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lRWyLjuc4FqV1ZiNtvfr7F6uvGFhyVzqgThcTe1+qsr8fb9XeRBjhQMREF09XUmd9
	 NO+GYZidhttYb6TPwGnmncqvDO+xfoInFX1T9wXihWIZ+yux5utnpLx/A1FAqjDlyB
	 OGBO4uNIeNIW/tyifSYQzJMCT0CH2tQZ2vr8HObe/BcEELWg9hhmTA/ycvXwiyoTk7
	 q5eWxl3V4b7EEhUeYCy9ZJ4JOWIzi4T5/MHmr2Oivl7C/TAeecu3zX16Le3yoCubyh
	 7ga0WzRSvV+/Bl/TZ2f5jeT/23MKETwOH/qFG0U80sLuLpIa3mPULZ7pjtenMWbEPg
	 Vm2dT4qMunoWQ==
Message-ID: <sashiko-outbox-208408@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI
 compatibility
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-6-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-6-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:34 +0000
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

> Serialized structures in KHO and Live Update Orchestrator currently rely
> on whole-structure compatibility strings or monolithic version fields to
> validate handed-over state across kexec. Any change to a serialized
> structure, even an optional additive field, requires bumping the
> compatibility string or version number and breaks live update between
> adjacent kernels.
>=20
> Introduce a generic feature header (struct kho_ser_hdr) for serialized
> binary structures in include/linux/kho/abi/feature.h. Each subsystem
> groups the fields of its serialized structure under feature indices,
> starting with index 0 for base fields. When a subsystem adds a new
> capability, it appends new fields to the end of its payload structure
> under a new feature index. Retired fields are kept in place so existing
> field offsets never shift; if the type or format of a field needs to
> change, the existing field and feature are kept intact until retired and
> [ ... ]
> layout while deserialization helpers follow the incoming header.
>=20
> Suggested-by: David Matlack <dmatlack@google.com>
> Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D5


