Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6982C369AB
	for <kexec@archiver.kernel.org>; Thu, 24 Apr 2025 10:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g8qMObmnBvoV59zuTKBbhVVCoTSB0SGdVbbq3ciSqIs=; b=F0RYhDZMeIKSq8BI1QKFeFqGTF
	4g2jVbtpcExKMMvxU+m4kpgqAFwH1wAQ1fbVpMBcdnkLsQs99EIE8BVpoarLmtZezgOo1ebnMVJaP
	c4vKtF5IcguLUm+1DdH2s+HEywszV2d54MXqqJ3359qFxXEc3vK3i5xk/6XJvQcgzmR1VXZHe7FvM
	3xmXgTaqYEbKXUYDEBNr2wEESa/dFdFw0BhYOsDbQDfSehfyrnMCwQdoBx1BV+oVPeE99b97rIsjG
	gATMD92F+sW08R95uxnLCkB6M+RNrf11vBJ2qzJXBfUWpfqyTrkwW8CyOsXqVrsAk22sTis1VbfmG
	HfJfAcmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7tjO-0000000Df4f-0JpX;
	Thu, 24 Apr 2025 10:22:58 +0000
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7syL-0000000DW7r-0el6
	for kexec@lists.infradead.org;
	Thu, 24 Apr 2025 09:34:23 +0000
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 55F991380553;
	Thu, 24 Apr 2025 05:34:19 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-05.internal (MEProxy); Thu, 24 Apr 2025 05:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745487259;
	 x=1745573659; bh=g8qMObmnBvoV59zuTKBbhVVCoTSB0SGdVbbq3ciSqIs=; b=
	l4oz5E9ejhddalNE1gBp+WbQB1JewQJqQ9RdL0zT/gUM3oRuK35ZYP2tWi5htxmP
	yY0KzoYer1ELpvxbaW+FRzTUcW/HbvM3DPa/tNw/hHC/LV9mxdx0AH/aQetgWJJO
	CXDV5fh4s++ZuBKQrI2Hvs2N0SbuyfpBQdrBKd1NiYTIXxw1ybRJ1TfrF3IIx5oI
	cDpwF2xrssubc8Z6gngfGyCpx9i2yT3jRMXUJPB8b7tfKr62910stzDTsEwobuhJ
	HH/0TwOXdZCgFo8v9wY4PcWAtt4s+7LtlxuNCt5ppvx/tee4reFVnrxScUZfeEIw
	sYknnea8eYNlR9yPs9BwKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745487259; x=
	1745573659; bh=g8qMObmnBvoV59zuTKBbhVVCoTSB0SGdVbbq3ciSqIs=; b=d
	T6yqn5iMxmNORQxqSJVxVOfsE1+MyPJ2IlhsOxZg5eYAlKo+V/ZSoU/kAEI2UFRJ
	QP8BLuWqARE+/yBTN4MnBP1PnLf06gYsuL8ilVJxAl1uasCo0RL5R2q63aS/9ocl
	nCyYl+c+5W8I7vJhdhuH0zkul45eZdNb59MZqO9I1CQnMx3FQOV7VSW/xo+bJ25x
	sEtg/LSLQ7JaRp56YE76CPGvcJYGZPN+8vKQTcTYoQ5mq3qBInbA6UQNw1w+aNQi
	SorZso3zWNrCK01NEKFtpQ/FzFwvPJGFkjlRIiWk7tvRAzJBK6CTXfUK0BlMwJfS
	CEOX5p7mechLpVr+0PBmg==
X-ME-Sender: <xms:mgUKaCaPimW3wcxILfm3FjZd-bFBsnZwjD4EBBjuuT07Hm-_H_eE9Q>
    <xme:mgUKaFYzmevekXL1SEwZ6uoWLM9YCOoaDbZ-xrx07SSprEw46yYnoyXqXVmEGpXmW
    KM8_XiNisXOsngv2WM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeluddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhrrghfsegrmhgriihonhdrtg
    homhdprhgtphhtthhopegthhgrnhhghihurghnlhesghhoohhglhgvrdgtohhmpdhrtghp
    thhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhohhrmhhssehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehrphhptheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtth
    hopehkvgigvggtsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohep
    sghhvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mgUKaM93AtMAZkkQnEadhKb6xhm5dMqzXlz2s99LTiCcIjlp6CsfnQ>
    <xmx:mgUKaEppaEm5MZ8Y110NSSIUVAaHiZLwqEkxrIc6DERY1OGSv9_Yjg>
    <xmx:mgUKaNoUiYjTRKi5dN_5BSIv2ZnNYTgtPB1BmCaQJBOADnvUZIEUbw>
    <xmx:mgUKaCRZ-BDrqUczsHwqw61BfOo4L-wkV4L-yvEzLNj1qxZrpEg4VQ>
    <xmx:mwUKaI20wZLLwZFJX1IyMtI4gGFUYoQ19uIHnB_aE5750WsSegl2253v>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7844C2220073; Thu, 24 Apr 2025 05:34:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: T5f99f2cd9f4697c1
Date: Thu, 24 Apr 2025 11:33:58 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Simon Horman" <horms@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Alexander Graf" <graf@amazon.com>, "Mike Rapoport" <rppt@kernel.org>,
 "Changyuan Lyu" <changyuanl@google.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan He" <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <19985176-a552-482e-9baf-7a1c4fe45d89@app.fastmail.com>
In-Reply-To: <20250424092344.GC3042781@horms.kernel.org>
References: <20250423162924.2213664-1-arnd@kernel.org>
 <20250424092344.GC3042781@horms.kernel.org>
Subject: Re: [PATCH] kexec: include asm/early_ioremap.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_023421_695770_5C5AC86E 
X-CRM114-Status: GOOD (  11.78  )
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

On Thu, Apr 24, 2025, at 11:23, Simon Horman wrote:
> On Wed, Apr 23, 2025 at 06:29:18PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The early_memremap() function is decleared in a header that is only indirectly
>> included here:
>> 
>> kernel/kexec_handover.c:1116:8: error: call to undeclared function 'early_memremap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>>  1116 |         fdt = early_memremap(fdt_phys, fdt_len);
>>       |               ^
>> 
>> Fixes: 4bfe738ce89a ("kexec: add KHO support to kexec file loads")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I didn't try to reproduce this problem. And perhaps this isn't particularly
> important. But, naively, I would have expected the following as it is
> the commit the introduces calls to early_memremap() in exec_handover.c.
>
> Fixes: b0a311dba688 ("kexec: add KHO parsing support")

Yes, you are correct. I've sent a v2 now. Ideally Andrew can just fold
the fixup into the "kexec: add KHO parsing support" patch, in which
case my incorrect changelog text disappears.

    Arnd

