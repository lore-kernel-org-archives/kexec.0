Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwByJ-0000aI-4D
 for kexec@lists.infradead.org; Thu, 16 Jul 2020 22:03:19 +0000
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com>
 <159466091925.24747.6840028682768745598.stgit@hbathini.in.ibm.com>
 <87365s9ysj.fsf@morokweng.localdomain>
 <baa29ea9-7698-a7e8-e5a4-c9f842e1fcc8@linux.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 06/12] ppc64/kexec_file: restrict memory usage of kdump
 kernel
In-reply-to: <baa29ea9-7698-a7e8-e5a4-c9f842e1fcc8@linux.ibm.com>
Date: Thu, 16 Jul 2020 19:03:08 -0300
Message-ID: <875zance3n.fsf@morokweng.localdomain>
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

> On 16/07/20 4:22 am, Thiago Jung Bauermann wrote:
>> 
>> Hari Bathini <hbathini@linux.ibm.com> writes:
>> 
>
> <snip>
>
>>> +/**
>>> + * get_node_path - Get the full path of the given node.
>>> + * @dn:            Node.
>>> + * @path:          Updated with the full path of the node.
>>> + *
>>> + * Returns nothing.
>>> + */
>>> +static void get_node_path(struct device_node *dn, char *path)
>>> +{
>>> +	if (!dn)
>>> +		return;
>>> +
>>> +	get_node_path(dn->parent, path);
>> 
>> Is it ok to do recursion in the kernel? In this case I believe it's not
>> problematic since the maximum call depth will be the maximum depth of a
>> device tree node which shouldn't be too much. Also, there are no local
>> variables in this function. But I thought it was worth mentioning.
>
> You are right. We are better off avoiding the recursion here. Will
> change it to an iterative version instead.

Ok.

>>> +	 * each representing a memory range.
>>> +	 */
>>> +	ranges = (len >> 2) / (n_mem_addr_cells + n_mem_size_cells);
>>> +
>>> +	for (i = 0; i < ranges; i++) {
>>> +		base = of_read_number(prop, n_mem_addr_cells);
>>> +		prop += n_mem_addr_cells;
>>> +		end = base + of_read_number(prop, n_mem_size_cells) - 1;
>
> prop is not used after the above.
>
>> You need to `prop += n_mem_size_cells` here.
>
> But yeah, adding it would make it look complete in some sense..

Isn't it used in the next iteration of the loop?

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
