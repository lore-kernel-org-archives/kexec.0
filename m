Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwBv8-0000Mv-Pl
 for kexec@lists.infradead.org; Thu, 16 Jul 2020 22:00:03 +0000
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com>
 <159466088775.24747.1248185448154277951.stgit@hbathini.in.ibm.com>
 <87365t8pse.fsf@morokweng.localdomain>
 <0582476e-415e-3f60-2bb2-6199d0340156@linux.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 04/12] ppc64/kexec_file: avoid stomping memory used by
 special regions
In-reply-to: <0582476e-415e-3f60-2bb2-6199d0340156@linux.ibm.com>
Date: Thu, 16 Jul 2020 18:59:49 -0300
Message-ID: <878sfjce96.fsf@morokweng.localdomain>
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

> On 15/07/20 8:09 am, Thiago Jung Bauermann wrote:
>> 
>> Hari Bathini <hbathini@linux.ibm.com> writes:
>> 
>
> <snip>
>  
>>> +/**
>>> + * __locate_mem_hole_top_down - Looks top down for a large enough memory hole
>>> + *                              in the memory regions between buf_min & buf_max
>>> + *                              for the buffer. If found, sets kbuf->mem.
>>> + * @kbuf:                       Buffer contents and memory parameters.
>>> + * @buf_min:                    Minimum address for the buffer.
>>> + * @buf_max:                    Maximum address for the buffer.
>>> + *
>>> + * Returns 0 on success, negative errno on error.
>>> + */
>>> +static int __locate_mem_hole_top_down(struct kexec_buf *kbuf,
>>> +				      u64 buf_min, u64 buf_max)
>>> +{
>>> +	int ret = -EADDRNOTAVAIL;
>>> +	phys_addr_t start, end;
>>> +	u64 i;
>>> +
>>> +	for_each_mem_range_rev(i, &memblock.memory, NULL, NUMA_NO_NODE,
>>> +			       MEMBLOCK_NONE, &start, &end, NULL) {
>>> +		if (start > buf_max)
>>> +			continue;
>>> +
>>> +		/* Memory hole not found */
>>> +		if (end < buf_min)
>>> +			break;
>>> +
>>> +		/* Adjust memory region based on the given range */
>>> +		if (start < buf_min)
>>> +			start = buf_min;
>>> +		if (end > buf_max)
>>> +			end = buf_max;
>>> +
>>> +		start = ALIGN(start, kbuf->buf_align);
>>> +		if (start < end && (end - start + 1) >= kbuf->memsz) {
>> 
>> This is why I dislike using start and end to express address ranges:
>> 
>> While struct resource seems to use the [address, end] convention, my
>
> struct crash_mem also uses [address, end] convention.
> This off-by-one error did not cause any issues as the hole start and size we try to find
> are at least page aligned.
>
> Nonetheless, I think fixing 'end' early in the loop with "end -= 1" would ensure
> correctness while continuing to use the same convention for structs crash_mem & resource.

Sounds good.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
