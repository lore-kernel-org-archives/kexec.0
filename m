Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A42606A323
	for <kexec@archiver.kernel.org>; Sat, 28 Nov 2026 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xo2xOKV2;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3bsoyiP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GDL4tQ9MZFinbmf7+bjHLotrH+bz3fCeonesVPcwHyM=; b=xo2xOKV2FpfZWxpttTlXDBHPYr
	/cyRmiUaSv/FE8OxDNf8rS09SkfQVFGvxQrq4q8mBlGHkSYjqHOrW4T39WdwASFNyptFnEcYSFT6l
	ZiCLrxBQAAdBNcpnjDYtPhmIL3rtjtpVBW7RvE0ZsH4lSM26XYztco9uWBKfCcmTrXHhmVahyrCxc
	SqD+XuGQ/Yilq0+wuhZJ3vyqIHm3UtKHOUGmkA81dLlmzO9VUeq3hMN3zl7KaW4T5qZxo4+2qEIrX
	Rmk4yAJ9Jr1qXwkNzvjZBr/JtmkXTswUYw/GHlbuXulFdO5o2bX9HsA4mqowXzZEpUIIGfj2KHAhN
	D34y7oTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXEjC-00000000a4P-3fUz;
	Sat, 28 Nov 2026 09:28:18 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXEj9-00000000a4I-205L
	for kexec@lists.infradead.org;
	Sat, 28 Nov 2026 09:28:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8F18060CD0;
	Sat, 28 Nov 2026 09:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88AE1F000C1;
	Sat, 28 Nov 2026 09:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795858094;
	bh=GDL4tQ9MZFinbmf7+bjHLotrH+bz3fCeonesVPcwHyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d3bsoyiP7MDgjNyRe6IArvaTlmqedyid4rV4dKU4nNeCjAA/s8dgW/JOmn7QTLgrs
	 YeC1HVoc93t5DXfMOBuhKV+ruwbgSiDD255cftCSZLwjS+EjPAIzomXdO0FbH4fLnq
	 MBETKm447cRuM+Ei2Gdkc7w2UOv6XPb22c/RSGVn1tRtnxsa59aS1ujzXYaY2x5RnR
	 ghb5uuTdIHlWfc9HJdJYTOrBT+iWgaqYKN6n3BFYGtlLUBskeO/nN7dc3TNxrwuPic
	 JT4kOWfJeVxQGLO6Gy0meaToCtoigb0ExFd8EtUAmy2qdEZmifDULYqRiMdr0tZ2aq
	 1OC1aikI8jF7A==
Message-ID: <sashiko-outbox-238588@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 0/2] kho: fixes for kho_init() failures
To: "Chris Down" <chris@chrisdown.name>, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org
Cc: graf@amazon.com, kexec@lists.infradead.org, kernel-team@meta.com
In-Reply-To: <cover.1795835884.git.chris@chrisdown.name>
References: <cover.1795835884.git.chris@chrisdown.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 09:28:13 +0000
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Sashiko has reviewed this 2-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795835884.gi=
t.chris@chrisdown.name

