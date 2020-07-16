Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwC1R-0001vG-Gw
 for kexec@lists.infradead.org; Thu, 16 Jul 2020 22:06:34 +0000
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com>
 <159466096898.24747.16701009925943468066.stgit@hbathini.in.ibm.com>
 <87y2nk8cjq.fsf@morokweng.localdomain>
 <bea19627-c6b7-5d59-e194-03038bb4d9f6@linux.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 09/12] ppc64/kexec_file: setup backup region for kdump
 kernel
In-reply-to: <bea19627-c6b7-5d59-e194-03038bb4d9f6@linux.ibm.com>
Date: Thu, 16 Jul 2020 19:06:20 -0300
Message-ID: <874kq7cdyb.fsf@morokweng.localdomain>
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
Cc: kernel test robot <lkp@intel.com>, Pingfan Liu <piliu@redhat.com>, Petr Tesarik <ptesarik@suse.cz>, Nayna Jain <nayna@linux.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>


Hari Bathini <hbathini@linux.ibm.com> writes:

> On 16/07/20 7:08 am, Thiago Jung Bauermann wrote:
>>
>> Hari Bathini <hbathini@linux.ibm.com> writes:
>>
>>> @@ -968,7 +1040,7 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
>>>
>>>  	/*
>>>  	 * Restrict memory usage for kdump kernel by setting up
>>> -	 * usable memory ranges.
>>> +	 * usable memory ranges and memory reserve map.
>>>  	 */
>>>  	if (image->type == KEXEC_TYPE_CRASH) {
>>>  		ret = get_usable_memory_ranges(&umem);
>>> @@ -980,6 +1052,24 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
>>>  			pr_err("Error setting up usable-memory property for kdump kernel\n");
>>>  			goto out;
>>>  		}
>>> +
>>> +		ret = fdt_add_mem_rsv(fdt, BACKUP_SRC_START + BACKUP_SRC_SIZE,
>>> +				      crashk_res.start - BACKUP_SRC_SIZE);
>>
>> I believe this answers my question from the other email about how the
>> crashkernel is prevented from stomping in the crashed kernel's memory,
>> right? I needed to think for a bit to understand what the above
>> reservation was protecting. I think it's worth adding a comment.
>
> Right. The reason to add it in the first place is, prom presses the panic button if
> it can't find low memory. Marking it reserved seems to keep it quiet though. so..
>
> Will add comment mentioning that..

Ah, makes sense. Thanks for the explanation.

>>> +void purgatory(void)
>>> +{
>>> +	void *dest, *src;
>>> +
>>> +	src = (void *)BACKUP_SRC_START;
>>> +	if (backup_start) {
>>> +		dest = (void *)backup_start;
>>> +		__memcpy(dest, src, BACKUP_SRC_SIZE);
>>> +	}
>>> +}
>>
>> In general I'm in favor of using C code over assembly, but having to
>> bring in that relocation support just for the above makes me wonder if
>> it's worth it in this case.
>
> I am planning to build on purgatory later with "I'm in purgatory" print support
> for pseries at least and also, sha256 digest check.

Ok. In that case, my preference would be to convert both the powerpc and
x86 purgatories to PIE since this greatly reduces the types of
relocations that are emitted, but better ask Dave Young what he thinks
before going down that route.

--
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
