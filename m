Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCC7606A31C
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AxjJZzOy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rUsaUhwHeiQf3xBbIOzTemfd4ixtkr1Kys8NIsISdFY=; b=AxjJZzOyhXoGHPs6IZOHLnchvh
	wTsOWeaA4TMv9wtiYC9VJHB6Rdz2xCqTJFgBSe3O9nQjBSERirqTU751pt7Zs6xhJjIbBwgNfmFmH
	T+6FA0v1+O5CsLY5cNDHkp/ILFFdk55Mz1LItCjaJQUV3nUSOXAFO2nnIfk9vDuyjNa2f1C6Xx1Ly
	LiEjUcAJIA8dlyrZKXGgc6/V19ggSMyOWCQri0PqsYhwQjcdZWRcRrt6dymbhxaFpeYozAZ3x5W2P
	E1OyAALjolpAp0mCKdcaDvkRex0naDbI7eLbeE6nDQEzfWorb3d29UfPp5Hs7gyig8aTWFNO2iWI5
	41ergWyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJD6u-0000000AH90-1g8V;
	Tue, 20 Oct 2026 16:54:48 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJD6s-0000000AH8f-2Ikr
	for kexec@lists.infradead.org;
	Tue, 20 Oct 2026 16:54:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D8F3C601F9;
	Tue, 20 Oct 2026 16:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1C91F000C9;
	Tue, 20 Oct 2026 16:54:44 +0000 (UTC)
Message-ID: <sashiko-outbox-179385@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/9] PCI: Enable async shutdown support
To: "David Jeffery" <djeffery@redhat.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, "Tarun Sahu" <tarunsahu@google.com>, "Stuart
 Hayes" <stuart.w.hayes@gmail.com>, "Laurence Oberman" <loberman@redhat.com>, "Bjorn
 Helgaas" <helgaas@kernel.org>, kexec@lists.infradead.org, "Ewan Milne" <emilne@redhat.com>, "John
 Meneghini" <jmeneghi@redhat.com>, =?utf-8?b?TG9tYmFyZGksIE1hdXJpemlv?= <mlombard@redhat.com>, "Bart
 Van Assche" <bvanassche@acm.org>, "John Garry" <john.g.garry@oracle.com>, "Jeremy
 Allison" <jallison@ciq.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, "Pasha
 Tatashin" <tatashin@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>
In-Reply-To: <20261020164435.80499-9-djeffery@redhat.com>
References: <20261020164435.80499-1-djeffery@redhat.com>
 <20261020164435.80499-9-djeffery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 16:54:14 +0000
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> Like its async suspend support, allow PCI device shutdown to be performed
> asynchronously to reduce shutdown time.
>=20
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020164435.8049=
9-1-djeffery@redhat.com?part=3D8


