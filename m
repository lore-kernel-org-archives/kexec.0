Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93031CF34A0
	for <kexec@archiver.kernel.org>; Thu,  3 Oct 2024 11:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3xo8tTxRKx+faJI1KJN2sroKlVt5d1pLRo9HtSmF2y0=; b=l6MZtTj/uGqF51
	RnuNVuLm7+S9OJxcQvknXdYoYkN/kBIGxl8Hsg4EoWY2NFTycTur42upILbw7uzWl61EqYqUXvmA+
	k6sj1l+0vsA+crnrw5/f+h8an1J3atLPAgkeCTk8gDPInOkQAn5tTpRj1tGLDbrcAV+04zhYF9Rsh
	cp86O24sZYLDzeeJG1KyVwFhdvWSTxkemk+fcgPkzaL7gzUWcc56FYU/i7oPH9L++Pa50WoAPNTHZ
	ycaRXvrrAZ9yyuUNarq2QyjAfPyQxB3Yapop2ZGbxvO2QFefBgVbLxgBrSbdojTD4E5UW93Zdlg8p
	LHvsuAeMpTsPAD4MZRMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swKMw-00000008wnR-3jXo;
	Thu, 03 Oct 2024 11:51:42 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swKMq-00000008wlE-1l2G;
	Thu, 03 Oct 2024 11:51:40 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a8a897bd4f1so102324966b.3;
        Thu, 03 Oct 2024 04:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727956294; x=1728561094; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IX9tvTHLAOYgmvxpBneEKBUS+/RTMNfK5EVxf2TOLuM=;
        b=FAVBiN62CDE5V+utq5P+9wAwUOPfGqrMhKbE1OhqEekUmX0t7TsDKdlkUBLDjw6lVC
         gI0ot2NZVuGEk1WcVKFJBnswUyh2PcJjMbS2ZR2aXp4tjV/dy79qZvK61IMSEttcSAhq
         dWYwml+FTZ8Ds0gsJEgET1YFPWBk8pohcurllAg84cXOTGy21G4i9i+4fY91bwZpwYcj
         ntIwbBGs18nMWHHORC/Mt0z6XsoaK6nbSHx6L9G2uR3zRehGZ8vf4zY5+WMac8E2TV/3
         ZTsP2oSQPKnZuv7EtlZbOWbYeo80XJ4BRsMnHgWNN/UbxtrLuFj5w2cPUu/4+PjIllpB
         y9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727956294; x=1728561094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IX9tvTHLAOYgmvxpBneEKBUS+/RTMNfK5EVxf2TOLuM=;
        b=YcxmpSP8tB1K77JK/4a3AjcvCUGFjEqAfOnF2qYfR+XRYrYCAavSmLI2LGVyrIowiI
         M0FHfG/YHNjIdbzgHmSA898kFwINBHG8GHofZEVJlHo44iRqb4wpHdybeBhbJczvznWH
         jScya7LTyU6BigRL3pM7Ckuu4gvc/W5n7fNeFP833GHmcO+3Wk7V4L1tLXMwbAg64DbT
         L5YBwoI6vEylBpFuWyzZxSwVDcWGrceR8wdNj0MkC3rPhzuJW1XtIg6YPPC7ZBpsW/Zm
         JFdpWHM3LLErvK51AAEwKsFEe67NgA8qRXB+HJzV0iq2qioIaK66RPgNTh9yWElrItsm
         /C4g==
X-Forwarded-Encrypted: i=1; AJvYcCWDQOT82DbdZ8mTMKmz6iwz36Bx7rl+xg3C/5ZRg/V2XRkDZlELGdUfxqNOLV0uImVhgXoPqw==@lists.infradead.org, AJvYcCWWEm0fLiEiCpCKlFeKWYtS4tM/RWbeg+QPJB4gysNWBo4kUjmy4HvODBkQQg5DTUXC9YbEwbqlhIt85ILOZsIqVQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwBQOtLzyoLaJrSqwyGThBNgLJVZm0xHwgBh3zzk8HdO9zyvLsg
	OXU01aHPWnHea3X23ilVjWkdCREi002RirbbI4SzLTOhgerpfeFL
