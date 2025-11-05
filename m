Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B658CCFA04
	for <kexec@archiver.kernel.org>; Wed,  5 Nov 2025 04:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mJ58wxkUp3QPDHQZyMF0q4nEx7f3gcDEWgs42azNwv4=; b=hPghGFUzdFzmOUFQNCIuRf8liC
	PVyO7v/TaBmx+ztxi+iNyrdYM5ne2LsurtZz/henuxJ3Ms/ljoy3S+P4mvJWukhaglAPebdPUL/y/
	P11++DkaHj2IfNsHh4/YwvAQQW03E3ePG1Ijp3F69xy4WcGhQ15tuKpHbUvn4VIioo9vNhFeiQV6u
	N84VMbh3jgIfnenvUZqct1PvPs0R+gr9IoB1X6+6QkN6JJ0der+LcZ4deJe2g/jXXhtC44U0qNMJK
	6O6e4HIMc5TrbZvEzdg8sQIG/zsq+8Oa/NPf/wM3NaFmgjcJT6jme2XoFwQihxDIyXoh9YgT30BNy
	j9Anjcgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGVBO-0000000D0AF-0obc;
	Wed, 05 Nov 2025 04:31:42 +0000
Received: from smtpbg151.qq.com ([18.169.211.239])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGVBK-0000000D09d-17wT
	for kexec@lists.infradead.org;
	Wed, 05 Nov 2025 04:31:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1762317064;
	bh=mJ58wxkUp3QPDHQZyMF0q4nEx7f3gcDEWgs42azNwv4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=onTdruhMlw5iPpYED7i0Drw+s5KfcnflcCoLRzr2nbijNY7Gke+rBa4ywdov/GFrz
	 A0C7aXoCN7nJhktapBuApjA4krZX956YYiOVjv/XUEts3d864G40gEj1Ty+QadeZnf
	 d2/9g6E2IZcR6nusIHUlmMt6oZnye4XMMvvM5cPY=
X-QQ-mid: zesmtpgz3t1762317061tf373d11d
X-QQ-Originating-IP: LqdixfTpbZBUVo+Ea7w7yN8rPbRjEJ7emqHxABhoIn8=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Nov 2025 12:31:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8064024665032217773
Message-ID: <C1D5AF8ADDDB53F3+623309e9-4fc9-4186-8f07-04cd6f5d5612@uniontech.com>
Date: Wed, 5 Nov 2025 12:31:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] kexec_file: Fix the issue of mismatch between loop
 variable types
From: Qiang Ma <maqianga@uniontech.com>
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251103063440.1681657-1-maqianga@uniontech.com>
 <20251103063440.1681657-5-maqianga@uniontech.com>
 <aQq/CHi10ihT8/sn@MiWiFi-R3L-srv>
 <c669d240-1ee8-4897-a30d-3efefe161085@uniontech.com>
