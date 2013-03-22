Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIrln-0004DH-LK
 for kexec@lists.infradead.org; Fri, 22 Mar 2013 02:31:53 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 40FF73EE081
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 11:31:48 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 24B9745DE54
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 11:31:48 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 09FBE45DE5E
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 11:31:48 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id EF4A91DB804F
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 11:31:47 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id A51371DB8051
 for <kexec@lists.infradead.org>; Fri, 22 Mar 2013 11:31:47 +0900 (JST)
Date: Fri, 22 Mar 2013 11:30:29 +0900 (JST)
Message-Id: <20130322.113029.44701859.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v3 18/21] vmcore: check if vmcore objects satify
 mmap()'s page-size boundary requirement
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <87ip4kntj5.fsf@xmission.com>
References: <20130321152124.GJ3934@redhat.com>
 <20130321152751.GK3934@redhat.com> <87ip4kntj5.fsf@xmission.com>
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
Date: Thu, 21 Mar 2013 17:54:22 -0700

> Vivek Goyal <vgoyal@redhat.com> writes:
> 
>> On Thu, Mar 21, 2013 at 11:21:24AM -0400, Vivek Goyal wrote:
>>
>> [..]
>>> So if starting or end address of PT_LOAD header is not aligned, why
>>> not we simply allocate a page. Copy the relevant data from old memory,
>>> fill rest with zero. That way mmap and read view will be same. There
>>> will be no surprises w.r.t reading old kernel memory beyond what's 
>>> specified by the headers.
>>
>> Copying from old memory might spring surprises w.r.t hw poisoned
>> pages. I guess we will have to disable MCE, read page, enable it
>> back or something like that to take care of these issues.
>>
>> In the past we have recommended makedumpfile to be careful, look
>> at struct pages and make sure we are not reading poisoned pages.
>> But vmcore itself is reading old memory and can run into this
>> issue too.
> 
> Vivek you are overthinking this.
> 
> If there are issues with reading partially exported pages we should
> fix them in kexec-tools or in the kernel where the data is exported.
> 
> In the examples given in the patch what we were looking at were cases
> where the BIOS rightly or wrongly was saying kernel this is my memory
> stay off.  But it was all perfectly healthy memory.
> 
> /proc/vmcore is a simple data dumper and prettifier.  Let's keep it that
> way so that we can predict how it will act when we feed it information.
> /proc/vmcore should not be worrying about or covering up sins elsewhere
> in the system.
> 
> At the level of /proc/vmcore we may want to do something about ensuring
> MCE's don't kill us.  But that is an orthogonal problem.

This is the part of old memory /proc/vmcore must read at its
initialization to generate its meta data, i.e. ELF header, program
header table and ELF note segments. Other memory chunks are part
makedumpfile should decide whether to read or avoid.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
