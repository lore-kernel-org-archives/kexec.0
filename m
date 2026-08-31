Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C173C624A4
	for <kexec@archiver.kernel.org>; Mon, 31 Aug 2026 13:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=53920xzB8XLNSjeZIZbkJ3m9LVbpBiAgUUyw5Vt5WJg=; b=ql6rS69VtQSL0SMVWlpHtYbVk2
	MFfXIied4NCxL22RrbFONH2c/XrcQOHhKo/XFqFh9Tqml8hLJNstDtm96LSk37e0JCEjeF8Q6nLgo
	TvpKLWszSngi+lPH15Bdmxmq1L1aO3ZI9fZUcKzVd7376FHyWU7IkVBuWCB35vMAaiIm4+t6rukNh
	8ewHOs6MnsE/dEu9Wr+TostRB/xhiECThmby0cMCciVECTvVaoP2yogqLftWPV4TAjuHxGZuUy8BJ
	u01hY2ty9uM2Qg22ACGSToY/Lxu6+tqhpq5anoJv4DvtPTqInLW83rLbj1a9UvhRCwnGXn9HVLLYp
	KG6l2S0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x12FC-00000009Shv-3wlc;
	Mon, 31 Aug 2026 13:40:14 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x12F4-00000009San-0qfj
	for kexec@lists.infradead.org;
	Mon, 31 Aug 2026 13:40:11 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso38711985ad.3
        for <kexec@lists.infradead.org>; Mon, 31 Aug 2026 06:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788183605; x=1788788405; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=53920xzB8XLNSjeZIZbkJ3m9LVbpBiAgUUyw5Vt5WJg=;
        b=bHWL9JEx6wTqO/UEIQtksl8isP2yf5vnkSDjh3q05EnZYpOqjj452FT5Dz4HFwcOws
         mCaJh7VRL7RFiJ39n1L+tAT/3KsZCmU0oCQGmwlj/cDW4FtYXtuGax51v01gsR9SV6NP
         NfUyc4XlFDeg0TTijF32OvIljirHVyDkwQFD22KwCbKYFpnDGGFAp1tfCG11CRJRm5zm
         ByCjLtfYYX2dSxQmbVa1lNJUGjoQ3HmnYG5lUwd6Lnclh81JeqdyT0HK7qRdLwMugEO4
         AhpGJgIfG0s9T9bXUuQjCrwe51z/n5pNl7xDX6DUuIWJkOZIkcauv/IpYxzX2FvPOThW
         L5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788183605; x=1788788405;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=53920xzB8XLNSjeZIZbkJ3m9LVbpBiAgUUyw5Vt5WJg=;
        b=kLEyiMRPnO8w/OwYxH4AYGfAAC+QFqvrqxsluQkdb+40lcLuRlFb3EXkHZjp2eebdi
         y+0bV8NQ6aO7cr8jE3ApBbP7BODZO+uzUihd5zgiMv7ZTOEoH6yfK6lfkKoxdd2ZRSfc
         d8nNfB1S08zPgivWy10MwKftmp3nsslGpnNNI+J61IEXSlQmZIog5nWyAxGrnZYcouAH
         U8JRdzKYnnWguv6+knNY8iVE9eWUGCRG/yNJ81k07Tb76ws4Ca+WVeRtHUCIzyS4QLGc
         oNB+E1jFTC44iy7QzM0mdukggorp1NJBpx0ZepqN2xQJ9c3pF9MUkedwI5Ywm1gc206n
         7VGw==
X-Forwarded-Encrypted: i=1; AKwUvBzrNKJklcGG7YSBVtjoNi85eXx3njpNRR7TeMWAK5AlPNzQdpxpngCzgW/TT5u2GimvblXthg==@lists.infradead.org
X-Gm-Message-State: AFuF++nIMUpX8Ryhaxv9ztIC1tADc8wgCrq2q+gQaa+S5JdrFM2fgvdC
	Lb7EF+K/F6UPikTAyg3WFLMCMa1K9L5agzwGObATNhWMSZBJrrzXjvVs
X-Gm-Gg: AYBFou2OeEYVjyqwGIaC7q8n3ifSMhG8jfejX5fu/OjTdRq2Me3Mw0kxKsZn7U1SEtd
	xY+IFLMf1uITP6pwaH/UC3+jr79+dXtfmDjxWuZuPhLYWFkVEf8fvY88pk/pydy5ZbEhcLcbzwt
	KvfzUlJxn0avVcPAO0EjB6MfmahdZ3ud9BD8KHW8cfk7Al3bzajg9unUyquAtGvRb1T08VBKIDE
	z18ZT8FGchiXlVD67faUkyTjqbhAbK6N06AZKYScgBrJtMRElvWmztJ6+FC65rOk+8svHCLuNkf
	iNzojn3y29wd5UY3kjifBZ+2rf2yJw0NX2GejajAUdCbyPjfZ1yby6AgnEqy/EiX7m0Da/bVzYU
	Sh2yy3cGqUjeVlM+wCx/jpWbnbtDfwVyWelq7cS2UsGr15mlRhISTI5+sO0lt+X3kUs0v1AetCK
	wHnu+m0URzHlTVNvRaAwn3geaWnCv5yhQFZetH9W/VEOcwOyaumX4ggg==
