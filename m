Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vnedg-00066n-FF
 for kexec@lists.infradead.org; Tue, 03 Dec 2013 01:19:01 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 235283EE0BB
 for <kexec@lists.infradead.org>; Tue,  3 Dec 2013 10:18:31 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 137AC45DE5A
 for <kexec@lists.infradead.org>; Tue,  3 Dec 2013 10:18:31 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.nic.fujitsu.com [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id F128B45DE54
 for <kexec@lists.infradead.org>; Tue,  3 Dec 2013 10:18:30 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id DF858E08002
 for <kexec@lists.infradead.org>; Tue,  3 Dec 2013 10:18:30 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 910031DB803C
 for <kexec@lists.infradead.org>; Tue,  3 Dec 2013 10:18:30 +0900 (JST)
Message-ID: <529D3158.2080603@jp.fujitsu.com>
Date: Tue, 03 Dec 2013 10:18:16 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] vmcore: call remap_pfn_range() separately for respective
 partial pages
References: <52970342.8090302@jp.fujitsu.com>
 <20131202152754.GC18642@redhat.com>
In-Reply-To: <20131202152754.GC18642@redhat.com>
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

(2013/12/03 0:27), Vivek Goyal wrote:
> On Thu, Nov 28, 2013 at 05:48:02PM +0900, HATAYAMA Daisuke wrote:
>> Hello Vivek,
>>
>> Here is a patch set for mmap failure for /proc/vmcore.
>> Could you try to use this on the problematic system?
>>
>> This patch doesn't copy partial pages to the 2nd kernel, only prepares
>> vmcore objects for respective partial pages to invoke remap_pfn_range()
>> for individual partial pages.
>
> Hi Hatayama,
>
> Thanks for the patch. Ok, I see that partial pages will be put in a separate
> call to remap_oldmem_pfn_range() and this time it should succeed.
>
> I am wondering what do you think about your old approach of copying
> only relevant old memory to a new kernel page in new kernel. I kind
> of feel little uncomfortable with the idea of rounding down start
> and roudning up end to page size boundaries and then accessing the
> full page using oldmem interface. A safer approach might be to allocate
> page in new kernel, read *only* those bytes as reported by elf header
> and fill rest of the page with zeros.
>
> Thanks
> Vivek
>

Even if copying partial pages into the 2nd kernel, we need to use ioremap()
once on them, and I think the ioremap() is exactly similar to
remap_pfn_range() for a single page. There seems no difference on safeness
between them.

Also, current /proc/vmcore shows user-land tools a shape with holes not
filled with zeros both in case of read() and in case of mmap(). If we adapt
copying one without reading data in holes, shape of /proc/vmcore gets
changed again.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
