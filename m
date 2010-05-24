Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gate.crashing.org ([63.228.1.57])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1OGdL8-000361-8v
	for kexec@lists.infradead.org; Mon, 24 May 2010 19:29:31 +0000
Subject: Re: [PATCH 2/2] powerpc, kdump: Fix race in kdump shutdown
Mime-Version: 1.0 (Apple Message framework v1078)
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <E722EF44-A08B-41E1-8ECA-D5BE46009128@kernel.crashing.org>
Date: Mon, 24 May 2010 14:29:24 -0500
Message-Id: <04AC722A-97CD-4451-B6AB-F4AC37EFAB1D@kernel.crashing.org>
References: <20100514054011.5E585D34AB@localhost.localdomain>
	<E722EF44-A08B-41E1-8ECA-D5BE46009128@kernel.crashing.org>
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
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>, kexec@lists.infradead.org, jlarrew@linux.vnet.ibm.com, Anton Blanchard <anton@samba.org>


On May 24, 2010, at 2:23 PM, Kumar Gala wrote:

> 
> On May 14, 2010, at 12:40 AM, Michael Neuling wrote:
> 
>> When we are crashing, the crashing/primary CPU IPIs the secondaries to
>> turn off IRQs, go into real mode and wait in kexec_wait.  While this
>> is happening, the primary tears down all the MMU maps.  Unfortunately
>> the primary doesn't check to make sure the secondaries have entered
>> real mode before doing this.
>> 
>> On PHYP machines, the secondaries can take a long time shutting down
>> the IRQ controller as RTAS calls are need.  These RTAS calls need to
>> be serialised which resilts in the secondaries contending in
>> lock_rtas() and hence taking a long time to shut down.
>> 
>> We've hit this on large POWER7 machines, where some secondaries are
>> still waiting in lock_rtas(), when the primary tears down the HPTEs.
>> 
>> This patch makes sure all secondaries are in real mode before the
>> primary tears down the MMU.  It uses the new kexec_state entry in the
>> paca.  It times out if the secondaries don't reach real mode after
>> 10sec.
>> 
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> ---
>> 
>> arch/powerpc/kernel/crash.c |   27 +++++++++++++++++++++++++++
>> 1 file changed, 27 insertions(+)
>> 
>> Index: linux-2.6-ozlabs/arch/powerpc/kernel/crash.c
>> ===================================================================
>> --- linux-2.6-ozlabs.orig/arch/powerpc/kernel/crash.c
>> +++ linux-2.6-ozlabs/arch/powerpc/kernel/crash.c
>> @@ -162,6 +162,32 @@ static void crash_kexec_prepare_cpus(int
>> 	/* Leave the IPI callback set */
>> }
>> 
>> +/* wait for all the CPUs to hit real mode but timeout if they don't come in */
>> +static void crash_kexec_wait_realmode(int cpu)
>> +{
>> +	unsigned int msecs;
>> +	int i;
>> +
>> +	msecs = 10000;
>> +	for (i=0; i < NR_CPUS && msecs > 0; i++) {
>> +		if (i == cpu)
>> +			continue;
>> +
>> +		while (paca[i].kexec_state < KEXEC_STATE_REAL_MODE) {
>> +			barrier();
>> +			if (!cpu_possible(i)) {
>> +				break;
>> +			}
>> +			if (!cpu_online(i)) {
>> +				break;
>> +			}
>> +			msecs--;
>> +			mdelay(1);
>> +		}
>> +	}
>> +	mb();
>> +}
>> +
>> /*
>> * This function will be called by secondary cpus or by kexec cpu
>> * if soft-reset is activated to stop some CPUs.
>> @@ -412,6 +438,7 @@ void default_machine_crash_shutdown(stru
>> 	crash_kexec_prepare_cpus(crashing_cpu);
>> 	cpu_set(crashing_cpu, cpus_in_crash);
>> 	crash_kexec_stop_spus();
> 
> should this be
> 
> #ifdef CONFIG_PPC_STD_MMU
> 
>> +	crash_kexec_wait_realmode(crashing_cpu);
> 
> #endif

I'm going to make it CONFIG_PPC_STD_MMU_64 as part of a Kexec book-e patch

- k
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