X-Received: by 2002:a17:902:ce88:b0:2c9:c952:6e9 with SMTP id d9443c01a7336-2d74dca2281mr379634065ad.2.1788183605112;
        Mon, 31 Aug 2026 06:40:05 -0700 (PDT)
Received: from localhost ([45.112.44.97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286fa20e2fsm30550306eec.28.2026.08.31.06.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:40:04 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Mon, 31 Aug 2026 21:36:33 +0800
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, catalin.marinas@arm.com, 
	will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, 
	pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, kees@kernel.org, 
	thuth@redhat.com, gshan@redhat.com, jic23@kernel.org, james.morse@arm.com, 
	ardb@kernel.org, leitao@debian.org, yeoreum.yun@arm.com, tangyouling@kylinos.cn, 
	hbathini@linux.ibm.com, adityag@linux.ibm.com, ionut.nechita@windriver.com, 
	liaoyuanhong@vivo.com, seanjc@google.com, fuqiang.wang@easystack.cn, makb@juniper.net, 
	piliu@redhat.com, ebiggers@kernel.org, jbouron@amazon.com, mclapinski@google.com, 
	me@linux.beauty, graf@amazon.com, bgwin@google.com, robh@kernel.org, 
	takahiro.akashi@linaro.org, palmer@rivosinc.com, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH v3 07/17] crash_dump: Fix potential double-free of
 keys_header
Message-ID: <apWDDWhkVMIpKWS-@Rk>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
 <20260826092541.3905933-8-ruanjinjie@huawei.com>
 <87186b8a-f68c-400b-97cf-8ea6129eba69@linux.ibm.com>
 <fecbe6ee-12e3-4f3d-94ac-eb7cd08eeb0d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fecbe6ee-12e3-4f3d-94ac-eb7cd08eeb0d@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260831_064008_501811_FBA24B9B 
X-CRM114-Status: GOOD (  20.23  )
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

On Mon, Aug 31, 2026 at 09:24:07AM +0800, Jinjie Ruan wrote:
>
>
>在 2026/8/30 13:59, Sourabh Jain 写道:
>> Hello Jinjie,
>>
>> Coiby is handling this issue in the below patch series:
>> https://lore.kernel.org/all/20260828084900.1496839-2-coiby.xu@gmail.com/
>>
>> Since the above patch series is all about crash_load_dm_crypt_keys,
>> could you
>> please consider dropping this patch from your series and reviewing his
>> patch
>> instead?
>
>Absolutely, happy to do so — I'll drop this patch and review Coiby's
>series instead.

Hi Jinjie,

Thank you for agreeing to drop your patch and review mine instead!

>
>>
>> Thanks,
>> Sourabh Jain
>>
>> On 26/08/26 14:55, Jinjie Ruan wrote:
>>> `keys_header` was freed in `build_keys_header()` without being reset
>>> to NULL, and the error path in `crash_load_dm_crypt_keys()` freed it
>>> unconditionally even when reused, leading to double-free or
>>> use-after-free.
>>>
>>> Add `free_keys_header()` to centralize freeing and NULL-setting.
>>> Use it in `build_keys_header()` and only free in the error path when
>>> the header was newly built (`!is_dm_key_reused`).
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Baoquan He <bhe@redhat.com>
>>> Cc: Mike Rapoport <rppt@kernel.org>
>>> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
>>> Cc: Pratyush Yadav <pratyush@kernel.org>
>>> Cc: Dave Young <ruirui.yang@linux.dev>
>>> Cc: stable@vger.kernel.org
>>> Fixes: e3a84be1ec2f ("arm64,ppc64le/kdump: pass dm-crypt keys to kdump
>>> kernel")
>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>> ---
>>>   kernel/crash_dump_dm_crypt.c | 15 +++++++++++----
>>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>>> index c685497cd470..ed0960ff0987 100644
>>> --- a/kernel/crash_dump_dm_crypt.c
>>> +++ b/kernel/crash_dump_dm_crypt.c
>>> @@ -363,15 +363,21 @@ static struct configfs_subsystem
>>> config_keys_subsys = {
>>>       },
>>>   };
>>>   +static void free_keys_header(void)
>>> +{
>>> +    if (keys_header) {
>>> +        kvfree(keys_header);
>>> +        keys_header = NULL;
>>> +    }
>>> +}
>>> +
>>>   static int build_keys_header(void)
>>>   {
>>>       struct config_item *item = NULL;
>>>       struct config_key *key;
>>>       int i, r;
>>>   -    if (keys_header != NULL)
>>> -        kvfree(keys_header);
>>> -
>>> +    free_keys_header();
>>>       keys_header = kzalloc(get_keys_header_size(key_count), GFP_KERNEL);
>>>       if (!keys_header)
>>>           return -ENOMEM;
>>> @@ -441,7 +447,8 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>>       r = kexec_add_buffer(&kbuf);
>>>       if (r) {
>>>           pr_err("Failed to call kexec_add_buffer, ret=%d\n", r);
>>> -        kvfree((void *)kbuf.buffer);
>>> +        if (!is_dm_key_reused)
>>> +            free_keys_header();
>>>           return r;
>>>       }
>>>       image->dm_crypt_keys_addr = kbuf.mem;
>>
>

-- 
Best regards,
Coiby

