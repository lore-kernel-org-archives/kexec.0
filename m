Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E5B606A326
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=P1s8x4XE;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MmZFJDiu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=lqh2h9OdAhEsv8R7JgV92DMgdxSdmNya/U3mKn63VeQ=; b=P1s8x4XEaR+bPWsHEvzH9JYqZQ
	mSvlTFHaolvIP+PV/gMyQVcbpN30V7igfe9N209CzlbZ7bLemerN8usl9JjquikE15Hgx+10tqoNE
	t0BwLbydvmX7Kz+XUSt5v853rf3COO75Y+hRLiiNefV87ayLRN/Mu4zMJ8ALZ23YjN1ZZtH4d9k4B
	JKUXVeutiCj61e5oo5lIVhHvGaxSGRAs2IcZRepcqRgxsMGhq9FiAyOERR2NlEY0xwp1kelKpTJmE
	WmAYhtePhevTR9OsIYMJjqaoP9vhR9/RjsLw4NRevR9FxJH/iQNNWOScciq+iku/4fCFg7oHwmdF3
	FtFnA+mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPyu-00000009JxJ-3CUH;
	Thu, 29 Oct 2026 13:15:48 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPys-00000009Jwz-3AKI
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 13:15:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DF0D6600D1;
	Thu, 29 Oct 2026 13:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98C01F01825;
	Thu, 29 Oct 2026 13:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793279745;
	bh=lqh2h9OdAhEsv8R7JgV92DMgdxSdmNya/U3mKn63VeQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=MmZFJDiu5p0O+/D6H9EcM1bWgs2P1sLao6pof6JMiCUbkuDuhoUnWvIYq6wdOTfbm
	 BpcdU9h8weFSI7YLOAuJPhsKw4Gi4YRQO5cUZN10fGi7ReIbYh9hagBT+jrYElX2YH
	 +ih3xGMrA3kLoEpG35T95VY9VY8CZ9PitTQpY1G0Ri8tbgIY4OEyb5lujXrodMB0ht
	 9mq4mqJBN5iSIEzqMYOWBi7auC6ctfTuZZc8lG2Ic63rca7gBPiLKOXjhv0fOpMgDy
	 ZaqKgfNBg3F6hiO66BQ6fFngZ+rT7A9j651kIkx8sefoDuBSSHj73PbusVG/D+GcyR
	 U4/gnsox7yWQw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>,  Jan
 Kara <jack@suse.cz>,  "Matthew Wilcox (Oracle)" <willy@infradead.org>,
  Hugh Dickins <hughd@google.com>,  Baolin Wang
 <baolin.wang@linux.alibaba.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  David Hildenbrand <david@kernel.org>,  Zi
 Yan <ziy@nvidia.com>,  "Liam R. Howlett" <liam@infradead.org>,  Nico Pache
 <nico.pache@linux.dev>,  Ryan Roberts <ryan.roberts@arm.com>,  Dev Jain
 <dev.jain@arm.com>,  Barry Song <baohua@kernel.org>,  Lance Yang
 <lance.yang@linux.dev>,  Usama Arif <usama.arif@linux.dev>,  Kiryl
 Shutsemau <kas@kernel.org>,  Mike Rapoport <rppt@kernel.org>,  Matthew
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
Subject: Re: [PATCH 1/3] mm/memfd_luo: don't use memfd_pin_folios()
In-Reply-To: <auKJXHWnNMzju7cv@google.com> (Pasha Tatashin's message of "Wed,
	28 Oct 2026 20:01:59 -0400")
References: <20261027173031.763213-1-pratyush@kernel.org>
	<20261027173031.763213-2-pratyush@kernel.org>
	<179321872100.1775665.6881420026761127422.b4-review@b4>
	<2vxz4ie5o2ak.fsf@kernel.org> <auKJXHWnNMzju7cv@google.com>
Date: Thu, 29 Oct 2026 14:15:38 +0100
Message-ID: <2vxzv76kmyv9.fsf@kernel.org>
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28 2026, Pasha Tatashin wrote:

> On 10-29 00:04, Pratyush Yadav wrote:
>> > Nit:
>> >
>> > I would suggest adding another helper, memfd_luo_get_folio(inode, index, 
>> > &folio), that wraps:
>> >
>> > - shmem_get_folio()
>> > - The !folio_is_longterm_pinnable() migration retry loop logic
>> >
>> > I think this would make the final code a bit more manageable.
>> 
>> Sounds good, will do.
>> 
>> >
>> > Other than that the patch looks alright, feel free to add
>> > Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> > Once the nit is addressed.
>> 
>> Thanks!
>> 
>> I think the MM side might take some time to gather reviews so I will
>> send this out as part of a liveupdate-only series. This patch is useful
>> on its own anyway.
>
> Sounds good. Could you also consider adding a patch to that live 
> update-only series to extend the memfd freeze from retrieve to finish()? 
> That would close another gap that does not affect us yet, but will once 
> other session fds depend on the memfd mapping.
>
> See:
> https://lore.kernel.org/r/20261022225035.377445-8-dmatlack@google.com

Hmm, right. That's a useful fix. I think I'll do that in a separate
series, since it can go independently.

-- 
Regards,
Pratyush Yadav

