Return-path: <kexec-bounces@lists.infradead.org>
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Iknm5-0005Vx-E9
	for kexec@lists.infradead.org; Wed, 24 Oct 2007 22:28:27 +0100
Message-ID: <471FB8D2.5060208@ct.jp.nec.com>
Date: Wed, 24 Oct 2007 14:27:46 -0700
From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] x86: add lapic_shutdown for x86_64
References: <47195763.1090803@ct.jp.nec.com> <47195807.6030809@ct.jp.nec.com>
	<20071024062933.GA4622@in.ibm.com>
In-Reply-To: <20071024062933.GA4622@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces@lists.infradead.org
To: vgoyal@in.ibm.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, tglx@linutronix.de, Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>

Vivek Goyal wrote:
> On Fri, Oct 19, 2007 at 06:21:11PM -0700, Hiroshi Shimamoto wrote:
>> From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
>>
>> Signed-off-by: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
>> ---
>>  arch/x86/kernel/apic_64.c |   14 ++++++++++++++
>>  include/asm-x86/apic_64.h |    1 +
>>  2 files changed, 15 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/x86/kernel/apic_64.c b/arch/x86/kernel/apic_64.c
>> index f47bc49..f28ccb5 100644
>> --- a/arch/x86/kernel/apic_64.c
>> +++ b/arch/x86/kernel/apic_64.c
>> @@ -287,6 +287,20 @@ void disable_local_APIC(void)
>>  	apic_write(APIC_SPIV, value);
>>  }
>>
>> +void lapic_shutdown(void)
>> +{
>> +	unsigned long flags;
>> +
>> +	if (!cpu_has_apic)
>> +		return;
>> +
>> +	local_irq_save(flags);
>> +
>> +	disable_local_APIC();
>> +
>> +	local_irq_restore(flags);
>> +}
>> +
>>  /*
> 
> Do we really have to introduce this function for 64bit? I remember some
> issues were faced on i386 w.r.t kernel enabling the LAPIC against the
> wishes of BIOS hence kernel was disabling it while shutting down. No
> such problems were reported for x86_64 hence this function existed only
> for i386.

Thanks for the comment. I didn't know the issues, so I'd simply added
this function for unification.

> If that is the case, probably we don't have to introduce lapic_shutdown()
> for x86_64. Instead call lapic_shutdown() for X86_32, and disble_local_APIC()
> otherwise?

I will do that. I was thinking which is good when posting these patches.

Thanks
Hiroshi Shimamoto

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
