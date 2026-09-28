Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39ED606A31C
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TWCFvKPm;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3XNkJUM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nU2fH54lTM/XVwJXQyjGLBeD3ZciwzAWp4eXcqDvdbM=; b=TWCFvKPmZmVp8uvb9YdjgIVqwy
	r/XsULo8wIk28w81jRZB2Dho8DBuZ+7jzJuwrmxEiLAHeftXS3a65o/ku1XGTciq6VGf6+9r3J4nS
	t0/sLqtjak+Gwnr7PLQGtSFnu/3evN8hLzBrIH4dqLjqNlaSorJQPnYYTugMbvg5Y+ALo5nOUpDs3
	MVw6NwZtDf9sXYxRg3G5sIvebX7A4TiDiTvcHK6b6MyA/jviMQrWZWrARkU1Z68v1HF9jXVRSKYEq
	BF6fzLYUQA1qu56va0PDwByU+SfRn+ocfVsm0V33691Rk4kb67cA7IAd+SbxX6Zs+Y41worHs01a6
	E+4te2ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ56P-000000099cw-2fpB;
	Tue, 20 Oct 2026 08:21:45 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFJA-00000001BsO-2f9v;
	Mon, 28 Sep 2026 17:38:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 52E5B436EE;
	Mon, 28 Sep 2026 17:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9521F00893;
	Mon, 28 Sep 2026 17:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790617112;
	bh=nU2fH54lTM/XVwJXQyjGLBeD3ZciwzAWp4eXcqDvdbM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S3XNkJUMsfb4UVOiI5bqkQdMQxSrtSwJSk+zko+Kb8nyx1/fqNP+w7Q7XMX4d9LFS
	 UpCy7pFlCeLa40OP6BXCxLJAzMBOd9S9sxWq8L8Jtt8orYI0l5uqfdJZROyth2vfib
	 5uQjGgfd2Z1mVJgCwOGmsJxkE0gLFEG3SX22xLC77eFkOJMnQzLdB37T2NqjWpNoyp
	 FTppfoE54PLRaqkGfhCai4quB2BGHu9vVrE9Ttd2f5wdvTQz58p7klVEjZDYk8ILzq
	 0uWbZHan00HjovXjqsXB+ZjTvra2/JJk7Xr6L34CRAqtG/8M4oLEVkPLj0ZgwqrtyI
	 1xxzJXt9dk+iA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/12] kexec: Expose the crash memaction bitmap in
 debugfs
To: "David Hildenbrand" <david@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Joshua
 Hahn" <joshua.hahnjy@gmail.com>, "Jann Horn" <jannh@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Michal Hocko" <mhocko@suse.com>, "Will
 Deacon" <will@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Harry
 Yoo" <harry@kernel.org>, "Nico Pache" <nico.pache@linux.dev>, "Herbert Xu" <herbert@gondor.apana.org.au>, "Peter
 Xu" <peterx@redhat.com>, "Mark Rutland" <mark.rutland@arm.com>, "Usama Arif" <usama.arif@linux.dev>, "Rik
 van Riel" <riel@surriel.com>, "Shuah Khan" <skhan@linuxfoundation.org>, "James
 Morris" <jmorris@namei.org>, "Dev Jain" <dev.jain@arm.com>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "Paul Moore" <paul@paul-moore.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Pedro Falcato" <pfalcato@suse.de>, "Baolin
 Wang" <baolin.wang@linux.alibaba.com>, "Ryan Roberts" <ryan.roberts@arm.com>, "Alasdair
 Kergon" <agk@redhat.com>, "Vlastimil Babka" <vbabka@kernel.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Rob Herring" <robh@kernel.org>, "Zi Yan" <ziy@nvidia.com>, "Mikulas
 Patocka" <mpatocka@redhat.com>, "Barry Song" <baohua@kernel.org>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Kiryl Shutsemau" <kas@kernel.org>, "Muchun
 Song" <muchun.song@linux.dev>, "Randy Dunlap" <rdunlap@infradead.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "David
 Howells" <dhowells@redhat.com>, "Saravana Kannan" <saravanak@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Benjamin Marzinski" <bmarzins@redhat.com>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Baoquan He" <baoquan.he@linux.dev>, "Dave
 Young" <ruirui.yang@linux.dev>, "Oscar Salvador" <osalvador@suse.de>, "Byungchul
 Park" <byungchul@sk.com>, "Alistair Popple" <apopple@nvidia.com>, "Lance
 Yang" <lance.yang@linux.dev>, "Brendan Jackman" <brendan.jackman@linux.dev>, "Matthew
 Brost" <matthew.brost@intel.com>, "Suren Baghdasaryan" <surenb@google.com>, "Ying
 Huang" <ying.huang@linux.alibaba.com>, "Arnd Bergmann" <arnd@arndb.de>, "Jonathan
 Corbet" <corbet@lwn.net>, "Mimi Zohar" <zohar@linux.ibm.com>, "Danilo
 Krummrich" <dakr@kernel.org>, "Gregory Price" <gourry@gourry.net>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Mike Snitzer" <snitzer@kernel.org>,
 =?utf-8?b?SmFuIFNlYmFzdGlhbiBHw7Z0dGU=?= <linux@jaseg.de>
