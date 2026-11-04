Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE74606A31B
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 01:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Maw1vqH1;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B2Hh1Iwy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9HfIaUVMh9ori0XHVA0Kw+TkFHlpDTR33QZVSpPLais=; b=Maw1vqH19snJ4dHOJKMpue5APp
	7qv7HcyboUdeL5A9Gp0KJXIuA5jxTdmgLuTktY4Xx6/yKGXcZI/d+5TYN9DNZJvChlQK3KoJnm/RM
	Hls8aDWCphNgsNW9/CleyoB+j/79ydRLwnNb0WyNFCzyzDsx40mfhd/WfDx+QXraRKWahN4tOJ+7a
	lHzjCzqnAxgJlkW/tZrOz7mIv/qlEpeuxmoLArpBzT6qJvhX0e2OYkKG3An/YU7UToZH+0XEDWukE
	zjgP2MbOpUOBDg4QRHRpGM+SinMBw1M8uBR5ceOiwWaLPn2/8zTOaRAFcVuFk4I4d4du5bHyRBX/T
	7d568hIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOPPa-000000042SJ-47BD;
	Wed, 04 Nov 2026 01:03:34 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOPPY-000000042P4-2VDc
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 01:03:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1220F60D8B;
	Wed,  4 Nov 2026 01:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3D21F000C1;
	Wed,  4 Nov 2026 01:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793754211;
	bh=9HfIaUVMh9ori0XHVA0Kw+TkFHlpDTR33QZVSpPLais=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B2Hh1IwyiQW9rMHSHfbsC2qZNnH8t6SIWKR+R3mQOL7bPLUx0KacvuubCArZYt3XV
	 uBdUL2KSAkzAhxpMFsoZEh9KDmeBsZ86qcfGIA+dmqvIrsBJB0Q8cGBQflH2x+cs08
	 EST84eZyhBqeG30wBDsFky7rTnmsysSSzhsQB5bd6T6d10M2HBSS56tsQWQnO2D+IK
	 kDzML7xUsOPUqzJFTDYfNPf3sPrOp+rVOHemmi5eTPrRi9HqsLH6btCDLlccF0C96E
	 IBTTGeOkQTHOwEerXB4otDM8rah62WDBfnZkOqR7fmLINvsRNRM/0CjjaWbeujgcPu
	 bO4gIkpFS516Q==
Message-ID: <sashiko-outbox-196338@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/10] mm/shmem_luo: Retrieve tmpfs files onto a
 tmpfs mount chosen by userspace
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
In-Reply-To: <20261103010216.3447716-8-dmatlack@google.com>
References: <20261103010216.3447716-1-dmatlack@google.com>
 <20261103010216.3447716-8-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 01:03:30 +0000
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

> Retrieve files that were preserved from a tmpfs mount onto a tmpfs mount
> chosen by userspace, instead of as memfds on the internal tmpfs mount.
> Add struct liveupdate_shmem_retrieve_arg, which userspace passes as the
> retrieve argument of LIVEUPDATE_SESSION_RETRIEVE_FD to choose the mount.
> Record which mount a file was on with a new SHMEM_LUO_FLAG_TMPFS flag in
> struct shmem_luo_ser, based on the superblock of the file.
>=20
> shmem_luo already accepts unlinked tmpfs files, such as files created
> with O_TMPFILE, and a following commit also accepts linked ones. The
> mount such a file was on doesn't exist in the new kernel, and userspace
> may want to put the file elsewhere anyway.
>=20
> Model struct liveupdate_shmem_retrieve_arg on open(): The kernel creates
> a new file as if by openat(dirfd, ".", O_TMPFILE | flags, mode), so the
> file gets the owner, permission checks and security labels of any new
> [ ... ]
>=20
> Like the other failures before the folios are restored, problems with
> the argument and with creating the file can be retried.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103010216.3447=
716-1-dmatlack@google.com?part=3D7


