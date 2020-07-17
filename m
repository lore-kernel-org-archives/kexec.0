Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwHpc-0006fZ-1e
 for kexec@lists.infradead.org; Fri, 17 Jul 2020 04:18:44 +0000
Subject: Re: [PATCH v3 06/12] ppc64/kexec_file: restrict memory usage of kdump
 kernel
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com>
 <159466091925.24747.6840028682768745598.stgit@hbathini.in.ibm.com>
 <87365s9ysj.fsf@morokweng.localdomain>
 <baa29ea9-7698-a7e8-e5a4-c9f842e1fcc8@linux.ibm.com>
 <875zance3n.fsf@morokweng.localdomain>
From: Hari Bathini <hbathini@linux.ibm.com>
Message-ID: <f1e6f1d4-5052-ce6a-747f-bb821987b75a@linux.ibm.com>
Date: Fri, 17 Jul 2020 09:47:25 +0530
MIME-Version: 1.0
In-Reply-To: <875zance3n.fsf@morokweng.localdomain>
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



On 17/07/20 3:33 am, Thiago Jung Bauermann wrote:
> 
> Hari Bathini <hbathini@linux.ibm.com> writes:
> 
>> On 16/07/20 4:22 am, Thiago Jung Bauermann wrote:
>>>
>>> Hari Bathini <hbathini@linux.ibm.com> writes:
>>>

<snip>
 
>>>> +	 * each representing a memory range.
>>>> +	 */
>>>> +	ranges = (len >> 2) / (n_mem_addr_cells + n_mem_size_cells);
>>>> +
>>>> +	for (i = 0; i < ranges; i++) {
>>>> +		base = of_read_number(prop, n_mem_addr_cells);
>>>> +		prop += n_mem_addr_cells;
>>>> +		end = base + of_read_number(prop, n_mem_size_cells) - 1;
>>
>> prop is not used after the above.
>>
>>> You need to `prop += n_mem_size_cells` here.
>>
>> But yeah, adding it would make it look complete in some sense..
> 
> Isn't it used in the next iteration of the loop?

Memory@XXX/reg typically has only one range. I was looking at it
from that perspective which is not right. Will update.

Thanks
Hari

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
