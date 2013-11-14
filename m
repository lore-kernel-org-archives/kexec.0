Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VguOO-0004DG-Hc
 for kexec@lists.infradead.org; Thu, 14 Nov 2013 10:43:21 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id C90B93EE0C1
 for <kexec@lists.infradead.org>; Thu, 14 Nov 2013 19:42:58 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id ADE9045DE63
 for <kexec@lists.infradead.org>; Thu, 14 Nov 2013 19:42:58 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.nic.fujitsu.com [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 7D4EB45DE54
 for <kexec@lists.infradead.org>; Thu, 14 Nov 2013 19:42:58 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 6E6691DB804D
 for <kexec@lists.infradead.org>; Thu, 14 Nov 2013 19:42:58 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1C4D51DB8046
 for <kexec@lists.infradead.org>; Thu, 14 Nov 2013 19:42:58 +0900 (JST)
Message-ID: <5284A920.8090404@jp.fujitsu.com>
Date: Thu, 14 Nov 2013 19:42:40 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v5 2/3] x86, apic: Add disable_cpu_apicid kernel parameter
References: <20131112094952.4902.72689.stgit@localhost6.localdomain6>
 <20131112095158.4902.75396.stgit@localhost6.localdomain6>
 <20131112104423.GB12849@pd.tnic>
In-Reply-To: <20131112104423.GB12849@pd.tnic>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Borislav Petkov <bp@alien8.de>
Cc: fengguang.wu@intel.com, jingbai.ma@hp.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, akpm@linux-foundation.org, hpa@linux.intel.com, vgoyal@redhat.com

(2013/11/12 19:44), Borislav Petkov wrote:
> On Tue, Nov 12, 2013 at 06:51:58PM +0900, HATAYAMA Daisuke wrote:
>> Add disable_cpu_apicid kernel parameter. To use this kernel parameter,
>> specify an initial APIC ID of the corresponding CPU you want to
>> disable.
>>
>> This is mostly used for the kdump 2nd kernel to disable BSP to wake up
>> multiple CPUs without causing system reset or hang due to sending INIT
>> from AP to BSP.
>>
>> Kdump users first figure out initial APIC ID of the BSP, CPU0 in the
>> 1st kernel, for example from /proc/cpuinfo and then set up this kernel
>> parameter for the 2nd kernel using the obtained APIC ID.
>>
>> However, doing this procedure at each boot time manually is awkward,
>> which should be automatically done by user-land service scripts, for
>> example, kexec-tools on fedora/RHEL distributions.
>>
>> This design is more flexible than disabling BSP in kernel boot time
>> automatically in that in kernel boot time we have no choice but
>> referring to ACPI/MP table to obtain initial APIC ID for BSP, meaning
>> that the method is not applicable to the systems without such BIOS
>> tables.
>>
>> One assumption behind this design is that users get initial APIC ID of
>> the BSP in still healthy state and so BSP is uniquely kept in
>> CPU0. Thus, through the kernel parameter, only one initial APIC ID can
>> be specified.
>>
>> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
>> ---
>>   arch/x86/kernel/apic/apic.c |   29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
>> index b60ad92..075bf23 100644
>> --- a/arch/x86/kernel/apic/apic.c
>> +++ b/arch/x86/kernel/apic/apic.c
>> @@ -78,6 +78,13 @@ unsigned int max_physical_apicid;
>>   physid_mask_t phys_cpu_present_map;
>>
>>   /*
>> + * Processor to be disabled specified by kernel parameter
>> + * disable_cpu_apicid=<int>, mostly used for the kdump 2nd kernel to
>> + * avoid undefined behaviour caused by sending INIT from AP to BSP.
>> + */
>> +unsigned int disabled_cpu_apicid = BAD_APICID;
>> +
>> +/*
>>    * Map cpu index to physical APIC ID
>>    */
>>   DEFINE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid, BAD_APICID);
>> @@ -2117,6 +2124,19 @@ void generic_processor_info(int apicid, int version)
>>   	bool boot_cpu_detected = physid_isset(boot_cpu_physical_apicid,
>>   				phys_cpu_present_map);
>>
>> +	if (disabled_cpu_apicid != BAD_APICID &&
>> +	    disabled_cpu_apicid != boot_cpu_physical_apicid &&
>> +	    disabled_cpu_apicid == apicid) {
>> +		int thiscpu = num_processors + disabled_cpus;
>> +
>> +		pr_warning("ACPI: Disable specified CPU."
>> +			   " Processor %d/0x%x ignored.\n",
>> +			   thiscpu, apicid);
>
> How am I to parse this message - that 'thiscpu' is being disabled
> currently? What does "Processor ... ignored" mean?
>
> Why not just write:
>
> 	ACPI: Disabling requested CPU %d (APIC ID: 0x%x)
>
> and everyone knows what's happening?
>

It seems "Disabling requested CPU %d" part is by far better than mine.
I'll apply this in the next patch.

For the latter part "(APIC ID: 0x%x)", there are other two messages about
disabling processors and I tried to use a message consistent with these.
So, I think "Processor %d/0x%x ignored.\n" should be used.

         /*
          * If boot cpu has not been detected yet, then only allow upto
          * nr_cpu_ids - 1 processors and keep one slot free for boot cpu
          */
         if (!boot_cpu_detected && num_processors >= nr_cpu_ids - 1 &&
             apicid != boot_cpu_physical_apicid) {
                 int thiscpu = max + disabled_cpus - 1;

                 pr_warning(
                         "ACPI: NR_CPUS/possible_cpus limit of %i almost"
                         " reached. Keeping one slot for boot cpu."
                         "  Processor %d/0x%x ignored.\n", max, thiscpu, apicid);

                 disabled_cpus++;
                 return;
         }

         if (num_processors >= nr_cpu_ids) {
                 int thiscpu = max + disabled_cpus;

                 pr_warning(
                         "ACPI: NR_CPUS/possible_cpus limit of %i reached."
                         "  Processor %d/0x%x ignored.\n", max, thiscpu, apicid);

                 disabled_cpus++;
                 return;
         }

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
