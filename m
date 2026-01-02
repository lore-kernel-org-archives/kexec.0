Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB0AFA374F
	for <kexec@archiver.kernel.org>; Fri,  2 Jan 2026 15:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vZM7TqRu/yWzeDptS/AMeKPxt1kNNx9jR2REOBS+MUI=; b=QHwo2Uh0UitLAK6MlnxKTRCOss
	i9YXmaK67LRI5pskv817GVE558VIifV19oqnB4CFmkjAjndXgkJnexFVNArxj7W3uv/TYf+0UGvY6
	CdNk3y8Kosv4tlPUChls9g+pjJrAP6qPHlnl+K4VgWsa5SIL/FdXR+/SQs83QgZnLg2vuIjJKJKGy
	SNIxUVcPZ7pByS5fKbvq3WUbmEH54wutwsEJIc04BCxvxaK/3YgOkQLNo+fybXZjd19K8+qaLOBSm
	j7yhF89f7zlKJFLXWqvvlscFZzrldWSyzcs4arbXSNZstbxNMKOfrwcjw5TdGqbJ6OBudLG3Z1aAB
	C7ZPCQNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbh9b-00000008RM3-24pk;
	Fri, 02 Jan 2026 15:33:27 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbh9Y-00000008RLi-2jID
	for kexec@lists.infradead.org;
	Fri, 02 Jan 2026 15:33:25 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso124873195e9.0
        for <kexec@lists.infradead.org>; Fri, 02 Jan 2026 07:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767368003; x=1767972803; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vZM7TqRu/yWzeDptS/AMeKPxt1kNNx9jR2REOBS+MUI=;
        b=fug9A27Nx5iWPfcrKrBgjwe6Sm7Sgi0sk7ZmQhY6/pEH0QhFLHbTwVv0HbjnuW/jNz
         clezZFzjLlnAJyy+O0QgrplMwwva8cwSwahVs0H3PEdWiI7yzgak69pijQQP8jF8SBi0
         xYJCmyKXZnyKNQcnWyipQ0YCs5zqhCzQxJxXhBBZS16p/pW1t2NX9s0ucEYu9bgztaZc
         FrqC7y8jgSv6XO7to6OfxpRx3Rz+qQuDGjQWktjMegv7IoVVVidX0N7buamZQyRPBNRr
         cZCLVpWSGR+quZyZS3eZOvLNy+S5KXWsZ9BuDfjHh06yoTwdIg6tCU3FKQ/JyCtj6gil
         CHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767368003; x=1767972803;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZM7TqRu/yWzeDptS/AMeKPxt1kNNx9jR2REOBS+MUI=;
        b=f7+BFAhhomD+cvqLdC03FVq7OPwKs4FPOgQaZ+CNcw3GYMvAO9tNM3tUI9y26mQMbG
         vYl4CJ0V8r6nszul5YkvyCvD7HxNnDoD+RlRSSEfe27ilDr9UGmurl0QnyBdTJ1tQBcZ
         meix8y1v5R7OZ29cOFjn3Ys+7VQtQmq/uHZvoWCDnUylZNPj3w/FBq1fOKcQKePGQV6g
         WjaJtQ1d0VugljfO7ErHi/ZoirIoCyIYbO5/MhKrMSey8vVSqW6l/GyDLGWJ8YHZjokn
         24jSKqb9VI3GNAwMJ8DDvGnwehnPIIF/72RP/FuCQGNBHQcosApuoaqZNikL1A8JBJh2
         mOJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPtkDqY+F77Wkh9DZypa87lLCb8Nl8xmACL4i9O5a/8FAt9xNGjrjY6Pf8CuHVEI5jiYzikg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzqyyYiUf9qPQw3z8V7W6yobQ+d3AKIHtbJpQCsnve0yF69T+ay
	gwWkRdmqnYuRhc1NaMMloOVHrvxmIt3tFfQyyYXV/mlUZ/B6hpAcPY9h
