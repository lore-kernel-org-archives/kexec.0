Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Ny7T7-0006CA-FC
	for kexec@lists.infradead.org; Sat, 03 Apr 2010 17:49:14 +0000
Subject: Re: [PATCH 3/4] Revert "x86: disable IOMMUs on kernel crash"
References: <20100403012751.834020949@sous-sol.org>
	<20100403012820.229410717@sous-sol.org>
	<20100403174128.GQ24846@8bytes.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 03 Apr 2010 10:49:09 -0700
In-Reply-To: <20100403174128.GQ24846@8bytes.org> (Joerg Roedel's message of
	"Sat\, 3 Apr 2010 19\:41\:28 +0200")
Message-ID: <m1vdc8juju.fsf@fess.ebiederm.org>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Joerg Roedel <joro@8bytes.org>
Cc: nhorman@redhat.com, nhorman@tuxdriver.com, Joerg Roedel <joerg.roedel@amd.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, vgoyal@redhat.com

Joerg Roedel <joro@8bytes.org> writes:

> On Fri, Apr 02, 2010 at 06:27:54PM -0700, Chris Wright wrote:
>> This effectively reverts commit 61d047be99757fd9b0af900d7abce9a13a337488.
>> 
>> Disabling the IOMMU can potetially allow DMA transactions to
>> complete without being translated.  Leave it enabled, and allow
>> crash kernel to do the IOMMU reinitialization properly.
>> 
>> Cc: Joerg Roedel <joerg.roedel@amd.com>
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Neil Horman <nhorman@tuxdriver.com>
>> Cc: Vivek Goyal <vgoyal@redhat.com>
>> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
>> ---
>>  arch/x86/kernel/crash.c |    6 ------
>>  1 file changed, 6 deletions(-)
>> 
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -27,7 +27,6 @@
>>  #include <asm/cpu.h>
>>  #include <asm/reboot.h>
>>  #include <asm/virtext.h>
>> -#include <asm/x86_init.h>
>>  
>>  #if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
>>  
>> @@ -103,10 +102,5 @@ void native_machine_crash_shutdown(struc
>>  #ifdef CONFIG_HPET_TIMER
>>  	hpet_disable();
>>  #endif
>> -
>> -#ifdef CONFIG_X86_64
>> -	x86_platform.iommu_shutdown();
>> -#endif
>> -
>>  	crash_save_cpu(regs, safe_smp_processor_id());
>
> Another problem: This also breaks if the kdump kernel has no
> iommu-support.

Not a problem.  We require a lot of things of the kdump kernel,
and it is immediately apparent in a basic sanity test.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