Content-Language: en-US
In-Reply-To: <c669d240-1ee8-4897-a30d-3efefe161085@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: M58CI+QHpTsklVtnHl0PfrWs7Jlc4iKmKu+ho6D9VUo+fgA8IjGwtizG
	weDUFU9SAJK37CUi9V8c+9mAfaCK6elmyArCc5r2rbzy3jMoItKKHswShO+/G6cFH+65pfp
	TydH6F4x7JKZHamoWJKyZOPpSUvf/b5XLmpII5Jm8ZiZGQxG4U0zRxUrL/TNmxnmdyZT6eJ
	HgjhBQf+287mGERgv8JPPa+3RrMfM3g8bsQLkMw3rXYLxsUIsjIOm8/MVK94zrsR4WQQC95
	MIBZk4dOfZCvSFTXutNJrxdTywJSIAvR+yFdHHkMKtj6CJMCx2f48mqojSrae30TSdCxiQU
	dtcMopqjj+VESf0X5nd+8G3Hg90USBF8Ee+JEgIzFCnuoXAoygjh9AxBey57UtNJezIuybn
	IH/M1z5hlKjn+Ihol/VTXYe+6DerWsrfPIlfkf28Wbdph9y6ZcKsws298R+UyhpNj6wfr3O
	xyr78MdlP6Bvn4uVmVNuZ+XO/k3bsT4DPjKF+qMgGvWwXDYBXOJc9wxIcW71DiR4RCZ7F2M
	qUYfaxxK10+VXozLdQhMjvXDp+Qu/6hnuDvAw5dHwMeh8in+jMTObKpVe65aX9O63p/yOS1
	D4uZ1fDUOW1dkoiCz+wchU8LrvwB4+ZwQjy6m4MtVSY426y1aLEz03Lmgu8dLrv8gzy0+bd
	aqnyf+MXkJ8i+XKyKyBsNxx32ieDTlG0bAd9KgXMxzILuRhC7sIAWTqwx5GrOcpmrrridY8
	gfpkpjB9hvp0bqS67aXfbKcoAhRgrsvRkFxqvsXVOIg8gtBIieHNulnkm78Cic2dKYxgjOG
	u6kEV0GeGhZbSoYzUgQ10yqwml6sidVMHLMU/5eKPp1LSj9KA1XLn3631oXdBDKgfUs4sxu
	0jONnuy2A/g8AsZMkpTntObWVeK6XO0a1xbcicEueaz7WaBNMvWkjRh96VQan5TJbyDB86u
	IdpC5kLFmsvXpOrOviU7yQPgcNSFaqe0CAxZpRk8EZj+JYi08v4OGOnorSkxGHVC2VqgQU7
	Om/hMXO7w76s0aRe0hwDpmXQDyrN7X9Jz/5ZzSCY9R2tVWGRoZDZp+jooAE3o=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_203139_095513_47BA6083 
X-CRM114-Status: UNSURE (   9.63  )
X-CRM114-Notice: Please train this message.
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


在 2025/11/5 11:47, Qiang Ma 写道:
>
> 在 2025/11/5 11:05, Baoquan He 写道:
>> On 11/03/25 at 02:34pm, Qiang Ma wrote:
>>> The type of the struct kimage member variable nr_segments is 
>>> unsigned long.
>>> Correct the loop variable i and the print format specifier type.
>> I can't see what's meaningful with this change. nr_segments is unsigned
>> long, but it's the range 'i' will loop. If so, we need change all for
>> loop of the int iterator.
> If image->nr_segments is large enough, 'i' overflow causes an infinite 
> loop.
Meanwhile, the do_kexec_load() was checked and also defined as 'unsigned 
long i'.
>>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>>> ---
>>>   kernel/kexec_file.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>>> index 4a24aadbad02..7afdaa0efc50 100644
>>> --- a/kernel/kexec_file.c
>>> +++ b/kernel/kexec_file.c
>>> @@ -366,7 +366,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, 
>>> int, initrd_fd,
>>>       int image_type = (flags & KEXEC_FILE_ON_CRASH) ?
>>>                KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
>>>       struct kimage **dest_image, *image;
>>> -    int ret = 0, i;
>>> +    int ret = 0;
>>> +    unsigned long i;
>>>         /* We only trust the superuser with rebooting the system. */
>>>       if (!kexec_load_permitted(image_type))
>>> @@ -432,7 +433,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, 
>>> int, initrd_fd,
>>>           struct kexec_segment *ksegment;
>>>             ksegment = &image->segment[i];
>>> -        kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx 
>>> memsz=0x%zx\n",
>>> +        kexec_dprintk("segment[%lu]: buf=0x%p bufsz=0x%zx mem=0x%lx 
>>> memsz=0x%zx\n",
>>>                     i, ksegment->buf, ksegment->bufsz, ksegment->mem,
>>>                     ksegment->memsz);
>>>   --
>>> 2.20.1
>>>
>>

