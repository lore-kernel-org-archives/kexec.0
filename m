Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqBP2-0004Bt-2U
 for kexec@lists.infradead.org; Tue, 30 Jun 2020 08:14:04 +0000
Subject: Re: [PATCH 04/11] ppc64/kexec_file: avoid stomping memory used by
 special regions
References: <159319825403.16351.7253978047621755765.stgit@hbathini.in.ibm.com>
 <159319831192.16351.17443438699302756548.stgit@hbathini.in.ibm.com>
 <9cfda789-0747-a67a-b825-5ea6f15099b8@redhat.com>
 <f745de42-297e-6eed-d25b-ea21d6000dc5@linux.ibm.com>
 <283fc181-2331-7c2f-db66-5e02e5ffb2e4@redhat.com>
 <cca6a693-a77f-885e-8ccc-967953f53800@linux.ibm.com>
From: piliu <piliu@redhat.com>
Message-ID: <aa6d91e7-b7c2-0e46-f446-a065d2db4b52@redhat.com>
Date: Tue, 30 Jun 2020 16:13:04 +0800
MIME-Version: 1.0
In-Reply-To: <cca6a693-a77f-885e-8ccc-967953f53800@linux.ibm.com>
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
To: Hari Bathini <hbathini@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>
Cc: Kexec-ml <kexec@lists.infradead.org>, Petr Tesarik <ptesarik@suse.cz>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Mimi Zohar <zohar@linux.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>



On 06/30/2020 02:10 PM, Hari Bathini wrote:
> 
> 
> On 30/06/20 9:00 am, piliu wrote:
>>
>>
>> On 06/29/2020 01:55 PM, Hari Bathini wrote:
>>>
>>>
>>> On 28/06/20 7:44 am, piliu wrote:
>>>> Hi Hari,
>>>
>>> Hi Pingfan,
>>>
>>>>
>>>> After a quick through for this series, I have a few question/comment on
>>>> this patch for the time being. Pls see comment inline.
>>>>
>>>> On 06/27/2020 03:05 AM, Hari Bathini wrote:
>>>>> crashkernel region could have an overlap with special memory regions
>>>>> like  opal, rtas, tce-table & such. These regions are referred to as
>>>>> exclude memory ranges. Setup this ranges during image probe in order
>>>>> to avoid them while finding the buffer for different kdump segments.
>>>
>>> [...]
>>>
>>>>> +	/*
>>>>> +	 * Use the locate_mem_hole logic in kexec_add_buffer() for regular
>>>>> +	 * kexec_file_load syscall
>>>>> +	 */
>>>>> +	if (kbuf->image->type != KEXEC_TYPE_CRASH)
>>>>> +		return 0;
>>>> Can the ranges overlap [crashk_res.start, crashk_res.end]?  Otherwise
>>>> there is no requirement for @exclude_ranges.
>>>
>>> The ranges like rtas, opal are loaded by f/w. They almost always overlap with
>>> crashkernel region. So, @exclude_ranges is required to support kdump.
>> f/w passes rtas/opal as service, then must f/w mark these ranges as
>> fdt_reserved_mem in order to make kernel aware not to use these ranges?
> 
> It does. Actually, reserve_map + reserved-ranges are reserved as soon as
> memblock allocator is ready but not before crashkernel reservation.
> Check early_reserve_mem() call in kernel/prom.c
> 
>> Otherwise kernel memory allocation besides kdump can also overwrite
>> these ranges.> 
>> Hmm, revisiting reserve_crashkernel(). It seems not to take any reserved
>> memory into consider except kernel text. Could it work based on memblock
>> allocator?
> 
> So, kdump could possibly overwrite these regions which is why an exclude
> range list is needed. Same thing was done in kexec-tools as well.
OK, got it.

Thanks,
Pingfan
> 
> Thanks
> Hari
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
