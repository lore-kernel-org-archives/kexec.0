Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xp5hL-0001lE-HT
 for kexec@lists.infradead.org; Fri, 14 Nov 2014 01:29:16 +0000
Received: from kw-mxoi1.gw.nic.fujitsu.com (unknown [10.0.237.133])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id EF5073EE0C1
 for <kexec@lists.infradead.org>; Fri, 14 Nov 2014 10:28:47 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by kw-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id D1E9CAC0850
 for <kexec@lists.infradead.org>; Fri, 14 Nov 2014 10:28:46 +0900 (JST)
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 6AB681DB803B
 for <kexec@lists.infradead.org>; Fri, 14 Nov 2014 10:28:46 +0900 (JST)
Date: Fri, 14 Nov 2014 10:31:33 +0900 (JST)
Message-Id: <20141114.103133.364422370204110382.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH] kdump, x86: report actual value of phys_base in VMCOREINFO
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20141113142548.GA1978@redhat.com>
References: <20141113090657.2578f087@hananiah.suse.cz>
 <54646C1D.1050102@jp.fujitsu.com>
 <20141113142548.GA1978@redhat.com>
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
Cc: kexec@lists.infradead.org, ptesarik@suse.cz, linux-kernel@vger.kernel.org, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, anderson@redhat.com

From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kdump, x86: report actual value of phys_base in VMCOREINFO
Date: Thu, 13 Nov 2014 09:25:48 -0500

> On Thu, Nov 13, 2014 at 05:30:21PM +0900, HATAYAMA, Daisuke wrote:
>> 
>> 
>> (2014/11/13 17:06), Petr Tesarik wrote:
>> >On Thu, 13 Nov 2014 09:17:09 +0900 (JST)
>> >HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
>> >
>> >>From: Vivek Goyal <vgoyal@redhat.com>
>> >>Subject: Re: [PATCH] kdump, x86: report actual value of phys_base in VMCOREINFO
>> >>Date: Wed, 12 Nov 2014 17:12:05 -0500
>> >>
>> >>>On Wed, Nov 12, 2014 at 03:40:42PM +0900, HATAYAMA Daisuke wrote:
>> >>>>Currently, VMCOREINFO note information reports the virtual address of
>> >>>>phys_base that is assigned to symbol phys_base. But this doesn't make
>> >>>>sense because to refer to value of the phys_base, it's necessary to
>> >>>>get the value of phys_base itself we are now about to refer to.
>> >>>>
>> >>>
>> >>>Hi Hatayama,
>> >>>
>> >>>/proc/vmcore ELF headers have virtual address information and using
>> >>>that you should be able to read actual value of phys_base. gdb deals
>> >>>with virtual addresses all the time and can read value of any symbol
>> >>>using those headers.
>> >>>
>> >>>So I am not sure what's the need for exporting actual value of
>> >>>phys_base.
>> >>>
>> >>
>> >>Sorry, my logic in the patch description was wrong. For /proc/vmcore,
>> >>there's enough information for makedumpdile to get phys_base. It's
>> >>correct. The problem here is that other crash dump mechanisms that run
>> >>outside Linux kernel independently don't have information to get
>> >>phys_base.
>> >
>> >Yes, but these mechanisms won't be able to read VMCOREINFO either, will
>> >they?
>> >
>> 
>> I don't intend such sophisticated function only by VMCOREINFO.
>> Search vmcore for VMCOREINFO using strings + grep before opening it by crash.
>> I intend that only here.
> 
> I think this is very crude and not proper way to get to vmcoreinfo. Can

I agree it's crude, but it's useful enough for my usecase.

> you give more context. What are those mechanisms and what are you trying
> to do.
> 

I after all write the same thing in the patch description... I mean
qemu dump, xendump (and other hypervisor dumps), firmware dumps
implemented on each vendor system for the crash dump mechanism.

But there's no prepared information now. So, crash utility has made
effort to calculate phys_base from the existing information. One
example is to check if how far linux_banner string is apart from where
it actually is in vmcore, and another is to walk page tables via CR4
register if it is included in note information of the crash dump
mechanism's environment.

There's no gurantee that these always work well. For example, because
these crash dump mechanisms run independently of Linux kernel, it
could be when CPU moves to some firmware code. Then, CR4 could point
at differnet page table.

Looking at VMCOREINFO, there's already phys_base information but it's
symbol value only and it doesn't make sense. So it should be
corrected. I think this is natural.

Also, I think it important to keep externally running crash dump
mechansms as independent as possible. If they depend on linux kernel,
it could reduce robustoness of their functionality. In case of
phys_base, if we added a mechanism to get phys_base, it would mean
that the crash dump mechisms doesn't work well until they got
phys_base. For robustness, I think it best to make Linux kernel put
necessary information anywhere and to make users to use them
independently.

--
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
