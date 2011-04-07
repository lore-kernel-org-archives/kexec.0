Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Q7n4c-0006N2-Ji
	for kexec@lists.infradead.org; Thu, 07 Apr 2011 11:08:27 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p37B1XHo013679
	for <kexec@lists.infradead.org>; Thu, 7 Apr 2011 05:01:33 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p37B8IXR119776
	for <kexec@lists.infradead.org>; Thu, 7 Apr 2011 05:08:18 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p37B8HUi010555
	for <kexec@lists.infradead.org>; Thu, 7 Apr 2011 05:08:17 -0600
Message-ID: <4D9D9B1E.70001@in.ibm.com>
Date: Thu, 07 Apr 2011 16:38:14 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: Re: Question regarding the kexec support for FSL Book E
References: <4D9D5F17.2040208@in.ibm.com> <4D9D7465.8030102@linutronix.de>
In-Reply-To: <4D9D7465.8030102@linutronix.de>
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
Cc: kexec@lists.infradead.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>



Thanks a lot for the response. Please

On 04/07/11 13:53, Sebastian Andrzej Siewior wrote:
> Suzuki Poulose wrote:
>> Hi Sebastian,
> Hi,
>
>> I am working on the Kexec support for PPC44x based boards. I was going through
>> the patchset that you have posted for FSL Book E. I was not able to understand
>> some parts of the setup code. If you have some time, could you please help me by
>> answering the questions below :
>>
>> Here is what I understood from the code walk through :
>>
>> In relocate_kernel :, we try to setup a 1:1 mapping for 0-2GB of memory so that
>> the code could run with the MMU switched on. We leave a temparory mapping in
>> place and create the mapping for 0-2GiB.
>>
>> Q1: Does the temparory mapping cover the code which sets up the mapping ? i.e,
>> the code in fsl_booke_entry_mapping.S ?
>
> Yes, it does. Please keep in mind that relocate_new_kernel is kmalloc()
> into a separate page while running. This is not just the case for
> FSL-BookE but for all arches.
>
>> Q2: Does the relocate kernel also get loaded within the 0-2GB memory ?
>
The above should have been relocate_new_kernel(), loaded into 0-2GB virtual address ?
> Yes. We don't have a mapping >2GiB.
>

>> If so,
>> won't we have multiple mappings for the code we are executing, unless we were
>> mapped 1:1 by the primary kernel ?
>
> The primary kernel maps 0-2GiB 1:1. We jump to relocate_new_kernel() which
> is somewhere within 0..2GiB and not part of the original kernel image.
So the 0-2GiB 1:1 mapping, could create a 1:1 entry for the
relocate_new_kernel()'s physical address(which is again somewhere in 0..2GiB) too.
But the virtual address for relocate_new_kernel() could be different (not
necessarily 1:1, as mapped by the primary kernel). So we will have one mapping setup
by the primary kernel and the other by the 1:1 mapping.
This is the case of "multiple mappings", I was referring to above.

How is this case taken care of ? Is it via the temporary mapping ? What is the virtual
  address used by temporary mapping for the "relocate_new_kernel()" ?


Thanks
Suzuki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
