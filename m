Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlpM0-0005jA-Gb
 for kexec@lists.infradead.org; Thu, 28 Nov 2013 00:21:14 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id DDD2B3EE1DA
 for <kexec@lists.infradead.org>; Thu, 28 Nov 2013 09:20:45 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id D09D745DE55
 for <kexec@lists.infradead.org>; Thu, 28 Nov 2013 09:20:45 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.nic.fujitsu.com [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9DFE045DE53
 for <kexec@lists.infradead.org>; Thu, 28 Nov 2013 09:20:45 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 8E8601DB804C
 for <kexec@lists.infradead.org>; Thu, 28 Nov 2013 09:20:45 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 377AE1DB8049
 for <kexec@lists.infradead.org>; Thu, 28 Nov 2013 09:20:45 +0900 (JST)
Message-ID: <52968BCA.4040803@jp.fujitsu.com>
Date: Thu, 28 Nov 2013 09:18:18 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v7 1/2] x86, apic: Add disable_cpu_apicid kernel parameter
References: <20131127020006.1493.86091.stgit@localhost6.localdomain6>
 <20131127020048.1493.43123.stgit@localhost6.localdomain6>
 <20131127151017.GI18706@redhat.com>
In-Reply-To: <20131127151017.GI18706@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: fengguang.wu@intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, akpm@linux-foundation.org, hpa@linux.intel.com, jingbai.ma@hp.com

(2013/11/28 0:10), Vivek Goyal wrote:
> On Wed, Nov 27, 2013 at 11:00:48AM +0900, HATAYAMA Daisuke wrote:
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
>> boot_cpu_physical_apicid is designed to have the apicid returned by
>> read_apic_id(). However, on some platforms, it is temporarilly
>> modified by the apicid reported as BSP through MP table. This function
>> is called with the modified boot_cpu_physical_apicid.
>>
>> On the platforms, boot_cpu_physical_apicid is always forced to be the
>> apicid of the BSP. Then, disabled_cpu_apicid kernel parameter doesn't
>> work well for apicids for APs.
>>
>> Here we leave improvement of handling boot_cpu_physical_apicid as
>> another work for now since the temporary modification is done on
>> differnet platforms and tests on each platform are required. As a
>> workaround, we directly update boot_cpu_physical_apicid by
>> read_apic_id().
>>
>> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
>> ---
>>   arch/x86/kernel/apic/apic.c |   49 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>
>> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
>> index d278736..a94f618 100644
>> --- a/arch/x86/kernel/apic/apic.c
>> +++ b/arch/x86/kernel/apic/apic.c
>> @@ -75,6 +75,13 @@ unsigned int max_physical_apicid;
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
>> @@ -2111,9 +2118,42 @@ void disconnect_bsp_APIC(int virt_wire_setup)
>>   int generic_processor_info(int apicid, int version)
>>   {
>>   	int cpu, max = nr_cpu_ids;
>> +	/*
>> +	 * boot_cpu_physical_apicid is designed to have the apicid
>> +	 * returned by read_apic_id(). However, on some platforms, it
>> +	 * is temporarilly modified by the apicid reported as BSP
>> +	 * through MP table. Concretely:
>> +	 *
>> +	 * - arch/x86/kernel/mpparse.c: MP_processor_info()
>> +	 * - arch/x86/mm/amdtopology.c: amd_numa_init()
>> +	 * - arch/x86/platform/visws/visws_quirks.c: MP_processor_info()
>> +	 *
>> +	 * This function is executed with the modified
>> +	 * boot_cpu_physical_apicid. So, disabled_cpu_apicid kernel
>> +	 * parameter doesn't work.
>> +	 *
>> +	 * Since fixing handling of boot_cpu_physical_apicid requires
>> +	 * another discussion and tests on each platform, we leave it
>> +	 * for now and here we use read_apic_id() directly by updating
>> +	 * global scope of boot_cpu_physical_id with the local one.
>> +	 */
>> +	unsigned int boot_cpu_physical_apicid = read_apic_id();
>
> I think this is confusing. Why are you trying to define a local variable
> with same name as global variable. There is no need. I think if we
> simply put the comment there that why are we not making use of
> boot_cpu_physical_apicid, that is good enough and directly read
> the apic id.
>
> 	if (disabled_cpu_apicid != BAD_APICID &&
> 	    disabled_cpu_apicid != read_apic_id() &&
> 	    disabled_cpu_apicid == apicid) {
>
> 	}
>

Because there are also other occurrences of boot_cpu_physical_apicid in the
same function, and defining the local variable with the same name needs
one line only, and it's a temporary workaround change, I think it unnatural
to replace boot_cpu_physical_apicid even temporarily.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
