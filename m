Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W9Arr-0002nw-4M
 for kexec@lists.infradead.org; Fri, 31 Jan 2014 09:58:36 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id A754D3EE0BB
 for <kexec@lists.infradead.org>; Fri, 31 Jan 2014 18:58:08 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9225545DE55
 for <kexec@lists.infradead.org>; Fri, 31 Jan 2014 18:58:08 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.nic.fujitsu.com [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9178A45DE6B
 for <kexec@lists.infradead.org>; Fri, 31 Jan 2014 18:58:06 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 847C4E08007
 for <kexec@lists.infradead.org>; Fri, 31 Jan 2014 18:58:06 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 2639AE08003
 for <kexec@lists.infradead.org>; Fri, 31 Jan 2014 18:58:06 +0900 (JST)
Message-ID: <52EB73A1.3080409@jp.fujitsu.com>
Date: Fri, 31 Jan 2014 18:57:53 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] vmcore: copy fractional pages into buffers in the
 kdump 2nd kernel
References: <52A579EE.6090107@jp.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971E47E1@BPXM01GP.gisp.nec.co.jp>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971E47E1@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

(2014/01/31 11:36), Atsushi Kumagai wrote:
> Hello HATAYAMA-san,
>
> On 2013/12/09 17:06:18, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
>> This is a patch for fixing mmap failure due to fractional page issue.
>>
>> This patch might be still a bit too large as a single patch and might need to split.
>> If you think patch refactoring is needed, please suggest.
>>
>> Change Log:
>>
>> v1 => v2)
>>
>> - Copy fractional pages from 1st kernel to 2nd kernel to reduce read
>>    to the fractional pages for reliability.
>>
>> - Deal with the case where multiple System RAM areas are contained in
>>    a single fractional page.
>>
>> Test:
>>
>> Tested on X86_64. Fractional pages are created using memmap= kernel
>> parameter on the kdump 1st kernel.
>
> Could you tell me more details about how to reproduce this ?
> I tried to create such fractional pages to test the patch at
> the end of this mail, by using memmap= kernel parameter as you said
> like below:
>
>    # cat /proc/iomem
>    ...
>    100000000-10fff57ff : System RAM
>    10fff5800-1100057ff : reserved
>    110005800-11fffffff : System RAM
>
> However, I couldn't face the mmap() failure and makedumpfile worked
> normally even using mmap() on linux-3.12.1. What am I missing here ?
>

This patch set tries to reduce potential risk on accessing i.e. creating
page tables reading memory outside System RAM regions. The potential risk
I intend here is for example effect of accessing mmio region.

If you didn't see any failure except for mmap() failure on fractional pages,
there's no potential risk on your system in the sense of what I mean above.
Or you could probably see different behavior by choosing other System RAM
region that resides in the memory that is used for something special.

Also, in early phase, our design didn't care about this kind of fractional pages
because we don't think there were many such systems on real world. But the
bug report came earlier than we expected. So, I think we should design
carefully here around at least as long as they can be done relatively simply.
# Sorry for delaying my work...

Of course, I think both kernel and makedumpfile address the issue together
to reduce potential risk as much as possible.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
