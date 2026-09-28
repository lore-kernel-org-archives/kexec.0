Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991FF606A319
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cK7v/GJX;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eRIVjcZP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+r35xYWViHAiR7sxYREvQL9rqqd84gi08nBU3k0Auv4=; b=cK7v/GJXH78+7Jv4vo13l4gcgb
	LD+4lPXo4S5tGd4xMpngFSVGzQdFiPNEjKwYoJC+It2uXsSUPNXIPbNz19e2n56aFxKWnfCwqgfJM
	muKMii32xr4rftkZvAwhn9qrt1mP9N3yIfogMVZS3NroZY9w91YMQOcPiqcEmOA+QORfI1X7vd/vH
	wqmoYI4nIlqJs7BjciWA1ZU7771UXNudQ6SkDnnYmcsonC0EoFKKy5odEbEmbcuWIUKM3WDVQHV3+
	ah2zJmYClQM6+oEYYEvNasHkzsVHaH1EaaYGxsrlZFdDbVIM7KVIzKlpXtZ3TWEhY2YR7kovClipK
	td0xdntA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ56P-000000099bi-0mQ9;
	Tue, 20 Oct 2026 08:21:45 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFHV-00000001BXg-4237;
	Mon, 28 Sep 2026 17:36:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A111140A75;
	Mon, 28 Sep 2026 17:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C373E1F000FF;
	Mon, 28 Sep 2026 17:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790617009;
	bh=+r35xYWViHAiR7sxYREvQL9rqqd84gi08nBU3k0Auv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eRIVjcZP6kE3UK//4StpY0kavKE44Mjonn9fR2bQ5ywHPLGZY7CPKGdakw96FJB7v
	 XI+YZlkU9mc3zKkw3tpHXI5R2ZR5F0wgAmT8jGSV8rfq/qjY3Mrlw3/qBbfO5WKuOx
	 s2pwzzkvQ1tgzCydYhj5KU1G9S/RnWjDK1uCICxHYGJtHZRNh2ljgOgjqFSmyVgKre
	 qv2Q2JEvM82S9mXhMPyboIDBYJYhYKAkhVWFWtA31dzU9VPBm+4Fvu0cbZEH7y0hKC
	 /4u5L0HiD/WxZdASK4k3eJOlokcp4muwL/as5ZaRhM3Icgjaz+U5b9iPTTX2OZOJTw
	 8GfrReHg+WMTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/12] kexec: Add a crash memaction registry
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Dave Young" <ruirui.yang@linux.dev>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "Kiryl Shutsemau" <kas@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Pedro Falcato" <pfalcato@suse.de>, "Usama Arif" <usama.arif@linux.dev>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "Mark Rutland" <mark.rutland@arm.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Alasdair
 Kergon" <agk@redhat.com>, "Baoquan He" <baoquan.he@linux.dev>, "Matthew
 Brost" <matthew.brost@intel.com>, "Joshua Hahn" <joshua.hahnjy@gmail.com>, "Ying
 Huang" <ying.huang@linux.alibaba.com>, "Serge E. Hallyn" <serge@hallyn.com>, "Jann
 Horn" <jannh@google.com>, "Herbert Xu" <herbert@gondor.apana.org.au>, "David
 S. Miller" <davem@davemloft.net>, "Michal Hocko" <mhocko@suse.com>, "Nico
 Pache" <nico.pache@linux.dev>, "Jarkko Sakkinen" <jarkko@kernel.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "David Hildenbrand" <david@kernel.org>, "Mikulas
 Patocka" <mpatocka@redhat.com>, "Will Deacon" <will@kernel.org>, "Danilo
 Krummrich" <dakr@kernel.org>, "Gregory Price" <gourry@gourry.net>, "Harry
 Yoo" <harry@kernel.org>, "James Morris" <jmorris@namei.org>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Oscar Salvador" <osalvador@suse.de>, "Ryan
 Roberts" <ryan.roberts@arm.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Lance Yang" <lance.yang@linux.dev>, "Muchun
 Song" <muchun.song@linux.dev>, "Rob Herring" <robh@kernel.org>, "Paul Moore" <paul@paul-moore.com>, "Rik
 van Riel" <riel@surriel.com>, "Peter Xu" <peterx@redhat.com>, "Arnd
 Bergmann" <arnd@arndb.de>, "Benjamin Marzinski" <bmarzins@redhat.com>, "Byungchul
 Park" <byungchul@sk.com>, "Saravana Kannan" <saravanak@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Zi Yan" <ziy@nvidia.com>, "Liam R.
 Howlett" <liam@infradead.org>, "Dev Jain" <dev.jain@arm.com>, "Barry Song" <baohua@kernel.org>, "Baolin
 Wang" <baolin.wang@linux.alibaba.com>, "David Howells" <dhowells@redhat.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Catalin Marinas" <catalin.marinas@arm.com>, "Mike
 Rapoport" <rppt@kernel.org>, =?utf-8?b?SmFuIFNlYmFzdGlhbiBHw7Z0dGU=?= <linux@jaseg.de>, "Rafael
 J. Wysocki" <rafael@kernel.org>, "Mike Snitzer" <snitzer@kernel.org>, "Alistair
 Popple" <apopple@nvidia.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Brendan
 Jackman" <brendan.jackman@linux.dev>
Cc: robh@kernel.org, linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-security-module@vger.kernel.org, dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, "Eric
 Biggers" <ebiggers@kernel.org>, kexec@lists.infradead.org, conor+dt@kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260928-crash-memaction-upstream-20260921-v3-1-e511e9ee2329@jaseg.de>
References: <20260928-crash-memaction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de>
 <20260928-crash-memaction-upstream-20260921-v3-1-e511e9ee2329@jaseg.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:36:45 +0000
Message-Id: <20260928173645.C373E1F000FF@smtp.kernel.org>
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

> Add a registry identifying page use to a kdump kernel. Intended uses are
> wiping of crypto keys on crash, or omitting pages holding e.g. crypto
> keys or unimportant caches from crash dumps.
>=20
> The registry is a bitmap with one bit for each physical page. The
> meaning of the bits is set by the crash_memaction=3D cmdline param. When
> not present, no bitmap is allocated. Marking is a lock-free bitmap
> update with no allocation, so it is safe from any context.
>=20
> The bitmap and its metadata is handed over to the kdump kernel through
> elfcorehdr.
>=20
> Signed-off-by: Jan Sebastian G=C3=B6tte <linux@jaseg.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-crash-mema=
ction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de?part=3D1


