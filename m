Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D7D606A323
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Mz2TRNdE;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJSi/vmL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2cBJI2nnIkywytYzxR6H/QQFOPTi1qFD5/ttRLHdX9w=; b=Mz2TRNdE3RC7NZAdZRNg2+qy6r
	9WiMVKdOtgUV6jVC/iTbBckrNsN+4fKQMVs1N5+cVYPKuh1KipHv6ndIdYIW6NmvElFD0D0IQqjXp
	SIW7WwwtWBjiJj/HLzZtWgLz4nqdSFtG7V1dWBdMRRSjnuli5hp8zt+Rp0C6dC57PH33KJkXwmCS/
	ODNu+GxyKy4iPudp5LskEPg5C9c9A60FxRprBtLMcQ1mEhFGt6iiv0CbpefJV+A/K1mfVV4tOA1xR
	hTvxCUgLamiusoH3OAybl/ISfLpmUFZYB4qXCbBxYYLn3ADRiPQpXLKt345MjywDY7SLeFdfxB6cS
	PwzwD/Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLl8Y-00000005U13-13gv;
	Tue, 27 Oct 2026 17:39:02 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLl8W-00000005U0O-1HUq
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 17:39:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BFBE043DB2;
	Tue, 27 Oct 2026 17:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC361F01825;
	Tue, 27 Oct 2026 17:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793122739;
	bh=2cBJI2nnIkywytYzxR6H/QQFOPTi1qFD5/ttRLHdX9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XJSi/vmLDkwnReKwKmEX4JRALl4syw+iIaeGn0uJWZZMKBFHHtHiF7enafrQ9woRP
	 yoSRlydCDwzuwwl/OCE+bZzKi3TXFoBvcoJ7/8vdphLqH13Vv4flItJXCKhApdPjX5
	 1fhiuCB7uODos7v0qtlUXi9BUb8CZY6nWHQ8JhpV8fhP6cfpK7Sb1TnmkbRqOB7ra7
	 8cu4ZAjnKmBA7PU8Ne84zg0Cmmg3Gh5PgrGF7ASspqYFeRa0sOzJLgYGuukSpK0FBJ
	 qjrKoONkCB6PmdFb5kmfDuZmQRqF1xnZH1d8ct2sQ+Bidhd/moOzuhhrX9Swacz4DS
	 c10ssfWxCS0og==
From: Pratyush Yadav <pratyush@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>,  Jan
 Kara <jack@suse.cz>,  "Matthew Wilcox (Oracle)" <willy@infradead.org>,
  Hugh Dickins <hughd@google.com>,  Baolin Wang
 <baolin.wang@linux.alibaba.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Zi Yan <ziy@nvidia.com>,  "Liam R. Howlett"
 <liam@infradead.org>,  Nico Pache <nico.pache@linux.dev>,  Ryan Roberts
 <ryan.roberts@arm.com>,  Dev Jain <dev.jain@arm.com>,  Barry Song
 <baohua@kernel.org>,  Lance Yang <lance.yang@linux.dev>,  Usama Arif
 <usama.arif@linux.dev>,  Kiryl Shutsemau <kas@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Mike Rapoport <rppt@kernel.org>,  Matthew
 Brost <matthew.brost@intel.com>,  Joshua Hahn <joshua.hahnjy@gmail.com>,
  Byungchul Park <byungchul@sk.com>,  Gregory Price <gourry@gourry.net>,
  Ying Huang <ying.huang@linux.alibaba.com>,  Alistair Popple
 <apopple@nvidia.com>,  Kairui Song <kasong@tencent.com>,  Qi Zheng
 <qi.zheng@linux.dev>,  Shakeel Butt <shakeel.butt@linux.dev>,  Axel
 Rasmussen <axelrasmussen@google.com>,  Yuanchu Xie <yuanchu@google.com>,
  Wei Xu <weixugc@google.com>,  Baoquan He <baoquan.he@linux.dev>,
  Johannes Weiner <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,
  Lorenzo Stoakes <ljs@kernel.org>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  kexec@lists.infradead.org
Subject: Re: [PATCH 0/3] mm: allow freezing mappings
In-Reply-To: <fcb7b786-53e5-49bb-8505-63eb8bb4e836@kernel.org> (David
	Hildenbrand's message of "Tue, 27 Oct 2026 18:35:51 +0100")
References: <20261027173031.763213-1-pratyush@kernel.org>
	<fcb7b786-53e5-49bb-8505-63eb8bb4e836@kernel.org>
Date: Tue, 27 Oct 2026 18:38:52 +0100
Message-ID: <2vxz33troxg3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27 2026, David Hildenbrand (Arm) wrote:

> On 10/27/26 18:30, Pratyush Yadav wrote:
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>> 
>> Hi,
>
> Hi,
>
> we're in the merge windows and focused on fixing things (apparently all of the
> kernel). This is not the right time to discuss new changes.

Sorry. I thought the MM tree was open to changes in the merge window.
Please feel free to ignore this until you are done with the merge
window. I can also resend it after -rc1/-rc2 if you'd like.

-- 
Regards,
Pratyush Yadav

