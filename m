Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpmqp-0002G6-U7
 for kexec@lists.infradead.org; Mon, 29 Jun 2020 06:01:08 +0000
Subject: Re: [PATCH 01/11] kexec_file: allow archs to handle special regions
 while locating memory hole
References: <159319825403.16351.7253978047621755765.stgit@hbathini.in.ibm.com>
 <159319828304.16351.6990340111766605842.stgit@hbathini.in.ibm.com>
 <ed94a357-16aa-9f17-aa5f-5aab6617ed68@redhat.com>
From: Hari Bathini <hbathini@linux.ibm.com>
Message-ID: <38237270-ce15-c8ec-a527-1ff938ca257d@linux.ibm.com>
Date: Mon, 29 Jun 2020 11:30:35 +0530
MIME-Version: 1.0
In-Reply-To: <ed94a357-16aa-9f17-aa5f-5aab6617ed68@redhat.com>
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
To: piliu <piliu@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>
Cc: Kexec-ml <kexec@lists.infradead.org>, Petr Tesarik <ptesarik@suse.cz>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Mimi Zohar <zohar@linux.ibm.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Eric Biederman <ebiederm@xmission.com>



On 28/06/20 7:58 am, piliu wrote:
> Hi Hari,
> 
> If in [4/11],  get_exclude_memory_ranges() turns out to be unnecessary
> ,then this patch is abundant either. As my understanding, memblock has
> already helped to achieved the purpose that get_exclude_memory_ranges()
> wants.

As mentioned in the other patch, there is a need for @exclude_ranges as crashkernel
region is likely to have an overlap with regions like opal, rtas..

But yeah.. the weak function should have been kexec_locate_mem_hole() instead
of kexec_add_buffer(). Will take care of that in v2.

> On 06/27/2020 03:04 AM, Hari Bathini wrote:
>> Some archs can have special memory regions, within the given memory
>> range, which can't be used for the buffer in a kexec segment. As
>> kexec_add_buffer() function is being called from generic code as well,
>> add weak arch_kexec_add_buffer definition for archs to override & take
>> care of special regions before trying to locate a memory hole.
>>
>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

Thanks
Hari

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
