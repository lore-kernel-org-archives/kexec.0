Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QS1UZ-0000c7-Bu
	for kexec@lists.infradead.org; Thu, 02 Jun 2011 06:34:52 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e4.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p526DYTH022090
	for <kexec@lists.infradead.org>; Thu, 2 Jun 2011 02:13:34 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p526Ylbc104176
	for <kexec@lists.infradead.org>; Thu, 2 Jun 2011 02:34:47 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p526YkZx006442
	for <kexec@lists.infradead.org>; Thu, 2 Jun 2011 02:34:46 -0400
Message-ID: <4DE72EFE.8080502@in.ibm.com>
Date: Thu, 02 Jun 2011 12:04:38 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] Kexec support for PPC440x
References: <4DE345B0.8020505@in.ibm.com> <4DE50617.7090509@linutronix.de>
In-Reply-To: <4DE50617.7090509@linutronix.de>
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
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, linux ppc dev <linuxppc-dev@lists.ozlabs.org>, lkml <linux-kernel@vger.kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>

On 05/31/11 20:45, Sebastian Andrzej Siewior wrote:
>
> Suzuki Poulose wrote:
>> Index: powerpc/arch/powerpc/kernel/44x_kexec_mapping.S
>> ===================================================================
>> --- /dev/null
>> +++ powerpc/arch/powerpc/kernel/44x_kexec_mapping.S
> ....
>
>> + *
>> + */
>> + bl nxtins /* Find our address */
>> +nxtins: mflr r5 /* Make it accessible */
>
> Please don't mix labels and instructions.
OK.
>
>> + tlbsx r23,0,r5 /* Find entry we are in */
>
> using tabs instead of spaces would make it look nice. Please also separate the arguments of the instruction i.e.
> tlbsx r23, 0, r5

Sure.
>
>
>> Index: powerpc/arch/powerpc/kernel/misc_32.S
>> ===================================================================
>> --- powerpc.orig/arch/powerpc/kernel/misc_32.S
>> +++ powerpc/arch/powerpc/kernel/misc_32.S
>> @@ -736,6 +736,28 @@ relocate_new_kernel:
>> mr r5, r31
>>
>> li r0, 0
>> +#elif defined(CONFIG_44x) && !defined(CONFIG_47x)
>> +
>> + mr r29, r3
>> + mr r30, r4
>> + mr r31, r5
>> +
>> +#include "44x_kexec_mapping.S"
>
> The way you setup the 1:1 mapping should be close to what you are doing on
> kernel entry.Isn't it possible to include the file here and in the entry
> code?
I will make this change and resend the patch.

Thanks

Suzuki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
