Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D047DE674BE
	for <kexec@archiver.kernel.org>; Mon, 22 Dec 2025 14:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RI6wkzq9art1PUr+oZHEIShCAnFL/nfJWig5oY9a9H4=; b=k6u9OYFjudPN1EnugQHzb4JR4t
	8uUdqRhFrcvzCuScSkBZ4q8Cs5HKRuCO1EqOY/g5lcVXjLUWEb4SMN8fK+oYX1zutgjj/haCseaIG
	UJfXexWscYcPx83D1UARlY7TnyZZVH2ZIsap2mKim8dQ4JMaS1V5QhT8TcpP2/03n3PvNNBrqeu+t
	fV0wdvYYCIfVntUcCZmKGTzGdR2dQvndd7JK1FFy5+wzeVr5N+r2tJWsE1FAysplDvPflUZdyRE6g
	xBYHfAWKqVvKELCR8DqH2EGoqlX++OmGmCloQQGD5ixK31v1eShdOlP2e142f2gSBRqXcALXw0yo0
	meJuqC/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXhNC-0000000DszK-0SKe;
	Mon, 22 Dec 2025 14:58:58 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXhN9-0000000Dsyd-17An
	for kexec@lists.infradead.org;
	Mon, 22 Dec 2025 14:58:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E756740684;
	Mon, 22 Dec 2025 14:58:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BA5C4CEF1;
	Mon, 22 Dec 2025 14:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766415533;
	bh=b4wwckHCSEHA9/WsH/82v8iyuGooOfYc2si289h0qdk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Sf8cvv973Ocy86SIfrhCawHgAShUAwMSVQXJmWzuodPbT41k1EQD8ytVx625GsbjA
	 SW8CeuEhVcF9igA8P6YYwwKKILnQ4wtjZ9NJUZC8GVOJy1YFzowIKCHG9Wpke6Cd3p
	 4hlh6ZLKMflh9K4G4Fn2woo7rNi6d3jEcqdrNbRMhKV4lClYGgNb/eEA1oF9C9q53H
	 PjiLu8ZRc9IoV32IPqFBobyygCnl0aDln4g75qhv3K1GZNkghCwfXPs4qohTcHGSXW
	 Mqh2ghyKhw/orybk4h09OSXMzd0E0OMiPtbla5X7ljWCIHF1WJ1K2PrewNZlPqPMoN
	 ptWtwVifEgDeQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Andrew Morton <akpm@linux-foundation.org>,  David Hildenbrand
 <david@kernel.org>,  Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,  "Liam
 R. Howlett" <Liam.Howlett@oracle.com>,  Vlastimil Babka <vbabka@suse.cz>,
  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko <mhocko@suse.com>,
  Jonathan Corbet <corbet@lwn.net>,  Thomas Gleixner <tglx@linutronix.de>,
  Ingo Molnar <mingo@redhat.com>,  Borislav Petkov <bp@alien8.de>,  Dave
 Hansen <dave.hansen@linux.intel.com>,  x86@kernel.org,  "H. Peter Anvin"
 <hpa@zytor.com>,  Muchun Song <muchun.song@linux.dev>,  Oscar Salvador
 <osalvador@suse.de>,  Alexander Graf <graf@amazon.com>,  David Matlack
 <dmatlack@google.com>,  David Rientjes <rientjes@google.com>,  Jason
 Gunthorpe <jgg@nvidia.com>,  Samiullah Khawaja <skhawaja@google.com>,
  Vipin Sharma <vipinsh@google.com>,  Zhu Yanjun <yanjun.zhu@linux.dev>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  linux-doc@vger.kernel.org,  kexec@lists.infradead.org
Subject: Re: [RFC PATCH 04/10] liveupdate: flb: allow getting FLB data in
 early boot
In-Reply-To: <CA+CK2bDWF6pbNQRkJFa+WcD1pwUOr3yQdrRUs-mgLWu5ght+7A@mail.gmail.com>
	(Pasha Tatashin's message of "Sat, 20 Dec 2025 10:11:34 -0500")
References: <20251206230222.853493-1-pratyush@kernel.org>
	<20251206230222.853493-5-pratyush@kernel.org>
	<CA+CK2bAV1y_LySjyj-wcn1cdSuVBdC+r+zQL7AQTY64nk3OxuQ@mail.gmail.com>
	<86wm2hj0ky.fsf@kernel.org>
	<CA+CK2bDWF6pbNQRkJFa+WcD1pwUOr3yQdrRUs-mgLWu5ght+7A@mail.gmail.com>
Date: Mon, 22 Dec 2025 23:58:43 +0900
Message-ID: <86o6nqd0m4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251222_065855_364699_5D745EB9 
X-CRM114-Status: GOOD (  21.83  )
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

On Sat, Dec 20 2025, Pasha Tatashin wrote:

>> > [Follow-up from LPC discussion]
>> >
>> > This patch is not needed, you can use liveupdate_flb_get_incoming()
>> > directly in early boot. The main concern is that we take mutex in that
>> > function, but that I think is safe. The might_sleep() has the proper
>> > handling to be called early in boot, it has "system_state ==
>> > SYSTEM_BOOTING" check to silence warning during boot.
>>
>> Right. I will give it a try. For hugetlb, this works fine since it
>> doesn't really need to do much in FLB retrieve anyway, it just needs to
>> parse some data structures.
>>
>> If other subsystems end up needing a two-part retrieve, one in early
>> boot and one later, then I think it would be a good idea to model that
>> properly instead of leaving it up to the subsystem to manage it.
>>
>> Anyway, that isn't a real problem today so let's look at it when it does
>> show up.
>
> FLB has exactly one .retrieve() lifecycle event. Once called, the data
> is considered fully available and cached in private->incoming.obj.
>
> If a subsystem has a requirement where it needs a specific state
> available very early and other state available much later, the clean
> solution is simply to register two separate FLBs.

Hmm, that can work too. Anyway, let's figure that out when there is a
real use case. For now, the current FLB design works fine.

-- 
Regards,
Pratyush Yadav

