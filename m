Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F323606A32A
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 07:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eMc4sMPw;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gy753nN7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=IB8SqNd+bfmQlxAZGy2UafWtc6X2soxRHK0a2GmJo3k=; b=eMc4sMPwcyHtefgorHoow0Mz2L
	ndaDduPolnMnLAP4YGcvQLb3t03rdyAQncmU2KQJ0RDerJK/Ejd6c0TotyCjWNfgtP9S/Fwc0PG3b
	jIyY4P52KlRHFAxxJqtfNyxZBYGnS8/jwcosIc1x+ZvxT0UpWbAes6shj0ZiHsWVvp1mvt3Qhl3wo
	PVWPFX6mezF1aynLwK32Q2oZmMXOVLo0CyMav904uxG2MspxrMoDmNRTMeOMjlljat3UfHh0Nmxxv
	2C79IsLpE2BYUL1mpjnpvXRnH35OVX3FOqQCOHNLwmga27PSWh9vsJp369976++14cWy26t1c3yiN
	9UF3J53Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRPdW-00000008yrg-3EFA;
	Thu, 12 Nov 2026 07:54:23 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRPdK-00000008ymB-3SY4
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 07:54:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 93EF143A51;
	Thu, 12 Nov 2026 07:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCCE1F00A05;
	Thu, 12 Nov 2026 07:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794470050;
	bh=IB8SqNd+bfmQlxAZGy2UafWtc6X2soxRHK0a2GmJo3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gy753nN7JmpSsz4BacirPz/11kRWThOELbRDvuvb7INRPTucd2fbkg5Ve83/fAX5s
	 tlIYXxTZ1tZbxGE1tWJV9ZhMuxptgve580rH6uUuf2+4vOKAraE6NAJjCw97Ym9PcB
	 +atOcSeqU+3A+PP0KbASjCFSTrFjBMQKsh4+D4aKpGiBfVmQW6Ukmx78+komHxfY9q
	 Dbx9LHbRI9csm5CeuB0QGfEVVbGTh/8yxbCutWeIdslIkJF7cX8ih/hWiAini4Vr1v
	 30citSikods76iznJvVJa27Sz6xOshZkKCxoeJbO9gZfXfNDEt+d3xJyl71vgNewP8
	 thqP8xkpdhuTQ==
Message-ID: <sashiko-outbox-210640@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/9] selftests/liveupdate: Catch incorrect file
 accounting across kexec
To: "Chris Down" <chris@chrisdown.name>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>
Cc: "Alexander Graf" <graf@amazon.com>, "Baoquan He" <baoquan.he@linux.dev>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, kexec@lists.infradead.org, kernel-team@meta.com
In-Reply-To: <d339c0af9c4ee54a5ee8052d5fe59c81302d82a7.1794383544.git.chris@chrisdown.name>
References: <cover.1794383544.git.chris@chrisdown.name>
 <d339c0af9c4ee54a5ee8052d5fe59c81302d82a7.1794383544.git.chris@chrisdown.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 07:54:09 +0000
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

> Check that each retrieve is counted while the session is still open.
> Finishing the session should count its unretrieved file as dropped,
> while a file in an unclaimed session should still be held.
>=20
> Signed-off-by: Chris Down <chris@chrisdown.name>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794383544.gi=
t.chris@chrisdown.name?part=3D4


