Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QS2Me-0001CJ-F4
	for kexec@lists.infradead.org; Thu, 02 Jun 2011 07:30:45 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p527J0bj004329
	for <kexec@lists.infradead.org>; Thu, 2 Jun 2011 01:19:00 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p527UJTj351824
	for <kexec@lists.infradead.org>; Thu, 2 Jun 2011 01:30:20 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p521UI1v032330
	for <kexec@lists.infradead.org>; Wed, 1 Jun 2011 19:30:19 -0600
Message-ID: <4DE73C04.5050208@in.ibm.com>
Date: Thu, 02 Jun 2011 13:00:12 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] Kexec support for PPC440x
References: <4DE345B0.8020505@in.ibm.com> <4DE50617.7090509@linutronix.de>
	<1306999551.29297.57.camel@pasglop>
In-Reply-To: <1306999551.29297.57.camel@pasglop>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux ppc dev <linuxppc-dev@lists.ozlabs.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>

On 06/02/11 12:55, Benjamin Herrenschmidt wrote:
> On Tue, 2011-05-31 at 17:15 +0200, Sebastian Andrzej Siewior wrote:
>> Suzuki Poulose wrote:
>>> Index: powerpc/arch/powerpc/kernel/44x_kexec_mapping.S
>>> ===================================================================
>>> --- /dev/null
>>> +++ powerpc/arch/powerpc/kernel/44x_kexec_mapping.S
>> ....
>>
>>> + *
>>> + */
>>> +    bl    nxtins                /* Find our address */
>>> +nxtins:    mflr    r5                /* Make it accessible */
>>
>> Please don't mix labels and instructions.
>
> With proper indent it's fine as long as he uses numerical relative
> labels which should be the case here. For example, the above, it should
> look like:
>
> 	bl	1f
> 1:	mflr	r5
>
>>> +    tlbsx    r23,0,r5            /* Find entry we are in */
>>
>> using tabs instead of spaces would make it look nice. Please also separate
>> the arguments of the instruction i.e.
>> 	tlbsx	r23, 0, r5
>
> That's arguable. If you look at arch/powerpc, we tend not to separate
> the arguments ;-)
>
> Actually I used to, others didn't and I changed my own style.
>
>>> Index: powerpc/arch/powerpc/kernel/misc_32.S
>>> ===================================================================
>>> --- powerpc.orig/arch/powerpc/kernel/misc_32.S
>>> +++ powerpc/arch/powerpc/kernel/misc_32.S
>>> @@ -736,6 +736,28 @@ relocate_new_kernel:
>>>       mr      r5, r31
>>>
>>>       li    r0, 0
>>> +#elif defined(CONFIG_44x)&&  !defined(CONFIG_47x)
>>> +
>>> +    mr    r29, r3
>>> +    mr    r30, r4
>>> +    mr    r31, r5
>>> +
>>> +#include "44x_kexec_mapping.S"
>>
>> The way you setup the 1:1 mapping should be close to what you are doing on
>> kernel entry. Isn't it possible to include the file here and in the entry
>> code?
>
> It should just not be #included, what about branching out instead ?

This code, i.e, relocate_new_kernel is copied into the control buffer, which will
get the first chance to execute before the purgatory. So we may not be able to
branch to the code, since we are executing this from a different address and we
would invalidate the mapping for the code except the control buffer.

Thanks

Suzuki
  


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
