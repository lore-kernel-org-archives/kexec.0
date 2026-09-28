Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBAC606A319
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QQ/tsBSD;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+w+Z9wE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QAKyyibYUeejb8Whf31Eer9u3DhP0lRlPQeFXRFIdSk=; b=QQ/tsBSDKUdfbOMiWSryS+pCoh
	Vl4bjLLDSB1d7Tc0sNjtPss77jn2nPmcnKObuJK2N/uVXLv6Tpxj7GJycQNjdLEa8mII/KQaBC+Po
	hzDP0X4JpzmRyD4cZaBHwxVRVtKmdKnqJIlinlbidvxB1I0f5Nn6pWH7JJRY/z9U1sDXe4hh9QMpp
	jB/JpBmzO0oNGV7n6vmJUESs4mIr7d/EDo9traLqg/xRe74HXsDDbxCM9dDT5IntItFb/xfuPgSDI
	HA1CyLYwQ1+TUaTMFaGemB3jlXx+9t+semNqAW5JTXOlEeTju40xCqRaD00/qOh9h5Znj/Fq00ebx
	8rZMVI2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ56K-000000099WI-1Zrx;
	Tue, 20 Oct 2026 08:21:40 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFFI-00000001B3n-03GM;
	Mon, 28 Sep 2026 17:34:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6F7C2601FB;
	Mon, 28 Sep 2026 17:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F581F000FF;
	Mon, 28 Sep 2026 17:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790616871;
	bh=QAKyyibYUeejb8Whf31Eer9u3DhP0lRlPQeFXRFIdSk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H+w+Z9wESnUyUk1z3NRUG0aKCTTmaliwJI3UJqNW92EDEx8yWt5IWQ7pyBzgIWwpf
	 edziuZ/MPBo4XgajXrK04hsrEOa/zvy+Ot0IOy60OhSRWI2Td9beXuchZesaQMJd5b
	 Rx0cT24384Qwv2um+9adZ5rPfGE9gkhKL3XL4T7h46kvSYWRzvBblgSqMGdYAp84z9
	 aY6v/2Uk75AUlow9mwHVkzL9YGx+gShh09W6Nwo3BqNgD1a8qNofxUq2ZVccFNV60v
	 nLG95gBh5yDckaxi0qJ/k1pkDigOBbNcvJ6/0B53eAbdssIAMPXl8HHzmteeMssO/b
	 a062/NVRAXUPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/12] mm: Add VM_CRASH_MARK
To: "Mimi Zohar" <zohar@linux.ibm.com>, "Michal Hocko" <mhocko@suse.com>, "Mikulas
 Patocka" <mpatocka@redhat.com>, "Mark Rutland" <mark.rutland@arm.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Jonathan Corbet" <corbet@lwn.net>, "David
 Howells" <dhowells@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, "Usama
 Arif" <usama.arif@linux.dev>, "Arnd Bergmann" <arnd@arndb.de>, "Brendan
 Jackman" <brendan.jackman@linux.dev>, "Saravana Kannan" <saravanak@kernel.org>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Muchun
 Song" <muchun.song@linux.dev>, "Benjamin Marzinski" <bmarzins@redhat.com>, "Will
 Deacon" <will@kernel.org>, "Nico Pache" <nico.pache@linux.dev>, "Alistair
 Popple" <apopple@nvidia.com>, "Suren Baghdasaryan" <surenb@google.com>, "Harry
 Yoo" <harry@kernel.org>, "Rob Herring" <robh@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Pedro Falcato" <pfalcato@suse.de>, "Oscar
 Salvador" <osalvador@suse.de>, "Lorenzo Stoakes" <ljs@kernel.org>, "Zi Yan" <ziy@nvidia.com>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "Byungchul Park" <byungchul@sk.com>, "Peter
 Xu" <peterx@redhat.com>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Barry
 Song" <baohua@kernel.org>, "Paul Moore" <paul@paul-moore.com>, "David
 Hildenbrand" <david@kernel.org>, "Gregory Price" <gourry@gourry.net>,
 =?utf-8?b?SmFuIFNlYmFzdGlhbiBHw7Z0dGU=?= <linux@jaseg.de>, "David S. Miller" <davem@davemloft.net>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Herbert Xu" <herbert@gondor.apana.org.au>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Ying Huang" <ying.huang@linux.alibaba.com>, "Alasdair
 Kergon" <agk@redhat.com>, "Joshua Hahn" <joshua.hahnjy@gmail.com>, "James
 Morris" <jmorris@namei.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Mike Snitzer" <snitzer@kernel.org>, "Lance
 Yang" <lance.yang@linux.dev>, "Danilo Krummrich" <dakr@kernel.org>, "Jann
 Horn" <jannh@google.com>, "Ryan Roberts" <ryan.roberts@arm.com>, "Dev Jain" <dev.jain@arm.com>, "Dave
 Young" <ruirui.yang@linux.dev>, "Kiryl Shutsemau" <kas@kernel.org>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Rik van Riel" <riel@surriel.com>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Matthew Brost" <matthew.brost@intel.com>
