Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37923606A324
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 08:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GKn3KdiK;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bs8gZl21
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UO0wORJC7A11uXsY7WzcFB5vHpZoMgQKuLqNvmRodkw=; b=GKn3KdiKEX1a+BF9TNqjhf9WeT
	CIvvj3kU/yLxIy9rkpZu0iFqUl3xVpEifJy56MYZcHGHje+Taud9pTgMECIVwpDswFCewLbShbQBo
	7FF35kl3IjRARojhKF6n+nwyhJdkg/XDYbM349yB5GeKTsN2sTDE0+kHf/XYdFR7KFDPp7cTkpTCr
	z/0D0LXsJI4UVxwo34mc506OQIuqxfr32YemOMUiCPjLBmGp5u3V2xNuJXD79uKMQTvwT4uKmc06y
	/jlHleJtw4+6VocV7+APe2dt5Qfxt/be6oQTp+OVv15dvxtvK65y4KfSwFsFNHCBQCqmTsFby9UT1
	YojHG/Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ56C-000000099NY-0Ro1;
	Tue, 20 Oct 2026 08:21:35 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFDi-00000001AnU-1JxA;
	Mon, 28 Sep 2026 17:32:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C7983410A6;
	Mon, 28 Sep 2026 17:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AAB1F000FF;
	Mon, 28 Sep 2026 17:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790616773;
	bh=UO0wORJC7A11uXsY7WzcFB5vHpZoMgQKuLqNvmRodkw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bs8gZl21EgXlr1ogxYmUKhEdGQWh/DAKFrR6vbipZPiBabZ1/ok6G279uSZM4DP/4
	 ejCloOlcoyCGBYgFxGf/57WgSkGZLso7QrCbJr8OgGzpc14kNkCT/I5uSVcJCUCBhv
	 Uqc9UpdAtMOGV1gznAP5SEf3kyCXDUuUKPM6oAvpbmATlCiWByYLe0Dmq25P8tRoqj
	 f/KStFDA/LQFsI/ox53s9PlgHfilT07LYzA2mlG2LTeDfTuKB0DJ+LRL/MPOcotAvv
	 mxi56tP/eLXb39m3eXRARWIyCdEJwqSYfVuOwyAMruQjB5h6YnuAetngetfhxwNu5K
	 wt1eBGoHMX10w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/12] crypto: api - Allocate tfms from the secret
 pool
To: "Rafael J. Wysocki" <rafael@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Will Deacon" <will@kernel.org>, "Brendan
 Jackman" <brendan.jackman@linux.dev>, "Johannes Weiner" <hannes@cmpxchg.org>, "Byungchul
 Park" <byungchul@sk.com>, "Gregory Price" <gourry@gourry.net>, "Ryan
 Roberts" <ryan.roberts@arm.com>, "Dave Young" <ruirui.yang@linux.dev>, "Mark
 Rutland" <mark.rutland@arm.com>, "Lance Yang" <lance.yang@linux.dev>, "Mikulas
 Patocka" <mpatocka@redhat.com>, "Zi Yan" <ziy@nvidia.com>, "Mike Rapoport" <rppt@kernel.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "David Howells" <dhowells@redhat.com>, "Serge
 E. Hallyn" <serge@hallyn.com>, "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Pedro Falcato" <pfalcato@suse.de>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Oscar Salvador" <osalvador@suse.de>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Peter Xu" <peterx@redhat.com>, "Benjamin
 Marzinski" <bmarzins@redhat.com>, "Nico Pache" <nico.pache@linux.dev>, "Kiryl
 Shutsemau" <kas@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Saravana
 Kannan" <saravanak@kernel.org>, "Joshua Hahn" <joshua.hahnjy@gmail.com>, "Rob
 Herring" <robh@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Mike
 Snitzer" <snitzer@kernel.org>, "Matthew Brost" <matthew.brost@intel.com>, "Rik
 van Riel" <riel@surriel.com>, "Harry Yoo" <harry@kernel.org>, "Barry Song" <baohua@kernel.org>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Vlastimil
 Babka" <vbabka@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Herbert
 Xu" <herbert@gondor.apana.org.au>, "Jarkko Sakkinen" <jarkko@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Jann Horn" <jannh@google.com>, "Usama Arif" <usama.arif@linux.dev>, "James
 Morris" <jmorris@namei.org>, =?utf-8?b?SmFuIFNlYmFzdGlhbiBHw7Z0dGU=?= <linux@jaseg.de>, "Suren
 Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, "David Hildenbrand" <david@kernel.org>, "Paul
 Moore" <paul@paul-moore.com>, "Dev Jain" <dev.jain@arm.com>, "Ying Huang" <ying.huang@linux.alibaba.com>, "Danilo
 Krummrich" <dakr@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Arnd
 Bergmann" <arnd@arndb.de>, "Muchun Song" <muchun.song@linux.dev>, "Alasdair
 Kergon" <agk@redhat.com>
Cc: devicetree@vger.kernel.org, linux-arch@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org, dm-devel@lists.linux.dev, linux-integrity@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, linux-fsdevel@vger.kernel.org, "Eric
 Biggers" <ebiggers@kernel.org>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260928-crash-memaction-upstream-20260921-v3-6-e511e9ee2329@jaseg.de>
References: <20260928-crash-memaction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de>
 <20260928-crash-memaction-upstream-20260921-v3-6-e511e9ee2329@jaseg.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:32:49 +0000
Message-Id: <20260928173250.18AAB1F000FF@smtp.kernel.org>
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

> A tfm's context holds the expanded key schedule, which a crash dump
> would capture.
>=20
> Allocate tfms from the secret pool, so that their backing pages are
> marked by crash_memaction for the kdump kernel to wipe.
> The context is a flexible array at the end of struct crypto_tfm and the
> frontend's private data sits in front of the struct, so the whole
> allocation moves into the pool.
>=20
> Allocation cost increases by a bucket lookup in crash_memaction. Freeing
> is unchanged.
>=20
> Signed-off-by: Jan Sebastian G=C3=B6tte <linux@jaseg.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-crash-mema=
ction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de?part=3D6


