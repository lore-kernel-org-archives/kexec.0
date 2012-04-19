Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SKojg-0003dl-3k
 for kexec@lists.infradead.org; Thu, 19 Apr 2012 10:37:13 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id AA7363EE0BB
 for <kexec@lists.infradead.org>; Thu, 19 Apr 2012 19:37:05 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 91B8B45DE5D
 for <kexec@lists.infradead.org>; Thu, 19 Apr 2012 19:37:05 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 7671845DE58
 for <kexec@lists.infradead.org>; Thu, 19 Apr 2012 19:37:05 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5ED08E08001
 for <kexec@lists.infradead.org>; Thu, 19 Apr 2012 19:37:05 +0900 (JST)
Received: from m106.s.css.fujitsu.com (m106.s.css.fujitsu.com [10.240.81.146])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 093FE1DB804C
 for <kexec@lists.infradead.org>; Thu, 19 Apr 2012 19:37:05 +0900 (JST)
Date: Thu, 19 Apr 2012 19:36:40 +0900 (JST)
Message-Id: <20120419.193640.59653378.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH 0/4] Export offsets of VMCS fields as note information
 for kdump
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <4F8EABF7.805@redhat.com>
References: <4F8E7A5B.5030904@redhat.com> <4F8E8E3D.8040707@cn.fujitsu.com>
 <4F8EABF7.805@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: avi@redhat.com
Cc: dzickus@redhat.com, luto@mit.edu, gregkh@suse.de, kvm@vger.kernel.org, joerg.roedel@amd.com, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, zhangyanfei@cn.fujitsu.com, ebiederm@xmission.com, ludwig.nussel@suse.de

From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 0/4] Export offsets of VMCS fields as note information for kdump
Date: Wed, 18 Apr 2012 14:56:39 +0300

> On 04/18/2012 12:49 PM, zhangyanfei wrote:
>> >>
>> > 
>> > What type of resource?  Can you give an example?
>> > 
>> Sorry. No concrete example for now.
>>
>> We are developing this on a conservative policy and I have put the vmcs processing
>> in a new module in patch set v2 as you required. The new module is auto-loaded when
>> the vmx cpufeature is detected and it depends on module kvm-intel. Loading and unloading
>> this module will have no side effect on the running guests.
>>
>> And one thing I have to stress is that, we can see guest image as crash dump from
>> guest machine's view if we have the vmcsinfo, this itself is useful.
> 
> Why is it useful?  Without a concrete example, it's hard to justify the
> code bloat.
> 

The reason why we want to retrieve guest machine's memory image as
crash dump is that then we can debug guest machine's status using
symbolic debugger such as gdb and crash utility.

This is very useful. Please consider the situation where engineers are
forced to look into guest machine's memory image through qemu-kvm's
process core dump using gdb without any symbolic information. It's
very inefficient.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
