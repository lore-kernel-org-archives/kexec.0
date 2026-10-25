Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813BE606A31A
	for <kexec@archiver.kernel.org>; Sun, 25 Oct 2026 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nO6V8vDz;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MT8Ywv4z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XtTeyB5NdjH4qHpZcbxhbLDH7fMOFZaSDCCAg8O7wGY=; b=nO6V8vDzHRsMazaELRrDlOKOQm
	q2CilD9Fys4GVQH/d3P8GoHb0blcHULONN8Ffaic0bc7Tf9lBA71jb9WQqXMtYWj2JLKcDU9XIPbJ
	OoiXli8HJFqeQG5ytINhkPEPqfIBI/7h9mYX4YyPyJzHmyH6PcOJpUaLKjj7XdjtIgAUYwmfbqUYZ
	mMw1LtRoot5PexFjJOSdOxa12Q/EDlvau7ZR/cxSXTRX4Y+tEA1BP9ktckmKqUASuYOOy/HT2ELg5
	LbIdV/PlOChobVW32UqilvZsgwxEbmmPZJmqFFL6W0O8InLYeh0qIKvAUR3p4+JelxB6RFOuzn/7p
	lGjD7d0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Sx-00000001Gos-0pwR;
	Sun, 25 Oct 2026 17:57:07 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Sw-00000001GnV-1lBE
	for kexec@lists.infradead.org;
	Sun, 25 Oct 2026 17:57:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D25FD600CB;
	Sun, 25 Oct 2026 17:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA1B1F01825;
	Sun, 25 Oct 2026 17:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792951025;
	bh=XtTeyB5NdjH4qHpZcbxhbLDH7fMOFZaSDCCAg8O7wGY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=MT8Ywv4z4GzSK9PFGgQS1vLdXvp87/AAYMn2wLmKFIrUuhPzmtaCrGWGLJaJ5eVPj
	 R1PRmhoOQ7YzFNVmeNxXmsMRGHHsfxUGRtSrxndNn/ogMQYbddGWuktVnO1Mv1vHZa
	 OfPzQ7yXjDmTFM4zS6KMs3F074KVMx2Xp5eAiEq/il7038DHbSZQGHjhEhQuK7LBr0
	 UPlnJ+x70YPN+QVpN6IPfiJp5WN1RxDjSGKtelNEm8PzxL6jS8vp5lUSIAdxRXNw3q
	 oKkanfjkrF1NGcfiUFWaJj84RV5SPYwP75c8xVn4rlqXEP8FtJh+OlMTLqQsqazsa/
	 yDGvwvFrdwiAg==
Message-ID: <sashiko-outbox-184307@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/9] kho: support read-only KHO mode in kho_block
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, kuba@kernel.org, enelsonmoore@gmail.com, bp@alien8.de, shuah@kernel.org, david@kernel.org, akpm@linux-foundation.org, ljs@kernel.org, mhocko@suse.com, skhan@linuxfoundation.org, vbabka@kernel.org, dapeng1.mi@linux.intel.com, corbet@lwn.net, surenb@google.com, kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org, elver@google.com, graf@amazon.com, lirongqing@baidu.com, liam@infradead.org, jlayton@kernel.org
In-Reply-To: <20261025174017.3870481-8-pasha.tatashin@soleen.com>
References: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
 <20261025174017.3870481-8-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 17:57:03 +0000
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

> In read-only KHO mode, incoming serialized kho_block chains lie outside
> the kernel's direct map and must not be modified or freed back into the
> page allocator.
>=20
> Map incoming serialized blocks read-only via kho_ro_map_folio(...,
> PAGE_KERNEL_RO) during cycle detection and restoration, and skip calling
> kho_restore_free() when destroying or shrinking a block set in read-only
> mode.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025174017.3870=
481-1-pasha.tatashin@soleen.com?part=3D7


