Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1083606A31B
	for <kexec@archiver.kernel.org>; Fri, 23 Oct 2026 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kqRNs+gA;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TY9WspuK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yRXc6er0DTeWm0Nbj4hOu25psi44IJIVLpR7W3vYqgs=; b=kqRNs+gAKvHY6VXLXPm/KJPkhH
	emAUsAOHeZgVGxi0usor+ML0k/hQF057BSTEpQh63kVOnAri5YcVAuT1AZrV0xc1dy/+26F5eoehr
	PepZ66jQ0J0qiSU3YxAsIn6DTClWeE29j/CAchnfNyfWWLipw438TJtLABH0iwl92EjwCWoKLabTx
	NFdvjzy8TCaBTaXbniJN7KvzKd7lVpj5IzSzblFsMHjt6UbrObqL9fJuSDM/oJSttY1KE/rPAivGU
	XY0n/BbI34XfuMcySEFwZupdbqHKLK9sWmVen/exy9IFkqftIjHHpN90UiWNOR4EVOdeowXpetsy6
	iRMSOXyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKO6r-0000000H4gV-1kfi;
	Fri, 23 Oct 2026 22:51:37 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKO6p-0000000H4eh-2LPl
	for kexec@lists.infradead.org;
	Fri, 23 Oct 2026 22:51:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5128143EF7;
	Fri, 23 Oct 2026 22:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5901F01825;
	Fri, 23 Oct 2026 22:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792795895;
	bh=yRXc6er0DTeWm0Nbj4hOu25psi44IJIVLpR7W3vYqgs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TY9WspuKgrSa82w227OCCGIK9mkSbDH8z6cT70eLB61WR1AV6MkoxRRVMr+Pp5Z+0
	 VqyBRNEQRaXh7F0jvv+GYQrQwrKpw4w0+xY10HRbHudurCPSd20fu+Wcxc9/BVSY0P
	 yLEighsAo2jmGFIRpzU6+cH6yhF9jJ+KMA3T50vlnk8Z1U4ANj/wHmbLek6vHcJ71E
	 Osryr6uG2EhQGbDZ+8TV9aXMkS/brN8qQnxAzW4+jnxfYRfD0Ng45pVDj3A3MQnqO6
	 Qtv4xJctdjwejfujiftm5o24ZHVJBv0o4SQeyoRsKUHWUsCnLXrPpYWutiPNr8VyoX
	 FGReCOrZXue+Q==
Message-ID: <sashiko-outbox-183324@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/10] liveupdate: Don't WARN if tracking a retrieved
 file fails
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org
Cc: "Alexander Graf" <graf@amazon.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baolin
 Wang" <baolin.wang@linux.alibaba.com>, "Christian Brauner" <brauner@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "Hugh Dickins" <hughd@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Liam R. Howlett" <liam@infradead.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Michal Hocko" <mhocko@suse.com>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Suren Baghdasaryan" <surenb@google.com>, "Vlastimil
 Babka" <vbabka@kernel.org>
In-Reply-To: <20261022225035.377445-6-dmatlack@google.com>
References: <20261022225035.377445-1-dmatlack@google.com>
 <20261022225035.377445-6-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 22:51:34 +0000
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

> Handle a failure to add a retrieved file to luo_preserved_files instead
> of triggering a WARN_ON(). xa_insert() can fail with -ENOMEM, and
> userspace can trigger that with LIVEUPDATE_SESSION_RETRIEVE_FD, so
> warning about it lets userspace crash systems with panic_on_warn.
>=20
> The handler has already consumed the preserved state when this happens,
> so make the failure permanent. Keep the file until the file set is
> finished, like any other retrieved file, so that its resources are not
> released before then. Finishing the file set then erases the file from
> luo_preserved_files, which does nothing for a file that was never added.
>=20
> Fixes: 00d0b372374f ("liveupdate: prevent double management of files")
> Assisted-by: LLM
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022225035.3774=
45-1-dmatlack@google.com?part=3D5


