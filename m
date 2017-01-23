Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cVead-0003Lt-JX
 for kexec@lists.infradead.org; Mon, 23 Jan 2017 13:23:20 +0000
Subject: Re: [PATCH v2] x86/crash: Update the stale comment in
 reserve_crashkernel()
References: <1485154103-18426-1-git-send-email-xlpang@redhat.com>
 <20170123084850.GA15988@dhcp-128-65.nay.redhat.com>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <58860406.1030604@redhat.com>
Date: Mon, 23 Jan 2017 21:24:22 +0800
MIME-Version: 1.0
In-Reply-To: <20170123084850.GA15988@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>, Xunlei Pang <xlpang@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Robert LeBlanc <robert@leblancnet.us>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>

On 01/23/2017 at 04:48 PM, Dave Young wrote:
> Hi, Xunlei
>
> On 01/23/17 at 02:48pm, Xunlei Pang wrote:
>> CRASH_KERNEL_ADDR_MAX has been missing for a long time,
>> update it with more detailed explanation.
>>
>> Cc: Robert LeBlanc <robert@leblancnet.us>
>> Cc: Baoquan He <bhe@redhat.com>
>> Signed-off-by: Xunlei Pang <xlpang@redhat.com>
>> ---
>>  arch/x86/kernel/setup.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>> index 4cfba94..c32a167 100644
>> --- a/arch/x86/kernel/setup.c
>> +++ b/arch/x86/kernel/setup.c
>> @@ -575,7 +575,9 @@ static void __init reserve_crashkernel(void)
>>  	/* 0 means: find the address automatically */
>>  	if (crash_base <= 0) {
>>  		/*
>> -		 *  kexec want bzImage is below CRASH_KERNEL_ADDR_MAX
>> +		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory
>> +		 * as old kexec-tools loads bzImage below that, unless
>> +		 * "crashkernel=size[KMG],high" is specified.
> There is already comment before the define of those macros, also
> there are 32bit case which has a different reason about 512M there as
> well.

If we see from the kexec's perspective, we have a common CRASH_ADDR_LOW_MAX
definition for both x86 32-bit and 64-bit(32-bit x86 has the same value defined for
CRASH_ADDR_LOW_MAX and CRASH_ADDR_HIGH_MAX), so old kexec will load below
CRASH_ADDR_LOW_MAX,  so I think the description is fine :-)

Regards,
Xunlei

>
> So it looks better to just drop the one line comment without adding
> further comments here.
>>  		 */
>>  		crash_base = memblock_find_in_range(CRASH_ALIGN,
>>  						    high ? CRASH_ADDR_HIGH_MAX
>> -- 
>> 1.8.3.1
>>
> Thanks
> Dave
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