Cc: linux-arm-kernel@lists.infradead.org, dm-devel@lists.linux.dev, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, "Eric
 Biggers" <ebiggers@kernel.org>, devicetree@vger.kernel.org, linux-security-module@vger.kernel.org, kexec@lists.infradead.org, driver-core@lists.linux.dev, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, conor+dt@kernel.org, linux-crypto@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260928-crash-memaction-upstream-20260921-v3-12-e511e9ee2329@jaseg.de>
References: <20260928-crash-memaction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de>
 <20260928-crash-memaction-upstream-20260921-v3-12-e511e9ee2329@jaseg.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:38:29 +0000
Message-Id: <20260928173829.9E9521F00893@smtp.kernel.org>
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
- [Low] kconfig: syntax error due to insufficient indentation in help text
--

commit d0f9200d03ebaf0ef39b9f78a15ab259102ed7e8
Author: Jan Sebastian G=C3=B6tte <linux@jaseg.de>

kexec: Expose the crash memaction bitmap in debugfs

This commit adds debugfs support to expose the crash memaction bitmap by
creating "regions" and "bitmap" files under /sys/kernel/debug/crash_memacti=
on/.
The feature is guarded by the new CONFIG_CRASH_MEMACTION_DEBUGFS option.

> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 3cdc8d459ac05..b5380e16bfafb 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -204,4 +204,18 @@ config CRASH_MEMACTION

[ ... ]

> +config CRASH_MEMACTION_DEBUGFS
> +	bool "Expose the crash memaction bitmap in debugfs"
> +	depends on CRASH_MEMACTION && DEBUG_FS
> +	help
> +	  Allow reading the live crash_memaction bitmap through
> +      /sys/kernel/debug/crash_memaction/. The bitmap is used when

[Severity: Low]
Does this indentation break the Kconfig help block?

The first line of the help text is indented with 1 tab and 2 spaces (which
is equivalent to 10 spaces in Kconfig), but this line starts with only 6
spaces. The Kconfig lexer terminates a help block when it encounters an
indentation level lower than the block's first line. This could cause the
parser to interpret the rest of the text as an invalid Kconfig directive,
potentially resulting in a syntax error and build failure during make confi=
g.

> +      CRASH_MEMACTION is set and when a crash_memaction cmdline param is=
 present
> +      to tell an eventual kdump kernel about the use of certain memory p=
ages.
> +
> +      Note that this is a debug interface only that gives no guarantees
> +      whatsoever on memory consistency.
> +
> +	  If unsure, say N.
> +
>  endmenu

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-crash-mema=
ction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de?part=3D12

