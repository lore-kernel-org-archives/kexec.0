Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C1D606A320
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VGhrnHyl;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CdVMt+Fz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xXafi02ZLO1Y0xc1WsCP1jTVPyy0rIJ0X6evEJWG+Cs=; b=VGhrnHyl0QYhfjF2IoM83oW/wH
	Z23WIr5dvKjfgacTqGZc6OGErJroykc9HdXcl/RRht5t3cWMpQ0Z34zUuladIF8di+KyG/1nNmar+
	hobrdni+x+4LcqyGop7M1e8414xXg6ukqGU3cEEecsynmI829m6BNVmNPVGzrwl5ylI8TK+LbfwIQ
	6mgUP2Ug0a/jRTVlUN6XWORQZ2Kp8tT0tZ2aZE2YHuP0fpHo9sKPvLR3ZPEdXWXESZINiMU2oSffm
	Ns2fNQazzwiRjhz6JQKUA0We6Wo6exr++sAFOTDxu92U3KOFt10gecFdfAri5lLibSZq1QGMwfNnX
	NrUTioiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ56O-000000099bN-3qCS;
	Tue, 20 Oct 2026 08:21:44 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFHN-00000001BUO-2QkX;
	Mon, 28 Sep 2026 17:36:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 88D0B60120;
	Mon, 28 Sep 2026 17:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B211F000FF;
	Mon, 28 Sep 2026 17:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790617000;
	bh=xXafi02ZLO1Y0xc1WsCP1jTVPyy0rIJ0X6evEJWG+Cs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CdVMt+Fzf8G8t9rbknnGaVrM5SS+D6vf8+Yoh8W6ZNN6HA8AwFKbWq4iAqfZXz+Ft
	 d6MVIyxwinfxhUDgeSbx7Dog/6xDVinP9/nnAQpm3L3BeHj6F2w9uLhGMX0RIwqRFp
	 ow0hYfT1lH9zRieXdzWZTFJ3OuwSjepCBV16JWZsA0vXLvh1ZOhMNs5F+OsbJov4tp
	 Rvcjcg0CXhk62W2ijvnpQb0dh5CrMyp0hQ+z20rlXdt1LlRtr6DDTzOnq5FPBrwN13
	 /j0jojUVX3IMJsrMgcEwhZ5ROe55Wv7PFan2FBHF9O9li/r2rx/qWmXuyEF8Ks1t22
	 NGObYvk9JQFvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/12] lib, kexec: Add a secret pool for key material
