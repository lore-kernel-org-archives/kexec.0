Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B36CD4F4C
	for <kexec@archiver.kernel.org>; Mon,  9 Sep 2024 06:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=exUpjx18BlaUMLhX8d35LE0MvK6iTgUu/AWfo42yoQA=; b=0nYhKfkWHj0LiI
	qQkNuNn8yICXpSJ30tWBZ9xwQtqjmbMx/pBM1wKkHB5ZPhXf2ZPOzblNqhkVjm6+k8gmDx/BPMhNI
	wLbmL6gvqkQDwR5dFbF3yKddNVEhPMn3L6Gn1tcyUUfWGJTxEefDNKhXhNF3cPuRrd+2IjimPMz5e
	4cf5ligA+LErBNx7xNmjktSgNEH9nM2jaAsyqGiMq/7oE6rmr50Nu3ytMWoh1nfromtzvKbXnYIKh
	cqrBHrP4bvq3i5sGYXTo07uDhlp3LsCZgCHcLHWwRIx9tWsWxuvRCbmLU+VPxy5tKL99G7L3mWtla
	xL6VMiXmWxvvVZzb2HLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snY4O-00000000eX2-3Ri8;
	Mon, 09 Sep 2024 06:40:16 +0000
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snY4M-00000000eVv-1OPJ
	for kexec@lists.infradead.org;
	Mon, 09 Sep 2024 06:40:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1725864005;
	bh=6PbbI4EATTD/OrTPSWHrhxuPyO3m+IU1wrsU9S79Rm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=V9dqjOT5cG2Z/ik0KS2Ug814aSRbGFjOwq9SedHMMKCwpDrApwYz0ArGViy5Lb/a6
	 yyUPuQILPkjStOT8poYnkXv2Jooq74dG20gBuKXWTIdbtJfuzKXTK1LVngFS+qL47Y
	 plgL18Xfd9FhnusGMn98V4drs3aZqenn6kZzlW+KAAn68oBd1MaE8NVVkazwUXht2r
	 y2quNbgbn/OHE5rKZB9Fx2hIk0Mg2qRd4DwRBh0Sau3G8FCHg4cobRsRqgbBZ3xziP
	 FB93Q+bcT6tCTUMRm6xjrcCEfb6yStHAyYy1QsneaiFUFc7x2lJo9kSs8Zj/PeDUv+
	 ly/dIYijM2sMA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X2HJL6vpQz4w2F;
	Mon,  9 Sep 2024 16:40:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dave Vasilevsky <dave@vasilevsky.ca>, glaubitz@physik.fu-berlin.de,
 bhe@redhat.com, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Reimar =?utf-8?Q?D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
In-Reply-To: <c04fe24a-26e6-44b5-a2dd-00eac589e36b@vasilevsky.ca>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
 <c04fe24a-26e6-44b5-a2dd-00eac589e36b@vasilevsky.ca>
Date: Mon, 09 Sep 2024 16:40:02 +1000
Message-ID: <87ed5t49fh.fsf@mail.lhotse>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240908_234014_665906_CA65ADAF 
X-CRM114-Status: GOOD (  10.45  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Dave Vasilevsky <dave@vasilevsky.ca> writes:
> I received a notification from Patchwork that my patch is now in the
> state "Handled Elsewhere".[0] Does that mean someone merged it
> somewhere? Or that I should be using a different mailing list? Or
> something else?
>
> I'd appreciate some guidance.

It was sent/Cc'ed to linuxppc-dev, so it was picked up by the linuxppc
patchwork, which is fine and normal.

Because it touches many arches I don't plan to merge it, I would expect
the kexec maintainers to take it.

So I marked it as "Handled Elsewhere" in the linuxppc patchwork - ie.
not handled via the powerpc tree.

That doesn't mean anyone else has merged it, it just means I haven't and
don't plan to.

cheers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
