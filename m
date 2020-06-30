Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jq6ys-0007Vz-P9
 for kexec@lists.infradead.org; Tue, 30 Jun 2020 03:30:47 +0000
Subject: Re: [PATCH 04/11] ppc64/kexec_file: avoid stomping memory used by
 special regions
References: <159319825403.16351.7253978047621755765.stgit@hbathini.in.ibm.com>
 <159319831192.16351.17443438699302756548.stgit@hbathini.in.ibm.com>
 <9cfda789-0747-a67a-b825-5ea6f15099b8@redhat.com>
 <f745de42-297e-6eed-d25b-ea21d6000dc5@linux.ibm.com>
From: piliu <piliu@redhat.com>
Message-ID: <283fc181-2331-7c2f-db66-5e02e5ffb2e4@redhat.com>
Date: Tue, 30 Jun 2020 11:30:26 +0800
MIME-Version: 1.0
In-Reply-To: <f745de42-297e-6eed-d25b-ea21d6000dc5@linux.ibm.com>
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



On 06/29/2020 01:55 PM, Hari Bathini wrote:
> 
> 
> On 28/06/20 7:44 am, piliu wrote:
>> Hi Hari,
> 
> Hi Pingfan,
> 
>>
>> After a quick through for this series, I have a few question/comment on
>> this patch for the time being. Pls see comment inline.
>>
>> On 06/27/2020 03:05 AM, Hari Bathini wrote:
>>> crashkernel region could have an overlap with special memory regions
>>> like  opal, rtas, tce-table & such. These regions are referred to as
>>> exclude memory ranges. Setup this ranges during image probe in order
>>> to avoid them while finding the buffer for different kdump segments.
> 
> [...]
> 
>>> +	/*
>>> +	 * Use the locate_mem_hole logic in kexec_add_buffer() for regular
>>> +	 * kexec_file_load syscall
>>> +	 */
>>> +	if (kbuf->image->type != KEXEC_TYPE_CRASH)
>>> +		return 0;
>> Can the ranges overlap [crashk_res.start, crashk_res.end]?  Otherwise
>> there is no requirement for @exclude_ranges.
> 
> The ranges like rtas, opal are loaded by f/w. They almost always overlap with
> crashkernel region. So, @exclude_ranges is required to support kdump.
f/w passes rtas/opal as service, then must f/w mark these ranges as
fdt_reserved_mem in order to make kernel aware not to use these ranges?
Otherwise kernel memory allocation besides kdump can also overwrite
these ranges.

Hmm, revisiting reserve_crashkernel(). It seems not to take any reserved
memory into consider except kernel text. Could it work based on memblock
allocator?

Thanks,
Pingfan
> 
>> I guess you have a design for future. If not true, then it is better to
>> fold the condition "if (kbuf->image->type != KEXEC_TYPE_CRASH)" into the
>> caller and rename this function to better distinguish use cases between
>> kexec and kdump
> 
> Yeah, this condition will be folded. I have a follow-up patch for that explaining
> why kexec case should also be folded. Will try to add that to this series for v2.
> 
> Thanks
> Hari
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
