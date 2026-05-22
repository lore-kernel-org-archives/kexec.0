Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDB4CD5BB0
	for <kexec@archiver.kernel.org>; Fri, 22 May 2026 13:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=46NyHzj3stcXZnP51xXm8AEPZCDBIfj/VG/WitvWNgs=; b=L8OvnImYQPehaHss/I38gdnHNv
	98wsd4dApEXDHytspz8hlwoqRLJEi4RIT6AlfjyQsp1IU+9+N3Qsk/+n4B47s1JFWe27NGNynMoE6
	o0qdl/Vvp689kvsTrBfGvBJtweIWpFFsGEjThUdjA3Eo4/Cg5wrCcUT7j8ceV1Xg5Tuaf2odnqa9E
	rz1lLyh4ZPI/wLF8hLtiQjoPKKII/Kz7HMRe6lz5dS5564yoxevo4dAcEf502LEa6vJxVb8Ypt9Bm
	6k9iC0J37rlsYVRpRl/N0z+M2IojXAXoASXenKeYQf904GaW6bdqo/UqOerd5Hd9fAvqnTh2t8Wvb
	8Q4hnINg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQPrM-0000000Ay2R-02Sp;
	Fri, 22 May 2026 13:24:16 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQPrJ-0000000Ay15-2bhy
	for kexec@lists.infradead.org;
	Fri, 22 May 2026 13:24:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 37C194175E;
	Fri, 22 May 2026 13:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204D61F00A3D;
	Fri, 22 May 2026 13:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779456253;
	bh=46NyHzj3stcXZnP51xXm8AEPZCDBIfj/VG/WitvWNgs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=GHtcqGUbEssMPpnShLAlpNSehIRjZL9H0xancMaKqYitLz0mUR6TLACisQckAnGtB
	 FsaYcp6cb3SPgHgF9oGJLJLhheIiPuqjv+214shLErZoK35uTMDqXuBOKZUAnDndC3
	 L/LnbSFR/fESiuCrG8h8oRadwJULpu3N5LQigmPbSTKg/HFUIMW5p0mb5ZhgT63MTy
	 nJU7UlxQuAyfgg5EdCnez/t9viHx5xY5ulScuwBG/4Z+cktsTwxbk5YgnoT3ucUJdt
	 xGhmAc4xsPhmrqu5lC6IZwwY6YyJ+Q+duWMsbNOChBmIDMMMbV/xvscPya0kIoyyuL
	 Wa7fPDhHCFUdQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Alexander Graf <graf@amazon.com>,  Muchun Song <muchun.song@linux.dev>,
  Oscar Salvador <osalvador@suse.de>,  David Hildenbrand
 <david@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,  Jason Miu
 <jasonmiu@google.com>,  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] kho: allow destroying KHO radix tree
In-Reply-To: <ag-Xa-bDOouXAFXb@plex> (Pasha Tatashin's message of "Thu, 21 May
	2026 23:46:23 +0000")
References: <20260429133928.850721-1-pratyush@kernel.org>
	<20260429133928.850721-8-pratyush@kernel.org> <ag-Xa-bDOouXAFXb@plex>
Date: Fri, 22 May 2026 15:24:09 +0200
Message-ID: <2vxzwlwv7f2e.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_062413_683121_2A1E95F8 
X-CRM114-Status: GOOD (  11.32  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, May 21 2026, Pasha Tatashin wrote:

> On 04-29 15:39, Pratyush Yadav wrote:
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>> 
>> Add kho_radix_destroy_tree() which allows destroying the radix tree and
>> freeing all its pages.
>> 
>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>> ---
>>  include/linux/kho_radix_tree.h     |  3 +++
>>  kernel/liveupdate/kexec_handover.c | 34 ++++++++++++++++++++++++++++++
>>  2 files changed, 37 insertions(+)
>
> Generally, in Linux, recursion is avoided due to statically sized kernel 
> stacks. However, here we are bound by a relatively shallow KHO tree, and 
> kho_radix_walk_tree() is already recursive, so I think it is alright. We 
> just need to be mindful of local variable usage (frame sizes) within these 
> recursive functions.

Yep, recursion is strictly bounded and the depth is no worse than any
page table walkers for example.

>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

Thanks!

-- 
Regards,
Pratyush Yadav

