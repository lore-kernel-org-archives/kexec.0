Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwBsb-0008Tl-59
 for kexec@lists.infradead.org; Thu, 16 Jul 2020 21:57:26 +0000
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com>
 <159466098739.24747.5860501703617893464.stgit@hbathini.in.ibm.com>
 <87tuy88ai7.fsf@morokweng.localdomain>
 <929db6fe-b221-a514-8ea1-93227f8d47b0@linux.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 10/12] ppc64/kexec_file: prepare elfcore header for
 crashing kernel
In-reply-to: <929db6fe-b221-a514-8ea1-93227f8d47b0@linux.ibm.com>
Date: Thu, 16 Jul 2020 18:57:15 -0300
Message-ID: <87a6zzcedg.fsf@morokweng.localdomain>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Pingfan Liu <piliu@redhat.com>, Petr Tesarik <ptesarik@suse.cz>, Nayna Jain <nayna@linux.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>


Hari Bathini <hbathini@linux.ibm.com> writes:

> On 16/07/20 7:52 am, Thiago Jung Bauermann wrote:
>> 
>> Hari Bathini <hbathini@linux.ibm.com> writes:
>> 
>>>  /**
>>> + * get_crash_memory_ranges - Get crash memory ranges. This list includes
>>> + *                           first/crashing kernel's memory regions that
>>> + *                           would be exported via an elfcore.
>>> + * @mem_ranges:              Range list to add the memory ranges to.
>>> + *
>>> + * Returns 0 on success, negative errno on error.
>>> + */
>>> +static int get_crash_memory_ranges(struct crash_mem **mem_ranges)
>>> +{
>>> +	struct memblock_region *reg;
>>> +	struct crash_mem *tmem;
>>> +	int ret;
>>> +
>>> +	for_each_memblock(memory, reg) {
>>> +		u64 base, size;
>>> +
>>> +		base = (u64)reg->base;
>>> +		size = (u64)reg->size;
>>> +
>>> +		/* Skip backup memory region, which needs a separate entry */
>>> +		if (base == BACKUP_SRC_START) {
>>> +			if (size > BACKUP_SRC_SIZE) {
>>> +				base = BACKUP_SRC_END + 1;
>>> +				size -= BACKUP_SRC_SIZE;
>>> +			} else
>>> +				continue;
>>> +		}
>>> +
>>> +		ret = add_mem_range(mem_ranges, base, size);
>>> +		if (ret)
>>> +			goto out;
>>> +
>>> +		/* Try merging adjacent ranges before reallocation attempt */
>>> +		if ((*mem_ranges)->nr_ranges == (*mem_ranges)->max_nr_ranges)
>>> +			sort_memory_ranges(*mem_ranges, true);
>>> +	}
>>> +
>>> +	/* Reallocate memory ranges if there is no space to split ranges */
>>> +	tmem = *mem_ranges;
>>> +	if (tmem && (tmem->nr_ranges == tmem->max_nr_ranges)) {
>>> +		tmem = realloc_mem_ranges(mem_ranges);
>>> +		if (!tmem)
>>> +			goto out;
>>> +	}
>>> +
>>> +	/* Exclude crashkernel region */
>>> +	ret = crash_exclude_mem_range(tmem, crashk_res.start, crashk_res.end);
>>> +	if (ret)
>>> +		goto out;
>>> +
>>> +	ret = add_rtas_mem_range(mem_ranges);
>>> +	if (ret)
>>> +		goto out;
>>> +
>>> +	ret = add_opal_mem_range(mem_ranges);
>>> +	if (ret)
>>> +		goto out;
>> 
>> Maybe I'm confused, but don't you add the RTAS and OPAL regions as
>> usable memory for the crashkernel? In that case they shouldn't show up
>> in the core file.
>
> kexec-tools does the same thing. I am not endorsing it but I was trying to stay
> in parity to avoid breaking any userspace tools/commands. But as you rightly
> pointed, this is NOT right. The right thing to do, to get the rtas/opal data at
> the time of crash, is to have a backup region for them just like we have for
> the first 64K memory. I was hoping to do that later.
>
> Will check how userspace tools respond to dropping these regions. If that makes
> the tools unhappy, will retain the regions with a FIXME. Sorry about the confusion.

No problem, thanks for the clarification.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
