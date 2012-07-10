Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SoOsy-0006lI-Sl
 for kexec@lists.infradead.org; Tue, 10 Jul 2012 01:05:12 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 8DC6C3EE0B6
 for <kexec@lists.infradead.org>; Tue, 10 Jul 2012 10:04:52 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 7399F45DE54
 for <kexec@lists.infradead.org>; Tue, 10 Jul 2012 10:04:52 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 554D345DD78
 for <kexec@lists.infradead.org>; Tue, 10 Jul 2012 10:04:52 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 48DA01DB803A
 for <kexec@lists.infradead.org>; Tue, 10 Jul 2012 10:04:52 +0900 (JST)
Received: from m021.s.css.fujitsu.com (m021.s.css.fujitsu.com [10.0.81.61])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 076C61DB802C
 for <kexec@lists.infradead.org>; Tue, 10 Jul 2012 10:04:52 +0900 (JST)
Date: Tue, 10 Jul 2012 10:04:27 +0900 (JST)
Message-Id: <20120710.100427.259038238.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v4 2/3] KVM-INTEL: Add new module vmcsinfo-intel to
 fill VMCSINFO
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <4FF6A0F3.2010201@cn.fujitsu.com>
References: <4FF4155F.6070508@cn.fujitsu.com>
 <20120706.170410.119097767.d.hatayama@jp.fujitsu.com>
 <4FF6A0F3.2010201@cn.fujitsu.com>
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
To: wency@cn.fujitsu.com
Cc: dzickus@redhat.com, luto@mit.edu, kvm@vger.kernel.org, joerg.roedel@amd.com, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, zhangyanfei@cn.fujitsu.com, avi@redhat.com, gregkh@linuxfoundation.org, ludwig.nussel@suse.de, ebiederm@xmission.com

From: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [PATCH v4 2/3] KVM-INTEL: Add new module vmcsinfo-intel to fill VMCSINFO
Date: Fri, 6 Jul 2012 16:25:23 +0800

> At 07/06/2012 04:04 PM, HATAYAMA Daisuke Wrote:
>> From: Yanfei Zhang <zhangyanfei@cn.fujitsu.com>
>> Subject: [PATCH v4 2/3] KVM-INTEL: Add new module vmcsinfo-intel to fill VMCSINFO
>> Date: Wed, 4 Jul 2012 18:05:19 +0800
>> 
>>> Besides, this patch also exports vmcs revision identifier via
>>> /sys/devices/system/cpu/vmcs_id and offsets of fields via
>>> /sys/devices/system/cpu/vmcs/.
>>> Individual offsets are contained in subfiles named by the filed's
>>> encoding, e.g.: /sys/devices/cpu/vmcs/0800
>> 
>> According to the discussion starting from
>> 
>> http://lkml.indiana.edu/hypermail/linux/kernel/1105.3/00749.html
> 
> IIRC, kvm can not work in such environment. The vcpu can run on
> different cpu. If the cpu's vmcs is different, I don't know what
> will happen. So do we need to support for such environment now?
> I think that if kvm can not work in such environment, we should
> not provide vmcs information for each physical cpu.
> 

Ah, I noticed my basic confusion: if it --- vcpu can run on cpus with
differnet VMCS revision --- were possible, this vmcsinfo would be
unnecessary because it would mean processer could read VMCS data with
revision different from its own one or some kind of reverse
engineering for convertion of differnet VMCS data were done.

I think kvm could probably work if only processors that have the same
VMCS revision are assigned to a single guest. But considering the VMCS
nature, such processor with differnet revision seems unlikely to be
used on host machine.

Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
