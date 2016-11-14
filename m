Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c6K2v-0000Bl-3H
 for kexec@lists.infradead.org; Mon, 14 Nov 2016 16:23:50 +0000
Subject: Re: [PATCH v2] kexec: Increase the upper limit for RAM segments
References: <1478902871-13800-1-git-send-email-sgoel@codeaurora.org>
 <5829974D.4020901@redhat.com>
From: "Goel, Sameer" <sgoel@codeaurora.org>
Message-ID: <8f592c5e-6999-771e-05cb-9c754ef94850@codeaurora.org>
Date: Mon, 14 Nov 2016 09:23:25 -0700
MIME-Version: 1.0
In-Reply-To: <5829974D.4020901@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: xlpang@redhat.com, geoff@infradead.org
Cc: kexec@lists.infradead.org, bhe@redhat.com

I meant MAX_MEMORY_RANGES. Updated KEXEC_SEGMENT_MAX to just match this. 
I can revert KEXEC_SEGMENT_MAX.

Thanks,
Sameer

On 11/14/2016 3:51 AM, Xunlei Pang wrote:
> On 2016/11/12 at 06:21, Sameer Goel wrote:
>> On a newer UEFI based Qualcomm target the number of system ram regions
>> retrieved from /proc/iomem are ~40. So increasing the current hardcoded
>> values to 64 from 16.
>
> I am a little confused, memory regions from /proc/iomem should be MAX_MEMORY_RANGES used
> as the elfcorehdr, while KEXEC_SEGMENT_MAX stands for the kexec segments passed to the kexec
> syscall, like kernel image, initrd image, purgatory, etc.
>
> Do you mean KEXEC_SEGMENT_MAX or MAX_MEMORY_RANGES?
>
> Regards,
> Xunlei
>
>>
>> Signed-off-by: Sameer Goel <sgoel@codeaurora.org>
>> ---
>>  kexec/arch/arm64/kexec-arm64.h | 2 +-
>>  kexec/kexec-syscall.h          | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
>> index bac62f8..bd4c20e 100644
>> --- a/kexec/arch/arm64/kexec-arm64.h
>> +++ b/kexec/arch/arm64/kexec-arm64.h
>> @@ -11,7 +11,7 @@
>>  #include "image-header.h"
>>  #include "kexec.h"
>>
>> -#define KEXEC_SEGMENT_MAX 16
>> +#define KEXEC_SEGMENT_MAX 64
>>
>>  #define BOOT_BLOCK_VERSION 17
>>  #define BOOT_BLOCK_LAST_COMP_VERSION 16
>> diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
>> index c0d0bea..f84c937 100644
>> --- a/kexec/kexec-syscall.h
>> +++ b/kexec/kexec-syscall.h
>> @@ -115,7 +115,7 @@ static inline long kexec_file_load(int kernel_fd, int initrd_fd,
>>  #define KEXEC_ARCH_MIPS    ( 8 << 16)
>>  #define KEXEC_ARCH_CRIS    (76 << 16)
>>
>> -#define KEXEC_MAX_SEGMENTS 16
>> +#define KEXEC_MAX_SEGMENTS 64
>>
>>  #ifdef __i386__
>>  #define KEXEC_ARCH_NATIVE	KEXEC_ARCH_386
>
>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
