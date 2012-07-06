Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Sn44R-0001kU-GA
 for kexec@lists.infradead.org; Fri, 06 Jul 2012 08:39:24 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 8920C3EE0BB
 for <kexec@lists.infradead.org>; Fri,  6 Jul 2012 17:39:14 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 6EBFB45DE4E
 for <kexec@lists.infradead.org>; Fri,  6 Jul 2012 17:39:14 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 5317F45DE52
 for <kexec@lists.infradead.org>; Fri,  6 Jul 2012 17:39:14 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 45CDD1DB8041
 for <kexec@lists.infradead.org>; Fri,  6 Jul 2012 17:39:14 +0900 (JST)
Received: from m023.s.css.fujitsu.com (m023.s.css.fujitsu.com [10.0.81.63])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 025221DB802F
 for <kexec@lists.infradead.org>; Fri,  6 Jul 2012 17:39:14 +0900 (JST)
Date: Fri, 06 Jul 2012 17:38:50 +0900 (JST)
Message-Id: <20120706.173850.11462611.d.hatayama@jp.fujitsu.com>
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

I think so too. The design can be kept very simple if kvm doesn't
support such case, and it would be good news. Is it true?

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
