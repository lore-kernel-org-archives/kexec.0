Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85797D116E4
	for <kexec@archiver.kernel.org>; Thu, 27 Nov 2025 02:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7TMgDKcDuO+a8FfAIh1HPsiWfN4auU+j7X84cJy2PqI=; b=CZ46NBE2Mvji56Pe2An76QfPCU
	mNKJb7AG1wDFWSmYoDGNHt0ql+Uaywuq49aWTRotlY/bbgc+89fpNziFtTVy0vywPA+3+yf2k64XB
	6I/Iog+9JzCnW50V71FIW4RtURcuifDEDaqPxq9itNsqgBhwyVh3aVleZ5kaIwYNLL4UwchmmOSX9
	HIqaxLLK3FMH95PaMl5zy5Rv9usxrnj08ai4idOyjp58FKTrBaADa8UnAPC8Jzh0znuz9LPDGWl25
	VqyN0PqrKfQrnDQXO9fRwZJgnh2aoVqy6Qx39/U4WIDBCX4Ji7Ui0MZDke03NQNELRSxK74qF473v
	wLRW5Aew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vORNq-0000000FsVr-1cEr;
	Thu, 27 Nov 2025 02:05:22 +0000
Received: from smtpbgeu2.qq.com ([18.194.254.142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vORNj-0000000FsTt-36Tk
	for kexec@lists.infradead.org;
	Thu, 27 Nov 2025 02:05:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1764209085;
	bh=7TMgDKcDuO+a8FfAIh1HPsiWfN4auU+j7X84cJy2PqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=TL02DivB5EG91RciylFvYaz8VARrKC2kDwcxw1viJMld8VBpzx9sJfOmCZYfTtss/
	 abeuQ0OBewrjfC7cXvq8h8XRO4Jw+tpPqXDBmsnvqrtplCdDeMZZflO+IlkNY0VNl7
	 DNlGg3WDJQqFZezyGIbfN/wUY6PcEaiwi4m1PqCM=
X-QQ-mid: zesmtpsz3t1764209082t75e6d365
X-QQ-Originating-IP: R1W27mN1EIMknNwOxEf8GO3kaReNAsp7u29qKwy7uE4=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Nov 2025 10:04:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18002369747829108487
Message-ID: <63BA9935197ADF34+2a3faf95-36da-46f1-b9b5-4e438e75d1be@uniontech.com>
Date: Thu, 27 Nov 2025 10:04:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] kexec: print out debugging message if required for
 kexec_load
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251126084427.3222212-1-maqianga@uniontech.com>
 <aSetpjhZi3T1Mjhb@MiWiFi-R3L-srv>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <aSetpjhZi3T1Mjhb@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OBUGnm9pFasAsKetXCa/DoGk7sp8vSZK3PM15q1GkKX2V/xxs5iQDa3y
	f9HbW4/7T6ZWow6oG1JFpQx2N4xggiESVnvto70RxxQpO4z5jTdcvtbYD3zxbRhIhGsUXp0
	k8x3Fdarp0QDj0IyWvTituF1yOAkb5m8vC+1aWjzdrWiZEUJ351zVhLIHa7YSVK/AsqAEdz
	Yq4ar7Cjrf9IMBFJIQEPQqsEyQgckZpjnj4VHp9WrycDvpE3lT7LRd1n4NWsXSt6rqCwvQn
	2HANbtkrfFIZV4iWy4LGWZ5PYTOff91FwtucZXRwsx7uvtO97RshPhtMl2X80TlJjGR/RX3
	+XfcG0q/tMMHGguDJ9BAqRTdhdzv9mMX0sg751P1p+F/E1qBIdhL63NbWY0mELUgPVj/fMa
	6+TGw6ERk+0J6F/tUdRrG03/T9KBwiJcSkGQeTL7adV9d//8oZqv7NEP6SKGlhPo7ig6Jaq
	mwJECjLajvVc2z28V0iu2DmHKkSVALoKs8MFTTIiNNp7k0S0Uaem9SsYMgyoYaXv5M1DTWn
	lnTqSmcJk+mzshYR/1bY9SwZZKg5n//M4+FS/XO0Iy2rCo/XMayfcmrGwKFzk98LGdlT5a3
	03+1YDIFFSAeHNgtUT59VKj7Hv/mWF5Nb66A1k6QXWF6mYbWdPKMp1U5FXw8t9oh8cOiyut
	Q5ANFS5xgqHDcNv3yHOiFogablEHZamKqx8wZUq1YZthLTiBbg8PjB2laQ1QundBHa23k5a
	LNXPW4oDEUufms1/UZlM9V14Vr20BAzI1SSZtNre8wIjRijRRkGr+HFj4Xzw9rGIgVCkadJ
	i2gBxjuEK2AzKFTOYnYjwUGi6Or4dtwkRi5kHrPyUbilHOJWI1K3kNFMdfO9da+g+Wmr4EC
	Wyu3eZg2lTt1XUaxgDjXkiiVvuvUGgUccfh155+cPBCzoCnt1j2oPXQtcY/EyZVOCDp3zC5
	KqT8pDJMLAwl33dTpu/z2WCgD+5ayYavQuJzKhX2vTpgyat8NfnQj1ariHUY4eNoxS/Fof4
	kEo22sC3QTQ3SdvIWLwA6nJXVBwWvC0TfHbwzZ417G5LWZ3NWYXaVvKA/UQgVU8bmBWCcoU
	o6OSjgOmcRa
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_180516_609566_DE27CA91 
X-CRM114-Status: GOOD (  16.91  )
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


在 2025/11/27 09:47, Baoquan He 写道:
> Hi,
>
> On 11/26/25 at 04:44pm, Qiang Ma wrote:
>> Overview:
>> =========
>> The commit a85ee18c7900 ("kexec_file: print out debugging message
>> if required") has added general code printing in kexec_file_load(),
>> but not in kexec_load().
>>      
>> Since kexec_load and kexec_file_load are not triggered simultaneously,
>> we can unify the debug flag of kexec and kexec_file as kexec_dbg_print.
> As I said in your last post, this is not needed at all, you just add a
> not needed thing to kernel.
>
> So NACK this patchset, unless you have reason to justify it. Sorry about
> it.
The segment prints discussed in the last post,

this patchset has been removed, leaving only type/start/head of kimage 
and flags.


I think the current patchset is still necessary.
For example, renaming kexec_file_dbg_print is still necessary, but not 
for kexec_file.


> Thanks
> Baoquan
>
>>      
>> Next, we need to do some things in this patchset:
>>      
>> 1. rename kexec_file_dbg_print to kexec_dbg_print
>> 2. Add KEXEC_DEBUG
>> 3. Initialize kexec_dbg_print for kexec
>> 4. Fix uninitialized struct kimage *image pointer
>> 5. Set the reset of kexec_dbg_print to kimage_free
>>
>> Testing:
>> =========
>> I did testing on x86_64, arm64 and loongarch. On x86_64, the printed messages
>> look like below:
>>
>> unset CONFIG_KEXEC_FILE:
>> [   81.502374] kexec: kexec_load: type:0, start:0x23fff7700 head:0x10a4b9002 flags:0x3e0010
>>
>> set CONFIG_KEXEC_FILE
>> [   36.774228] kexec_file: kernel: 0000000066c386c8 kernel_size: 0xd78400
>> [   36.821814] kexec-bzImage64: Loaded purgatory at 0x23fffb000
>> [   36.821826] kexec-bzImage64: Loaded boot_param, command line and misc at 0x23fff9000 bufsz=0x12d0 memsz=0x2000
>> [   36.821829] kexec-bzImage64: Loaded 64bit kernel at 0x23d400000 bufsz=0xd73400 memsz=0x2ab7000
>> [   36.821918] kexec-bzImage64: Loaded initrd at 0x23bd0b000 bufsz=0x16f40a8 memsz=0x16f40a8
>> [   36.821920] kexec-bzImage64: Final command line is: root=/dev/mapper/test-root crashkernel=auto rd.lvm.lv=test/root
>> [   36.821925] kexec-bzImage64: E820 memmap:
>> [   36.821926] kexec-bzImage64: 0000000000000000-000000000009ffff (1)
>> [   36.821928] kexec-bzImage64: 0000000000100000-0000000000811fff (1)
>> [   36.821930] kexec-bzImage64: 0000000000812000-0000000000812fff (2)
>> [   36.821931] kexec-bzImage64: 0000000000813000-00000000bee38fff (1)
>> [   36.821933] kexec-bzImage64: 00000000bee39000-00000000beec2fff (2)
>> [   36.821934] kexec-bzImage64: 00000000beec3000-00000000bf8ecfff (1)
>> [   36.821935] kexec-bzImage64: 00000000bf8ed000-00000000bfb6cfff (2)
>> [   36.821936] kexec-bzImage64: 00000000bfb6d000-00000000bfb7efff (3)
>> [   36.821937] kexec-bzImage64: 00000000bfb7f000-00000000bfbfefff (4)
>> [   36.821938] kexec-bzImage64: 00000000bfbff000-00000000bff7bfff (1)
>> [   36.821939] kexec-bzImage64: 00000000bff7c000-00000000bfffffff (2)
>> [   36.821940] kexec-bzImage64: 00000000feffc000-00000000feffffff (2)
>> [   36.821941] kexec-bzImage64: 00000000ffc00000-00000000ffffffff (2)
>> [   36.821942] kexec-bzImage64: 0000000100000000-000000023fffffff (1)
>> [   36.872348] kexec_file: nr_segments = 4
>> [   36.872356] kexec_file: segment[0]: buf=0x000000005314ece7 bufsz=0x4000 mem=0x23fffb000 memsz=0x5000
>> [   36.872370] kexec_file: segment[1]: buf=0x000000006e59b143 bufsz=0x12d0 mem=0x23fff9000 memsz=0x2000
>> [   36.872374] kexec_file: segment[2]: buf=0x00000000eb7b1fc3 bufsz=0xd73400 mem=0x23d400000 memsz=0x2ab7000
>> [   36.882172] kexec_file: segment[3]: buf=0x000000006af76441 bufsz=0x16f40a8 mem=0x23bd0b000 memsz=0x16f5000
>> [   36.889113] kexec_file: kexec_file_load: type:0, start:0x23fffb150 head:0x101a2e002 flags:0x8
>>
>> Changes in v3:
>> ==========
>> - Rename kexec_core_dbg_print to kexec_dbg_print
>> - Remove unnecessary segments prints
>> - Remove patch "kexec_file: Fix the issue of mismatch between loop variable types"
>>
>> Qiang Ma (3):
>>    kexec: Fix uninitialized struct kimage *image pointer
>>    kexec: add kexec flag to control debug printing
>>    kexec: print out debugging message if required for kexec_load
>>
>>   include/linux/kexec.h      | 9 +++++----
>>   include/uapi/linux/kexec.h | 1 +
>>   kernel/kexec.c             | 8 +++++++-
>>   kernel/kexec_core.c        | 4 +++-
>>   kernel/kexec_file.c        | 4 +---
>>   5 files changed, 17 insertions(+), 9 deletions(-)
>>
>> -- 
>> 2.20.1
>>
>

