Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by casper.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aLqIl-0000Fp-JL
 for kexec@lists.infradead.org; Wed, 20 Jan 2016 10:47:49 +0000
Subject: [RFC PATCH 3/4] purgatory/x86: Support CMOS RTC
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Wed, 20 Jan 2016 19:37:40 +0900
Message-ID: <20160120103740.4234.84157.stgit@softrs>
In-Reply-To: <20160120103734.4234.64015.stgit@softrs>
References: <20160120103734.4234.64015.stgit@softrs>
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
To: Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, Corey Minyard <minyard@acm.org>

Support CMOS RTC based on MC148618A RTC by overriding get_unix_time()
function.  This is needed for the timeout API previously added.

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
---
 purgatory/arch/i386/Makefile   |    1 
 purgatory/arch/i386/rtc_cmos.c |  104 ++++++++++++++++++++++++++++++++++++++++
 purgatory/arch/x86_64/Makefile |    1 
 3 files changed, 106 insertions(+)
 create mode 100644 purgatory/arch/i386/rtc_cmos.c

diff --git a/purgatory/arch/i386/Makefile b/purgatory/arch/i386/Makefile
index 1532219..cb77328 100644
--- a/purgatory/arch/i386/Makefile
+++ b/purgatory/arch/i386/Makefile
@@ -13,6 +13,7 @@ i386_PURGATORY_SRCS += purgatory/arch/i386/console-x86.c
 i386_PURGATORY_SRCS += purgatory/arch/i386/vga.c
 i386_PURGATORY_SRCS += purgatory/arch/i386/pic.c
 i386_PURGATORY_SRCS += purgatory/arch/i386/crashdump_backup.c
+i386_PURGATORY_SRCS += purgatory/arch/i386/rtc_cmos.c
 
 dist += purgatory/arch/i386/Makefile $(i386_PURGATORY_SRCS)	\
 	purgatory/arch/i386/purgatory-x86.h			\
diff --git a/purgatory/arch/i386/rtc_cmos.c b/purgatory/arch/i386/rtc_cmos.c
new file mode 100644
index 0000000..3dbbd01
--- /dev/null
+++ b/purgatory/arch/i386/rtc_cmos.c
@@ -0,0 +1,104 @@
+#include <sys/io.h>
+#include "time.h"
+
+#define CMOS_PORT0		0x70
+#define  CMOS_NMI_DISABLE	0x80
+#define CMOS_PORT1		0x71
+
+#define RTC_SECONDS		0x00
+#define RTC_MINUTES		0x02
+#define RTC_HOURS		0x04
+#define RTC_DAY			0x07
+#define RTC_MONTH		0x08
+#define RTC_YEAR		0x09
+
+#define RTC_REGA		0x0a
+#define  RTC_UIP		0x80
+#define RTC_REGB		0x0b
+#define  RTC_HOURFORM		0x02
+#define  RTC_DM			0x04
+
+static int is_bcd;	/* 1 if the Data Mode is BCD */
+static int is_12hr;	/* 1 if the Hour Format is 12-hr mode */
+
+unsigned char read_cmos(int idx)
+{
+	static unsigned char nmi_disable_bit = 0xff;
+
+	/* Preserve NMI Disable bit at the first time */
+	if (nmi_disable_bit == 0xff)
+		nmi_disable_bit = inb(CMOS_PORT0) & CMOS_NMI_DISABLE;
+
+	outb(nmi_disable_bit | (idx & 0x7f), CMOS_PORT0);
+
+	return inb(CMOS_PORT1);
+}
+
+/**
+ * Return UNIX-epoch time.
+ *
+ * If the RTC is about to be updated (UIP bit is set), this function wait
+ * for that.  It takes at most 2228us with MC146818A RTC according to
+ * the specification.  Modern MC146818A-compatible RTCs in chipset will work
+ * faster, but not so much.  So you shouldn't call this function too often.
+ */
+time64_t get_unix_time(void)
+{
+	static int is_first_time = 1;
+	unsigned char byte;
+	int ss, mm, hh;
+	int day, mon, year;
+	int is_pm;
+
+	/* Check the modes at the first time. */
+	if (is_first_time) {
+		byte = read_cmos(RTC_REGB);
+		if (!(byte & RTC_DM))
+			is_bcd = 1;
+
+		if (!(byte & RTC_HOURFORM))
+			is_12hr = 1;
+
+		is_first_time = 0;
+	}
+
+ 	/* Wait for the clock update to be done if it is in progress */
+	do {
+		byte = read_cmos(RTC_REGA);
+	} while (byte & RTC_UIP);
+
+
+	/*
+	 * Now, we have 244us at least until the clock update will start.
+	 */
+	ss = read_cmos(RTC_SECONDS);
+	mm = read_cmos(RTC_MINUTES);
+	hh = read_cmos(RTC_HOURS);
+	day = read_cmos(RTC_DAY);
+	mon = read_cmos(RTC_MONTH);
+	year = read_cmos(RTC_YEAR);
+
+	/* If the RTC is in 12-hr mode, bit-7 of HOUR byte indicates PM. */
+	is_pm = (hh & 0x80);
+	hh &= 0x7f; /* drop AM/PM bit */
+
+	if (is_bcd) {
+		ss = (ss >> 4) * 10 + (ss & 0xf);
+		mm = (mm >> 4) * 10 + (mm & 0xf);
+		hh = (hh >> 4) * 10 + (hh & 0xf);
+		day = (day >> 4) * 10 + (day & 0xf);
+		mon = (mon >> 4) * 10 + (mon & 0xf);
+		year = (year >> 4) * 10 + (year & 0xf) +
+			2000; /* FIXME? */
+	}
+
+	if (is_12hr) {
+		if (is_pm && hh != 12)
+			hh += 12;
+
+		if (!is_pm && hh == 12)
+			hh = 0;
+	}
+
+	return date2unix(year, mon, day, hh, mm, ss);
+}
diff --git a/purgatory/arch/x86_64/Makefile b/purgatory/arch/x86_64/Makefile
index 7300937..bca1f71 100644
--- a/purgatory/arch/x86_64/Makefile
+++ b/purgatory/arch/x86_64/Makefile
@@ -22,5 +22,6 @@ x86_64_PURGATORY_SRCS += purgatory/arch/i386/crashdump_backup.c
 x86_64_PURGATORY_SRCS += purgatory/arch/i386/console-x86.c
 x86_64_PURGATORY_SRCS += purgatory/arch/i386/vga.c
 x86_64_PURGATORY_SRCS += purgatory/arch/i386/pic.c
+x86_64_PURGATORY_SRCS += purgatory/arch/i386/rtc_cmos.c
 
 x86_64_PURGATORY_EXTRA_CFLAGS = -mcmodel=large



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
