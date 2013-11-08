Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VedTR-00028k-Fd
 for kexec@lists.infradead.org; Fri, 08 Nov 2013 04:15:11 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 46AD43EE1A1
 for <kexec@lists.infradead.org>; Fri,  8 Nov 2013 13:14:40 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 3109D45DE50
 for <kexec@lists.infradead.org>; Fri,  8 Nov 2013 13:14:40 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.nic.fujitsu.com [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 163DA45DE4E
 for <kexec@lists.infradead.org>; Fri,  8 Nov 2013 13:14:40 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 038D91DB8042
 for <kexec@lists.infradead.org>; Fri,  8 Nov 2013 13:14:40 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id AB6A11DB803E
 for <kexec@lists.infradead.org>; Fri,  8 Nov 2013 13:14:39 +0900 (JST)
Message-ID: <527C64E2.4000501@jp.fujitsu.com>
Date: Fri, 08 Nov 2013 13:13:22 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] x86, apic, kexec: Add disable_cpu_apic kernel
 parameter
References: <20131022150015.24240.39686.stgit@localhost6.localdomain6>
 <20131108033043.GA3133@dhcp-16-105.nay.redhat.com>
In-Reply-To: <20131108033043.GA3133@dhcp-16-105.nay.redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: fengguang.wu@intel.com, jingbai.ma@hp.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, akpm@linux-foundation.org, hpa@linux.intel.com, vgoyal@redhat.com

(2013/11/08 12:30), Baoquan He wrote:
> Hi,
>
> Reccently people reported kexec didn't work correctly. After check, it's
> a regression. Since a code block which migrate current thread to cpu0
> when executing "kexec -e", this can be reproduced by setting affinity to
> CPUn(n!=0). You can find this patch in this link:
> https://lkml.org/lkml/2013/11/5/88
>
> Then I thought why we don't do this in kdump. I tried migrating current
> thread to cpu0 when crash happened, it works very well. Set affinity to
> make crash happened on CPUn(n!=0), then all cpus can be brought up and
> dump is successful. I pasted the patch as below.
>
> Only one thing worried me, whether the context related to crash cpu will
> be different, and do we care which cpu crashed. If it need be cared, or
> it doesn't involve difference, That will be great. Multiple CPUs can be
> supported easily in this simpler way. Meanwhile, this patch just try to
> migrate, if it's failed, we can avoid to bring up bsp.
>
> Watch do you think about it?
>

We have already discussed this idea. It's the idea of my first patch and
it was nacked. See the following url. (Sorry, I removed explanation of
development history from patch description at v4 patch, but I've planned
to write what ideas doesn't work well in documentation of this work.)

https://lkml.org/lkml/2012/4/15/181

The key reason why we cannot do that is the environment we are running
must be considered broken. Either interrupts or scheduler could no longer
work. Tables for interrupts can be broken. The other cpus except for the
crashing cpu are no longer guaranteed to be running sanely. Migrating cpu
from the crashing cpu to cpu0 reduces reliability of kdump.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
