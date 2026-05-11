Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6828ACD37BE
	for <kexec@archiver.kernel.org>; Mon, 11 May 2026 16:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DxLGg8/beFqi55fuw6m5jzykjB/pARNr7wxzOWVsglo=; b=eevGhqGmp7W22co8dKODy69tkI
	tAfCIa1wLH5RtnHdKucgmti1oJzCh5i09GLBFa9H02PPn79Ol2hxXxyIVAifmeu48wGxX3jfz9hJ9
	xigXqgWDtA+GQ4U2XgG7bAAHlifncqZ04HfU1tYiE9N27xEPdBFZN6El1VWsEIpnBUEaibZHNQ0kk
	56SEpDs8PNlKCv++JmfpS5Mo62EDk1Mwp6HhHgf+FLgYHxDvvbnMJWowNUMilIc3k5T3f0YEAtRkS
	MJlzY5fGxcW+Wi8OofPOd/GMArORw3ZtAi+KlhTLkjX7s3h7Bi3pR4QLOzeZ+UN1dhepkZCenc88k
	S2AsSL9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMTdG-0000000EEWm-0fBZ;
	Mon, 11 May 2026 16:37:26 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMTdF-0000000EEWc-0NLK
	for kexec@lists.infradead.org;
	Mon, 11 May 2026 16:37:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 23A486001A;
	Mon, 11 May 2026 16:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27EFC2BCB0;
	Mon, 11 May 2026 16:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778517443;
	bh=PRBYljbQKWzUvkUwyYwlu8uiQpZenEvMUngtqTEHQlE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SXwreISvRN5mfNFWBWr1nGiO5hu5rrN0ri50RX37nwn0k2uG9o50p+kw5zkvfXGji
	 h++6onZ61CzAHXkj4m6FL39l3DTNhO8rDlsTDqBmPvTOEQqOlonQXkskpHTd/xZ1Cl
	 XV1yFOsOlVTWVX+fBMMWqwRHpw/YGJKE4lVwcfChPi4DKc8d34rxBZJNP8QlVhls7y
	 LAGdUZc70kxDlUPctWdJX4KPBigq1SQY6eP/D1YHDN8qUhH1nqJkP1drlNRN+fDdx9
	 i7+5JFrTQi+jD7DyvC+B7CH1uJIV8+Mql2GLxouJ1z7HW+C8ojsPjU3eZu8XmzjIPN
	 2uqLraTQFx+YQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] kho: add data argument to radix walk callback
In-Reply-To: <agHDI-NdI_AhslBJ@kernel.org> (Mike Rapoport's message of "Mon,
	11 May 2026 14:53:07 +0300")
References: <20260429133928.850721-1-pratyush@kernel.org>
	<20260429133928.850721-6-pratyush@kernel.org>
	<agHDI-NdI_AhslBJ@kernel.org>
Date: Mon, 11 May 2026 18:37:20 +0200
Message-ID: <2vxzqznhc37j.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, May 11 2026, Mike Rapoport wrote:

> On Wed, Apr 29, 2026 at 03:39:07PM +0200, Pratyush Yadav wrote:
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>> 
>> Add an opaque data pointer argument to kho_radix_walk_cb_t. This can be
>> used for callers to pass extra information to the callback.
>
> Nit:  ^by IMHO

ACK, makes sense.

-- 
Regards,
Pratyush Yadav

