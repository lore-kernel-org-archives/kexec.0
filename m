Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1819B606A31A
	for <kexec@archiver.kernel.org>; Fri, 30 Oct 2026 03:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oGkj7mTi;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WVyySgER
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4lRxhCLjKYbzZrW1LP9LsvCg6C3CF6EvR60YksWCfl8=; b=oGkj7mTijueEHeWmK9XUwuvC+B
	C0w74Qfo0Hk8C9ZJf16SlhSzOMCGeVylB99UIOO4VL9qPRZANG0+QQ8z0Eet9hz/aQHQLso3N3HWR
	OXYvjeQWsDghLZSE4JRLq662yOEfVCw4rJSmuDmkHRmTHKd5nG7VLcMe02Th65wFBEMU6BNRZ7B/S
	thNLpW/f5rX+pZO4JS2ImzA4WVZXBnom+Tk3B7DM6tuowbRHTPkFfdEmx0DBZfA2qnrK4yklc7cym
	1HYfnmXZUbPBjca6u+IKVmxL2z1wHWtaJiUiD4qlhrMyyiBQi40HNjaLUbL6b2DjtukrYIETLpY1Y
	XXoAXiFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdUl-0000000AkXN-3PIw;
	Fri, 30 Oct 2026 03:41:35 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMdUk-0000000AkWV-2kTk
	for kexec@lists.infradead.org;
	Fri, 30 Oct 2026 03:41:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1A29F600E4;
	Fri, 30 Oct 2026 03:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A631F0093A;
	Fri, 30 Oct 2026 03:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793331693;
	bh=4lRxhCLjKYbzZrW1LP9LsvCg6C3CF6EvR60YksWCfl8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WVyySgERMHVSxUqifi/JMmcn/EqHFuU6YjwSYdSJX+vzf8M88BsPlZLQ1JXJlS+Ng
	 ltMyaUQBeG8WeLE/E+YPADTYkqlaiI/tLF8suEfzSmJA6olzBnxL/cf4/7t0HLY+JG
	 Qowqt5VAG+NLCvPStUwzQe5P0VmgpOCQwEcMpcK1xjt4MinS2idNVwmtlj35vPRuqq
	 bjNIqA072LnRMCiYOHWkLLza/pjKGunM7F6tn/2UvoCoSq8Q7Vzi7fZibQVfGqcVUc
	 l7Xl8wFIZfSd0RgJnGBI3jcVteuFceiYHS+PtfX/Py+BkVuGXdFnXehwss85yf5s2U
	 ugfixc6SvuBdw==
Message-ID: <sashiko-outbox-190253@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 25/47] mm/userfaultfd: wake waiters when registration
 modes are removed
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Johannes Weiner" <hannes@cmpxchg.org>, "Michal
 Hocko" <mhocko@kernel.org>, "Qi Zheng" <qi.zheng@linux.dev>, "Shakeel Butt" <shakeel.butt@linux.dev>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Kairui Song" <kasong@tencent.com>, "Barry Song" <baohua@kernel.org>, "Axel
 Rasmussen" <axelrasmussen@google.com>, "Yuanchu Xie" <yuanchu@google.com>, "Wei
 Xu" <weixugc@google.com>, "Baoquan He" <baoquan.he@linux.dev>, "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Liam
 R. Howlett" <liam@infradead.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Kees Cook" <kees@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Jann
 Horn" <jannh@google.com>, "Pedro Falcato" <pfalcato@suse.de>, "Hugh Dickins" <hughd@google.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>,
 =?utf-8?b?TWF0dGhldyBXaWxjb3ggKE9yYWNsZSk=?= <willy@infradead.org>, "Jan
 Kara" <jack@suse.cz>, "Zi Yan" <ziy@nvidia.com>, "Lance Yang" <lance.yang@linux.dev>, "Rik
 van Riel" <riel@surriel.com>, "Harry Yoo" <harry@kernel.org>, "Alistair
 Popple" <apopple@nvidia.com>, "Nico Pache" <nico.pache@linux.dev>, "Ryan
 Roberts" <ryan.roberts@arm.com>, "Dev Jain" <dev.jain@arm.com>, "Usama Arif" <usama.arif@linux.dev>, "Kiryl
 Shutsemau" <kas@kernel.org>, "Matthew Brost" <matthew.brost@intel.com>, "John
 Hubbard" <jhubbard@nvidia.com>, "Peter Xu" <peterx@redhat.com>, "Will
 Deacon" <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Nick
 Piggin" <npiggin@gmail.com>, "Oscar Salvador" <osalvador@suse.de>, "Minchan
 Kim" <minchan@kernel.org>, "Muchun Song" <muchun.song@linux.dev>, "Xu Xin" <xu.xin@linux.dev>, "Chengming
 Zhou" <chengming.zhou@linux.dev>, "Chris Li" <chrisl@kernel.org>, "Kemeng
 Shi" <shikemeng@huaweicloud.com>, "Nhat Pham" <nphamcs@gmail.com>, "Youngjun
 Park" <youngjun.park@lge.com>, "Gregory Price" <gourry@gourry.net>, "Joshua
 Hahn" <joshua.hahnjy@gmail.com>, "Rakie Kim" <rakie.kim@sk.com>, "Ying
 Huang" <ying.huang@linux.alibaba.com>, "Jason Gunthorpe" <jgg@ziepe.ca>
Cc: kexec@lists.infradead.org
In-Reply-To: <20261029-fixes_core-v2-25-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-25-a64ce7f83abb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 03:41:30 +0000
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> UFFDIO_REGISTER can replace MISSING or MINOR tracking without waking
> faults that are already queued. For example, switching an anonymous
> range from MISSING to WP leaves a missing-fault waiter asleep until
> userspace explicitly wakes it.
>=20
> When a registration change removes a UFFD mode, wake waiters in the
> affected interval after updating the VMA. The VMA is write-locked at
> this point, so no new faults can queue under the old modes and woken
> threads cannot retry until mmap_write_unlock(). Waiters for retained
> modes in the same interval may also wake and refault.
>=20
> The hang reproduces for MISSING-to-WP and MINOR-to-MISSING transitions,
> with both read and unread fault events.
>=20
> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfa=
ultfd ioctl")
> Cc: stable@vger.kernel.org
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-fixes_core=
-v2-0-a64ce7f83abb@kernel.org?part=3D25


