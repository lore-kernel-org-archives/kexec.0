Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIW7q-0000hc-Aq
 for kexec@lists.infradead.org; Thu, 21 Mar 2013 03:25:11 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id A149C3EE0CF
 for <kexec@lists.infradead.org>; Thu, 21 Mar 2013 12:25:07 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 8958A45DEBC
 for <kexec@lists.infradead.org>; Thu, 21 Mar 2013 12:25:07 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 48EBC45DEB2
 for <kexec@lists.infradead.org>; Thu, 21 Mar 2013 12:25:07 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3949F1DB803E
 for <kexec@lists.infradead.org>; Thu, 21 Mar 2013 12:25:07 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id E3BAB1DB803B
 for <kexec@lists.infradead.org>; Thu, 21 Mar 2013 12:25:06 +0900 (JST)
Date: Thu, 21 Mar 2013 12:25:01 +0900 (JST)
Message-Id: <20130321.122501.82758179.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v3 18/21] vmcore: check if vmcore objects satify
 mmap()'s page-size boundary requirement
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <87txo5bxk4.fsf@xmission.com>
References: <877gl3koay.fsf@xmission.com> <20130320135716.GE17274@redhat.com>
 <87txo5bxk4.fsf@xmission.com>
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
To: ebiederm@xmission.com
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, cpw@sgi.com, vgoyal@redhat.com

From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 18/21] vmcore: check if vmcore objects satify mmap()'s page-size boundary requirement
Date: Wed, 20 Mar 2013 13:55:55 -0700

> Vivek Goyal <vgoyal@redhat.com> writes:
> 
>> On Tue, Mar 19, 2013 at 03:38:45PM -0700, Eric W. Biederman wrote:
>>> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> writes:
>>> 
>>> > If there's some vmcore object that doesn't satisfy page-size boundary
>>> > requirement, remap_pfn_range() fails to remap it to user-space.
>>> >
>>> > Objects that posisbly don't satisfy the requirement are ELF note
>>> > segments only. The memory chunks corresponding to PT_LOAD entries are
>>> > guaranteed to satisfy page-size boundary requirement by the copy from
>>> > old memory to buffer in 2nd kernel done in later patch.
>>> >
>>> > This patch doesn't copy each note segment into the 2nd kernel since
>>> > they amount to so large in total if there are multiple CPUs. For
>>> > example, current maximum number of CPUs in x86_64 is 5120, where note
>>> > segments exceed 1MB with NT_PRSTATUS only.
>>> 
>>> So you require the first kernel to reserve an additional 20MB, instead
>>> of just 1.6MB.  336 bytes versus 4096 bytes.
>>> 
>>> That seems like completely the wrong tradeoff in memory consumption,
>>> filesize, and backwards compatibility.
>>
>> Agreed. 
>>
>> So we already copy ELF headers in second kernel's memory. If we start
>> copying notes too, then both headers and notes will support mmap().
> 
> The only real is it could be a bit tricky to allocate all of the memory
> for the notes section on high cpu count systems in a single allocation.
> 

Do you mean it's getting difficult on many-cpus machine to get free
pages consequtive enough to be able to cover all the notes?

If so, is it necessary to think about any care to it in the next
patch? Or, should it be pending for now?

>> For mmap() of memory regions which are not page aligned, we can map
>> extra bytes (as you suggested in one of the mails). Given the fact
>> that we have one ELF header for every memory range, we can always modify
>> the file offset where phdr data is starting to make space for mapping
>> of extra bytes.
> 
> Agreed ELF file offset % PAGE_SIZE should == physical address % PAGE_SIZE to
> make mmap work.
> 

OK, your conclusion is the 1st version is better than the 2nd.

The purpose of this design was not to export anything but dump target
memory to user-space from /proc/vmcore. I think it better to do it if
possible. it's possible for read interface to fill the corresponding
part with 0. But it's impossible for mmap interface to data on modify
old memory.

Do you agree two vmcores seen from read and mmap interfaces are no
longer coincide?

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