X-Google-Smtp-Source: AGHT+IGjsHGnUfYGC96kOqpUuLWRj65nI1QtiDjAvHGAxnWeJTR4Pja1kibf9jVolcOP0OF/G7jHAA==
X-Received: by 2002:a17:907:9706:b0:a8a:8cdb:83a7 with SMTP id a640c23a62f3a-a98f838a302mr571025166b.54.1727956293522;
        Thu, 03 Oct 2024 04:51:33 -0700 (PDT)
Received: from [192.168.1.50] ([147.12.138.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99103b314asm75313266b.103.2024.10.03.04.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 04:51:33 -0700 (PDT)
Message-ID: <1ea5538f-7e96-4034-9af9-e2d5fd72e069@gmail.com>
Date: Thu, 3 Oct 2024 12:51:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: arm64: Kexec: Warning: virt_to_phys used for non-linear address
To: Will Deacon <will@kernel.org>, Breno Leitao <leitao@debian.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh@kernel.org>, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 catalin.marinas@arm.com, rmikey@meta.com
References: <ZnFKEtqfqJkYflwL@gmail.com> <ZnFxI-jCoJcO8WPw@J2N7QTR9R3>
 <20240624113614.GA8361@willie-the-truck> <ZscEo8KJfn4xfm6X@gmail.com>
 <20240823133842.GE32156@willie-the-truck>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20240823133842.GE32156@willie-the-truck>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_045136_499512_70EF0C2E 
X-CRM114-Status: GOOD (  25.41  )
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



On 23/08/2024 14:38, Will Deacon wrote:
> On Thu, Aug 22, 2024 at 02:28:03AM -0700, Breno Leitao wrote:
>> On Mon, Jun 24, 2024 at 12:36:14PM +0100, Will Deacon wrote:
>>> On Tue, Jun 18, 2024 at 12:36:03PM +0100, Mark Rutland wrote:
>>>> On Tue, Jun 18, 2024 at 01:49:22AM -0700, Breno Leitao wrote:
>>
>>>>> Since __pa() is a macro to __virt_to_phys():
>>>>>
>>>>> 	#define __pa(x)                 __virt_to_phys((unsigned long)(x))
>>>>>
>>>>> I am curious why this address is special that makes __virt_to_phys()
>>>>> unhappy.
>>>>
>>>> It's a fixmap address rather than a linear-map address. Confusingly
>>>> 'virt' generally means the linear map rather than any virtual address,
>>>> and usually virt_to_*() only work on linear map addresses.
>>>>
>>>> I'm not sure how to fix this; the major reason we fixmap the FDT is so
>>>> that it can be anywhere in memory (and e.g. may not be in the linear map
>>>> at all), so we can't always generate a linear map VA.
>>>>
>>>> We could stash the PA at boot time, and pass this as an argument to
>>>> of_kexec_alloc_and_setup_fdt().
>>>
>>> Yeah, if it was passed as an additional argument to early_init_dt_scan(),
>>> then the core could could track it. Alternatively, we'd need a helper
>>> macro to get the PA and have an arm64-variant for the fixmap (everybody
>>> else could use __pa()).
>>>
>>>> Rob, any thoughts? I couldn't see a neat way of doing this, but maybe we
>>>> could initialise an initial_boot_params_phys at setup time, with a bit
>>>> of churn to early_init_dt_verify() and friends?
>>>
>>> Rob?
>>
>> Hello, is there anything I can do or test to have this moving?
> 
> I've not seen anything from Rob, so the best bet is probably to see if
> you can hack up a patch to fix it yourself and then cc the rest of us
> when you post it.
> 
> Will
> 
Hi,

We are seeing this while doing kexec, so I sent a potential fix in [1].

I did print the values and they are different
initial_boot_params_pa 0x6937a00000
__pa(initial_boot_params) 0x8000125e0000

so I think a fix is necessary as we are deleting some random memory while doing
kexec which could lead to very difficult to debug crashes if its something critical.

I just stashed the physical address and used it later during kexec.
I dont see anything that could convert fixmap to phys, but maybe its there and 
I didn't find it? The other option is to write fix_to_phys which would look something
very similar to like kernel_page_present [2]? I do think the patch in [1] is much
simpler, but happy to try something like [2] or anything else that is recommended.

Thanks!
Usama

[1] https://lore.kernel.org/all/20241003113840.2972416-1-usamaarif642@gmail.com/
[2] https://elixir.bootlin.com/linux/v6.11.1/source/arch/arm64/mm/pageattr.c#L213


> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
