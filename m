Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIw8Z-0003Lx-S6
 for kexec@lists.infradead.org; Fri, 22 Mar 2013 07:11:44 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id EE87E3EE0BD
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 16:11:29 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id D24E045DE4D
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 16:11:29 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id B11C845DE51
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 16:11:29 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id A23BFE18002
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 16:11:29 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 435FE1DB8041
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 16:11:29 +0900 (JST)
Date: Fri, 22 Mar 2013 16:11:21 +0900 (JST)
Message-Id: <20130322.161121.07584638.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v3 18/21] vmcore: check if vmcore objects satify
 mmap()'s page-size boundary requirement
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20130321144929.GH3934@redhat.com>
References: <20130321.151428.393714972.d.hatayama@jp.fujitsu.com>
 <87y5dhw71o.fsf@xmission.com> <20130321144929.GH3934@redhat.com>
Mime-Version: 1.0
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
To: vgoyal@redhat.com
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, cpw@sgi.com

From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 18/21] vmcore: check if vmcore objects satify mmap()'s page-size boundary requirement
Date: Thu, 21 Mar 2013 10:49:29 -0400

> On Thu, Mar 21, 2013 at 12:22:59AM -0700, Eric W. Biederman wrote:
>> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> writes:
>> 
>> > OK, rigorously, suceess or faliure of the requested free pages
>> > allocation depends on actual memory layout at the 2nd kernel boot. To
>> > increase the possibility of allocating memory, we have no method but
>> > reserve more memory for the 2nd kernel now.
>> 
>> Good enough.   If there are fragmentation issues that cause allocation
>> problems on larger boxes we can use vmalloc and remap_vmalloc_range, but
>> we certainly don't need to start there.
>> 
>> Especialy as for most 8 or 16 core boxes we are talking about a 4KiB or
>> an 8KiBP allocation.  Aka order 0 or order 1.
>> 
> 
> Actually we are already handling the large SGI machines so we need
> to plan for 4096 cpus now while we write these patches.
> 
> vmalloc() and remap_vmalloc_range() sounds reasonable. So that's what
> we should probaly use.
> 
> Alternatively why not allocate everything in 4K pages and use vmcore_list
> to map offset into right addresses and call remap_pfn_range() on these
> addresses.

I have an introductory question about design of vmalloc. My
understanding is that vmalloc allocates *pages* enough to cover a
requested size and returns the first corresponding virtual address.
So, the address returned is inherently always page-size aligned.

It looks like vmalloc does so in the current implementation, but I
don't know older implementations and I cannot make sure this is
guranteed in vmalloc's interface. There's the comment explaing the
interface of vmalloc as below, but it seems to me a little vague in
that it doesn't say clearly what's is returned as an address.

/**
 *      vmalloc  -  allocate virtually contiguous memory
 *      @size:          allocation size
 *      Allocate enough pages to cover @size from the page level
 *      allocator and map them into contiguous kernel virtual space.
 *
 *      For tight control over page level allocator and protection flags
 *      use __vmalloc() instead.
 */
void *vmalloc(unsigned long size)
{
        return __vmalloc_node_flags(size, NUMA_NO_NODE,
                                    GFP_KERNEL | __GFP_HIGHMEM);
}
EXPORT_SYMBOL(vmalloc);

BTW, simple test module code also shows they returns page-size aligned
objects, where 1-byte objects are allocated 12-times.

$ dmesg | tail -n 12
[3552817.290982] test: objects[0] = ffffc9000060c000
[3552817.291197] test: objects[1] = ffffc9000060e000
[3552817.291379] test: objects[2] = ffffc9000067d000
[3552817.291566] test: objects[3] = ffffc90010f99000
[3552817.291833] test: objects[4] = ffffc90010f9b000
[3552817.292015] test: objects[5] = ffffc90010f9d000
[3552817.292207] test: objects[6] = ffffc90010f9f000
[3552817.292386] test: objects[7] = ffffc90010fa1000
[3552817.292574] test: objects[8] = ffffc90010fa3000
[3552817.292785] test: objects[9] = ffffc90010fa5000
[3552817.292964] test: objects[10] = ffffc90010fa7000
[3552817.293143] test: objects[11] = ffffc90010fa9000

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
