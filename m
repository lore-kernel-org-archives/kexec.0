Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VniMg-0001F7-Hb
 for kexec@lists.infradead.org; Tue, 03 Dec 2013 05:17:43 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id CFE243EE0C0
 for <kexec@lists.infradead.org>; Tue,  3 Dec 2013 14:17:15 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id BB94145DEB5
 for <kexec@lists.infradead.org>; Tue,  3 Dec 2013 14:17:15 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.nic.fujitsu.com [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 939CB45DEBC
 for <kexec@lists.infradead.org>; Tue,  3 Dec 2013 14:17:15 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 712F7E0800A
 for <kexec@lists.infradead.org>; Tue,  3 Dec 2013 14:17:15 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 001E81DB8045
 for <kexec@lists.infradead.org>; Tue,  3 Dec 2013 14:17:15 +0900 (JST)
Message-ID: <529D6933.9070609@jp.fujitsu.com>
Date: Tue, 03 Dec 2013 14:16:35 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] vmcore: call remap_pfn_range() separately for respective
 partial pages
References: <52970342.8090302@jp.fujitsu.com>
 <20131202152754.GC18642@redhat.com> <529D3158.2080603@jp.fujitsu.com>
In-Reply-To: <529D3158.2080603@jp.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "Eric W. Biederman" <ebiederm@xmission.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

(2013/12/03 10:18), HATAYAMA Daisuke wrote:
> (2013/12/03 0:27), Vivek Goyal wrote:
>> On Thu, Nov 28, 2013 at 05:48:02PM +0900, HATAYAMA Daisuke wrote:
>>> Hello Vivek,
>>>
>>> Here is a patch set for mmap failure for /proc/vmcore.
>>> Could you try to use this on the problematic system?
>>>
>>> This patch doesn't copy partial pages to the 2nd kernel, only prepares
>>> vmcore objects for respective partial pages to invoke remap_pfn_range()
>>> for individual partial pages.
>>
>> Hi Hatayama,
>>
>> Thanks for the patch. Ok, I see that partial pages will be put in a separate
>> call to remap_oldmem_pfn_range() and this time it should succeed.
>>
>> I am wondering what do you think about your old approach of copying
>> only relevant old memory to a new kernel page in new kernel. I kind
>> of feel little uncomfortable with the idea of rounding down start
>> and roudning up end to page size boundaries and then accessing the
>> full page using oldmem interface. A safer approach might be to allocate
>> page in new kernel, read *only* those bytes as reported by elf header
>> and fill rest of the page with zeros.
>>
>> Thanks
>> Vivek
>>
>
> Even if copying partial pages into the 2nd kernel, we need to use ioremap()
> once on them, and I think the ioremap() is exactly similar to
> remap_pfn_range() for a single page. There seems no difference on safeness
> between them.
>

I suspected some kind of pre-fetching could be performed when just page table
is created. But it's common thing between the two cases above. Then, as you say,
it would be safer to read less data from non-System-RAM area. Copying seems
better in our case.

Another concern to reading data from partial pages is a possibility of
undesirable hardware prefetch to non-System-RAM area. Is it better to disable this?

> Also, current /proc/vmcore shows user-land tools a shape with holes not
> filled with zeros both in case of read() and in case of mmap(). If we adapt
> copying one without reading data in holes, shape of /proc/vmcore gets
> changed again.
>

So, next patch will change data in holes by filling them with zeros.

BTW, we have now page cache interface implemented by Michael Holzheu, but
we have yet to use it on x86 because we've never wanted it so far. It's
natural to use it to read partial pages on-demand, but I also in part think
that it's not proper time to start using new mechanism that needs to be tested
more. How do you think?

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
