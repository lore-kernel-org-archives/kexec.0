Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39266606A332
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 07:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=z+b6c3JR;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bvbYk8t3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Nfqi5UHTaaz1n9/Aibwz/SGhnCFYc6EGe3usKVP2bg8=; b=z+b6c3JR5CyIij4GlnhlU5L4m+
	A4VfH0JrcSyH46Y4/Z+Phc5q1LfAMflNI6JhfjbqtvAOmNVhJ5MQplzd7eTTB9icy+/Joo8YiCKBm
	q1NJRl3Ob/ITnByWQY7uUpcBGDxoK7luNiyCUpJgaQecWCd3dUOQC6B8VdhlvoMRs6lbvS+quYav/
	rNeyI0rwKl5c6OTIng15foM1f1K24f4r9OfCtosO2xYKTPDt3KEUpqx9lPvpuLTKos8ii33HH9XwL
	7YxIs3xC1+pS3Se9T58ZC+bsbsP1zRbByna0RqZ8HroTSN0T4jYGyaSiSDOJh6Q1TB/nkIIRQ0Zuf
	PsPQ8JFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRPdh-00000008yyZ-3xML;
	Thu, 12 Nov 2026 07:54:33 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRPdL-00000008ymd-40UR
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 07:54:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9DD5643A55;
	Thu, 12 Nov 2026 07:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06721F00A05;
	Thu, 12 Nov 2026 07:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794470051;
	bh=Nfqi5UHTaaz1n9/Aibwz/SGhnCFYc6EGe3usKVP2bg8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bvbYk8t3BSqSIHNXZiAMkaV+7LlqvA3WAgx8X8A2l1utDH1im2H3ZE/40AotnuvZn
	 6yKLUPJDN49sHZUlZnzxgPNH3fg3hC91Qnqbfh8EUpkPQfKx+kltuFk4RVkWTSVBvQ
	 6pckFQOIAvwwjUVi0NFbCn2rQAGzl4eIS/GZ7Q7MUa6nX7u2KAf/QJeK7hXcptC821
	 EBceBcMhTm2a+Jmk31M67RkvAHBjT0mN7ofMPt7GJkugZIAGaRvgTEtuO0ymxfl6i8
	 7X+kOMdYlN1lg5a+xL14k2VttzriIrifNFqiUTXRPUYu1z0F9ZnFjzPbpYMjTM4Eb5
	 guwkQHKB61bSA==
Message-ID: <sashiko-outbox-210641@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] selftests/kho: Catch missing or zero bootmem
 reports before kexec
To: "Chris Down" <chris@chrisdown.name>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>
Cc: "Alexander Graf" <graf@amazon.com>, "Baoquan He" <baoquan.he@linux.dev>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, kexec@lists.infradead.org, kernel-team@meta.com
In-Reply-To: <2edf50f498070047a363420b890cb7ff0294b87b.1794383544.git.chris@chrisdown.name>
References: <cover.1794383544.git.chris@chrisdown.name>
 <2edf50f498070047a363420b890cb7ff0294b87b.1794383544.git.chris@chrisdown.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 07:54:10 +0000
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

> The KHO vmtest can pass even if the bootmem size is no longer visible to
> userspace. Let's fail if /sys/kernel/kexec/kho_bootmem_size can't be
> read or reports zero on the KHO-enabled boot.
>=20
> Signed-off-by: Chris Down <chris@chrisdown.name>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794383544.gi=
t.chris@chrisdown.name?part=3D5


