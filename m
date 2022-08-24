Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4810CC32796
	for <kexec@archiver.kernel.org>; Wed, 24 Aug 2022 19:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SoO6L2cqH+HOo45cQljV+ep2PaW2WCFS++dCzKA85PI=; b=T5ykPJR4LjyVv4
	4Y8UpzxverbnZSiGfmpF3g9deU8RZO3vP5b3iNB2nIBe1+FdIzZDwNBosbcrTeXNtjSoOTpX1xDEU
	FLbaelMr0VDKGKwBrXBL5aUKmKoJp4Q4TkB1DMT7940BOV44CZ2VRE1RukkRy/7oQ/F1d7J55B6y5
	m6pHPEtCc5dO3bDnX+JZyQl4+TwQh1uGbSJs43w9vGyPg/Fg0VlnBuAyHYGz/YknFNjddFdpUn1rF
	4jKVuGFjP6DZPFSOfT9WAhyruYYZCdgvA5tYtL4pcWy4szZzTjSk95ELMNV280umlUR9HaedMKxdp
	iy34pcWOxjv7OnkzOQww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQvc1-00FY6C-CM; Wed, 24 Aug 2022 19:00:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQvby-00FXzF-4A
	for kexec@lists.infradead.org; Wed, 24 Aug 2022 19:00:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661367618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FIiUmby88Yb55/rny3f+ooD+63bbUsdXMXTOH9q/LhQ=;
	b=RlO1muGemGIILsyAVvvdS/sByQ3gxIcV/a1ytp8Fowrza3IuDzUmyLhtuDvUMtf6tm7fJ5
	1CVMaydJciZL6u7VW/cPVsvUCJRfFschEnZHa7sLF+iaZEaYQA3JpJz5e73IwwnuWm6fZQ
	fenDrWKfjPsqxW3/KW8yiF8wlEfPLYY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-613-k-goXsQQOqWFsLa8uFNtcA-1; Wed, 24 Aug 2022 15:00:17 -0400
X-MC-Unique: k-goXsQQOqWFsLa8uFNtcA-1
Received: by mail-wm1-f70.google.com with SMTP id r10-20020a1c440a000000b003a538a648a9so9754065wma.5
        for <kexec@lists.infradead.org>; Wed, 24 Aug 2022 12:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=FIiUmby88Yb55/rny3f+ooD+63bbUsdXMXTOH9q/LhQ=;
        b=RgJ1ErDNZJqKhFkXlWwnAiDMtPd1TLle4P9VppyMUYzuSe5vqt1Wkuas1T8QtW8XpE
         mYdf2Mc+I4mO7f5p4Ayv4clf11ISMrsKt2EIU4clg1yzJjx72HQ5ieNOE2A54jqZRGin
         5o79wOJQTUdgoXXIaUyPRlodkTXtiHtgEMYTbJsmtVhKdpgKRLBQYPU/5g0LtfmMIGlw
         AfL9eedkh2RgW1XcjgHJIlJKUY6mb8p80MbBZbZC4aTXhbJvFTFk/r9n00wCxl8I1k04
         1h6vapnCfEknDPh/16HslQ1zIbQau3elv6XPqqQFFF3Iox+9Dsel3YGY8pNpemffLpa5
         282Q==
X-Gm-Message-State: ACgBeo2tc4+tUFn9HoORrXDjClx7gM4FBq1reRf38bpR9aDLNf8R2n0W
	6w5mpkFuRkXGmkBjdoN5rZ4oFCmgp5x1LEz4vETczCnqaiYfL9PS8mGY48UtgYlgTyat4VzfIvX
	nru5jRTHaWMKQecUW809s
X-Received: by 2002:a7b:c451:0:b0:3a6:829a:6102 with SMTP id l17-20020a7bc451000000b003a6829a6102mr5173771wmi.12.1661367616198;
        Wed, 24 Aug 2022 12:00:16 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5ZOVK4qpWVvOkODaq4ZLUaZhRYxNGGEB2PU/jsgu2M5tKioth0d58LkEi9N7bWMamVaYBo2w==
X-Received: by 2002:a7b:c451:0:b0:3a6:829a:6102 with SMTP id l17-20020a7bc451000000b003a6829a6102mr5173682wmi.12.1661367614025;
        Wed, 24 Aug 2022 12:00:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:c500:5445:cf40:2e32:6e73? (p200300cbc707c5005445cf402e326e73.dip0.t-ipconnect.de. [2003:cb:c707:c500:5445:cf40:2e32:6e73])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d5445000000b0021e571a99d5sm17290174wrv.17.2022.08.24.12.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 12:00:13 -0700 (PDT)
Message-ID: <693dc564-349b-7174-b096-53d2107f27a8@redhat.com>
Date: Wed, 24 Aug 2022 21:00:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH RFC 2/2] checkpatch: warn on usage of VM_BUG_ON() and
 friends
To: Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
 David Laight <David.Laight@ACULAB.COM>, Jonathan Corbet <corbet@lwn.net>,
 Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
References: <20220824163100.224449-1-david@redhat.com>
 <20220824163100.224449-3-david@redhat.com>
 <3c250aa26020b2f336fd575a58d06ba26faf1f14.camel@perches.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <3c250aa26020b2f336fd575a58d06ba26faf1f14.camel@perches.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220824_120022_249670_BF4E219F 
X-CRM114-Status: GOOD (  21.11  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 24.08.22 18:52, Joe Perches wrote:
> On Wed, 2022-08-24 at 18:31 +0200, David Hildenbrand wrote:
>> checkpatch does not point out that VM_BUG_ON() and friends should be
>> avoided, however, Linus notes:
>>
>>     VM_BUG_ON() has the exact same semantics as BUG_ON. It is literally
>>     no different, the only difference is "we can make the code smaller
>>     because these are less important". [1]
>>
>> So let's warn on VM_BUG_ON() and friends as well. While at it, make it
>> clearer that the kernel really shouldn't be crashed.
>>
>> Note that there are some other *_BUG_ON flavors, but they are not all
>> bad: for example, KVM_BUG_ON() only triggers a WARN_ON_ONCE and then
>> flags KVM as being buggy, so we'll not care about them for now here.
> []
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -4695,12 +4695,12 @@ sub process {
>>  			}
>>  		}
>>  
>> -# avoid BUG() or BUG_ON()
>> -		if ($line =~ /\b(?:BUG|BUG_ON)\b/) {
>> +# do not use BUG(), BUG_ON(), VM_BUG_ON() and friends.
>> +		if ($line =~ /\b(?:BUG|BUG_ON|VM_BUG_ON|VM_BUG_ON_[A-Z]+)\b/) {
> 
> Perhaps better as something like the below to pick up more variants
> 
> 		if ($line =~ /\b(?!KVM_|BUILD_)(?:[A-Z_]*_)?BUG(?:_ON)?(?:_[A-Z_]+)?\s*\(/

... then I'll have to scan the other cases if they do something similar
as KVM. ... well, okay, I'll do it. :)

> 
>>  			my $msg_level = \&WARN;
>>  			$msg_level = \&CHK if ($file);
>>  			&{$msg_level}("AVOID_BUG",
>> -				      "Avoid crashing the kernel - try using WARN_ON & recovery code rather than BUG() or BUG_ON()\n" . $herecurr);
> 
> and maybe:
> 
> 				      "Do not crash the kernel unless it is unavoidable - use WARN_ON_ONCE & recovery code (if reasonable) rather than BUG() or variants\n" . $herecurr);
> 
> 

Yes, thanks!

-- 
Thanks,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
