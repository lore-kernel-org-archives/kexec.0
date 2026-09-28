Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AF3606A31B
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FOLpoBp1;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EVFu0Pkk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QVeyl5juHc9NJdeD8w2LctoRHYEP7jkGYs5FqZyrwKE=; b=FOLpoBp1bVfAjMiLnSlVu82FGR
	/nlEFXFfzlxiY+mH1Tx4aHfs2HgBZs66R6Z2UzUwum6xMGF/kHPRJtOYjhzeh9UuRa3gJy46RkGXq
	B28wg8E41+ZjEKXQIoEwREQEPua//0BpGCc/OwgYgniS0ceCs9AnLxD6rXBn+y0Vc37WWwGPF81Wh
	r0lKMjkIhq+jN6go/9kU41ftfJvL/T9eX+XZOamsb6FJNuLy8TlSwyibQht6fLdwPLS5Xb/+TGzoC
	ydq9dY6Kzfmr2vcXm7GHB4UUEXmU04bWROFPTuf0rYF7rvqOLGMFtdKRacoqGVtj3RVwZHy5s4JlW
	9F8to8zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ56L-000000099Wo-2auf;
	Tue, 20 Oct 2026 08:21:44 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFG6-00000001BBy-0TpO;
	Mon, 28 Sep 2026 17:35:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9A3304451C;
	Mon, 28 Sep 2026 17:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC3E1F000FF;
	Mon, 28 Sep 2026 17:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790616921;
	bh=QVeyl5juHc9NJdeD8w2LctoRHYEP7jkGYs5FqZyrwKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EVFu0PkkUr8RV9mJRyKpyqQI0KLTl3eJ7cm3rD0eHUOrJFg12gdP4hTIhrBrQLcqx
	 DbGbKJ9Pqs/CzWQkWJdwqFfS+uxZ7QMpVc+1ei7HjNk0Y/WemxWbLjnkULJ4JUT+De
	 CQRCq6zo9B7dF6dK67pIoay6PE4C8hWugtefNItCljakS0O50fVoIIu3Hu/+Drl81P
	 48KDHKDvUXHIVv5sle+bfB9fb2uOvwiWutpb2mamcMMiXF3zon9LfAts50zpG22279
	 eqlSNWYkYSL02mUPtY3yW819sweAPRaC0NtyWCu3rqUbN4JJhqMoUI7sjSowtv712Q
	 g/nBMfMVK1Bpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/12] arm64: Enable the crash memaction registry
To: "Peter Xu" <peterx@redhat.com>, "Mark Rutland" <mark.rutland@arm.com>, "Mike
 Snitzer" <snitzer@kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Serge E. Hallyn" <serge@hallyn.com>, "Gregory
 Price" <gourry@gourry.net>, "Kiryl Shutsemau" <kas@kernel.org>, "Harry Yoo" <harry@kernel.org>, "Oscar
 Salvador" <osalvador@suse.de>, "Joshua Hahn" <joshua.hahnjy@gmail.com>, "Will
 Deacon" <will@kernel.org>, "Usama Arif" <usama.arif@linux.dev>, "Paul Moore" <paul@paul-moore.com>, "Saravana
 Kannan" <saravanak@kernel.org>, "Michal Hocko" <mhocko@suse.com>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Dev Jain" <dev.jain@arm.com>, "David S. Miller" <davem@davemloft.net>, "Rik
 van Riel" <riel@surriel.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Mikulas
 Patocka" <mpatocka@redhat.com>, "Danilo Krummrich" <dakr@kernel.org>, "Jann
 Horn" <jannh@google.com>, =?utf-8?b?SmFuIFNlYmFzdGlhbiBHw7Z0dGU=?= <linux@jaseg.de>, "Pedro
 Falcato" <pfalcato@suse.de>, "Randy Dunlap" <rdunlap@infradead.org>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Herbert Xu" <herbert@gondor.apana.org.au>, "Muchun
 Song" <muchun.song@linux.dev>, "Benjamin Marzinski" <bmarzins@redhat.com>, "Lance
 Yang" <lance.yang@linux.dev>, "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Byungchul Park" <byungchul@sk.com>, "Brendan
 Jackman" <brendan.jackman@linux.dev>, "Jonathan Corbet" <corbet@lwn.net>, "Alasdair
 Kergon" <agk@redhat.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Baoquan
 He" <baoquan.he@linux.dev>, "Zi Yan" <ziy@nvidia.com>, "Ryan Roberts" <ryan.roberts@arm.com>, "David
 Hildenbrand" <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, "Barry Song" <baohua@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Alistair Popple" <apopple@nvidia.com>, "Matthew
 Brost" <matthew.brost@intel.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Ying Huang" <ying.huang@linux.alibaba.com>, "Nico
 Pache" <nico.pache@linux.dev>, "Andrew Morton" <akpm@linux-foundation.org>, "Mike
 Rapoport" <rppt@kernel.org>, "David Howells" <dhowells@redhat.com>, "Rob
 Herring" <robh@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "James Morris" <jmorris@namei.org>, "Dave
 Young" <ruirui.yang@linux.dev>, "Mimi Zohar" <zohar@linux.ibm.com>
Cc: driver-core@lists.linux.dev, linux-crypto@vger.kernel.org, kexec@lists.infradead.org, linux-doc@vger.kernel.org, conor+dt@kernel.org, linux-security-module@vger.kernel.org, devicetree@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Eric
 Biggers" <ebiggers@kernel.org>, robh@kernel.org, dm-devel@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20260928-crash-memaction-upstream-20260921-v3-4-e511e9ee2329@jaseg.de>
References: <20260928-crash-memaction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de>
 <20260928-crash-memaction-upstream-20260921-v3-4-e511e9ee2329@jaseg.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:35:17 +0000
Message-Id: <20260928173517.CDC3E1F000FF@smtp.kernel.org>
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

> Select ARCH_SUPPORTS_CRASH_MEMACTION on arm64.
>=20
> Signed-off-by: Jan Sebastian G=C3=B6tte <linux@jaseg.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-crash-mema=
ction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de?part=3D4


