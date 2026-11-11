Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8390360A260A
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 06:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IMKEK20z;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHdllNx1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JZ2AEmQ7pHHLs/eRI52uhacUy5GcrVT3hL0SVdey+uQ=; b=IMKEK20zWgh7SbJ22huCN/ttAs
	AuqM3HuYO+KEE7CZKeXhDY9ys/6u38EIIbKijLVeWsahICoADCZl3ulNTdj/k9JcC7JIq8bhpF+JS
	NLdwSyhgJWsVn//Tj9nehHRzu1yE56OgHlJRycFtT4y5PGtQxZ2MdrVV3SDBIr3x/3oIqG3NXsulL
	g0MJzJZIakBTTq3wC4ojTH01YddvJcu7QTFe0g/XpMyX+NgDircDHbJDpuHFY+inEfkGJTqKustwl
	0nyURw+FjJKWY5nVb1VNWtddzkMKxnjDxrkK7WWpfqluZibCJopJo8OhGkVO8DGJg+1GiI0cdmqj3
	200e39oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dn-00000005jVK-0n7N;
	Wed, 11 Nov 2026 06:17:03 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dl-00000005jTR-3KjW
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 06:17:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8677C47313;
	Wed, 11 Nov 2026 06:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C131F00A05;
	Wed, 11 Nov 2026 06:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377821;
	bh=JZ2AEmQ7pHHLs/eRI52uhacUy5GcrVT3hL0SVdey+uQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SHdllNx1jfhZK165QTWy5svLHO1Wrs92KBgBpcp/hyaqZtbxG4U8BLvJYbMRW9qGM
	 s4t2QjnyGXZ/pMjNJ/TuAywgaGGqGXEkNjMkqfXB4VxrdNJULOXupe+FF3vWAzuJ0v
	 jFjzJFjd5PBAOikclL6WewLMFAqE5SUiyMCev8rAqVK/uOXCAR+qfKWqBc6MlrJAba
	 a3sGK3cC8EXS+0Ocjbv6rjDiRQwtxPfIBtvio7FfUQe70+K/dv6b1bz700gfFhUgPb
	 RP9Ko7whMcRUDM5TQ4YJXS6LGt8lCxB4V8L1yM/9U9oNgyYTscAOh2a3jEfbMe9J1+
	 MmAvwqExyicqQ==
Message-ID: <sashiko-outbox-208422@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 19/19] kho: Add KUnit test for the feature header
 helpers
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-20-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-20-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:59 +0000
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

> Add a KUnit test suite in lib/tests/kho_feature_kunit.c covering
> the Kexec HandOver feature header declared in
> include/linux/kho/abi/feature.h.
>=20
> The suite contains three focused test cases:
> - kho_ser_hdr_zero_flags_test: verifies zero-feature header
>   initialization, payload sizing, and empty feature queries.
> - kho_ser_hdr_set_get_test: verifies DECLARE_KHO_SER structure sizing,
>   header initialization, payload pointer resolution, and 1-bit
>   feature flag setting and retrieval across flags entry boundaries,
>   including out-of-range queries.
> - kho_ser_hdr_validate_test: verifies __kho_ser_validate rejecting
>   unsupported required feature flags while ignoring optional flags.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D19


