Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailout1.samsung.com ([203.254.224.24])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Rktem-00029t-Uz
 for kexec@lists.infradead.org; Wed, 11 Jan 2012 08:35:42 +0000
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep 7
 2010)) with ESMTP id <0LXM00ECQL6TSHU0@mailout1.samsung.com> for
 kexec@lists.infradead.org; Wed, 11 Jan 2012 17:35:32 +0900 (KST)
Received: from [165.213.219.123] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep 7
 2010)) with ESMTPA id <0LXM00HTNL77CKJ0@mmp2.samsung.com> for
 kexec@lists.infradead.org; Wed, 11 Jan 2012 17:35:31 +0900 (KST)
Message-id: <4F0D49DD.80305@samsung.com>
Date: Wed, 11 Jan 2012 17:35:41 +0900
From: Joonyoung Shim <jy0922.shim@samsung.com>
MIME-version: 1.0
Subject: ARM kexec SMP problem using exynos4210
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux@arm.linux.org.uk
Cc: kexec@lists.infradead.org, will.deacon@arm.com

Hi,

I have tested kexec to Nuri board using Exynos4210(Dual-core ARM
Cortex-A9) on the latest mainline kernel but i am facing one problem.

The kernel enabled SMP, kernel_kexec() calls machine_shutdown to stop
all cpus except current cpu and jumps to the new kernel but the kernel
is hanged soon.

I used cpu_down(1) to make disabled cpu1 instead of smp_send_stop of
machine_shutdown and it is booted successfully to new kernel.

Any ideas?

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
