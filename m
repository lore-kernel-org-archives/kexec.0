Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747DF606A323
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 07:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CxATBrdS;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j9h6CfXR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/VckeByaIlUE9XmBzf0OTh1j8X9sYW3LSD4QV2EGrbU=; b=CxATBrdSMVsxFbMKAYumkFsRJm
	ayVB1qWz7e6EsDyEVHn1cMbQciGKc1JbFlcRWnpRxd/QRQLRIO3bk+YUCGKWWKfqAFfdNtXdZJbCM
	3zD8hZ7Th93d0O8rSHxeG8VZ58OE6UECkIhdA7yVouzKtwtCEEP9gxRYCSigkBi9voU6W8NZ0LlgD
	iL8L5DoAbSYpznN9uaEIh3n3t0XLDXCf5/VLG87ZT9qVYk0KVRE1gH+zFjsVKXzlwoJbdEgqAAhUO
	fgfpDK+hy26GQ2+lBuqcMOA2SfXwoc4MHcnslciE1DTjKRkG6If7DcYzZoHQwSMWBp9PPCRVsbo47
	Rdz71XCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRPdK-00000008ylp-0184;
	Thu, 12 Nov 2026 07:54:10 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRPdI-00000008yl0-2MNo
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 07:54:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AE46A6372E;
	Thu, 12 Nov 2026 07:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2A51F00A05;
	Thu, 12 Nov 2026 07:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794470047;
	bh=/VckeByaIlUE9XmBzf0OTh1j8X9sYW3LSD4QV2EGrbU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j9h6CfXRX4B+fmGQCrMZy95ng1/IbKts/ADqHebQ1teAVNJ980TbmwUzzG6vvM0DI
	 74xKyJ0+/VXX4S/GzMzU1vXSDISauhxRa7EB48wGLCV0aCxO1E88V4eMsKujaUJtg0
	 rybpCEijp65ZNqEzYQWTR2qv6I4JOCuo1HKAVBzb5PQJyrXpAbn1LafhqgsLZX8eUP
	 jYFhYwW0lpwqsWxgP739E9a18thoxwWT6JnWSYDar4fdbPG96knCQ4wz9hHRMZXILu
	 fnJtf7iggD/kEbNNs6jv7c8aKyhNqRUi7q6UBuhQzcswJ+IEXkgTMcPVJXY70prIKt
	 T5OqyfvY89P9A==
Message-ID: <sashiko-outbox-210637@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/9] kho: Reclaim the metadata page left reserved after
 kexec
To: "Chris Down" <chris@chrisdown.name>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>
Cc: "Breno Leitao" <leitao@debian.org>, "Alexander Graf" <graf@amazon.com>, "Baoquan
 He" <baoquan.he@linux.dev>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, kexec@lists.infradead.org, kernel-team@meta.com
In-Reply-To: <63ca64c004b296a998a3e531f8c0c4964916b70c.1794383544.git.chris@chrisdown.name>
References: <cover.1794383544.git.chris@chrisdown.name>
 <63ca64c004b296a998a3e531f8c0c4964916b70c.1794383544.git.chris@chrisdown.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 07:54:06 +0000
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

> After a KHO kexec, the new kernel keeps the page holding the previous
> kernel's kexec metadata reserved for as long as it runs. It only needs
> the page once, since kho_in_kexec_metadata() copies the previous release
> and the kexec count out of it at boot, and nothing reads it again.
>=20
> Free it with kho_restore_free() once copying is complete.
>=20
> Fixes: 76aa46b9e404 ("kho: kexec-metadata: track previous kernel chain")
> Signed-off-by: Chris Down <chris@chrisdown.name>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794383544.gi=
t.chris@chrisdown.name?part=3D1