X-Gm-Gg: AY/fxX5oTGs8oGAR1fLkl8MrUfQQOOPq9D5RfotA887So/D1wV/4cum/bKsn3V+rPo5
	jp6gM8lLSzI5MtV8fN/XdygmP2AjOeDSs3M1uBI5+z98jOwMrBSj5v7V3r+v9luwTPJhRSUnMFW
	bQP26u0Af44fcaDYq/hgheIfve/Kt7OoDd7Gv43BUDvW2fnYXIp3N/YWy+6+UDVBif5+qMjhPjR
	mxbcA4XBZWYGRG5qo+YJdIlU4otgjG2j6te0xHlW142nSVp9ld9q7ZBYcYxlY27WI0g/5uLndnL
	RB/0lgbHoTiiUb2ip4i5yoo99SEnRNsd27jjSaMJP/TdQPLy8CEa13CdRwWy4LyXVjGJbPr1Zje
	nKUa+OvVFG7ZWlPgvL23bhidGbU0GqKBVtQdSFgYLBPsX6TMFRECZJ//mnSNizFgaMrSLXHRo4o
	a5aL5Vdi10lg8CtBWe0oP92lHKBihcBcbvaMscj30I/td27bLVI9hAcBgIlw6jOMCdVUfkhcOae
	zytnYEHNXH5
X-Google-Smtp-Source: AGHT+IFdFPZ9y4Ebi3gAY7G7FC7AwJ44xGEc2VCOYAbH4i07YP5Y3jFlEX44SExQe+wg/PAm5eJa/w==
X-Received: by 2002:a05:600c:3b0e:b0:47b:deb9:fbc with SMTP id 5b1f17b1804b1-47d1955b7f4mr410575745e9.2.1767368002607;
        Fri, 02 Jan 2026 07:33:22 -0800 (PST)
Received: from ?IPV6:2001:16a2:c8d2:2b00:183a:1350:d3a4:d89? ([2001:16a2:c8d2:2b00:183a:1350:d3a4:d89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27c2260sm778246715e9.15.2026.01.02.07.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jan 2026 07:33:22 -0800 (PST)
Message-ID: <b1e1be89-348e-4188-bb04-c86904e61709@gmail.com>
Date: Fri, 2 Jan 2026 18:33:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] kexec: history: track previous kernel version
Content-Language: en-GB
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-mm@kvack.org, rmikey@meta.com, clm@fb.com,
 riel@surriel.com, kernel-team@meta.com
References: <20260102-kho-v2-0-1747b1a3a1d6@debian.org>
 <20260102-kho-v2-1-1747b1a3a1d6@debian.org>
 <2b315095-2393-45d5-b0bf-ea9fbecd2607@gmail.com>
 <dc7x5xq2ufanc5vesvs6ccvulfiddqjcf74r7pp3tr4bfiomib@akskveejglww>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <dc7x5xq2ufanc5vesvs6ccvulfiddqjcf74r7pp3tr4bfiomib@akskveejglww>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260102_073324_712388_2940520F 
X-CRM114-Status: GOOD (  13.88  )
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



On 02/01/2026 18:14, Breno Leitao wrote:
> Hello Usama,
> 
> On Fri, Jan 02, 2026 at 06:02:39PM +0300, Usama Arif wrote:
>> On 02/01/2026 17:53, Breno Leitao wrote:
>> I think we should make this default if KHO is enabled, i.e. not have a Kconfig
>> option for this. The cost of storing the char array is negligable.
> 
> Sure, I can get it enabled by default once KHO gets enabled. Thanks for
> the feedback.
> 
>>> +	pr_info("This kernel was kexec'ed from kernel release: %s\n",
>>> +		kho_in.previous_release);
>>
>> Maybe s/release/version everywhere? It might not be a release, but no strong opinion.
> 
> As I understand, in the kernel parlance, "version" is something
> different from "release", and what we want here is "release". Here is an
> example of uname, which also matches with kernel source code and UTS.
> 
>   # uname --kernel-version
>   #1 SMP Mon Nov 17 07:00:42 PST 2025
> 
>   # uname --kernel-release
>   6.16.1-0_gc0739ee5037a
>

ack


