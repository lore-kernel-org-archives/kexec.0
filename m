Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5208660A261E
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ii0xte4D;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CiOBtobw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8v0HMtdYSmeR7hSMV83Y5zxCj1beVOpYUQy4t0SZILE=; b=Ii0xte4Dc6wvjX4GhMYVVN4ux+
	fyL+ATDsuB9MMSt7sPjJA5eafbr7Y25Z/YhyvnU8l2TSVT9eHTZ+DiEOpUxG6iyKaMESRjdC5AJ9o
	O0H2rQQEa04hXgRdMN87Efiqjl4FZXoPMiajNtgK9I/GqauWW5X++Vr1ZB0nrW4udMA7ka2GaLCv4
	j38qAQgXnWI4NEk7Olep3cGNVZ/uws0+Ea0rK5RqA7sEp8z7vtaiMFpp6KACKYKNn16I8sGu94Wbb
	co5oLBWf9Hw6g6c1PeF0/WUl9a0/D0emjzBGak4ygnXj7fYj5RjB8q0tvC0bPl7CPg+KtALtClBCG
	cEwDlUDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ56B-000000099Mb-1Xya;
	Tue, 20 Oct 2026 08:21:31 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFD8-00000001Afi-3aoA;
	Mon, 28 Sep 2026 17:32:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4A3A4601F0;
	Mon, 28 Sep 2026 17:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604931F000FF;
	Mon, 28 Sep 2026 17:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790616738;
	bh=8v0HMtdYSmeR7hSMV83Y5zxCj1beVOpYUQy4t0SZILE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CiOBtobwfu4y22KpWjQYigG/SpghA3ZMlFopVsdnLt72agD6Na8u4zEaQV1gDfh/R
	 vPhP2hluuNYNnSKQ/oHFemJe2nmSOsG5hEzgjoBbn4FmBi94jSRYmehzmjhl+smP9k
	 Ynk0BgeUjd5wjzXn25xE16bMc897uxA3eya68pnLc2QlFHAtS0MZ1lnaq2WB7u2ZK8
	 fuY4ufUCglEtqbXnKVuv0r1LdgP8eQ7+CKClYlZnICwdD8HHYQyB2LaDjPAn/PX5Tj
	 Bu952lnXnp0ztfZLVtYiYzSRtQ62djuzg99bhr2cV6f05Ooqt3Rn776dbFVVVvDNdJ
	 JhQSWw0Ks2zVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/12] security/keys: Allocate key payloads from the
 secret pool
To: "David Hildenbrand" <david@kernel.org>, "Paul Moore" <paul@paul-moore.com>, "Muchun
 Song" <muchun.song@linux.dev>, "Michal Hocko" <mhocko@suse.com>, "Mikulas
 Patocka" <mpatocka@redhat.com>, "Mike Snitzer" <snitzer@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Oscar Salvador" <osalvador@suse.de>, "Kiryl
 Shutsemau" <kas@kernel.org>, "David Howells" <dhowells@redhat.com>, "Ryan
 Roberts" <ryan.roberts@arm.com>, "Danilo Krummrich" <dakr@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, "Vlastimil Babka" <vbabka@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Ying Huang" <ying.huang@linux.alibaba.com>, "Liam
 R. Howlett" <liam@infradead.org>, "Baoquan He" <baoquan.he@linux.dev>, "Nico
 Pache" <nico.pache@linux.dev>, "Matthew Brost" <matthew.brost@intel.com>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Rob Herring" <robh@kernel.org>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "David
 S. Miller" <davem@davemloft.net>, "Alasdair Kergon" <agk@redhat.com>, "Lance
 Yang" <lance.yang@linux.dev>, "Barry Song" <baohua@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Zi
 Yan" <ziy@nvidia.com>, "Herbert Xu" <herbert@gondor.apana.org.au>, "Peter
 Xu" <peterx@redhat.com>, "Dev Jain" <dev.jain@arm.com>, "Johannes Weiner" <hannes@cmpxchg.org>, "Arnd
 Bergmann" <arnd@arndb.de>, "Will Deacon" <will@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jonathan Corbet" <corbet@lwn.net>, "Saravana
 Kannan" <saravanak@kernel.org>, "Brendan Jackman" <brendan.jackman@linux.dev>, "Benjamin
 Marzinski" <bmarzins@redhat.com>, "Pedro Falcato" <pfalcato@suse.de>,
 =?utf-8?b?SmFuIFNlYmFzdGlhbiBHw7Z0dGU=?= <linux@jaseg.de>, "Jann Horn" <jannh@google.com>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Byungchul Park" <byungchul@sk.com>, "Gregory
 Price" <gourry@gourry.net>, "Usama Arif" <usama.arif@linux.dev>, "Serge E.
 Hallyn" <serge@hallyn.com>, "James Bottomley" <James.Bottomley@HansenPartnership.com>, "James
 Morris" <jmorris@namei.org>, "Rik van Riel" <riel@surriel.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Harry Yoo" <harry@kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>, "Dave
 Young" <ruirui.yang@linux.dev>, "Joshua Hahn" <joshua.hahnjy@gmail.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Alistair Popple" <apopple@nvidia.com>
Cc: conor+dt@kernel.org, linux-fsdevel@vger.kernel.org, robh@kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, dm-devel@lists.linux.dev, kexec@lists.infradead.org, linux-arch@vger.kernel.org, driver-core@lists.linux.dev, "Eric
 Biggers" <ebiggers@kernel.org>, devicetree@vger.kernel.org
In-Reply-To: <20260928-crash-memaction-upstream-20260921-v3-7-e511e9ee2329@jaseg.de>
References: <20260928-crash-memaction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de>
 <20260928-crash-memaction-upstream-20260921-v3-7-e511e9ee2329@jaseg.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:32:15 +0000
Message-Id: <20260928173215.604931F000FF@smtp.kernel.org>
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

> Key payloads sit in memory in plain text for as long as the key exists,
> and a kdump crash dump captures them along with everything else.
>=20
> Allocate the payloads of the user-defined, trusted and encrypted key
> types from the new secret pool, so that their backing pages are marked
> by crash_memaction for the kdump kernel to wipe.
>=20
> This commit covers the key types used by dm-crypt/cryptsetup. Additional
> key types can be added if needed in future commits.
>=20
> Signed-off-by: Jan Sebastian G=C3=B6tte <linux@jaseg.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-crash-mema=
ction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de?part=3D7


