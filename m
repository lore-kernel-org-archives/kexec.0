Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VEyWd-0005TQ-Pj
 for kexec@lists.infradead.org; Thu, 29 Aug 2013 09:28:24 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 9727C3EE0BB
 for <kexec@lists.infradead.org>; Thu, 29 Aug 2013 18:27:54 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 8408745DE59
 for <kexec@lists.infradead.org>; Thu, 29 Aug 2013 18:27:54 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 6B40A45DE55
 for <kexec@lists.infradead.org>; Thu, 29 Aug 2013 18:27:54 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5E6EE1DB8043
 for <kexec@lists.infradead.org>; Thu, 29 Aug 2013 18:27:54 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1566A1DB804A
 for <kexec@lists.infradead.org>; Thu, 29 Aug 2013 18:27:54 +0900 (JST)
Subject: [PATCH 0/2] x86, apic: Disable BSP if boot cpu is AP
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Thu, 29 Aug 2013 18:27:53 +0900
Message-ID: <20130829092458.5476.10277.stgit@localhost6.localdomain6>
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
To: ebiederm@xmission.com, vgoyal@redhat.com
Cc: akpm@linux-foundation.org, hpa@linux.intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jingbai.ma@hp.com

This is the patch series to address the issue that kdump 2nd kernel
now fails to wake up multiple CPUs.

This is based on 3.11-rc7.

I tested this patch series on x86. I used 2 cpus by specifying
nr_cpus=2 for the 2nd kernel. I checked both ACPI MADT and MP table
case; the former is default on my system and for the latter I did
acpi=off. I crashed the system both on BSP and AP by taskset -c {0,1}
sh -c "echo c > /proc/sysrq-trigger".

---

HATAYAMA Daisuke (2):
      x86, apic: Add boot_cpu_is_bsp() to check if boot cpu is BSP
      x86, apic: Disable BSP if boot cpu is AP


 arch/x86/include/asm/mpspec.h |    5 ++++-
 arch/x86/kernel/acpi/boot.c   |   11 ++++++++++-
 arch/x86/kernel/apic/apic.c   |   32 +++++++++++++++++++++++++++++++-
 arch/x86/kernel/devicetree.c  |    1 +
 arch/x86/kernel/mpparse.c     |   15 +++++++++++++--
 arch/x86/kernel/setup.c       |    2 ++
 arch/x86/platform/sfi/sfi.c   |    2 +-
 7 files changed, 62 insertions(+), 6 deletions(-)

-- 
Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
