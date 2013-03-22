Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIq56-00051q-Oq
 for kexec@lists.infradead.org; Fri, 22 Mar 2013 00:43:42 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 045123EE0C1
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 09:43:39 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id DF27E45DE58
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 09:43:38 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id C856745DE54
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 09:43:38 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id BB681E08002
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 09:43:38 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 64BB31DB804E
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 09:43:38 +0900 (JST)
Date: Fri, 22 Mar 2013 09:43:32 +0900 (JST)
Message-Id: <20130322.094332.87614031.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v3 18/21] vmcore: check if vmcore objects satify
 mmap()'s page-size boundary requirement
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20130321152751.GK3934@redhat.com>
References: <87a9pxz0wv.fsf@xmission.com> <20130321152124.GJ3934@redhat.com>
 <20130321152751.GK3934@redhat.com>
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
Date: Thu, 21 Mar 2013 11:27:51 -0400

> On Thu, Mar 21, 2013 at 11:21:24AM -0400, Vivek Goyal wrote:
> 
> [..]
>> So if starting or end address of PT_LOAD header is not aligned, why
>> not we simply allocate a page. Copy the relevant data from old memory,
>> fill rest with zero. That way mmap and read view will be same. There
>> will be no surprises w.r.t reading old kernel memory beyond what's 
>> specified by the headers.
> 
> Copying from old memory might spring surprises w.r.t hw poisoned
> pages. I guess we will have to disable MCE, read page, enable it
> back or something like that to take care of these issues.
> 
> In the past we have recommended makedumpfile to be careful, look
> at struct pages and make sure we are not reading poisoned pages.
> But vmcore itself is reading old memory and can run into this
> issue too.

Yes, that has been already implemented in makedumpfile.

Not only copying, but also mmaping poisoned pages might be problematic
due to hardware cache prefetch performed by creation of page table to
the poisoned pages. Or MCE disables the prefetch? I'm not sure but
I'll investigate this. makedumpfile might also take care of calling
mmap.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
