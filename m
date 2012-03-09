Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from serv2.oss.ntt.co.jp ([222.151.198.100])
 by casper.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1S5wUk-0007s6-C5
 for kexec@lists.infradead.org; Fri, 09 Mar 2012 09:52:22 +0000
Message-ID: <4F59D2AE.1020509@oss.ntt.co.jp>
Date: Fri, 09 Mar 2012 18:51:42 +0900
From: =?UTF-8?B?RmVybmFuZG8gTHVpcyBWw6F6cXVleiBDYW8=?= <fernando@oss.ntt.co.jp>
MIME-Version: 1.0
Subject: [PATCH 1/3] boot: fortify early_idt_handlers definition
References: <CAE9FiQVPnO8-tuPoio0Wxv=8rjdm2tJbBk3+3ystueyYtZn9BA@mail.gmail.com>
 <20120216172735.GX9751@redhat.com>
 <CAE9FiQVhbAM9vjx-uFcuc0ndsUp0aez9_TsQHStje5G5iwYbag@mail.gmail.com>
 <20120216215603.GH9751@redhat.com> <m1y5s2ku36.fsf@fess.ebiederm.org>
 <m1fwe9bpk2.fsf@fess.ebiederm.org> <20120217195430.GO9751@redhat.com>
 <m1y5s07rn3.fsf@fess.ebiederm.org> <20120220151419.GU9751@redhat.com>
 <m1obss39a4.fsf@fess.ebiederm.org> <20120221135934.GF26998@redhat.com>
 <m1ipip6xe8.fsf@fess.ebiederm.org> <4F573E1C.2060909@oss.ntt.co.jp>
 <4F573E74.5040504@oss.ntt.co.jp> <m1eht31z8e.fsf@fess.ebiederm.org>
 <4F58495B.5080308@oss.ntt.co.jp> <m1r4x3yrsv.fsf@fess.ebiederm.org>
 <4F59CDE5.8010400@oss.ntt.co.jp>
In-Reply-To: <4F59CDE5.8010400@oss.ntt.co.jp>
Content-Type: multipart/mixed; boundary="------------020409050107000907000903"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Don Zickus <dzickus@redhat.com>, linux-tip-commits@vger.kernel.org, torvalds@linux-foundation.org, mingo@elte.hu, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, akpm@linux-foundation.org, Yinghai Lu <yinghai@kernel.org>, tglx@linutronix.de, vgoyal@redhat.com

This is a multi-part message in MIME format.
--------------020409050107000907000903
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



--------------020409050107000907000903
Content-Type: text/x-patch;
 name="fortify-early_idt_handlers-definition.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fortify-early_idt_handlers-definition.patch"

Subject: [PATCH 1/3] boot: fortify early_idt_handlers definition

From: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>

The current definition is too brittle which makes it easy to screw things up
when modifying the code. Add some comments while at it.

Signed-off-by: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
---

diff -urNp linux-3.3-rc6-orig/arch/x86/include/asm/segment.h linux-3.3-rc6/arch/x86/include/asm/segment.h
--- linux-3.3-rc6-orig/arch/x86/include/asm/segment.h	2012-01-05 08:55:44.000000000 +0900
+++ linux-3.3-rc6/arch/x86/include/asm/segment.h	2012-03-09 17:50:40.965438325 +0900
@@ -210,8 +210,10 @@
 #define TLS_SIZE (GDT_ENTRY_TLS_ENTRIES * 8)
 
 #ifdef __KERNEL__
+#define EARLY_IDT_HANDLER_SIZE 16
 #ifndef __ASSEMBLY__
-extern const char early_idt_handlers[NUM_EXCEPTION_VECTORS][10];
+extern const char
+	early_idt_handlers[NUM_EXCEPTION_VECTORS][EARLY_IDT_HANDLER_SIZE];
 #endif
 #endif
 
diff -urNp linux-3.3-rc6-orig/arch/x86/kernel/head_64.S linux-3.3-rc6/arch/x86/kernel/head_64.S
--- linux-3.3-rc6-orig/arch/x86/kernel/head_64.S	2012-03-09 17:48:04.563492864 +0900
+++ linux-3.3-rc6/arch/x86/kernel/head_64.S	2012-03-09 18:06:13.329009305 +0900
@@ -272,11 +272,20 @@ bad_address:
 	.section ".init.text","ax"
 #ifdef CONFIG_EARLY_PRINTK
 	.globl early_idt_handlers
+	.align EARLY_IDT_HANDLER_SIZE
 early_idt_handlers:
 	i = 0
 	.rept NUM_EXCEPTION_VECTORS
 	movl $i, %esi
 	jmp early_idt_handler
+	/*
+	 * early_idt_handlers is treated as a
+	 * [NUM_EXCEPTION_VECTORS][EARLY_IDT_HANDLER_SIZE] array from C code
+	 * so we have to make sure that each handler fits in its
+	 * EARLY_IDT_HANDLER_SIZE bytes long slot. Handlers shorter than that
+	 * will be taken care of by the align directive below.
+	 */
+	.align EARLY_IDT_HANDLER_SIZE
 	i = i + 1
 	.endr
 #endif

--------------020409050107000907000903
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------020409050107000907000903--

