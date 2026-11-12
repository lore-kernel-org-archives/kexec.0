Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2A1606A321
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=shEYiEeP;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jq+83qij
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zgqol6BdGGz8uUItEWiY11rkyvb0aLXuc+QDZ5HubA8=; b=shEYiEeP6PVWhgPmDgTHGb3yts
	0h/49VISNf8hWcP/raNKKDVMOHLMdR1ol13fAdO3uEPB6s5jrGqAINE5YRa05pC0e247bppdHehct
	3VizDaCnrDMvIkjzIXmIgsS+1pv15t+W1uCzRxvNeUcD9FrWfa/BW1bwf+mmseUWnXb9D4AtQNdE3
	l1HwRw6gG6VYabw4pkjucnh2af9gmFGs39BeACYn0fskB0TRryqhrM57i/uVlvBgfky+FNfQtJL25
	12X8V+4i2tGRi0KHJ7u3xkjr3cNRIs2UCcKfqOBw0J0woUFurd202S+iPM2mkQzvv/nFwii4ycvX9
	n5DGeTPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRXsG-0000000Aedj-1Kza;
	Thu, 12 Nov 2026 16:42:08 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRXsF-0000000AedJ-2dzH
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 16:42:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E3E9E6234C;
	Thu, 12 Nov 2026 16:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DF81F000C4;
	Thu, 12 Nov 2026 16:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794501726;
	bh=zgqol6BdGGz8uUItEWiY11rkyvb0aLXuc+QDZ5HubA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jq+83qijWrTw6srx8yNKrZ6jRor/t9lJKQOqD3+A8ou8lGd5mVLlC1HEodq++gwIQ
	 0i0rrPquKU9uJnTbtyV7vmtF4/zeAdVJSnKzM42Z41ycxdQ0rfRwuxx3IwUyvOKEWP
	 YCB8dzYPg+91jnwKh11Z6smoI/gEcF8DiKOfQqLAkMriuMVqYsWxSxfdT2hmDEPGqO
	 xUH+CfVw8dfGgBEXqD75+KlLYucl9pW6FNEjmrLcTrBZaLQLoFsbw0xAYsyIHk0nRe
	 Cw6udEtJtMk1HS4pPYblZAFP/aJvenTtYbRnYhzN2I9lyjtccSlXY8hF67P3OxfYnP
	 nfH7mmorgK4JA==
Message-ID: <sashiko-outbox-211524@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/4] sh/crash_dump: check ioremap() in
 copy_oldmem_page()
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>, "Breno Leitao" <leitao@debian.org>, "Chris
 Mason" <mason@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, "David
 Hildenbrand" <david@kernel.org>
In-Reply-To: <20261112-work-procfs-oldmem-v1-2-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
 <20261112-work-procfs-oldmem-v1-2-ecdcafd99265@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 16:42:05 +0000
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

> copy_oldmem_page() maps a page of the old kernel with ioremap() and
> copies from it without checking whether the mapping worked. If it
> didn't, the copy reads from an offset into the NULL page.
>=20
> Return -ENOMEM like the other architectures do. read_from_oldmem() turns
> that into -EFAULT like any other short copy.
>=20
> Fixes: 4d5ade5b29c6 ("sh: kdump support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-work-procf=
s-oldmem-v1-0-ecdcafd99265@kernel.org?part=3D2


