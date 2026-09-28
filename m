Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0804A606A324
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=io0Fo7Kw;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EXIu9dO6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rv/LkB6PetOdVT/pJO5A17DkMHpW1BtDQRc+jBFVZPw=; b=io0Fo7Kwv2s24DuxPMz++WU34h
	QnwhY2Yhj8FG/49RFzzqt1IQIvC1aH76Qw9JYTi0GD51cMNzKELEspw2k5I/a6vAAKE8CM4IpS3pA
	8Eg0sSXXba1fdZVn+IKVxzXI28ICnx9xX3QQu/HElF+w/zd4edUjO6OPP+iyebah10YCu06QX2eMm
	w8Dz95Qh84MNjoa9OX1Cslx/Lfmzw5PCbyQc4+7XnvXkRBxQ4XvX6kQfbqT+a4/VQzHDiwodLGcUe
	4AySoJMjWLdNyLM+Phgr9rfASeUj4/pCylDCkZnZ/xCUk5CEUVEzopcEsbg7ruTIiQJCHVyq43I/B
	DCiKL44w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ56K-000000099V1-0nSe;
	Tue, 20 Oct 2026 08:21:40 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFEm-00000001Az4-2VvV;
	Mon, 28 Sep 2026 17:34:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 05C5843995;
	Mon, 28 Sep 2026 17:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E641F000FF;
	Mon, 28 Sep 2026 17:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790616839;
	bh=Rv/LkB6PetOdVT/pJO5A17DkMHpW1BtDQRc+jBFVZPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EXIu9dO6xq2mXjLluKTuv30Af8CyESirOON3Mf9f2hlYpl04nw+40wD3YbPZG1tfL
	 HmEUK5JSYhOyLVpaITSvM4ELC305cnUmqN9ksJ+i7mccp6EtQ/LsYNrSRewyr85nde
	 fVJV76IlrsFhWqVs/3xmVmIBd5rfId8R3Lh7oVvN7+x6UaAjI/u56vaUwWNH+BzmMd
	 5K4imrySj0RLN+5w4QO4+sSnSj9TmSjJF2l8B8t3RQ3nGTFBARSJ9FwuxizUmBvtrv
	 QDRybDY6Goyif08lGnOWdctOSDJJJnyLsuwJCiGm2H3dSjfMBA31RN52rTusPsKHOf
	 pnr0NyfPsRKJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/12] dm crypt: Allocate key material from the
 secret pool
To: "Usama Arif" <usama.arif@linux.dev>, "Matthew Brost" <matthew.brost@intel.com>, "Byungchul
 Park" <byungchul@sk.com>, "Harry Yoo" <harry@kernel.org>, "Dave Young" <ruirui.yang@linux.dev>, "Will
 Deacon" <will@kernel.org>, "David Howells" <dhowells@redhat.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Mark Rutland" <mark.rutland@arm.com>, "Kiryl
 Shutsemau" <kas@kernel.org>, "Dev Jain" <dev.jain@arm.com>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "Mikulas Patocka" <mpatocka@redhat.com>, "Ryan
 Roberts" <ryan.roberts@arm.com>, "Peter Xu" <peterx@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, "Vlastimil Babka" <vbabka@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>, "James
 Morris" <jmorris@namei.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Jann Horn" <jannh@google.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Saravana Kannan" <saravanak@kernel.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, "Lance Yang" <lance.yang@linux.dev>, "Barry
 Song" <baohua@kernel.org>, "Oscar Salvador" <osalvador@suse.de>, "Ying
 Huang" <ying.huang@linux.alibaba.com>, "Randy Dunlap" <rdunlap@infradead.org>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "Muchun Song" <muchun.song@linux.dev>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Herbert Xu" <herbert@gondor.apana.org.au>, "Brendan
 Jackman" <brendan.jackman@linux.dev>, "Gregory Price" <gourry@gourry.net>, "Baolin
 Wang" <baolin.wang@linux.alibaba.com>, "Danilo Krummrich" <dakr@kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, "Mike Rapoport" <rppt@kernel.org>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Michal
 Hocko" <mhocko@suse.com>, "Liam R. Howlett" <liam@infradead.org>, "Rik van
 Riel" <riel@surriel.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Nico
 Pache" <nico.pache@linux.dev>, =?utf-8?b?SmFuIFNlYmFzdGlhbiBHw7Z0dGU=?= <linux@jaseg.de>, "Mike
 Snitzer" <snitzer@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, "Paul Moore" <paul@paul-moore.com>, "Pedro
 Falcato" <pfalcato@suse.de>, "Baoquan He" <baoquan.he@linux.dev>, "Suren
 Baghdasaryan" <surenb@google.com>, "Alasdair Kergon" <agk@redhat.com>, "Zi
 Yan" <ziy@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Rob Herring" <robh@kernel.org>, "Joshua
 Hahn" <joshua.hahnjy@gmail.com>, "Benjamin Marzinski" <bmarzins@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, conor+dt@kernel.org, driver-core@lists.linux.dev, linux-arm-kernel@lists.infradead.org, robh@kernel.org, linux-security-module@vger.kernel.org, kexec@lists.infradead.org, keyrings@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Eric
 Biggers" <ebiggers@kernel.org>, linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev
In-Reply-To: <20260928-crash-memaction-upstream-20260921-v3-5-e511e9ee2329@jaseg.de>
References: <20260928-crash-memaction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de>
 <20260928-crash-memaction-upstream-20260921-v3-5-e511e9ee2329@jaseg.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:33:55 +0000
Message-Id: <20260928173355.B7E641F000FF@smtp.kernel.org>
X-Mailman-Approved-At: Tue, 20 Oct 2026 01:21:10 -0700
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

> dm-crypt keeps the volume key, the IV mode seeds and, when a keyring key
> is used, the key description in memory for as long as the target exists.
> If the system crashes, they are left in memory and will end up in a
> crash dump.
>=20
> Allocate every buffer that holds key material from the new secret pool,
> whose backing pages are marked by crash_memaction for the kdump kernel
> to wipe. The volume key is a flexible array at the end of struct
> crypt_config, so the whole struct moves into the pool with it.
>=20
> Signed-off-by: Jan Sebastian G=C3=B6tte <linux@jaseg.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-crash-mema=
ction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de?part=3D5


