Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QSStS-0003KJ-Hn
	for kexec@lists.infradead.org; Fri, 03 Jun 2011 11:50:23 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p53BclMW015567
	for <kexec@lists.infradead.org>; Fri, 3 Jun 2011 07:38:47 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p53BoH97121728
	for <kexec@lists.infradead.org>; Fri, 3 Jun 2011 07:50:17 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p53BoHAq006892
	for <kexec@lists.infradead.org>; Fri, 3 Jun 2011 08:50:17 -0300
Message-ID: <4DE8CA76.2060303@in.ibm.com>
Date: Fri, 03 Jun 2011 17:20:14 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] Kexec support for PPC440x
References: <4DE345B0.8020505@in.ibm.com> <4DE50617.7090509@linutronix.de>
	<4DE72EFE.8080502@in.ibm.com>
In-Reply-To: <4DE72EFE.8080502@in.ibm.com>
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
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux ppc dev <linuxppc-dev@lists.ozlabs.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>

On 06/02/11 12:04, Suzuki Poulose wrote:
> On 05/31/11 20:45, Sebastian Andrzej Siewior wrote:
>>
>> Suzuki Poulose wrote:
>>> Index: powerpc/arch/powerpc/kernel/44x_kexec_mapping.S
>>> ===================================================================
>>> --- /dev/null
>>> +++ powerpc/arch/powerpc/kernel/44x_kexec_mapping.S
>> ....
>>
>>> + *
>>> + */
>>> + bl nxtins /* Find our address */
>>> +nxtins: mflr r5 /* Make it accessible */
>>
>> Please don't mix labels and instructions.
> OK.
>>
>>> + tlbsx r23,0,r5 /* Find entry we are in */
>>
>> using tabs instead of spaces would make it look nice. Please also separate the arguments of the instruction i.e.
>> tlbsx r23, 0, r5
>
> Sure.
>>
>>
>>> Index: powerpc/arch/powerpc/kernel/misc_32.S
>>> ===================================================================
>>> --- powerpc.orig/arch/powerpc/kernel/misc_32.S
>>> +++ powerpc/arch/powerpc/kernel/misc_32.S
>>> @@ -736,6 +736,28 @@ relocate_new_kernel:
>>> mr r5, r31
>>>
>>> li r0, 0
>>> +#elif defined(CONFIG_44x) && !defined(CONFIG_47x)
>>> +
>>> + mr r29, r3
>>> + mr r30, r4
>>> + mr r31, r5
>>> +
>>> +#include "44x_kexec_mapping.S"
>>
>> The way you setup the 1:1 mapping should be close to what you are doing on
>> kernel entry.Isn't it possible to include the file here and in the entry
>> code?

> I will make this change and resend the patch.

I took a look at the way we do it at kernel entry. It looks more cleaner to leave
it untouched. Especially, when we add the support for 47x in the future, the code
  will become more unreadable.

What do you think ?

Thanks

Suzuki
>
> Thanks
>
> Suzuki
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
