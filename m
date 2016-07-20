Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bPhic-0001D2-F5
 for kexec@lists.infradead.org; Wed, 20 Jul 2016 02:58:43 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 3/3] x86/apic: Clean up the apic delivery mode macro definition
Date: Wed, 20 Jul 2016 10:58:03 +0800
Message-Id: <1468983483-3952-4-git-send-email-bhe@redhat.com>
In-Reply-To: <1468983483-3952-1-git-send-email-bhe@redhat.com>
References: <1468983483-3952-1-git-send-email-bhe@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: fenghua.yu@intel.com, Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, weijg.fnst@cn.fujitsu.com, jiang.liu@linux.intel.com, vgoyal@redhat.com

Arch x86 use ICR to send IPI, and the delivery mode in ICR can be set.
They are defined like APIC_DM_xxxxx in arch/x86/include/asm/apicdef.h.
LVT table also includes a delivery mode field to set the type of
interrupt to be sent to processor, they are defined like APIC_MODE_xxxx.
And ExtINT can only be set for LVT LINT0/1, ICR can't use ExtINT either.

However the current code defines APIC_DM_EXTINT and mixed the usage of
it with APIC_MODE_EXTINT. Here clean it up.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/include/asm/apicdef.h | 1 -
 arch/x86/kernel/apic/apic.c    | 8 +++++---
 arch/x86/kernel/apic/io_apic.c | 7 +++++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/apicdef.h b/arch/x86/include/asm/apicdef.h
index c46bb99..cbca926 100644
--- a/arch/x86/include/asm/apicdef.h
+++ b/arch/x86/include/asm/apicdef.h
@@ -85,7 +85,6 @@
 #define		APIC_DM_NMI		0x00400
 #define		APIC_DM_INIT		0x00500
 #define		APIC_DM_STARTUP		0x00600
-#define		APIC_DM_EXTINT		0x00700
 #define		APIC_VECTOR_MASK	0x000FF
 #define	APIC_ICR2	0x310
 #define		GET_APIC_DEST_FIELD(x)	(((x) >> 24) & 0xFF)
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 9bb2770..7bf639d 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1163,7 +1163,8 @@ void __init init_bsp_APIC(void)
 	/*
 	 * Set up the virtual wire mode.
 	 */
-	apic_write(APIC_LVT0, APIC_DM_EXTINT);
+	value = SET_APIC_DELIVERY_MODE(0, APIC_MODE_EXTINT);
+	apic_write(APIC_LVT0, value);
 	value = APIC_DM_NMI;
 	if (!lapic_is_integrated())		/* 82489DX */
 		value |= APIC_LVT_LEVEL_TRIGGER;
@@ -1377,10 +1378,11 @@ void setup_local_APIC(void)
 	 */
 	value = apic_read(APIC_LVT0) & APIC_LVT_MASKED;
 	if (!cpu && (pic_mode || !value)) {
-		value = APIC_DM_EXTINT;
+		value = SET_APIC_DELIVERY_MODE(0, APIC_MODE_EXTINT);
 		apic_printk(APIC_VERBOSE, "enabled ExtINT on CPU#%d\n", cpu);
 	} else {
-		value = APIC_DM_EXTINT | APIC_LVT_MASKED;
+		value = SET_APIC_DELIVERY_MODE(0, APIC_MODE_EXTINT);
+		value = value | APIC_LVT_MASKED;
 		apic_printk(APIC_VERBOSE, "masked ExtINT on CPU#%d\n", cpu);
 	}
 	apic_write(APIC_LVT0, value);
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index f3f3abe..a911564 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2053,6 +2053,7 @@ static inline void __init check_timer(void)
 	int apic1, pin1, apic2, pin2;
 	unsigned long flags;
 	int no_pin1 = 0;
+	unsigned int value;
 
 	local_irq_save(flags);
 
@@ -2070,7 +2071,8 @@ static inline void __init check_timer(void)
 	 * The AEOI mode will finish them in the 8259A
 	 * automatically.
 	 */
-	apic_write(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_EXTINT);
+	value = SET_APIC_DELIVERY_MODE(0, APIC_MODE_EXTINT);
+	apic_write(APIC_LVT0, APIC_LVT_MASKED | value);
 	legacy_pic->init(1);
 
 	pin1  = find_isa_irq_pin(0, mp_INT);
@@ -2171,7 +2173,8 @@ static inline void __init check_timer(void)
 
 	legacy_pic->init(0);
 	legacy_pic->make_irq(0);
-	apic_write(APIC_LVT0, APIC_DM_EXTINT);
+	value = SET_APIC_DELIVERY_MODE(0, APIC_MODE_EXTINT);
+	apic_write(APIC_LVT0, value);
 
 	unlock_ExtINT_logic();
 
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
