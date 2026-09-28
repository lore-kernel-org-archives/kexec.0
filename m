Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A84F606A324
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 08:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NZ3MBQup;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KjJm0noY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dJBj7jrhd8l/3+1i/MYD1Oe07SV8AbeGkY/QzpcIlXk=; b=NZ3MBQupT/n0KM7uOX3H+Lu/1S
	jEUOwFRmWoK7RBBnKRFtpBk5cBXMorYcasvjFO9/X92b6WFqdtQJAoRTZO3AndX9hoSXZJnUK6cQr
	akLqAEEjcoF1MDdtkLyTMHZQ2VAJo3nMKhT1YvdlsfCMj+MVMZNuDSiTeTtgSxPmywuYmz6ycdBOs
	sEvdLvicEy/15ooJ8h9Tw0QhrB5qjjGAuvZuGmNGFenFFhDZREGAvQxgfUfHi8PMSa+RuQAaY6/T5
	mV2yIYObs8ICowoIvdZUu7Dy0FN2Pe2MfRc2tXhXKnPBd9KQBv5m5Qh2GCSuDVhT1rn4xJWl5k8pU
	15ahXTEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ56Q-000000099eJ-1jkv;
	Tue, 20 Oct 2026 08:21:46 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFUQ-00000001Edw-3G1v;
	Mon, 28 Sep 2026 17:50:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5674960120;
	Mon, 28 Sep 2026 17:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F290B1F000FF;
	Mon, 28 Sep 2026 17:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790617809;
	bh=dJBj7jrhd8l/3+1i/MYD1Oe07SV8AbeGkY/QzpcIlXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KjJm0noY+sn5WykpEMYX/0cqYF5OZAonPsiiMo8gsrJp3dbtWXzQ+MUuPiGJZJA0x
	 6jLqI4XrjH/ECSiSdsjKSDEcOX8VHNjxTUmFetbOQTlOnUn092Xi9vWRpAgkcyI7cV
	 VEdR4+s8FUt72QAhYPACB1DPHc7Kdjz2uCMGh47V7dCsVAU9tDI9stHRuVWg4VowUL
	 wsubuRL7tSu1HVvPbp8bYrkCi5Pwl78yS8X19cLVqL1XZl7poDdf3RukkTBc6rpsfh
	 AjjBKhJEyZefMZQzGawiz22PfrG9g5f1MlSZXvtXI+fxD2E2qzuSdugjHmvJG38tDb
	 U9iSc28s9bD3A==
Date: Mon, 28 Sep 2026 18:49:51 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Jan Sebastian =?utf-8?B?R8O2dHRl?= <linux@jaseg.de>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <baoquan.he@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
	Benjamin Marzinski <bmarzins@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biggers <ebiggers@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org, driver-core@lists.linux.dev, 
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, dm-devel@lists.linux.dev, 
	linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 00/12] CRASH_MEMACTION: describe pages to a kdump
 kernel (was: CRASH_WIPE_SECRETS)
Message-ID: <arqli0H0v5qPG22z@gremlin>
References: <20260928-crash-memaction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260928-crash-memaction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de>
X-Mailman-Approved-At: Tue, 20 Oct 2026 01:21:11 -0700
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Sep 28, 2026 at 07:17:48PM +0200, Jan Sebastian Götte wrote:
> I'm using linux on an embedded target in a Hardware Security Module-like
> application. One requirement is that I want the system to be able to
> quickly erase its memory when it detects physical tampering. I'm
> approaching that by using kdump to load into a small payload that
> instead of dumping RAM, erases RAM frmo start to end. However, writing
> all of RAM, especially on an embedded target, is rather slow. For this
> reason, I propose a new crash_memaction mechanism that lets the old
> kernel indicate marked memory areas to the kdump kernel at page
> granularity.

Sorry this all seems really invasive for what seems to be a very specific
use case.

In general, with big changes like this, you should send the series as an
RFC.

Please send any future revisions of this as an RFC.

The bar for a new VMA flag, a new madvise() flag, etc. is really quite
high, and I've already noticed what looks like quite buggy code glancing
through.

And again, I really don't think your case sounds all that compelling for
general users, given how invasive the changes are, so I strongly suggest
you rethink your approach.

In any case, as a newcomer to mm, we really ask that people start with
smaller changes and build up gradually, a change like this really should
only be done by somebody with an established reputation in the kernel.

In general re: AI-generated code see
https://docs.kernel.org/process/generated-content.html

	If tools permit you to generate a contribution automatically, expect
	additional scrutiny in proportion to how much of it was generated.

	As with the output of any tooling, the result may be incorrect or
	inappropriate. You are expected to understand and to be able to defend
	everything you submit. If you are unable to do so, then do not submit the
	resulting changes.

	If you do so anyway, maintainers are entitled to reject your series without
	detailed review.

Thanks!

--
Cheers, Lorenzo

