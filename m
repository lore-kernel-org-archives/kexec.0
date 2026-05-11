Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4994CD37BE
	for <kexec@archiver.kernel.org>; Mon, 11 May 2026 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=waL1s2GXuDPz9kvHkNF3Pd1gPq/IAJncjl/05fQhw2k=; b=WFfME059AXJuucp/mWZy/RHPJx
	e73pI4HKbQPhL1SPjMvZsH+xAPMpxsvOflU0wR55l4+8Ddpez/ZLvazJaSuYYxPPKAu4wFl/iGlOR
	FVVY81tvjkhZeBqDIi7efnIhIVSz13bF/+T7mVPjzpfAF/pgxywRKd8OlxRcFvR1JDBfJSNQEx/XU
	mL+jzD3muVWm8teWgG6kndgifYvwpHh2ZR899aKcHJV1il9uGbfyeJQufx8sc/1nzp2iTWAvPW4Hx
	Kad16lMZtk6oD1JxqVI3ilPBJ3+XNQ9qsTORg3V6/Gh/6fdf2fjUIO3dzBRTgojpmt2RziWrKppM9
	erknF4ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMTg6-0000000EEwM-3eme;
	Mon, 11 May 2026 16:40:22 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMTg5-0000000EEvu-0ocT
	for kexec@lists.infradead.org;
	Mon, 11 May 2026 16:40:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 686D2416A1;
	Mon, 11 May 2026 16:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F20C2BCB0;
	Mon, 11 May 2026 16:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778517620;
	bh=5Sy2Vpv0vDIpYFu4ImjlfBjTqwz0lLOoa+OwNsUw6hM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Aoe08CUrjB1qKN3KIDK0zQ4/hDTZrmcaQTUPmLyK/bHWKwjdgnKG9VepTO99yXigc
	 UVChFCzbF1NI2uUpK/V9Um916/iJYf+MSkaqlMCzF3V/FYtDsXSCESVRCfQ55sRzNb
	 vBSTPTAGj8Usif7Iwdh4XNMm9ephMs8oPo2S6Tya+XxGJE1fKp6t7/X0WAYXkRqPAa
	 KczkmzTbCbOhyZWcoCyZeyT7WLBr82JP+O349v+7o0ZAA1tLHlSjCfsiou/zpafqk2
	 BRDlbEp+74njsAGBlzDGlyYgufscXlxRMGJI79qCw1P8hKDdWtCvEi++awc1nAVdip
	 0BAN09OnXzfJg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] kho: add callback for table pages
In-Reply-To: <2vxzv7ctc38a.fsf@kernel.org> (Pratyush Yadav's message of "Mon,
	11 May 2026 18:36:53 +0200")
References: <20260429133928.850721-1-pratyush@kernel.org>
	<20260429133928.850721-5-pratyush@kernel.org>
	<agHCbpn5Hn3XsEWH@kernel.org> <2vxzv7ctc38a.fsf@kernel.org>
Date: Mon, 11 May 2026 18:40:16 +0200
Message-ID: <2vxzik8tc32n.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_094021_296236_92ACBCE4 
X-CRM114-Status: GOOD (  12.61  )
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

On Mon, May 11 2026, Pratyush Yadav wrote:

> On Mon, May 11 2026, Mike Rapoport wrote:
>
>> On Wed, Apr 29, 2026 at 03:39:06PM +0200, Pratyush Yadav wrote:
>>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>>> 
>>> The KHO memory preservation radix tree does not mark the table pages
>>> themselves as scratch. This is done to avoid a circular dependency where
>>> preserving a page can lead of allocating other preserved pages. This
>>> means any walker looking for free ranges of memory outside of scratch
>>> areas will ignore the table
>>> 
>>> Add a table callback that is invoked for each table page. The callback
>>
>> A sentence why a table callback helps would be nice here :)
>
> The main reason is that a later patch will create a radix tree for short
> use and will need to destroy it afterwards.

This was meant for patch 7.

The reason for this one is that kho_extend_scratch() needs to exclude
table pages from its free ranges. Will add it.

>
> Will add that here.
>
>>
>>> is given the physical address of the table page.
>>> 
>>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

