Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqcFR-0008Az-8q
 for kexec@lists.infradead.org; Wed, 01 Jul 2020 12:53:58 +0000
Subject: Re: [PATCH 04/11] ppc64/kexec_file: avoid stomping memory used by
 special regions
References: <159319825403.16351.7253978047621755765.stgit@hbathini.in.ibm.com>
 <159319831192.16351.17443438699302756548.stgit@hbathini.in.ibm.com>
 <20200701074012.GA4496@dhcp-128-65.nay.redhat.com>
From: piliu <piliu@redhat.com>
Message-ID: <bc8fe308-5ce9-1ca6-c832-7c3a75a732d2@redhat.com>
Date: Wed, 1 Jul 2020 20:53:35 +0800
MIME-Version: 1.0
In-Reply-To: <20200701074012.GA4496@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, Petr Tesarik <ptesarik@suse.cz>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Eric Biederman <ebiederm@xmission.com>



On 07/01/2020 03:40 PM, Dave Young wrote:
> Hi Hari,
> On 06/27/20 at 12:35am, Hari Bathini wrote:
>> crashkernel region could have an overlap with special memory regions
>> like  opal, rtas, tce-table & such. These regions are referred to as
>> exclude memory ranges. Setup this ranges during image probe in order
>> to avoid them while finding the buffer for different kdump segments.
>> Implement kexec_locate_mem_hole_ppc64() that locates a memory hole
>> accounting for these ranges. Also, override arch_kexec_add_buffer()
>> to locate a memory hole & later call __kexec_add_buffer() function
>> with kbuf->mem set to skip the generic locate memory hole lookup.
>>
>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>> ---
>>  arch/powerpc/include/asm/crashdump-ppc64.h |   10 +
>>  arch/powerpc/include/asm/kexec.h           |    7 -
>>  arch/powerpc/kexec/elf_64.c                |    7 +
>>  arch/powerpc/kexec/file_load_64.c          |  292 ++++++++++++++++++++++++++++
>>  4 files changed, 312 insertions(+), 4 deletions(-)
>>  create mode 100644 arch/powerpc/include/asm/crashdump-ppc64.h
>>
> [snip]
>>  /**
>> + * get_exclude_memory_ranges - Get exclude memory ranges. This list includes
>> + *                             regions like opal/rtas, tce-table, initrd,
>> + *                             kernel, htab which should be avoided while
>> + *                             setting up kexec load segments.
>> + * @mem_ranges:                Range list to add the memory ranges to.
>> + *
>> + * Returns 0 on success, negative errno on error.
>> + */
>> +static int get_exclude_memory_ranges(struct crash_mem **mem_ranges)
>> +{
>> +	int ret;
>> +
>> +	ret = add_tce_mem_ranges(mem_ranges);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret = add_initrd_mem_range(mem_ranges);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret = add_htab_mem_range(mem_ranges);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret = add_kernel_mem_range(mem_ranges);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret = add_rtas_mem_range(mem_ranges, false);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret = add_opal_mem_range(mem_ranges, false);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret = add_reserved_ranges(mem_ranges);
>> +	if (ret)
>> +		goto out;
>> +
>> +	/* exclude memory ranges should be sorted for easy lookup */
>> +	sort_memory_ranges(*mem_ranges);
>> +out:
>> +	if (ret)
>> +		pr_err("Failed to setup exclude memory ranges\n");
>> +	return ret;
>> +}
> 
> I'm confused about the "overlap with crashkernel memory", does that mean
> those normal kernel used memory could be put in crashkernel reserved
> memory range?  If so why can't just skip those areas while crashkernel
> doing the reservation?
I raised the same question in another mail. As Hari's answer, "kexec -p"
skips these ranges in user space. And the same logic should be done in
"kexec -s -p"

Regards,
Pingfan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
