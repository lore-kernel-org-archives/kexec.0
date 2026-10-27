Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995C9606A31A
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 00:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jJLga+8i;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oIxSG+Dj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=L5nikXpv/xZsjo16NPMtXyS9I+TzlIHFWn1PxMXRvGw=; b=jJLga+8i461t8cxv57POrhAs06
	euScp7ZVUCELarLzz2BoWFVYvPfUdvnHVUnOnmGvrj/yoCUTUfql9tCxvaYD2umQJAkWRBUCSc4kh
	YFXFMKYbD1Zj7cR3Q1rvVUwg1kRO6xosBzhjF1hQ3JtwnsGzTdUpK8eB8CpLFBI0A0YOODrrYVMxh
	1OFWP7+8N5LQIDO1Y/cveca4izcmILO1GMHvkDxK8OPzgbtdzlY1+7Z9Y57iHSNSV+iH0KazRFQ/8
	AREZ/Gho64Q4ZmUgflJkTmvhR77IbLA6N75MFnifDvv4+n2fDO/nWFflmDWsK1MEKs9L5+3j29vQS
	bgZu43wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLUpA-00000003Vvy-1HtI;
	Tue, 27 Oct 2026 00:13:56 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLUp8-00000003Vut-2sNl
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 00:13:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 213EA600DA;
	Tue, 27 Oct 2026 00:13:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA711F01825;
	Tue, 27 Oct 2026 00:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793060033;
	bh=L5nikXpv/xZsjo16NPMtXyS9I+TzlIHFWn1PxMXRvGw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oIxSG+DjjmyxxX4jMd7BMQL07sCyhIVvel7ZdDHbwR4XanaVidqNFG7wzZoVNjYdq
	 PC9sHXpgnrKIE1TUh5oTVpqDZ/sHCklEentV4ETfIQJC7IKMdSfKDgQI/javy/vVXz
	 5D2ufMPGWwVvCpCGMAZZFVy2mqh0GQWf7vvI6q/947n838lGUowERGJyiOv/i/XwqP
	 BqXROqApXKOBBgVagMTZb3R+jHwoN1zluodQyhmHyl/i1f6cM+jGzsDfdsEHi4bQ+o
	 cSTEsgFXERfeJQ0AngR93Is5+esPl30A2xQ62dVLJW3DpvTEGJ+UjX+oQaEq29L2k1
	 Asl8isKEFVrgQ==
Message-ID: <sashiko-outbox-185916@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 34/46] mm/memory: reject remote COW faults on PFN
 mappings
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
Cc: kexec@lists.infradead.org, "Chris Mason" <mason@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-34-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-34-6f74bec9a5bb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 00:13:50 +0000
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

> From: Chris Mason <mason@kernel.org>
>=20
> When handling a COW fault without a normal source page (PFN mappings),
> __wp_page_copy_user() copies from the faulting user address. For remote
> faults, this accesses the wrong address space, resulting in wrong data
> getting copied.
>=20
> For example, user_events updates an enable bit in the registering
> process's memory. If that memory needs to be faulted in,
> user_event_enabler_fault_fixup() calls fixup_user_fault() from a work
> item. Placing the enable bit in a private PFN mapping can trigger this
> remote COW path.
>=20
> Reject these faults with VM_FAULT_SIGBUS when the target mm differs from
> current->mm: remote faults. Ordinary (non-PFN) mappings are not affected.
>=20
> The user-address copy dates back to commit 6aab341e0a28 ("mm: re-architect
> the VM_UNPAGED logic"); likely, actual ways to get remote faults in
> there on COW PFN mappings appeared afterwards. But the fix is simple and
> straight forward.
>=20
> Fix generated by an LLM and sent by Chris Mason in private.
>=20
> Fixes: 6aab341e0a28 ("mm: re-architect the VM_UNPAGED logic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> [ david: simplify comment and description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-fixes_core=
-v1-0-6f74bec9a5bb@kernel.org?part=3D34


