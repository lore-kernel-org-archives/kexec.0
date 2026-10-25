Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65785606A31B
	for <kexec@archiver.kernel.org>; Sun, 25 Oct 2026 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CBFHaoyY;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mA6pV1U7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=D248TiigfybOOMu4NnGSaoYecN7MRSpjpsoXPedCPbc=; b=CBFHaoyYeQnzWTJvPWqsaDCzPQ
	gMfhrCA61NiAKf5hqgrm4ydOFP6+n+IxdAb+L6CPAwVHnSoASRdQokES/sTj7jdj13Xb9HkzPkIgS
	QE3KgbvnNatlK4MpnpOxhn7xkLlfixTD3aCldw5zX2SJksGlqc74tLbd4btAhtkqs6QkdgOJcrjP+
	Um/f4O2aTGR/tNHGkUdK3X0x7Ugw5OpsDwygF7URK2CJ/vlsTm3zlLssIqvhsZm0tmwovf4Xab92a
	+e7Nu55SJXfFKvcv5whuHe8SlpwmwHtBY8mqht4W7/bfKXPDIumxYyum2gC1FnLW/kWubP/Uz4Mva
	M/B5yuBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Sv-00000001Gly-0VF0;
	Sun, 25 Oct 2026 17:57:05 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Su-00000001GkS-0xVj
	for kexec@lists.infradead.org;
	Sun, 25 Oct 2026 17:57:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A7A7E600CB;
	Sun, 25 Oct 2026 17:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B041F01829;
	Sun, 25 Oct 2026 17:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792951023;
	bh=D248TiigfybOOMu4NnGSaoYecN7MRSpjpsoXPedCPbc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=mA6pV1U7XMeRs/SC3EArLHjGuJvb3V49Mb+TSh+5hi3zDs7GhM23XcLIl8IOm1FVr
	 dIv/QZl5Ky8o5KkK/9t8AmERrnzcvBM3EjrEIq7fSMMrQCLMrcs0wOZF1QWvZU6JNx
	 PK8FN38KLZDnDoWguK5Z5aOEwhB3BOjlX8Dusgrj2nFXGqIVF+BFuWgEQsYEn3G48y
	 g3XS9KbqNdv6D4af7nwZTQF15357GyEzXmnyjkQvKrP9LsKG12pj/UWfylyOnrjREb
	 +cJbCDsMUTWqrVetvnbusJuJ/COm3cE6bRm/16DzlGfWjNcfNDtil+zAEbC+9AvVl3
	 N0o5iaBoRCt6g==
Message-ID: <sashiko-outbox-184306@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/9] kho: support read-only KHO mode in KHO core
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, kuba@kernel.org, enelsonmoore@gmail.com, bp@alien8.de, shuah@kernel.org, david@kernel.org, akpm@linux-foundation.org, ljs@kernel.org, mhocko@suse.com, skhan@linuxfoundation.org, vbabka@kernel.org, dapeng1.mi@linux.intel.com, corbet@lwn.net, surenb@google.com, kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org, elver@google.com, graf@amazon.com, lirongqing@baidu.com, liam@infradead.org, jlayton@kernel.org
In-Reply-To: <20261025174017.3870481-7-pasha.tatashin@soleen.com>
References: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
 <20261025174017.3870481-7-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 17:57:01 +0000
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

> When booted with 'kho_ro=3D<pa>', skip standard KHO bootmem and FDT
> ingestion in kho_populate() before early_param parsing runs, disable
> standard KHO in kho_memory_init() once early parameters are parsed, and
> use kho_ro_get_fdt() in kho_retrieve_subtree().
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025174017.3870=
481-1-pasha.tatashin@soleen.com?part=3D6


