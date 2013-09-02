Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VGJzY-0004aT-Ku
 for kexec@lists.infradead.org; Mon, 02 Sep 2013 02:35:50 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id A480B3EE10C
 for <kexec@lists.infradead.org>; Mon,  2 Sep 2013 11:35:19 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9341D45DE60
 for <kexec@lists.infradead.org>; Mon,  2 Sep 2013 11:35:19 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 6C26A45DE55
 for <kexec@lists.infradead.org>; Mon,  2 Sep 2013 11:35:19 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5272B1DB803A
 for <kexec@lists.infradead.org>; Mon,  2 Sep 2013 11:35:19 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id E9373E08002
 for <kexec@lists.infradead.org>; Mon,  2 Sep 2013 11:35:18 +0900 (JST)
Message-ID: <5223F8DB.3040506@jp.fujitsu.com>
Date: Mon, 02 Sep 2013 11:32:59 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] x86, apic: Disable BSP if boot cpu is AP
References: <20130829092458.5476.10277.stgit@localhost6.localdomain6>
 <20130829092804.5476.95588.stgit@localhost6.localdomain6>
 <20130831052252.GC12617@x1.alien8.de>
In-Reply-To: <20130831052252.GC12617@x1.alien8.de>
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
Cc: jingbai.ma@hp.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, akpm@linux-foundation.org, hpa@linux.intel.com, vgoyal@redhat.com

(2013/08/31 14:22), Borislav Petkov wrote:
> On Thu, Aug 29, 2013 at 06:28:04PM +0900, HATAYAMA Daisuke wrote:
>> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
>> index 66cab35..fd969d1 100644
>> --- a/arch/x86/kernel/apic/apic.c
>> +++ b/arch/x86/kernel/apic/apic.c
>> @@ -2113,13 +2113,29 @@ void disconnect_bsp_APIC(int virt_wire_setup)
>>   	apic_write(APIC_LVT1, value);
>>   }
>>
>> -void generic_processor_info(int apicid, int version)
>> +void generic_processor_info(int apicid, bool isbsp, int version)
>>   {
>>   	int cpu, max = nr_cpu_ids;
>>   	bool boot_cpu_detected = physid_isset(boot_cpu_physical_apicid,
>>   				phys_cpu_present_map);
>>
>>   	/*
>> +	 * If boot cpu is AP, we now don't have any way to initialize
>> +	 * BSP. To save memory consumed, we disable BSP this case and
>
> I don't think we disable the BSP just so that we save memory and rather
> because we hang in the kdump kernel otherwise, right?
>

Thanks for your reviewing.

Yes, primary reason of disabling BSP is to avoid hang/reset in the kdump
2nd kernel. Saving memory is the secondary merit compared with
the user-space workaround by specifying nr_cpus=1 or maxcpus=1 and
waking up APs later except for the BSP. I will not write this in the
next version.

>> +	 * use (N-1)-cpus.
>> +	 */
>> +	if (isbsp && !boot_cpu_is_bsp) {
>
> This variable naming looks confusing, IMHO. It would probably be more
> understandable if 'isbsp' was called 'boot_cpu' to denote that this is
> the CPU we're booting on currently. The comment above it then explains
> that it is an AP and it might also refer to the issue why we're doing
> that.
>

As you suggest, boot_cpu seems more understandable also to me. BTW, please
notice that it doesn't denote that the CPU we're booting on currently,
but that the CPU with BSP flag set.

In general, current code uses many terms to denote the cpu that is run
at kernel boot-up processing such as boot cpu, bsp, cpu0 and possibly others
since in usual situation, boot cpu is always BSP and assigned to cpu0.
But it is not the case in case of kexec. I'm using the word bsp purposely
in the isbsp to mean the CPU with BSP flag set.

So I think it's better to use bsp_cpu here to denote the CPU with BSP flag set.

For the comment, how about the following one?

         /*
          * In this case, boot cpu is AP. This can happen on
          * kexec/kdump. Consider the case that crash happens on some
          * AP and enters kdump 2nd kernel with the AP.
          *
          * Then, there's issue that if we send INIT to BSP, due to x86
          * hardware specification, it is forced to jump at BIOS init
          * code and system hangs or resets immediately.
          *
          * To avoid the issue, we disable BSP. Then, there's no longer
          * possbility to send INIT to BSP.
          */

>> +		int thiscpu = num_processors + disabled_cpus;
>> +
>> +		pr_warning("ACPI: The boot cpu is not BSP. "
>> +			   "The BSP Processor %d/0x%x ignored.\n",
>> +			   thiscpu, apicid);
>
> Visible comment, so needs a bit of correcting:
>
> 	"ACPI: We're not booting on the BSP; BSP %d/0x%x ignored."
>

Yes, I'll use this message in the next patch.

>> +
>> +		disabled_cpus++;
>> +		return;
>> +	}
>> +
>> +	/*
>>   	 * If boot cpu has not been detected yet, then only allow upto
>>   	 * nr_cpu_ids - 1 processors and keep one slot free for boot cpu
>>   	 */
>
> Thanks.
>


-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
