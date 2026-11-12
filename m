Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA40606A321
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 00:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fAP58ch1;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g48e7TUY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ejT3vcX6NoBHgjVLR3eAsOXkkvsKTbrBkJrvK81r90U=; b=fAP58ch1VbNMMlXkDyc1X1cd+a
	39+22XQmiACNjZ0Vee6LYPT2L/u0U9We0BISgpQnBmNNF4iKn6pnvy6uJMt4M/Pnc3uzYwbwIwpj8
	i0oPjJ26YqZJUOhSyQiw56RPlev/Wwuwaa0/AAacrCNpVkrjs4yEWQ1CX7KaQ/kmN7hPvFPtryGTk
	8kKY9k6djG0b43zU/vEJJGtWxOMhkGHN2gqqVrOMAmyrvcPwKtJahyNz8A+btWIgLX6YqgzqgpC3F
	gwDMbAgTZeY16o8YGGhh+8gH4Jq28El7k+BMEjS+UDH3Wn9VWvnPiho8VZI51nemEthuLtF858vnH
	2pbSbX8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIii-00000008F9V-1tUk;
	Thu, 12 Nov 2026 00:31:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIig-00000008F6s-29tQ
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 00:31:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2FE97412A2;
	Thu, 12 Nov 2026 00:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDFD1F00A05;
	Thu, 12 Nov 2026 00:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443474;
	bh=ejT3vcX6NoBHgjVLR3eAsOXkkvsKTbrBkJrvK81r90U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g48e7TUYEbiaU5q4tY0Jlv7/JnuirJte4YPauTLNmzKvc/Pmh/iIZmyKajc4fZ5vL
	 WkBVPqBf1ZuNKOYnpipb8fVN7aU+P7lEi/YglRhWTnUDndFhTdA2DXvzCSDwSfgZuq
	 cU6RVpb3wNE8wJeFamraHFqtb4cOlqq8KPnEKaoc8Vta5VU8GMky3fJ7Faawb6FOpv
	 eryUmIdKoNFPMjX1Sp0COUfMdwV+UZdNNg6UZk9g+WcZxIMoXk4+ygDML1sUNBn+Dj
	 On3HuKNhIbGxx18Jsjuwkk2cSQrmb2JV8fFRCkgxNcZwF+LeYhepJkivPoVY7N8agq
	 8a1it5bM5kjug==
Message-ID: <sashiko-outbox-209939@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/19] liveupdate: Add helpers to track the files
 that LUO manages
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
In-Reply-To: <20261111002358.1842967-8-dmatlack@google.com>
References: <20261111002358.1842967-1-dmatlack@google.com>
 <20261111002358.1842967-8-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:31:12 +0000
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

> Add luo_track_file() and luo_untrack_file(), which add a file to and
> remove it from luo_preserved_files, and use them instead of open-coding
> xa_insert() and xa_erase() with luo_get_id() for preserved and retrieved
> files.
>=20
> The next commit lets file handlers make LUO track the file they retrieve
> into, which adds more users. The helpers keep the key and the -EBUSY
> behavior in one place.
>=20
> No functional change intended.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111002358.1842=
967-1-dmatlack@google.com?part=3D7