Cc: robh@kernel.org, "Eric Biggers" <ebiggers@kernel.org>, conor+dt@kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, devicetree@vger.kernel.org, kexec@lists.infradead.org, linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org, dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
In-Reply-To: <20260928-crash-memaction-upstream-20260921-v3-8-e511e9ee2329@jaseg.de>
References: <20260928-crash-memaction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de>
 <20260928-crash-memaction-upstream-20260921-v3-8-e511e9ee2329@jaseg.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:34:25 +0000
Message-Id: <20260928173427.06F581F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] mm: VM_CRASH_MARK missing from ftrace mmflags VMA flag definitions
- [Low] mm: proc.rst missing documentation for 'cm' VmFlags mnemonic
--

commit 7b00e78975a449ed080eb0472f9ec80a85b781f6
Author: Jan Sebastian G=C3=B6tte <linux@jaseg.de>

mm: Add VM_CRASH_MARK

This commit adds a new VMA flag, VM_CRASH_MARK, to describe folios mapped
into a VMA to the kdump kernel through crash_memaction. The flag indicates
pages to be handled based on the cmdline param, such as secret or cache
pages.

> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index c0d228036b8a6..880946edf4dfa 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1161,6 +1161,9 @@ static void show_smap_vma_flags(struct seq_file *m,=
 struct vm_area_struct *vma)
>  #endif
>  #ifdef CONFIG_64BIT
>  		[ilog2(VM_SEALED)] =3D "sl",
> +#endif
> +#ifdef CONFIG_CRASH_MEMACTION
> +		[ilog2(VM_CRASH_MARK)] =3D "cm",

[Severity: Low]
Since this adds the new cm mnemonic to the smaps output in show_smap_vma_fl=
ags(),
shouldn't this also be documented in Documentation/filesystems/proc.rst so =
users
reading the smaps file can understand what the string means?

>  #endif
>  	};
>  	size_t i;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b9ed4f569b75f..4ffe6350f8655 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
[ ... ]
> @@ -526,6 +530,11 @@ enum {
>  #define VM_ALLOW_ANY_UNCACHED	VM_NONE
>  #define VM_SEALED		VM_NONE
>  #endif
> +#ifdef CONFIG_CRASH_MEMACTION
> +#define VM_CRASH_MARK		INIT_VM_FLAG(CRASH_MARK)

[Severity: Low]
When defining a new VMA flag here, does it also need to be registered in the
__def_vmaflag_names array in include/trace/events/mmflags.h?

If it is omitted, tracing tools capturing mmap or madvise events might outp=
ut
an unknown hexadecimal bit instead of the human-readable crash_mark flag.

> +#else
> +#define VM_CRASH_MARK		VM_NONE
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-crash-mema=
ction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de?part=3D8

