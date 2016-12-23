Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cKLKw-0005LQ-9I
 for kexec@lists.infradead.org; Fri, 23 Dec 2016 08:36:23 +0000
Subject: Re: [PATCH] x86/crash: Update the stale comment in
 reserve_crashkernel()
References: <1481772621-17923-1-git-send-email-xlpang@redhat.com>
 <20161222032234.GB25035@x1>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <585CE24D.80208@redhat.com>
Date: Fri, 23 Dec 2016 16:37:33 +0800
MIME-Version: 1.0
In-Reply-To: <20161222032234.GB25035@x1>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: xlpang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>, Xunlei Pang <xlpang@redhat.com>
Cc: Robert LeBlanc <robert@leblancnet.us>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On 12/22/2016 at 11:22 AM, Baoquan He wrote:
> On 12/15/16 at 11:30am, Xunlei Pang wrote:
>> CRASH_KERNEL_ADDR_MAX was missing for a long time, update it
>> with more detailed explanation.
>>
>> Cc: Robert LeBlanc <robert@leblancnet.us>
>> Cc: Baoquan He <bhe@redhat.com>
>> Signed-off-by: Xunlei Pang <xlpang@redhat.com>
>> ---
>>  arch/x86/kernel/setup.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>> index 9c337b0..79ee507 100644
>> --- a/arch/x86/kernel/setup.c
>> +++ b/arch/x86/kernel/setup.c
>> @@ -575,7 +575,10 @@ static void __init reserve_crashkernel(void)
>>  	/* 0 means: find the address automatically */
>>  	if (crash_base <= 0) {
>>  		/*
>> -		 *  kexec want bzImage is below CRASH_KERNEL_ADDR_MAX
>> +		 * Set CRASH_ADDR_LOW_MAX upper bound for crash range
>> +		 * as old kexec-tools loads bzImage below that, unless
>> +		 * "size,high" or "size@offset"(nonzero offset, see the
>> +		 * else leg below) is specified.
> Yes, this is a good catch. It might be better to add comment only about
> this if branch. If you want to say more about the upper bounds, better

OK, how about the following change?
        /*
         * Set CRASH_ADDR_LOW_MAX upper bound for crash memory.
         * as old kexec-tools loads bzImage below that, unless
         * "crashkernel=size[KMG],high" is specified.
         */

> discuss with Robert LeBlanc to see if it can be detailed in kdump.txt.

Yes, this is independent of Robert's documentation patch.

>
> Also please CC to x86 maintainers, or akpm. They can help merge this.

OK, thanks!

Regards,
Xunlei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
