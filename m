Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vo8QX-0006QN-DY
 for kexec@lists.infradead.org; Wed, 04 Dec 2013 09:07:26 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 25CFC3EE11D
 for <kexec@lists.infradead.org>; Wed,  4 Dec 2013 18:07:03 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id C219945DEB7
 for <kexec@lists.infradead.org>; Wed,  4 Dec 2013 18:07:02 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.nic.fujitsu.com [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 9951845DEBC
 for <kexec@lists.infradead.org>; Wed,  4 Dec 2013 18:07:02 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 5D2D3E08002
 for <kexec@lists.infradead.org>; Wed,  4 Dec 2013 18:07:02 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 46A65E08009
 for <kexec@lists.infradead.org>; Wed,  4 Dec 2013 18:07:01 +0900 (JST)
Message-ID: <529EF070.4080800@jp.fujitsu.com>
Date: Wed, 04 Dec 2013 18:05:52 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] vmcore: call remap_pfn_range() separately for respective
 partial pages
References: <52970342.8090302@jp.fujitsu.com>
 <20131202152754.GC18642@redhat.com> <529D3158.2080603@jp.fujitsu.com>
 <529D6933.9070609@jp.fujitsu.com> <20131203151247.GD4251@redhat.com>
In-Reply-To: <20131203151247.GD4251@redhat.com>
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

(2013/12/04 0:12), Vivek Goyal wrote:
> On Tue, Dec 03, 2013 at 02:16:35PM +0900, HATAYAMA Daisuke wrote:
>
> [..]
>>> Even if copying partial pages into the 2nd kernel, we need to use ioremap()
>>> once on them, and I think the ioremap() is exactly similar to
>>> remap_pfn_range() for a single page. There seems no difference on safeness
>>> between them.
>>>
>>
>> I suspected some kind of pre-fetching could be performed when just page table
>> is created. But it's common thing between the two cases above. Then, as you say,
>> it would be safer to read less data from non-System-RAM area. Copying seems
>> better in our case.
>
> If we map page and just read *only* those bytes as advertized by ELF
> headers and fill rest of the bytes with zero, I think that seems like
> a right thing to do. We are only accessing what has been exported by
> ELF headers and not trying to read outside that range.
>
>>
>> Another concern to reading data from partial pages is a possibility of
>> undesirable hardware prefetch to non-System-RAM area. Is it better to disable this?
>
> If it becomes an issue, may be. I think we can fix it when we run into
> an actual issue.
>

I see.

>>
>>> Also, current /proc/vmcore shows user-land tools a shape with holes not
>>> filled with zeros both in case of read() and in case of mmap(). If we adapt
>>> copying one without reading data in holes, shape of /proc/vmcore gets
>>> changed again.
>>>
>>
>> So, next patch will change data in holes by filling them with zeros.
>>
>> BTW, we have now page cache interface implemented by Michael Holzheu, but
>> we have yet to use it on x86 because we've never wanted it so far. It's
>> natural to use it to read partial pages on-demand, but I also in part think
>> that it's not proper time to start using new mechanism that needs to be tested
>> more. How do you think?
>
> Do we gain anything significant by using that interface. To me it looks
> like this will just delay creation of mapping for partial pages. Does not
> save us any memory in second kernel?
>

Amount of partial pages seems not so problematic.
No, the number of partial pages are at most the number of System RAM entries * 2.
I guess the number of the entries doesn't exceed 100 even in the worst case.
Less than 1MiB even in the worst case.

The mechanism would be useful for platform that has large amount of note segment.
But per-cpu note segemnt of x86 is relatively small, so meaningful platform seems
the ones with a large number of cpus and they are still restrictive. Other archs
that has large per-cpu note segment would already want the feature, just as
Michael Holzheu explained previously for some of their s390 platform.

> I would think that in first pass, keep it simple. Copy partial pages in
> second kernel's memory. Read data as exported by ELF headers. Fill rest
> of the page with zeros. Adjust /proc/vmcore ELF headers accordingly and
> that should do it.
>

Yes, I also want to keep simplicity. I'll post a new patch tomorrow.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