To: "Rob Herring" <robh@kernel.org>, "Barry Song" <baohua@kernel.org>, "Matthew
 Brost" <matthew.brost@intel.com>, "Zi Yan" <ziy@nvidia.com>, "David Howells" <dhowells@redhat.com>, "Dev
 Jain" <dev.jain@arm.com>, "David Hildenbrand" <david@kernel.org>, "Herbert
 Xu" <herbert@gondor.apana.org.au>, "Andrew Morton" <akpm@linux-foundation.org>, "Benjamin
 Marzinski" <bmarzins@redhat.com>, "Michal Hocko" <mhocko@suse.com>, "Johannes
 Weiner" <hannes@cmpxchg.org>, =?utf-8?b?SmFuIFNlYmFzdGlhbiBHw7Z0dGU=?= <linux@jaseg.de>, "Mark
 Rutland" <mark.rutland@arm.com>, "Kiryl Shutsemau" <kas@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "James Morris" <jmorris@namei.org>, "Rik
 van Riel" <riel@surriel.com>, "Usama Arif" <usama.arif@linux.dev>, "Mikulas
 Patocka" <mpatocka@redhat.com>, "Mike Snitzer" <snitzer@kernel.org>, "Lance
 Yang" <lance.yang@linux.dev>, "Randy Dunlap" <rdunlap@infradead.org>, "Baolin
 Wang" <baolin.wang@linux.alibaba.com>, "Byungchul Park" <byungchul@sk.com>, "Paul
 Moore" <paul@paul-moore.com>, "Lorenzo Stoakes" <ljs@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "David
 S. Miller" <davem@davemloft.net>, "Peter Xu" <peterx@redhat.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Brendan Jackman" <brendan.jackman@linux.dev>, "Harry
 Yoo" <harry@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Oscar
 Salvador" <osalvador@suse.de>, "Pedro Falcato" <pfalcato@suse.de>, "Gregory
 Price" <gourry@gourry.net>, "Mimi Zohar" <zohar@linux.ibm.com>, "Saravana
 Kannan" <saravanak@kernel.org>, "Joshua Hahn" <joshua.hahnjy@gmail.com>, "Baoquan
 He" <baoquan.he@linux.dev>, "Jann Horn" <jannh@google.com>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Muchun
 Song" <muchun.song@linux.dev>, "Suren Baghdasaryan" <surenb@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Alistair Popple" <apopple@nvidia.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Ryan Roberts" <ryan.roberts@arm.com>, "Danilo
 Krummrich" <dakr@kernel.org>, "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Alasdair Kergon" <agk@redhat.com>, "Will
 Deacon" <will@kernel.org>, "Nico Pache" <nico.pache@linux.dev>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Dave Young" <ruirui.yang@linux.dev>, "Ying
 Huang" <ying.huang@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, keyrings@vger.kernel.org, robh@kernel.org, linux-doc@vger.kernel.org, conor+dt@kernel.org, dm-devel@lists.linux.dev, linux-mm@kvack.org, linux-integrity@vger.kernel.org, devicetree@vger.kernel.org, driver-core@lists.linux.dev, linux-fsdevel@vger.kernel.org, "Eric
 Biggers" <ebiggers@kernel.org>, linux-security-module@vger.kernel.org, linux-crypto@vger.kernel.org, linux-arch@vger.kernel.org
In-Reply-To: <20260928-crash-memaction-upstream-20260921-v3-2-e511e9ee2329@jaseg.de>
References: <20260928-crash-memaction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de>
 <20260928-crash-memaction-upstream-20260921-v3-2-e511e9ee2329@jaseg.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:36:35 +0000
Message-Id: <20260928173636.78B211F000FF@smtp.kernel.org>
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] lib/secret_pool: fallback to shared kmalloc inadvertently marks en=
tire pages as secret
--

commit 774a436bfd0576d919ce17b831096d5b8c8dbbb5
Author: Jan Sebastian G=C3=B6tte <linux@jaseg.de>

lib, kexec: Add a secret pool for key material
   =20
Key material allocated with kmalloc() shares its slab pages with
unrelated allocations. crash_memaction marks memory at page granularity,
so smaller objects in shared slab pages can't cleanly be marked or
unmarked. This commit adds a secret pool built on kmem_buckets to
hold such keys in marked pages.

> diff --git a/lib/secret_pool.c b/lib/secret_pool.c
> new file mode 100644
> index 0000000000000..62954847091a0
> --- /dev/null
> +++ b/lib/secret_pool.c
> @@ -0,0 +1,27 @@
[ ... ]
> +void *secret_pool_alloc_node(size_t size, gfp_t flags, int node)
> +{
> +	void *p =3D kmem_buckets_alloc_node_track_caller(secret_pool, size,
> +						       flags, node);
> +
> +	crash_memaction_mark(p, size, CRASH_MEMACTION_SECRET);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does this unconditionally mark the allocation even if it falls back to a sh=
ared
kmalloc page?

The commit message notes that if the secret pool is used before its initcall
runs or if pool creation fails, allocations will fall back to ordinary kmal=
loc
caches.

Because crash_memaction_mark() operates at page granularity, wouldn't calli=
ng
it on a shared kmalloc page inadvertently mark the entire page (and unrelat=
ed
kernel objects sharing it) as a secret?

In the event of a crash, could this cause the kdump kernel to wipe or exclu=
de
these shared pages, potentially destroying crash data?

> +
> +	return p;
> +}
> +EXPORT_SYMBOL_GPL(secret_pool_alloc_node);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-crash-mema=
ction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de?part=3D2

