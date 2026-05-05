Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7583DCD3427
	for <kexec@archiver.kernel.org>; Tue,  5 May 2026 12:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vz4CGX36EEsGsxBDpjNDXedJ2PK5fPred0mFZ7McNg8=; b=T9xH97GHymjKeXDvH7zjf7PrRm
	6qIhFFcV/WeAhX+8ip5R5wUNeu7jd98ti8IHROIiqjuunGP/c3LNJ9ehtCL2inTVBxVJxGkHPFtcJ
	GN9q8HeUWx63ssroIXkNVtZq4kex242YogVJnJjzu6HMuqXk5aPNjSQUjQChJMc0SJEEOuK/41/hY
	p1XVH2r4nmw87+rW1/FQZ93EbT466PjbqHFxpmC6wGAdNOIUZRXZTlSvN1IdEpbWe0HTwaZT+vSq4
	c7hm0/bIY1nBYnqPy0kXD/OvQsGW9djSdD77aaV0kkoT1tKkC4VIzYCalSh9uRVrQeARVOY8/SJy0
	OzoBuI3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wKFIJ-0000000GFI8-3U3w;
	Tue, 05 May 2026 12:54:35 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wKFIG-0000000GFHJ-3UsM
	for kexec@lists.infradead.org;
	Tue, 05 May 2026 12:54:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DDE6F40116;
	Tue,  5 May 2026 12:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE9AC2BCC7;
	Tue,  5 May 2026 12:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777985671;
	bh=+N0bcqLoMfCKrRzjn409ABjF3VG3lutlDleguHU1gMY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mUWj78NJ6NaeKrIkzqEk78tvh91VgHNAcuHRL6eX1AgQF+YiYT1G6CPJDqLgnWXOa
	 k05SaoKl2K+N0jm9ahJm7/dmxzYsGZHI2CaRUAeYu6vCnFh/fMjgTxHgzXj4pz8IK5
	 Vsel93yCQ6y3feeyxFtZb+u+Sj8xLeU+DhxPtauTQbnB7/QiDuqLQTE1yqvKeDh18a
	 /faSDiUbzhpm7+iCNGutW4xGxgSceU2Imy8aQ6iHpXBTesq+8lfDyuCXr3aluqfs2c
	 oiSOzilb6j+zTK2tgzdYFkPNLMUK8B7RrBufGEPCjyhtpDyRJRCY1QFbAyE8dUVXuj
	 bcW655W4QvVOA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jork Loeser <jloeser@linux.microsoft.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Alexander Graf
 <graf@amazon.com>,  Muchun Song <muchun.song@linux.dev>,  Oscar Salvador
 <osalvador@suse.de>,  David Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] kho: generalize radix tree APIs
In-Reply-To: <331da42-b255-326b-cd5-28d07a7e2cb2@linux.microsoft.com> (Jork
	Loeser's message of "Tue, 5 May 2026 04:20:14 -0700 (PDT)")
References: <20260429133928.850721-1-pratyush@kernel.org>
	<20260429133928.850721-2-pratyush@kernel.org>
	<331da42-b255-326b-cd5-28d07a7e2cb2@linux.microsoft.com>
Date: Tue, 05 May 2026 14:54:28 +0200
Message-ID: <2vxztssm10fv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260505_055432_894542_990D9632 
X-CRM114-Status: GOOD (  13.09  )
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

On Tue, May 05 2026, Jork Loeser wrote:

> On Wed, 29 Apr 2026, Pratyush Yadav wrote:
>
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>>
>> The KHO radix tree is a data structure that can track the presence or
>> absence of an arbitrary key, with nothing inherently tied to KHO memory
>> preservation tracking. This was one of the design goals of the radix
>> tree. This was done to enable it to be re-used by other users of KHO.
>
> "Arbitrary key": Not quite the complete 64-bits, rather 64 - PAGE_SIZE, correct?

Right, 64 - PAGE_SHIFT.

>
>> + * kho_radix_add_key - Add a key to the radix tree.
>>  * @tree: The KHO radix tree.
>> + * @key: The key to add.
>>  *
>> + * This function traverses the radix tree based on the key provided. It sets the
>> + * corresponding bit in the leaf bitmap to mark the key as present. If
>> + * intermediate nodes do not exist along the path, they are allocated and added
>> + * to the tree.
>
> Consider adding a note on the key-width limitation.

I think adding a runtime check would also be a good idea here.

-- 
Regards,
Pratyush Yadav

