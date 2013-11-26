Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlB3H-0008W1-Qp
 for kexec@lists.infradead.org; Tue, 26 Nov 2013 05:19:13 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id A47503EE0B6
 for <kexec@lists.infradead.org>; Tue, 26 Nov 2013 14:18:41 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 56DF345DFD4
 for <kexec@lists.infradead.org>; Tue, 26 Nov 2013 14:18:41 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.nic.fujitsu.com [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9492845DECC
 for <kexec@lists.infradead.org>; Tue, 26 Nov 2013 14:18:39 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id E9D95E781CC
 for <kexec@lists.infradead.org>; Tue, 26 Nov 2013 14:17:44 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 8699AE781C6
 for <kexec@lists.infradead.org>; Tue, 26 Nov 2013 14:17:44 +0900 (JST)
Message-ID: <52942E9B.2030003@jp.fujitsu.com>
Date: Tue, 26 Nov 2013 14:16:11 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: /proc/vmcore mmap() failure issue
References: <20131115142617.GC6637@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971BF592@BPXM01GP.gisp.nec.co.jp>
 <20131118135511.GA30637@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971C3862@BPXM01GP.gisp.nec.co.jp>
 <20131120145901.GB27924@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971C43E3@BPXM01GP.gisp.nec.co.jp>
 <528DC4F2.5040000@jp.fujitsu.com> <20131121165237.GG16208@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971C5AB3@BPXM01GP.gisp.nec.co.jp>
 <529311F1.90603@jp.fujitsu.com> <20131125144150.GC21378@redhat.com>
In-Reply-To: <20131125144150.GC21378@redhat.com>
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
Cc: "bhe@redhat.com" <bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "dyoung@redhat.com" <dyoung@redhat.com>, "chaowang@redhat.com" <chaowang@redhat.com>

(2013/11/25 23:41), Vivek Goyal wrote:
> On Mon, Nov 25, 2013 at 06:01:37PM +0900, HATAYAMA Daisuke wrote:
>
> [..]
>>> I agree to avoid this issue by fixing makedumpfile as workaround while to
>>> fix kernel is so tough and risky. However, it sounds strange to me to fix
>>> userspace side elaborately for such definite kernel issue whose cause is
>>> known, so we should fix the kernel itself.
>>>
>>
>>> Otherwise, will you continue to add specific fixes into user tools to
>>> address kernel issues like this case ?
>>>
>>
>> makedumpfile supports a wide range of kernel versions and needs to satisfy
>> backward compatibility. mmap() on /proc/vmcore might be backported to some of
>> the old versions on some distributions if necessary. Then, it's hard to fix
>> each old kernel at each back port. The method that can be applied to all the
>> kernels in general, is necessary.
>>
>> Also, looking at ia64 case where there's boot loader data on partial pages,
>> there could be other environments where partial pages contain other important
>> data other components have. So, the issue depends not only on kernels but also
>> other components such as boot loader and firmwares that can put data on
>> partial pages. We need to get there as long as there's important data there
>> and we have access to there.
>
> Hi Atsushi, Hatayama,
>
> So even if we fix the mmap() issue in kernel, looks like it will be a
> good idea to ship the fix in makedumpfile as there have been a kernel
> release where mmap() will cause issues.
>
> Having said that, I think we need to fix it in kernel also. I was not sure
> that what's the right fix. Should we truncate partial pages or should
> we just copy partial pages from old memory to new kernel's memory and fill
> partial page with zeros. And that's why I was hoping that makedumpfile
> can fill the gap.
>
> Copying partial pages to new memory seems like a safer approach. So may
> be we can take a fix in makeudmpfile and another in kernel.
>
> Hatayama, I know that in the past your initial mmap() patches were copying
> partial pages to new kernel's memory. Would you like to resurrect that
> patch again?
>

(Oh, I yesterday had totally forgotten partial page handling that was dropped
from mmap() patch set in the middle of development...)

Yes, but wait until next week.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
