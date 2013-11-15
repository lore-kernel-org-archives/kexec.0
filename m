Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VhFvj-0002kW-Uh
 for kexec@lists.infradead.org; Fri, 15 Nov 2013 09:43:14 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 932913EE0C0
 for <kexec@lists.infradead.org>; Fri, 15 Nov 2013 18:42:41 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 8494745DE54
 for <kexec@lists.infradead.org>; Fri, 15 Nov 2013 18:42:41 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.nic.fujitsu.com [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 2B3DC45DD77
 for <kexec@lists.infradead.org>; Fri, 15 Nov 2013 18:42:41 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 15786E38003
 for <kexec@lists.infradead.org>; Fri, 15 Nov 2013 18:42:41 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id ADDDE1DB803B
 for <kexec@lists.infradead.org>; Fri, 15 Nov 2013 18:42:40 +0900 (JST)
Message-ID: <5285EC60.1060906@jp.fujitsu.com>
Date: Fri, 15 Nov 2013 18:41:52 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: /proc/vmcore mmap() failure issue
References: <20131113204130.GD7613@redhat.com> <5284A689.70903@jp.fujitsu.com>
 <20131114151359.GA3913@redhat.com>
In-Reply-To: <20131114151359.GA3913@redhat.com>
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
Cc: Baoquan He <bhe@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux kernel mailing list <linux-kernel@vger.kernel.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "Eric W. Biederman" <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, WANG Chao <chaowang@redhat.com>

(2013/11/15 0:13), Vivek Goyal wrote:
> On Thu, Nov 14, 2013 at 07:31:37PM +0900, HATAYAMA Daisuke wrote:
>
> [..]
>> BTW, I previously found a part of makedumpfile that truncates the first and
>> last pages if they are not aligned in page size. Discussing with Kumagai-san,
>> the truncation is performed on some ia64 system and he found a valid data in
>> the truncated area, and the latest makedumpfile no longer does such
>> truncation.
>
> I went through the mail thread link you posted below. Looks like
> bootloader had put command line in that area and that would be truncated
> if we exclude partial pages from vmcore.
>
> I don't know about IA64, but on x86, I see that we are trimming partial
> pages before they are added to memblock. So any memory allocations after
> this should not happen in partial page area. Bootloader still might
> place some things in those partial pages I guess.
>
> So do we care about that little bootloader data if it happens to be
> there. Dump mechanism works only after kdump service has been loaded.
> That means first kernel is up and running. That means any relevant
> data passed to us from bootloader has already been copied in kernel
> memory and kernel did not crash. So to me, we don't have a strong
> need to look at exactly how bootloader passed data looked originally.
> We can just look at kernel copy of associated data structures (bootparams,
> command line etc).
>
> I think being able to mmap() vmcore is much more important. BTW, is
> it possible to change makedumpfile so that it uses mmap() for reading
> page aligned areas and falls back to read() interface for reading
> partial pages? (Though it is beginning to sound already complicatated
> to me).
>
> Given the fact that hpa does not like fixing it in kernel. We are left
> with option of fixing it in following places.
>
> - Drop partial pages in kexec-tools
> - Drop partial pages in makeudmpfile.
> - Read partial pages using read() interface in makedumpfile
> - Modify /proc/vmcore to copy partial pages in second kernel's memory.
>
> It is not clear to me that partial pages are really useful.  So I want
> to avoid modifying /proc/vmcore to deal with partial pages and increase
> complexity.
>
> So fixing makedumpfile (either option2 or option 3) seems least risky
> to me. In fact I would say let us keep it simple and truncate partial
> pages in makedumpfile to keep it simple. And look at option 3 once we
> have a strong use case for partial pages.
>
> What do you think?
>

As you say, it's not clear that partial pages are really useful, but on
the other hand, it seems to me not clear that they are really useless.
I think we should get them as long as we have access to them.

It seems best to me the option 3). Switching between read and mmap would
be not so complex and also it's by far flexible in makedumpfile than in
kernel.

Also, I think it better for /proc/vmcore to disable mmap on partial
pages in order to avoid the issue here.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
