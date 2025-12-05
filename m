Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9808D2F7C7
	for <kexec@archiver.kernel.org>; Fri,  5 Dec 2025 09:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cgtijbrOnH0Ezq4FjBcJ4gYpYInic5EP4ZCg9mmBXzE=; b=kD+vrsVp6vzWY2/A+YbnG4i9aA
	w+H8CUoXSsfp5QOt+RJwR1Yqaj0BpBHxnN0EnUbO8r62na1YKiBuQ9T0JnTUZafgtdr1ZegNoc/Ez
	enSbpBpKTKVuM/mRPKWEWi7i0mfrjZH7idtK8V4dtPr0hvsGWPBFQH7Y5sgVWWPJDAeia6AiyqeS0
	GztHAejCZYU9dtYVTLgssK3mX7u5TfWI52pDlLJugyoGzQRogEKhHATxhCO8/jiyWgRU6PENprfma
	n3XjjypuWDozVucDiFL/UQsl3ze/yMwQm7wB67CUyWbr7QlacctceHdEPOOwsRUNeYG7/0kRFLUZ9
	tAdJb3nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRS11-00000009I4w-3Brk;
	Fri, 05 Dec 2025 09:22:15 +0000
Received: from smtpbgeu2.qq.com ([18.194.254.142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRS0u-00000009I4A-1tBa
	for kexec@lists.infradead.org;
	Fri, 05 Dec 2025 09:22:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1764926456;
	bh=cgtijbrOnH0Ezq4FjBcJ4gYpYInic5EP4ZCg9mmBXzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=EBSt5/f7LweS1yHuEeN9KN8J5LrTxvgUWeB5IJmJ+EQDETF/Seby+cR54u9zKzt7N
	 GK+5mtmLP2tgUGM18kDExZwe7LiXc7DQVwfLJP4ZJ1WXQqgHrgyTSsYaye4PL+Tbg0
	 LrQbTOC/GRhkEiJV7501XK+QvmebfOPql1BSKlTU=
X-QQ-mid: esmtpsz16t1764926448t7642b181
X-QQ-Originating-IP: 25sTiplx55a9oIa9Uyt7aniRWWrZzT/qG4MW+e2/qrg=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 05 Dec 2025 17:20:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1852198581106936330
Message-ID: <ED6B71C237EB49E8+8e70fa30-f5fe-4d26-91c9-8498938a55b1@uniontech.com>
Date: Fri, 5 Dec 2025 17:20:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] kexec: print out debugging message if required for
 kexec_load
To: Sourabh Jain <sourabhjain@linux.ibm.com>, akpm@linux-foundation.org,
 bhe@redhat.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>
References: <20251126084427.3222212-1-maqianga@uniontech.com>
 <5be9a0d7-f014-41a7-97a2-75a3ba23f1d9@linux.ibm.com>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <5be9a0d7-f014-41a7-97a2-75a3ba23f1d9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NWujniBqiFoNBAaCB52u+pFq8JU6McjttiCIYHrnEoP2O1RhCRENxESE
	rVLG2IPNjgNGKpUhCyHVXmuhGiNSKAHpvdifrFD5bdGpG9b1JAp9PTRGs5YdTZItpErQw0A
	jdLEcAbFcy7bpJRu1gfp4i/bD6qjZWfnZe8eU9AsFwmWTZc4qwY78WSo24Jm9feKkVkwnNn
	3DCzJ0WlGnWwHdR9ytTzOcNH7pF/WtLoXcwxxAIuEC9S0XXppbUaqAG1gY0JQW0f4MXCIFR
	Kn1XtUrU419ze2Uw4rfE0rUr0ECVvVy1w1/1E1y0u4vN1CRSDYSxpRcbzwxcG+by1SVpLYj
	Aqr5KHxE6ACpepPGSygQh1VVKEJkcxAdnRTwVbNDlKRWsK/9cG3Zr/bnqtRi+NAq7hG2I3+
	b+Ik+n/rwNV2OcHjVmuKFysIN8z01StjvO6ozirwhccCmbVeHCc7wB4mRNLv4dAolUQDE+D
	Bho7tDHisuRmmKuUXXERiEfFSJgn+B8gq2Aly/PqePChWNGScgYGf9zFvpQrmDMEkpdmxS1
	3g+fAtzIfzptOida3o6DEMNDtml8/oHwnE4wRysTgMGSx5Z8YufTI15SkxawsEgXcdEoy6d
	NqdGj39edMY8uzM+tInG4KD+kmCITBx3gyfGs7G95H1fA4DhZOlIb0BSKL4cM2xVCU2aabW
	REJKeSX9u3nIthYuScwQ+YNs1uKup6XvKDYfmIGUOWr72neoxlPIeNui0O96uGA/pG25XNb
	mSbMuoUcKtNWnKHpPvFUbfrzUCZyPTDfBTA56XbfozKAN79F1mKKUHYgT/roJO3aElR7irP
	7w5SZEN0K+dGuiviVjY8MuAxF2eu0S3cW4UVdvqZh2eBGDLc5aN6eI04FRYR2ie3POnPwSN
	+VnZI9+NqDbOL3RtIRQO2Zd639fW9BcFU5qT9BdoPkTitg1mP4A8ycx7m/2gb8xvgcl6ceW
	ZZmnYINcRUkIQVxCQpXW59uh5dHIHtgWXtOw5Gj+n6+S51UkctR50Jc4e6qbYIze2yw0wvA
	T4QkP9Ba3h5Fp6ZJ+YcpN61ZpyzXc=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251205_012209_460966_64358DDF 
X-CRM114-Status: GOOD (  38.92  )
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


在 2025/12/4 20:18, Sourabh Jain 写道:
> Hello All,
>
> I read this patch series, including the older versions, and this is 
> what I
> think about the changes.
>
> There are two main reasons I see for why this patch series is proposed
> (these were not mentioned in the cover letter or commit messages):
>
> 1. Commit eb7622d908a09 ("kexec_file, riscv: print out debugging message
>    if required") and commit 6f8c1da071a4 ("kexec_file, arm64: print out
>    debugging message if required") moved some kexec-related debug 
> prints to
>    kexec_dprintk instead of pr_debug or pr_notice.
>
>    These commits made it easier to control the updated debug prints using
>    the -d option of kexec tool for kexec_file_load system call. But since
>    kexec_dprintk is not available for the kexec_load system call, 
> those prints
>    are no longer available for kexec_load at all. So patch series try 
> to bring
>    those logs for kexec_load system call.
>
> 2. Patch 03/03 prints additional logs about the kexec image type, start,
>     head, and flags via kexec_dprintk for the kexec_load system call.
>
> This is done by enabling the kexec_dprintk for kexec_load, so that logs
> from point 1 and the new logs from point 2 can be printed for kexec_load
> system call.
>
> However, the patch series does not explain why these additional debug 
> logs
> are needed for kexec_load. Since most of the work involved in loading
> kexec images through kexec_load happens in the kexec userspace tool, and
> the tool already provides enough logs to debug issues, the need for these
> extra kernel logs is not clear.
As pointed out in the point 1, these two commits not only move some
kexec-related debug prints to kexec_dprintk instead of pr_debug or 
pr_notice,
but also respectively remove and delete the debug print in kexec_image_info.
These debug print initially existed for both kexec_load and 
kexec_file_load in kernel space.
Just commit cbc2fe9d9cb2 ("kexec_file: The "add kexec_file flag to 
control debug printing")
series of patches removed or deleted some parts, but this series of 
patches only added them
to the generic code under the kexec_file_load path, not to the 
kexec_load path.
Therefore, the reason for adding this part of the debug print is to add 
this deleted debug print
to the kexec_load generic code. Regarding duplicate prints related to 
architecture, as mentioned
in previous posts[1], I want remove the print(type/head of kimage) in 
arm64, and then add it
to the general code.

[1]: 
https://lore.kernel.org/lkml/4D709A5E16BE5DEC+04521049-61de-411f-85c1-cfc049ff04c5@uniontech.com/

If commit cbc2fe9d9cb2 ("kexec_file: The "add kexec_file flag to control 
debug printing" series of patches
is indeed intended to remove those kexec_image_info in kexec_load, not 
to lose them.
I think patch 3 can be removed, but patch 1, 2 are still required.
As Sourabh Jain mentioned in the point 1, the debugging print that uses 
kexec_dprintk
in the kexec_load path currently existing under arm64 is equivalent to 
being unavailable.
>
> So adding the need for the additional debug logs in the cover letter or
> commit message is needed to decide whether it is worth adding the code
> change proposed in this patch series Also, I found it hard to map the 
> commit message to the changes introduced in the commits. And finally 
> If I review the patches only based on the code changes: 01/03 The 
> commit message refers to kexec_dbg_print 
There is an error in the patch description. It should be 
kexec_file_dbg_print. I will fix it.
> as kexec_core_dbg_print. 02/03 I think kexec_dbg_print should be set 
> to false at the end of kimage_free, not at the start. 03/03 There is 
> duplication of debug logs for architectures that already print the 
> same information. For example, arm64. - 
In the kimage_file_alloc_init()/kimage_alloc_init(), if there is an 
abnormal exit before executing *rimage = image,
the image is empty, but kexec_dbg_print has been initialized.
In this case, It needs to be placed at the beginning of kimage_free to 
reset it.
> Sourabh Jain
> On 26/11/25 14:14, Qiang Ma wrote:
>> Overview:
>> =========
>> The commit a85ee18c7900 ("kexec_file: print out debugging message
>> if required") has added general code printing in kexec_file_load(),
>> but not in kexec_load().
>>      Since kexec_load and kexec_file_load are not triggered 
>> simultaneously,
>> we can unify the debug flag of kexec and kexec_file as kexec_dbg_print.
>>      Next, we need to do some things in this patchset:
>>      1. rename kexec_file_dbg_print to kexec_dbg_print
>> 2. Add KEXEC_DEBUG
>> 3. Initialize kexec_dbg_print for kexec
>> 4. Fix uninitialized struct kimage *image pointer
>> 5. Set the reset of kexec_dbg_print to kimage_free
>>
>> Testing:
>> =========
>> I did testing on x86_64, arm64 and loongarch. On x86_64, the printed 
>> messages
>> look like below:
>>
>> unset CONFIG_KEXEC_FILE:
>> [   81.502374] kexec: kexec_load: type:0, start:0x23fff7700 
>> head:0x10a4b9002 flags:0x3e0010
>>
>> set CONFIG_KEXEC_FILE
>> [   36.774228] kexec_file: kernel: 0000000066c386c8 kernel_size: 
>> 0xd78400
>> [   36.821814] kexec-bzImage64: Loaded purgatory at 0x23fffb000
>> [   36.821826] kexec-bzImage64: Loaded boot_param, command line and 
>> misc at 0x23fff9000 bufsz=0x12d0 memsz=0x2000
>> [   36.821829] kexec-bzImage64: Loaded 64bit kernel at 0x23d400000 
>> bufsz=0xd73400 memsz=0x2ab7000
>> [   36.821918] kexec-bzImage64: Loaded initrd at 0x23bd0b000 
>> bufsz=0x16f40a8 memsz=0x16f40a8
>> [   36.821920] kexec-bzImage64: Final command line is: 
>> root=/dev/mapper/test-root crashkernel=auto rd.lvm.lv=test/root
>> [   36.821925] kexec-bzImage64: E820 memmap:
>> [   36.821926] kexec-bzImage64: 0000000000000000-000000000009ffff (1)
>> [   36.821928] kexec-bzImage64: 0000000000100000-0000000000811fff (1)
>> [   36.821930] kexec-bzImage64: 0000000000812000-0000000000812fff (2)
>> [   36.821931] kexec-bzImage64: 0000000000813000-00000000bee38fff (1)
>> [   36.821933] kexec-bzImage64: 00000000bee39000-00000000beec2fff (2)
>> [   36.821934] kexec-bzImage64: 00000000beec3000-00000000bf8ecfff (1)
>> [   36.821935] kexec-bzImage64: 00000000bf8ed000-00000000bfb6cfff (2)
>> [   36.821936] kexec-bzImage64: 00000000bfb6d000-00000000bfb7efff (3)
>> [   36.821937] kexec-bzImage64: 00000000bfb7f000-00000000bfbfefff (4)
>> [   36.821938] kexec-bzImage64: 00000000bfbff000-00000000bff7bfff (1)
>> [   36.821939] kexec-bzImage64: 00000000bff7c000-00000000bfffffff (2)
>> [   36.821940] kexec-bzImage64: 00000000feffc000-00000000feffffff (2)
>> [   36.821941] kexec-bzImage64: 00000000ffc00000-00000000ffffffff (2)
>> [   36.821942] kexec-bzImage64: 0000000100000000-000000023fffffff (1)
>> [   36.872348] kexec_file: nr_segments = 4
>> [   36.872356] kexec_file: segment[0]: buf=0x000000005314ece7 
>> bufsz=0x4000 mem=0x23fffb000 memsz=0x5000
>> [   36.872370] kexec_file: segment[1]: buf=0x000000006e59b143 
>> bufsz=0x12d0 mem=0x23fff9000 memsz=0x2000
>> [   36.872374] kexec_file: segment[2]: buf=0x00000000eb7b1fc3 
>> bufsz=0xd73400 mem=0x23d400000 memsz=0x2ab7000
>> [   36.882172] kexec_file: segment[3]: buf=0x000000006af76441 
>> bufsz=0x16f40a8 mem=0x23bd0b000 memsz=0x16f5000
>> [   36.889113] kexec_file: kexec_file_load: type:0, start:0x23fffb150 
>> head:0x101a2e002 flags:0x8
>>
>> Changes in v3:
>> ==========
>> - Rename kexec_core_dbg_print to kexec_dbg_print
>> - Remove unnecessary segments prints
>> - Remove patch "kexec_file: Fix the issue of mismatch between loop 
>> variable types"
>>
>> Qiang Ma (3):
>>    kexec: Fix uninitialized struct kimage *image pointer
>>    kexec: add kexec flag to control debug printing
>>    kexec: print out debugging message if required for kexec_load
>>
>>   include/linux/kexec.h      | 9 +++++----
>>   include/uapi/linux/kexec.h | 1 +
>>   kernel/kexec.c             | 8 +++++++-
>>   kernel/kexec_core.c        | 4 +++-
>>   kernel/kexec_file.c        | 4 +---
>>   5 files changed, 17 insertions(+), 9 deletions(-)
>>
>
>

