Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VYdT4-0005aI-OO
 for kexec@lists.infradead.org; Tue, 22 Oct 2013 15:02:00 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id C0A0B3EE1DA
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 00:01:32 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 974C145DE4D
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 00:01:32 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 74CBB45DE50
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 00:01:32 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 43C4CE0801B
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 00:01:32 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8FF0AE08030
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 00:01:27 +0900 (JST)
Subject: [PATCH v4 1/3] x86,
 apic: Don't count the CPU with BP flag from MP table as booting-up CPU
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Wed, 23 Oct 2013 00:01:24 +0900
Message-ID: <20131022150124.24240.20741.stgit@localhost6.localdomain6>
In-Reply-To: <20131022150015.24240.39686.stgit@localhost6.localdomain6>
References: <20131022150015.24240.39686.stgit@localhost6.localdomain6>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: hpa@linux.intel.com, ebiederm@xmission.com, vgoyal@redhat.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, akpm@linux-foundation.org, fengguang.wu@intel.com, jingbai.ma@hp.com

If crash occurs on some AP, then kdump 2nd kernel is booted up on the
AP. Therefore, it is not always correct that the CPU that is currently
booting up the kernel is BSP. It's wrong to reflect BSP information in
MP table as for the current booting up CPU.

Also, boot_cpu_physical_apicid has already been initialized before
reaching here, for example, in register_lapic_address().

This is a preparation for next patch that will introduce a new kernel
parameter to disabls specified CPU where boot_cpu_physical_apicid
needs to have apicid for the currently booting up CPU to identify it
to avoid falsely disabling it.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 arch/x86/kernel/mpparse.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index d2b5648..969bb9f 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -64,7 +64,6 @@ static void __init MP_processor_info(struct mpc_cpu *m)
 
 	if (m->cpuflag & CPU_BOOTPROCESSOR) {
 		bootup_cpu = " (Bootup-CPU)";
-		boot_cpu_physical_apicid = m->apicid;
 	}
 
 	printk(KERN_INFO "Processor #%d%s\n", m->apicid, bootup_cpu);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
