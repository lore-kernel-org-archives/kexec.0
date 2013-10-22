Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VYdT4-0005aL-ON
 for kexec@lists.infradead.org; Tue, 22 Oct 2013 15:02:00 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 0C0DB3EE1E2
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 00:01:40 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id E955145DE58
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 00:01:39 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id D0D5545DE52
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 00:01:39 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id BC3C21DB803C
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 00:01:39 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id C7BF21DB8038
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 00:01:38 +0900 (JST)
Subject: [PATCH v4 3/3] Documentation, x86, apic,
 kexec: Add disable_cpu_apicid kernel parameter
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Wed, 23 Oct 2013 00:01:35 +0900
Message-ID: <20131022150135.24240.40322.stgit@localhost6.localdomain6>
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

Add disable_cpu_apicid kernel parameter to disable the CPU with the
specified number of initial APIC ID, mostly used for the kdump 2nd
kernel to disable BSP to wake up multiple CPUs without causing system
reset or hang due to sending INIT from AP to BSP.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 Documentation/kernel-parameters.txt |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index fcbb736..0ca0902 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -774,6 +774,15 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 	disable=	[IPV6]
 			See Documentation/networking/ipv6.txt.
 
+	disable_cpu_apicid= [X86,APIC,KEXEC,SMP]
+			Format: <int>
+			The number of initial APIC ID for the
+			corresponding CPU to be disabled at boot,
+			mostly used for the kdump 2nd kernel to
+			disable BSP to wake up multiple CPUs without
+			causing system reset or hang due to sending
+			INIT from AP to BSP.
+
 	disable_ddw     [PPC/PSERIES]
 			Disable Dynamic DMA Window support. Use this if
 			to workaround buggy firmware.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
