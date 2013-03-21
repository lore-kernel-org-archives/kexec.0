Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIZH5-0002Iu-F0
 for kexec@lists.infradead.org; Thu, 21 Mar 2013 06:46:56 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 469763EE0BB
 for <kexec@lists.infradead.org>; Thu, 21 Mar 2013 15:46:53 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 2B57045DE58
 for <kexec@lists.infradead.org>; Thu, 21 Mar 2013 15:46:53 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 0161845DE5B
 for <kexec@lists.infradead.org>; Thu, 21 Mar 2013 15:46:53 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id E7DCCE08003
 for <kexec@lists.infradead.org>; Thu, 21 Mar 2013 15:46:52 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9A6531DB803F
 for <kexec@lists.infradead.org>; Thu, 21 Mar 2013 15:46:52 +0900 (JST)
Date: Thu, 21 Mar 2013 15:46:50 +0900 (JST)
Message-Id: <20130321.154650.424925595.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v3 18/21] vmcore: check if vmcore objects satify
 mmap()'s page-size boundary requirement
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <87ip4l1d1q.fsf@xmission.com>
References: <8738vp75cy.fsf@xmission.com>
 <20130321.151428.393714972.d.hatayama@jp.fujitsu.com>
 <87ip4l1d1q.fsf@xmission.com>
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
Date: Wed, 20 Mar 2013 23:29:05 -0700

> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> writes:
>>
>> Do you mean for each range represented by each PT_LOAD entry, say:
>>
>>   [p_paddr, p_paddr + p_memsz]
>>
>> extend it as:
>>
>>   [rounddown(p_paddr, PAGE_SIZE), roundup(p_paddr + p_memsz, PAGE_SIZE)].
>>
>> not only objects in vmcore_list, but also updating p_paddr and p_memsz
>> members themselves of each PT_LOAD entry? In other words, there's no
>> new holes not referenced by any PT_LOAD entry since the regions
>> referenced by some PT_LOAD entry, themselves are extended.
> 
> No.  p_paddr and p_memsz as exported should remain the same.
> I am suggesting that we change p_offset.
> 
> I am suggesting to include the data in the file as if we had changed
> p_paddr and p_memsz.
> 
>> Then, the vmcores seen from read and mmap methods are coincide in the
>> direction of including both ranges
>>
>>   [rounddown(p_paddr, PAGE_SIZE), p_paddr]
>>
>> and
>>
>>   [p_paddr + p_memsz, roundup(p_paddr + p_memsz, PAGE_SIZE)]
>>
>> are included in both vmcores seen from read and mmap methods, although
>> they are originally not dump target memory, which you are not
>> problematic for ease of implementation.
>>
>> Is there difference here from you understanding?
> 
> Preserving the actual PT_LOAD segments p_paddr and p_memsz values is
> important. p_offset we can change as much as we want.  Which means there
> can be logical holes in the file between PT_LOAD segments, where we put
> the extra data needed to keep everything page aligned.
> 

So, I have to make the same question again. Is it OK if two vmcores
are different? How do you intend the ``extra data'' to be deal with? I
mean mmap() has to export part of old memory as the ``extra data''.

If you think OK, I'll fill the ``extra data'' with 0 in case of read
method. If not OK, I'll fill with the corresponding part of old
memory.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
