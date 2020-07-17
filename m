Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwWWw-0004Kr-Nk
 for kexec@lists.infradead.org; Fri, 17 Jul 2020 20:00:27 +0000
Subject: Re: [PATCH v3 03/12] powerpc/kexec_file: add helper functions for
 getting memory ranges
From: Hari Bathini <hbathini@linux.ibm.com>
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com>
 <159466087136.24747.16494497863685481495.stgit@hbathini.in.ibm.com>
 <874kq98xo4.fsf@morokweng.localdomain>
 <0684ed3d-0dde-8dce-f12c-72ef86bc91f9@linux.ibm.com>
Message-ID: <1b09c0e4-54c9-7dd6-4402-81c9d1ba3ee0@linux.ibm.com>
Date: Sat, 18 Jul 2020 01:30:13 +0530
MIME-Version: 1.0
In-Reply-To: <0684ed3d-0dde-8dce-f12c-72ef86bc91f9@linux.ibm.com>
Content-Language: en-US
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: Pingfan Liu <piliu@redhat.com>, Petr Tesarik <ptesarik@suse.cz>, Nayna Jain <nayna@linux.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>



On 17/07/20 10:02 am, Hari Bathini wrote:
> 
> 
> On 15/07/20 5:19 am, Thiago Jung Bauermann wrote:
>>
>> Hello Hari,
>>
>> Hari Bathini <hbathini@linux.ibm.com> writes:
>>
>>> In kexec case, the kernel to be loaded uses the same memory layout as
>>> the running kernel. So, passing on the DT of the running kernel would
>>> be good enough.
>>>
>>> But in case of kdump, different memory ranges are needed to manage
>>> loading the kdump kernel, booting into it and exporting the elfcore
>>> of the crashing kernel. The ranges are exlude memory ranges, usable
>>
>> s/exlude/exclude/
>>
>>> memory ranges, reserved memory ranges and crash memory ranges.
>>>
>>> Exclude memory ranges specify the list of memory ranges to avoid while
>>> loading kdump segments. Usable memory ranges list the memory ranges
>>> that could be used for booting kdump kernel. Reserved memory ranges
>>> list the memory regions for the loading kernel's reserve map. Crash
>>> memory ranges list the memory ranges to be exported as the crashing
>>> kernel's elfcore.
>>>
>>> Add helper functions for setting up the above mentioned memory ranges.
>>> This helpers facilitate in understanding the subsequent changes better
>>> and make it easy to setup the different memory ranges listed above, as
>>> and when appropriate.
>>>
>>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>>> Tested-by: Pingfan Liu <piliu@redhat.com>
>>
> 
> <snip>
> 
>>> +/**
>>> + * add_reserved_ranges - Adds "/reserved-ranges" regions exported by f/w
>>> + *                       to the given memory ranges list.
>>> + * @mem_ranges:          Range list to add the memory ranges to.
>>> + *
>>> + * Returns 0 on success, negative errno on error.
>>> + */
>>> +int add_reserved_ranges(struct crash_mem **mem_ranges)
>>> +{
>>> +	int i, len, ret = 0;
>>> +	const __be32 *prop;
>>> +
>>> +	prop = of_get_property(of_root, "reserved-ranges", &len);
>>> +	if (!prop)
>>> +		return 0;
>>> +
>>> +	/*
>>> +	 * Each reserved range is an (address,size) pair, 2 cells each,
>>> +	 * totalling 4 cells per range.
>>
>> Can you assume that, or do you need to check the #address-cells and
>> #size-cells properties of the root node?
> 
> Taken from early_reserve_mem_dt() which did not seem to care.
> Should we be doing any different here?

On second thoughts, wouldn't hurt to be extra cautious. Will use
#address-cells & #size-cells to parse reserved-ranges.

Thanks
Hari

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
