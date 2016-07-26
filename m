Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bRsf1-0000re-JN
 for kexec@lists.infradead.org; Tue, 26 Jul 2016 03:04:00 +0000
From: Wei Jiangang <weijg.fnst@cn.fujitsu.com>
Subject: [PATCH v2 1/3] x86/apic: Remove "focus disabled" for 64bit case
Date: Tue, 26 Jul 2016 10:59:53 +0800
Message-ID: <1469501995-2991-2-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1469501995-2991-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1469501995-2991-1-git-send-email-weijg.fnst@cn.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: bhe@redhat.com, xpang@redhat.com, joro@8bytes.org, x86@kernel.org, kexec@lists.infradead.org, Cao jin <caoj.fnst@cn.fujitsu.com>, mingo@redhat.com, kernel@kyup.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, Wei Jiangang <weijg.fnst@cn.fujitsu.com>

Disable processor focus for 64bit causes a crash,
Call Trace as following:

  [<ffffffff8133499f>] dump_stack+0x63/0x84
  [<ffffffff810800f1>] __warn+0xd1/0xf0
  [<ffffffff8108016f>] warn_slowpath_fmt+0x5f/0x80
  [<ffffffff81068ab2>] ex_handler_wrmsr_unsafe+0x62/0x70
  [<ffffffff81068b29>] fixup_exception+0x39/0x50
  [<ffffffff8102e030>] do_general_protection+0x80/0x160
  [<ffffffff816a89a8>] general_protection+0x28/0x30
  [<ffffffff81062554>] ? native_write_msr+0x4/0x30
  [<ffffffff81059c52>] ? native_apic_msr_write+0x32/0x40
  [<ffffffff81d92964>] init_bsp_APIC+0x5f/0x118
  [<ffffffff81d87489>] init_ISA_irqs+0x19/0x4c
  [<ffffffff81d87512>] native_init_IRQ+0xd/0x377
  [<ffffffff81d874fe>] init_IRQ+0x42/0x49
  [<ffffffff81d7afc6>] start_kernel+0x2ce/0x4c8
  [<ffffffff81d7aae6>] ? set_init_arg+0x55/0x55
  [<ffffffff81d7a120>] ? early_idt_handler_array+0x120/0x120
  [<ffffffff81d7a5db>] x86_64_start_reservations+0x2f/0x31
  [<ffffffff81d7a729>] x86_64_start_kernel+0x14c/0x16f

Keep a consistent implementation with the setup_local_APIC(),
always use processor focus for 64bit.
more details refer to commit 89c38c2867eb ("x86: apic - unify
setup_local_APIC")

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
Signed-off-by: Wei Jiangang <weijg.fnst@cn.fujitsu.com>
---
 arch/x86/kernel/apic/apic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 60078a67d7e3..0273b652c689 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1154,9 +1154,7 @@ void __init init_bsp_APIC(void)
 	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) &&
 	    (boot_cpu_data.x86 == 15))
 		value &= ~APIC_SPIV_FOCUS_DISABLED;
-	else
 #endif
-		value |= APIC_SPIV_FOCUS_DISABLED;
 	value |= SPURIOUS_APIC_VECTOR;
 	apic_write(APIC_SPIV, value);
 
-- 
1.9.3




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
