Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B70BCA600C
	for <kexec@archiver.kernel.org>; Thu,  8 Oct 2026 19:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=imD318uYbaR4I8GkThDrvvtTnqtl46+qes0QsXa8DAo=; b=eRhZeZQTSUwDVwceeZSvIhOcKg
	9f0yMxYfqJObFQhuRTohr4Q6Q31QR3MZ18SN+3z9NkONNryk07QMH+OjO+fupOxXprdE1qbPzwIqB
	Z6hCGsBNvyTpNTTTCBoPOsVagibUZSoCmISHLxLD0qIcVOg5GCcfiN4woJ3FxVlAqqpPl4BkH5KJE
	vrcdM/WSNDENTWmUogrusxEUh1N/6VrzB/B1h8n41aDs5KZBj1nc9WfPKp9GrA7pE7jsazlxVAaRj
	U7uEcj2Pp8sc9SghDL5K7z+kx5ITq7PWTlNnjcxqbBaH4erNkMOOatbmvkXdKIshs7az9czfd+Est
	zjRMOIUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEtXm-00000004uBl-0mii;
	Thu, 08 Oct 2026 19:12:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEtXk-00000004uBd-495f
	for kexec@lists.infradead.org;
	Thu, 08 Oct 2026 19:12:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 52418413A5;
	Thu,  8 Oct 2026 19:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78B21F000FF;
	Thu,  8 Oct 2026 19:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791486760;
	bh=imD318uYbaR4I8GkThDrvvtTnqtl46+qes0QsXa8DAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PnKRpahRAs+fCtPQqncrSuQSpAwUK3VFsokdhvscClzl2W+rCLWdn+MQfKgjpJm5z
	 e5B29u7tHEzbtCCN5Gg9E937UIKqJtUjNs5lPBa8N3UIgn38tPpINJHT1wnGzunjRL
	 QF1DOUumYsRMStJDTuSK5uKzqspKyN/3Ory2AKsVoauj5uvAPwidSGEDxYTZ9UxtH9
	 bfp2OTL6sN2qZX2NrIRiHCyPT1lu2QlVosFVqcW43mkAAWvuhzsDrXX41RdVku2Ltx
	 sUQfuwqyHCsDFzxcTMTQDkLl9oi9UXyRdpYpIosHfUgBqhTjHZO5+D+AphwNLm48aM
	 569ZCvB0szQfA==
Message-ID: <sashiko-outbox-164503@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] memblock: drop for_each_memblock_type() and open
 code its users
To: dmatlack@google.com, "Tarun Sahu" <tarunsahu@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Andrew Morton" <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261008190828.3221718-1-tarunsahu@google.com>
References: <20261008190828.3221718-1-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 19:12:39 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> for_each_memblock_type() always starts the iteration at index 0 and its
> body is a trivial 'for' loop, so it hides very little. It also gets in
> the way of iterating from an arbitrary index, which the next patch
> needs.
>=20
> Remove the macro and open code its three users: memblock_add_range(),
> memblock_isolate_range() and memblock_dump(). While at it, move the
> region pointer into the loop body scope.
>=20
> No functional change.
>=20
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008190828.3221=
718-1-tarunsahu@google.com?part=3D1


