Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Q83bU-0005hD-W1
	for kexec@lists.infradead.org; Fri, 08 Apr 2011 04:47:30 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p384ZMfw009486
	for <kexec@lists.infradead.org>; Thu, 7 Apr 2011 22:35:22 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p384lOd3101530
	for <kexec@lists.infradead.org>; Thu, 7 Apr 2011 22:47:24 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p384lNMF027934
	for <kexec@lists.infradead.org>; Thu, 7 Apr 2011 22:47:24 -0600
Message-ID: <4D9E9355.8010407@in.ibm.com>
Date: Fri, 08 Apr 2011 10:17:17 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: Re: Question regarding the kexec support for FSL Book E
References: <4D9D5F17.2040208@in.ibm.com> <4D9D7465.8030102@linutronix.de>
	<4D9D9B1E.70001@in.ibm.com>
	<BANLkTimw4e=mF-8K+zwtXed9BcA1c8=7-g@mail.gmail.com>
	<20110407162258.GA15298@linutronix.de>
In-Reply-To: <20110407162258.GA15298@linutronix.de>
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
Cc: McClintock Matthew-B29882 <B29882@freescale.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>

On 04/07/11 21:52, Sebastian Andrzej Siewior wrote:
> * McClintock Matthew-B29882 | 2011-04-07 15:19:12 [+0000]:
>
>> On Thu, Apr 7, 2011 at 6:08 AM, Suzuki Poulose<suzuki@in.ibm.com>  wrote:
>>> How is this case taken care of ? Is it via the temporary mapping ? What is
>>> the virtual
>>>   address used by temporary mapping for the "relocate_new_kernel()" ?
>
> It is the same as the physical :) It is hard to tell where exactly the
> kernel image will be. It is somewhere between 0 and
> KEXEC_CONTROL_MEMORY_LIMIT. It is allocated in
> kimage_alloc_normal_control_pages(). It should not matter where it is.

I guess I got my answer :). The virtual address of the relocate_new_kernel() is
a kernel space VA, and hence would be above 2G (> PAGE_OFFSET), so there won't
be a clash of the 1:1 mapping that we create. Also, the src/destination pages
won't overlap the with the relocate_new_kernel. Hence we are safe.

>
>> When you load the new kexec image with kexec -l, I believe we make
>> sure we are in the first 2gb of memory. Then when you kexec, all the
>> TLB's are torn down and we setup a 1:1 virtual:physical mapping for
>> the first 2GB of memory. Then some assembly copies kernel from the
>> stored location to the destination and we boot the new kernel.
>
> arch/powerpc/include/asm/kexec.h:
> |#ifdef CONFIG_FSL_BOOKE
> |
> |/*
> | * On FSL-BookE we setup a 1:1 mapping which covers the first 2GiB of memory
> | * and therefore we can only deal with memory within this range
> | */
> |#define KEXEC_SOURCE_MEMORY_LIMIT      (2 * 1024 * 1024 * 1024UL - 1)
> |#define KEXEC_DESTINATION_MEMORY_LIMIT (2 * 1024 * 1024 * 1024UL - 1)
> |#define KEXEC_CONTROL_MEMORY_LIMIT     (2 * 1024 * 1024 * 1024UL - 1)
> |
> |#else
>
> So the kernel never gives memory above 2GiB to userland.
Right. If the page allocated is above 2GiB Physical Address, it is discarded,
and we look for new page.

Thanks

Suzuki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
