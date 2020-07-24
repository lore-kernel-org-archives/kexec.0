Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyyNe-0002tp-8G
 for kexec@lists.infradead.org; Fri, 24 Jul 2020 14:08:59 +0000
Subject: Re: [PATCH v4 06/12] ppc64/kexec_file: restrict memory usage of kdump
 kernel
References: <159524918900.20855.17709718993097359220.stgit@hbathini.in.ibm.com>
 <159524954805.20855.1164928096364700614.stgit@hbathini.in.ibm.com>
 <875zad6ajx.fsf@morokweng.localdomain>
From: Hari Bathini <hbathini@linux.ibm.com>
Message-ID: <77c606da-8eb2-d831-147b-a204b498c7d7@linux.ibm.com>
Date: Fri, 24 Jul 2020 19:38:45 +0530
MIME-Version: 1.0
In-Reply-To: <875zad6ajx.fsf@morokweng.localdomain>
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



On 24/07/20 5:36 am, Thiago Jung Bauermann wrote:
> 
> Hari Bathini <hbathini@linux.ibm.com> writes:
> 
>> Kdump kernel, used for capturing the kernel core image, is supposed
>> to use only specific memory regions to avoid corrupting the image to
>> be captured. The regions are crashkernel range - the memory reserved
>> explicitly for kdump kernel, memory used for the tce-table, the OPAL
>> region and RTAS region as applicable. Restrict kdump kernel memory
>> to use only these regions by setting up usable-memory DT property.
>> Also, tell the kdump kernel to run at the loaded address by setting
>> the magic word at 0x5c.
>>
>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>> Tested-by: Pingfan Liu <piliu@redhat.com>
>> ---
>>
>> v3 -> v4:
>> * Updated get_node_path() to be an iterative function instead of a
>>   recursive one.
>> * Added comment explaining why low memory is added to kdump kernel's
>>   usable memory ranges though it doesn't fall in crashkernel region.
>> * For correctness, added fdt_add_mem_rsv() for the low memory being
>>   added to kdump kernel's usable memory ranges.
> 
> Good idea.
> 
>> * Fixed prop pointer update in add_usable_mem_property() and changed
>>   duple to tuple as suggested by Thiago.
> 
> <snip>
> 
>> +/**
>> + * get_node_pathlen - Get the full path length of the given node.
>> + * @dn:               Node.
>> + *
>> + * Also, counts '/' at the end of the path.
>> + * For example, /memory@0 will be "/memory@0/\0" => 11 bytes.
> 
> Wouldn't this function return 10 in the case of /memory@0?

Actually, it does return 11. +1 while returning is for counting %NUL.
On top of that we count an extra '/' for root node.. so, it ends up as 11.
('/'memory@0'/''\0'). Note the extra '/' before '\0'. Let me handle root node
separately. That should avoid the confusion.

>> + *
>> + * Returns the string length of the node's full path.
>> + */
> 
> Maybe it's me (by analogy with strlen()), but I would expect "string
> length" to not include the terminating \0. I suggest renaming the
> function to something like get_node_path_size() and do s/length/size/ in
> the comment above if it's supposed to count the terminating \0.

Sure, will update the function name.

Thanks
Hari

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
