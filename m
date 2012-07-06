Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Sn3XH-0005ac-Po
 for kexec@lists.infradead.org; Fri, 06 Jul 2012 08:05:09 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 1843F3EE0B6
 for <kexec@lists.infradead.org>; Fri,  6 Jul 2012 17:04:57 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id EF73645DEB6
 for <kexec@lists.infradead.org>; Fri,  6 Jul 2012 17:04:56 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id D441B45DE9E
 for <kexec@lists.infradead.org>; Fri,  6 Jul 2012 17:04:56 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id C6A9B1DB8040
 for <kexec@lists.infradead.org>; Fri,  6 Jul 2012 17:04:56 +0900 (JST)
Received: from m021.s.css.fujitsu.com (m021.s.css.fujitsu.com [10.0.81.61])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 7481C1DB803E
 for <kexec@lists.infradead.org>; Fri,  6 Jul 2012 17:04:56 +0900 (JST)
Date: Fri, 06 Jul 2012 17:04:10 +0900 (JST)
Message-Id: <20120706.170410.119097767.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v4 2/3] KVM-INTEL: Add new module vmcsinfo-intel to
 fill VMCSINFO
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <4FF4155F.6070508@cn.fujitsu.com>
References: <4FF413D2.4030006@cn.fujitsu.com> <4FF4155F.6070508@cn.fujitsu.com>
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
To: zhangyanfei@cn.fujitsu.com
Cc: dzickus@redhat.com, luto@mit.edu, kvm@vger.kernel.org, joerg.roedel@amd.com, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, avi@redhat.com, gregkh@linuxfoundation.org, ebiederm@xmission.com

From: Yanfei Zhang <zhangyanfei@cn.fujitsu.com>
Subject: [PATCH v4 2/3] KVM-INTEL: Add new module vmcsinfo-intel to fill VMCSINFO
Date: Wed, 4 Jul 2012 18:05:19 +0800

> Besides, this patch also exports vmcs revision identifier via
> /sys/devices/system/cpu/vmcs_id and offsets of fields via
> /sys/devices/system/cpu/vmcs/.
> Individual offsets are contained in subfiles named by the filed's
> encoding, e.g.: /sys/devices/cpu/vmcs/0800

According to the discussion starting from

http://lkml.indiana.edu/hypermail/linux/kernel/1105.3/00749.html

system can be composed of CPUs with different steppings or differnet
microcode revisions. Becase of the nature that it's hided in the
specification, I suspect layout of vmcs could change across different
steppings or microcode revisions. Then, the interface needs to be
changed as per-cpu like

   /sys/devices/cpu/cpu0/vmcs/0800
   /sys/devices/cpu/cpu1/vmcs/0800
   ...
   /sys/devices/cpu/cpuN/vmcs/0800

Also, processing of vmcsinfo initialization needs to be done per cpu,
and can be triggered when cpu is added not when kvm module is loaded.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
