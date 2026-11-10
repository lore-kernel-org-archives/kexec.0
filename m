Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DC1606A325
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 12:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=A0NlB7zj;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPqzm62S
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Der7fgiXvRnpihogyZCLRPVXoT2AJly7UPQnFlw9TSg=; b=A0NlB7zjjJLYsJeqOA/qw2nBJF
	g/XC4Zxdanh/h5UffpVwj+7TNtYmGbF63YYVAZ0+6CyYRn6FMCYz3p8cqBLxWDMcUTE3MRGzJV0/z
	Uj9xMYJT2cSzRMiRohzBa//awa0naoJ4eBvQWIu09bkF4zq7ufUhMhf8qMKOTh8MzMfHPtV9EYqHX
	RDMga1PIi2zOqg1yKbH5VkUQ2NWvlO39M4dDfXrPBX35z9gLMX1fSMAkeV1XmIjFbH9RXgbex/M4s
	DOD7RavhlPiuU/NTC1CMGKO7TTyIk9btF61PgqqsrT0WfvSmtdwrZI83G+KaMLcaIYnD9mqEjtQNq
	fRQUfBrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQl0t-00000003rGz-0UHq;
	Tue, 10 Nov 2026 12:31:47 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQl0s-00000003rGn-0Z29
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 12:31:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 75D7E614A1;
	Tue, 10 Nov 2026 12:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD9C1F008A2;
	Tue, 10 Nov 2026 12:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313905;
	bh=Der7fgiXvRnpihogyZCLRPVXoT2AJly7UPQnFlw9TSg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lPqzm62SEhz9MXyscDTgAIY9hS9jrO4A2j+jhVsvH/DF11gTeoMkOk3VYS2Pj+HhV
	 tB7hur8fS9ffeaylGHJ6tBWGvoz8z2pCTkr0zbjuqWgLhD0Yx5ESop9yqFVqS4Md9v
	 4mGs+5LDR2QKqsUOlSH68maUMZMkvszKcr8+YA7oy8DVbwQT1AgGhYXxtSEjvL9SxO
	 GgCE8cjne2ZuViI67moEQChYEoZ3HgkbwDZxDdCVYp9c1IYGgSiArYTeG6X2Som3Cx
	 K+bpGG150YooOReRZjq8YjX4kPpS3LxHeWzes2cQe+r1JojLNmsnVCCMtl0uzE+D/L
	 60GVNiSM5D6JA==
Message-ID: <sashiko-outbox-207026@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH printk 5/6] printk: Add panic+kexec flush point
To: "John Ogness" <john.ogness@linutronix.de>, "Petr Mladek" <pmladek@suse.com>
Cc: "Sergey Senozhatsky" <senozhatsky@chromium.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Ryan
 Roberts" <ryan.roberts@arm.com>, "Breno Leitao" <leitao@debian.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Dave Young" <ruirui.yang@linux.dev>, kexec@lists.infradead.org
In-Reply-To: <20261109123127.489676-6-john.ogness@linutronix.de>
References: <20261109123127.489676-1-john.ogness@linutronix.de>
 <20261109123127.489676-6-john.ogness@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 12:31:44 +0000
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

> During panic, nbcon consoles transition to atomic printing. However,
> there are consoles that do not support safe atomic printing
> (CON_NBCON_ATOMIC_UNSAFE). Such consoles will only flush during
> panic if their unsafe flush policy allows them to do so.
>=20
> The unsafe flush policy NBCON_PANIC_FLUSH only allows unsafe
> flushing when particular flushes are explicitly invoked. Call
> printk_trigger_flush(PR_FLUSH_RESTART) before performing the kexec
> in order to give such consoles a chance to perform an unsafe flush.
>=20
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109123127.4896=
76-1-john.ogness@linutronix.de?part=3D5


