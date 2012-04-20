Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SLAom-0000Bx-NR
 for kexec@lists.infradead.org; Fri, 20 Apr 2012 10:11:58 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 584163EE0B6
 for <kexec@lists.infradead.org>; Fri, 20 Apr 2012 19:11:52 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3E8D345DE9E
 for <kexec@lists.infradead.org>; Fri, 20 Apr 2012 19:11:52 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 0C07245DEA6
 for <kexec@lists.infradead.org>; Fri, 20 Apr 2012 19:11:52 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id F09701DB803F
 for <kexec@lists.infradead.org>; Fri, 20 Apr 2012 19:11:51 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.240.81.133])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id AA6B51DB8038
 for <kexec@lists.infradead.org>; Fri, 20 Apr 2012 19:11:51 +0900 (JST)
Date: Fri, 20 Apr 2012 19:11:33 +0900 (JST)
Message-Id: <20120420.191133.488341439.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH 0/4] Export offsets of VMCS fields as note information
 for kdump
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <4F900020.5010702@redhat.com>
References: <4F8FF7AC.1060309@redhat.com>
 <20120419.210119.246504497.d.hatayama@jp.fujitsu.com>
 <4F900020.5010702@redhat.com>
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
Cc: dzickus@redhat.com, luto@mit.edu, mtosatti@redhat.com, kvm@vger.kernel.org, joerg.roedel@amd.com, gregkh@suse.de, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, zhangyanfei@cn.fujitsu.com, ebiederm@xmission.com, ludwig.nussel@suse.de

From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 0/4] Export offsets of VMCS fields as note information for kdump
Date: Thu, 19 Apr 2012 15:08:00 +0300

> On 04/19/2012 03:01 PM, HATAYAMA Daisuke wrote:
>> >> It would be not helpful for the qemu crash case you are concerned
>> >> about. We want to use the guest state data to look into guest
>> >> machine's image in the crasshed qemu.
>> > 
>> > Why?
>> > 
>>
>> It seems natural to check the situation from guest machine's side when
>> qemu crashs. Suppose a service is running on the guest machine, and
>> then the qemu crash. Then, we may need to know the details of the
>> progress of the service if it's important. What has been successfully
>> done, and what has not yet.
> 
> How can a service on the guest be related to a qemu crash?  And how
> would guest registers help?

I don't mean the service is related to qemu's crash. When qemu
crashes, then the guest machine also crashes (although it doesn't
notice anything). What I'm interested in here is guest machine side,
not qemu side. I want to debug guest machine, not qemu.

> 
> You can extract the list of running processes from a qemu crash dump
> without looking at guest registers.  And most vcpus are running
> asynchronously to qemu, so their register contents is irrelevant (if a
> vcpu is running synchronously with qemu - it just exited to qemu and is
> waiting for a response - then you'd see the details in qemu's call stack).
> 

Just as you say, we can refer to guest machine's memory without guest
registers.

The definitely necessary data in vmcs are RSP and RIP, which are not
saved in anywhare of kvm module. The two registers are needed for back
tracing to determine what processsing is being done on the guest
machine at qemu crash.

There are other useful data in vmcs, but even if we don't have them,
we can do what we want to do in exchange of usability.

For example, we want IA32_EFER.LMA to determine whether guest machine
is in 32-bit or 64-bit mode. But there are only two modes, we can
perhaps try these in order in an ad-hoc way.

Other control registers are also useful, but they are not so important
than definitely needed.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
