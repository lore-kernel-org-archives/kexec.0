Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QgsWB-0000UD-Ev
	for kexec@lists.infradead.org; Wed, 13 Jul 2011 06:02:00 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp09.in.ibm.com (8.14.4/8.13.1) with ESMTP id p6D5h9n8020375
	for <kexec@lists.infradead.org>; Wed, 13 Jul 2011 11:13:09 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p6D61lfq1310766
	for <kexec@lists.infradead.org>; Wed, 13 Jul 2011 11:31:48 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p6D61loG030060
	for <kexec@lists.infradead.org>; Wed, 13 Jul 2011 16:01:47 +1000
Message-ID: <4E1D34CB.8010207@in.ibm.com>
Date: Wed, 13 Jul 2011 11:31:47 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] powerpc32: Kexec support for PPC440X chipsets
References: <20110712064356.28567.48722.stgit@suzukikp.in.ibm.com>
	<BE0C6BFF-E55A-4860-A05C-CA5313012FCC@kernel.crashing.org>
In-Reply-To: <BE0C6BFF-E55A-4860-A05C-CA5313012FCC@kernel.crashing.org>
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
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Benjammin Herrenschmidt <benh@kernel.crashing.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kexec <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, linux ppc dev <linuxppc-dev@lists.ozlabs.org>, Vivek Goyal <vgoyal@redhat.com>

On 07/13/11 10:58, Kumar Gala wrote:
>
> On Jul 12, 2011, at 1:44 AM, Suzuki K. Poulose wrote:
>
>> Changes from V1: Uses a tmp mapping in the other address space to setup
>> 		 the 1:1 mapping (suggested by Sebastian Andrzej Siewior).
>>
>> Note: Should we do the same for kernel entry code for PPC44x ?
>>
>> This patch adds kexec support for PPC440 based chipsets.This work is based
>> on the KEXEC patches for FSL BookE.
>>
>> The FSL BookE patch and the code flow could be found at the link below:
>>
>> 	http://patchwork.ozlabs.org/patch/49359/
>>
>> Steps:
>>
>> 1) Invalidate all the TLB entries except the one this code is run from
>> 2) Create a tmp mapping for our code in the other address space and jump to it
>> 3) Invalidate the entry we used
>> 4) Create a 1:1 mapping for 0-2GiB in blocks of 256M
>> 5) Jump to the new 1:1 mapping and invalidate the tmp mapping
>>
>> I have tested this patches on Ebony, Sequoia boards and Virtex on QEMU.
>> It would be great if somebody could test this on the other boards.
>>
>> Signed-off-by: 	Suzuki Poulose<suzuki@in.ibm.com>
>> Cc:	Sebastian Andrzej Siewior<bigeasy@linutronix.de>
>> ---
>>
>> arch/powerpc/Kconfig             |    2
>> arch/powerpc/include/asm/kexec.h |    2
>> arch/powerpc/kernel/misc_32.S    |  170 ++++++++++++++++++++++++++++++++++++++
>> 3 files changed, 172 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 423145a6..d04fae0 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -349,7 +349,7 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
>>
>> config KEXEC
>> 	bool "kexec system call (EXPERIMENTAL)"
>> -	depends on (PPC_BOOK3S || FSL_BOOKE)&&  EXPERIMENTAL
>> +	depends on (PPC_BOOK3S || FSL_BOOKE || (44x&&  !SMP&&  !47x))&&  EXPERIMENTAL
>
> Is there something special about 47x that its not supported?

At the moment, I have not written the code for doing the 47x TLB setup which
is slightly different from 44x.

It is in my TODO list. I don't have access to a 47x yet. I will work on it
once I get access to the board.

Thanks
Suzuki

>
>> 	help
>> 	  kexec is a system call that implements the ability to shutdown your
>> 	  current kernel, and to start another kernel.  It is like a reboot
>
> - k
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
