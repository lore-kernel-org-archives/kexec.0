Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67959606A32D
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 00:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=v0MD6jMY;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jV8ZN2V8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=n2DLkGxJnSbmGCrxwXPwOmko4Nq/oIQoKWE8FxALXB4=; b=v0MD6jMYN8fslsGBgL+/btud4L
	N0Tha/LHk6L/V0C9Esoj5RZ/FnZDykdCW7cD+RWpkCpxMQD7yJNLooqGIFpsTJW39wJYhFhZy7L2Y
	ONpRZ/+Zf/JjVM5i4Vef9gcsOYyllrPdsebAelAbzolXGUMKhx8WIRV4LxfhLAX4DJJvszWMavnAw
	NOUaoZitkgD9vOH5zDSaHedPlMINQBvrZeMM4KdY2GeBThu9WljsyKy+IcRGcTXyV5woN3gDw0NOm
	+frP2hk/8RApHDRBWv7eFEDOk9ztsJ0wGNrnhnQSBZXf2tc6oGNPeRa1pO8HKFjDuddEI5dlZMwae
	YIStPmkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIis-00000008FNw-05vs;
	Thu, 12 Nov 2026 00:31:26 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIip-00000008FK5-14rc
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 00:31:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 081C5412C7;
	Thu, 12 Nov 2026 00:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D131F00A05;
	Thu, 12 Nov 2026 00:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443482;
	bh=n2DLkGxJnSbmGCrxwXPwOmko4Nq/oIQoKWE8FxALXB4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jV8ZN2V8elC5tg1hqboCWazEECOipHcdQQdNUfBPFa4cl6x4IklnhUCXJUfwjcKB8
	 txpxzEOVetNzjGEwTptX43XOVN8d27dELPQbJLmZ3BeUtVXD6WcY2MMVkFOvtGXazS
	 6BYD7gWcvRwsyTeDurYDYsDLDrBWULSEyDkeTyuXOsh4V6bmR3W5JN6lfDwpDoYxzV
	 jKyrNITrJwBKWusdLnClcBLNcVEC1GKXAYE4JLhlOJ7xxEudab3T4u4nS43xXn84dX
	 dizQ8/GDNQwu3LT3KG4/U3ZW+oKmR7oXa0pJGQ5TN0qpn8pa5axDq56kGenxBoT9LT
	 Mq6ZVqiLtPhow==
Message-ID: <sashiko-outbox-209945@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/19] mm/shmem_luo: Allow preserving tmpfs files
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
In-Reply-To: <20261111002358.1842967-14-dmatlack@google.com>
References: <20261111002358.1842967-1-dmatlack@google.com>
 <20261111002358.1842967-14-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:31:21 +0000
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

> Allow preserving files on tmpfs mounts by dropping the link count check
> from shmem_luo_can_preserve(). The check was meant to limit preservation
> to memfds, which never have links. It isn't needed anymore, since tmpfs
> files are now retrieved into a file on a tmpfs mount.
>=20
> Userspace can keep using a linked file by its path until the Live
> Update. The path of the file isn't preserved. Userspace creates the file
> to retrieve it into, and can then link that file at the path it wants.
>=20
> Preserving a linked file affects everyone who opens it by its path,
> since its size is frozen while it is preserved. The permission check
> added by "mm/shmem_luo: Require permission to preserve a file" covers
> that: Callers need permission to write to the file, or must own it if
> its size can't change anyway.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111002358.1842=
967-1-dmatlack@google.com?part=3D13


