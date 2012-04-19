Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SKq3S-0000TY-RQ
 for kexec@lists.infradead.org; Thu, 19 Apr 2012 12:01:44 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id DB3363EE0B5
 for <kexec@lists.infradead.org>; Thu, 19 Apr 2012 21:01:39 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id BE85745DD74
 for <kexec@lists.infradead.org>; Thu, 19 Apr 2012 21:01:39 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 9579C45DE50
 for <kexec@lists.infradead.org>; Thu, 19 Apr 2012 21:01:39 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 873701DB8041
 for <kexec@lists.infradead.org>; Thu, 19 Apr 2012 21:01:39 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.240.81.133])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 3B4481DB803A
 for <kexec@lists.infradead.org>; Thu, 19 Apr 2012 21:01:39 +0900 (JST)
Date: Thu, 19 Apr 2012 21:01:19 +0900 (JST)
Message-Id: <20120419.210119.246504497.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH 0/4] Export offsets of VMCS fields as note information
 for kdump
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <4F8FF7AC.1060309@redhat.com>
References: <4F8FEC22.400@redhat.com>
 <20120419.202707.276752866.d.hatayama@jp.fujitsu.com>
 <4F8FF7AC.1060309@redhat.com>
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
Date: Thu, 19 Apr 2012 14:31:56 +0300

> On 04/19/2012 02:27 PM, HATAYAMA Daisuke wrote:
>> >> The reason why we want to retrieve guest machine's memory image as
>> >> crash dump is that then we can debug guest machine's status using
>> >> symbolic debugger such as gdb and crash utility.
>> >>
>> >> This is very useful. Please consider the situation where engineers are
>> >> forced to look into guest machine's memory image through qemu-kvm's
>> >> process core dump using gdb without any symbolic information. It's
>> >> very inefficient.
>> > 
>> > I still don't follow.  If qemu crashed, the values in guest registers
>> > are irrelevant.  In what way can the help debug the qemu crash?
>> > 
>>
>> It would be not helpful for the qemu crash case you are concerned
>> about. We want to use the guest state data to look into guest
>> machine's image in the crasshed qemu.
> 
> Why?
> 

It seems natural to check the situation from guest machine's side when
qemu crashs. Suppose a service is running on the guest machine, and
then the qemu crash. Then, we may need to know the details of the
progress of the service if it's important. What has been successfully
done, and what has not yet.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
