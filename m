Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC7A60A2616
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0cQ6bYbh;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aaaRP7xu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YUNsQKbdoNdkmOn7hVMkhLGJNjStR4GPA47+J2XShC8=; b=0cQ6bYbhOZ1mX2r+8wfbz1Ocrr
	2n3HhfwbYS0oe78+dVioaENuK+0B1bz0CtGjXIYtKraF+mHehPOAJFjf2PCQi2UchjnBzrPEgCyvn
	0imlfSsLcmy+G8vGsnVnLAm+qyMa3uHVuHOydyt5y9xvgsCCTO+yzKp/Qsz9Yqctimi1bfrXmJ5e9
	KV9KXzP+gqvT1LIhqUyQ8G9HlwNdrlR4d6GsOi7VmvfWbTEAUPVydKeHGKqxKMvx3FelpTJ00YHZv
	iw2R1MBDP1/gRQAk2kMtykHFZ0bLpEtEOGT64JyOv+Hnqkq4QWIjDd1IzwkgH/17VA/e2uvpheX0Y
	ntHh5jkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ56A-000000099KB-3utC;
	Tue, 20 Oct 2026 08:21:31 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFCg-00000001AZc-1nOY;
	Mon, 28 Sep 2026 17:31:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C98F6600D1;
	Mon, 28 Sep 2026 17:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E5F1F000FF;
	Mon, 28 Sep 2026 17:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790616709;
	bh=YUNsQKbdoNdkmOn7hVMkhLGJNjStR4GPA47+J2XShC8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aaaRP7xu4vYzsbzzIB1ARh5jRF/4XJXKwPf+eveA2AT8Jqgpt1Dnjgyzvhb6dw3MN
	 s5SsekoSkivHHuRMmjC8WK+SNNa6oKFRebBMX+pN+jDJMgAGxCCLmBp3y5icFGCyhq
	 koLG98wagBmCJ91hpHOfudtH6lk7UG6sxDevYDhmrwIL+e6sTydtzOC05AhgMH5nAw
	 VhsKAc6sD+RdhsMIBV2DVLUmCWQ+TBtLqTSr+vRei2d6ksq1uQcIEXUBbTV1E41N5c
	 FPQgqNF2AvWgUTJmSpxqa1beS5wNqni9CREmTJ+4t9aZH1Me00wySFaMVs7FJ3kIdV
	 Gx2ByASjD6MFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/12] Documentation/mm: Document the crash memaction
 registry
To: "Mikulas Patocka" <mpatocka@redhat.com>, "David Hildenbrand" <david@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Michal Hocko" <mhocko@suse.com>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Peter
 Xu" <peterx@redhat.com>, "Danilo Krummrich" <dakr@kernel.org>, "Ying Huang" <ying.huang@linux.alibaba.com>, "Jann
 Horn" <jannh@google.com>, "Herbert Xu" <herbert@gondor.apana.org.au>, "Saravana
 Kannan" <saravanak@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Gregory
 Price" <gourry@gourry.net>, "Catalin Marinas" <catalin.marinas@arm.com>, "Mike
 Snitzer" <snitzer@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Harry
 Yoo" <harry@kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>, "Matthew Brost" <matthew.brost@intel.com>,
 =?utf-8?b?SmFuIFNlYmFzdGlhbiBHw7Z0dGU=?= <linux@jaseg.de>, "Paul Moore" <paul@paul-moore.com>, "Rob
 Herring" <robh@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Nico
 Pache" <nico.pache@linux.dev>, "Baoquan He" <baoquan.he@linux.dev>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Muchun Song" <muchun.song@linux.dev>, "Kiryl
 Shutsemau" <kas@kernel.org>, "Dev Jain" <dev.jain@arm.com>, "Arnd Bergmann" <arnd@arndb.de>, "David
 S. Miller" <davem@davemloft.net>, "Suren Baghdasaryan" <surenb@google.com>, "Serge
 E. Hallyn" <serge@hallyn.com>, "Will Deacon" <will@kernel.org>, "Ryan
 Roberts" <ryan.roberts@arm.com>, "Mike Rapoport" <rppt@kernel.org>, "Benjamin
 Marzinski" <bmarzins@redhat.com>, "Jarkko Sakkinen" <jarkko@kernel.org>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Byungchul
 Park" <byungchul@sk.com>, "Lance Yang" <lance.yang@linux.dev>, "Brendan
 Jackman" <brendan.jackman@linux.dev>, "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Dave
 Young" <ruirui.yang@linux.dev>, "Zi Yan" <ziy@nvidia.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Barry
 Song" <baohua@kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>, "Mark
 Rutland" <mark.rutland@arm.com>, "Pedro Falcato" <pfalcato@suse.de>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "Joshua Hahn" <joshua.hahnjy@gmail.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Vlastimil Babka" <vbabka@kernel.org>, "James
 Morris" <jmorris@namei.org>, "Oscar Salvador" <osalvador@suse.de>, "Rik van
 Riel" <riel@surriel.com>, "Usama Arif" <usama.arif@linux.dev>, "Alasdair
 Kergon" <agk@redhat.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, "Eric Biggers" <ebiggers@kernel.org>, linux-security-module@vger.kernel.org, conor+dt@kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org, dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, keyrings@vger.kernel.org, driver-core@lists.linux.dev, linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, linux-arch@vger.kernel.org
In-Reply-To: <20260928-crash-memaction-upstream-20260921-v3-11-e511e9ee2329@jaseg.de>
References: <20260928-crash-memaction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de>
 <20260928-crash-memaction-upstream-20260921-v3-11-e511e9ee2329@jaseg.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:31:44 +0000
Message-Id: <20260928173144.96E5F1F000FF@smtp.kernel.org>
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

> Describe the crash memaction registry, including its kernel and userspace
> interfaces, allocation lifetime rules, and current limitations.
>=20
> Signed-off-by: Jan Sebastian G=C3=B6tte <linux@jaseg.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-crash-mema=
ction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de?part=3D11


