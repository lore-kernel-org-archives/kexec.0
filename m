Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i2RlQ-0006lq-3k
 for kexec@lists.infradead.org; Tue, 27 Aug 2019 03:03:21 +0000
Received: by mail-pg1-x542.google.com with SMTP id l21so11776438pgm.3
 for <kexec@lists.infradead.org>; Mon, 26 Aug 2019 20:03:19 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
Subject: [PATCHv2 4/4] x86/smp: disallow MCE handler on rebooting AP
Date: Tue, 27 Aug 2019 11:02:23 +0800
Message-Id: <1566874943-4449-5-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1566874943-4449-1-git-send-email-kernelfans@gmail.com>
References: <1566874943-4449-1-git-send-email-kernelfans@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, Baoquan He <bhe@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>, Daniel Drake <drake@endlessm.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Masami Hiramatsu <mhiramat@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Qian Cai <cai@lca.pw>, Dave Young <dyoung@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Eric Biederman <ebiederm@xmission.com>

"kexec -l" sends the rest cpu to halt state with local apic disabled. But
they can still respond to MCE.  Meanwhile the execution of MCE handler
relies on the 1st kernel's page table and text, which may be cracked during
the 2nd kernel bootup. Hence Before sending SIPI to AP in 2nd kernel, an
MCE event makes AP take the risk of running in weird context.

Heavily suppress it by disallowing MCE handler on rebooting AP.

Note: after this patch, "kexec -l" still has a little window vulnerable to
weird context, despite AP uses tlb cache and icache.  Consider the
scenario: The 1st kernel code native_halt() in stop_this_cpu() is modified
during the 2nd kernel bootup. Then AP is waken up by MCE after the
modification, and will continue in a weired context. This needs extra
effort.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Qian Cai <cai@lca.pw>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Daniel Drake <drake@endlessm.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org
---
 arch/x86/kernel/smp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 96421f9..55b0f11 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -157,11 +157,15 @@ void native_send_call_func_ipi(const struct cpumask *mask)
 
 static int smp_stop_nmi_callback(unsigned int val, struct pt_regs *regs)
 {
+	struct desc_ptr null_ptr = { 0 };
+
 	/* We are registered on stopping cpu too, avoid spurious NMI */
 	if (raw_smp_processor_id() == atomic_read(&stopping_cpu))
 		return NMI_HANDLED;
 
 	cpu_emergency_vmxoff();
+	/* prevent from dispatching MCE handler */
+	load_idt(&null_ptr);
 	stop_this_cpu(NULL);
 
 	return NMI_HANDLED;
@@ -173,8 +177,12 @@ static int smp_stop_nmi_callback(unsigned int val, struct pt_regs *regs)
 
 asmlinkage __visible void smp_reboot_interrupt(void)
 {
+	struct desc_ptr null_ptr = { 0 };
+
 	ipi_entering_ack_irq();
 	cpu_emergency_vmxoff();
+	/* prevent from dispatching MCE handler */
+	load_idt(&null_ptr);
 	stop_this_cpu(NULL);
 	irq_exit();
 }
-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
