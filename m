Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by merlin.infradead.org with esmtp (Exim 4.85 #2 (Red Hat Linux))
 id 1aLqIl-0005wG-Tl
 for kexec@lists.infradead.org; Wed, 20 Jan 2016 10:47:49 +0000
Subject: [RFC PATCH 4/4] purgatory/ipmi: Add timeout logic to IPMI command
 processing
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Wed, 20 Jan 2016 19:37:42 +0900
Message-ID: <20160120103742.4234.12599.stgit@softrs>
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

If you enable the IPMI command issuing features and your BMC is
malfunctioning, you may loops indefinitely while processing IPMI
commands.  To guarantee that the second kernel starts to boot in
fixed seconds, this patch introduces a timeout for the total
processing time of IPMI commands.  The timeout is 5 seconds by
default.

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
---
 purgatory/ipmi.c |   65 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/purgatory/ipmi.c b/purgatory/ipmi.c
index 0acb853..f4a093a 100644
--- a/purgatory/ipmi.c
+++ b/purgatory/ipmi.c
@@ -1,6 +1,7 @@
 #include <sys/io.h>
 #include <purgatory.h>
 #include "../kexec/ipmi.h"
+#include "time.h"
 
 #define KCS_PORT_DEFAULT	0xca2
 #define KCS_PORT_DATA		(kcs_port + 0)
@@ -41,6 +42,8 @@ const unsigned char cmd_stop_wdt[] = {
 	0xff,
 };
 
+static struct timeout_info ipmi_to; /* Total timeout for IPMI operations */
+
 static inline unsigned char read_status(void)
 {
 	return inb(KCS_PORT_STATUS);
@@ -49,29 +52,50 @@ static inline unsigned char read_status(void)
 unsigned char wait_out(void)
 {
 	unsigned char status;
+	static int count = 0;
 
 	do {
+		count++;
+		if (count % 1024 == 0)
+			EXIT_ON_TIMEOUT(&ipmi_to, 1);
+
 		status = read_status();
 	} while ((status & KCS_STATUS_OBF) == 0);
 
 	return status;
+
+timed_out:
+	return 0xff;
 }
 
 unsigned char wait_in(void)
 {
 	unsigned char status;
+	static int count = 0;
 
 	do {
+		count++;
+		if (count % 1024 == 0)
+			EXIT_ON_TIMEOUT(&ipmi_to, 1);
+
 		status = read_status();
 	} while (status & KCS_STATUS_IBF);
 
 	return status;
+
+timed_out:
+	return 0xff;
 }
 
 unsigned char read_data(void)
 {
 	wait_out();
+	EXIT_ON_TIMEOUT(&ipmi_to, 0);
+
 	return inb(KCS_PORT_DATA);
+
+timed_out:
+	return 0xff;
 }
 
 void clear_obf(void)
@@ -105,12 +129,17 @@ int write_ipmi_cmd(const unsigned char *cmd, int size)
 	int i;
 
 	wait_in();
+	EXIT_ON_TIMEOUT(&ipmi_to, 0);
+
 	status = write_cmd(KCS_CMD_WRITE_START);
+	EXIT_ON_TIMEOUT(&ipmi_to, 0);
+
 	if (GET_STATUS_STATE(status) != KCS_WRITE_STATE)
 		return -1;
 
 	for (i = 0; i < size - 1; i++) {
 		status = write_data(cmd[i]);
+		EXIT_ON_TIMEOUT(&ipmi_to, 0);
 
 		if (GET_STATUS_STATE(status) != KCS_WRITE_STATE)
 			return -1;
@@ -118,12 +147,18 @@ int write_ipmi_cmd(const unsigned char *cmd, int size)
 
 	/* last write */
 	status = write_cmd(KCS_CMD_WRITE_END);
+	EXIT_ON_TIMEOUT(&ipmi_to, 0);
+
 	if (GET_STATUS_STATE(status) != KCS_WRITE_STATE)
 		return -1;
 
 	write_data(cmd[i]);
+	EXIT_ON_TIMEOUT(&ipmi_to, 0);
 
 	return 0;
+
+timed_out:
+	return -1;
 }
 
 /*
@@ -140,11 +175,17 @@ unsigned char read_result(void)
 
 	while (1) {
 		state = GET_STATUS_STATE(wait_in());
+		EXIT_ON_TIMEOUT(&ipmi_to, 0);
+
 		if (state == KCS_READ_STATE) {
 			data[count] = read_data();
+			EXIT_ON_TIMEOUT(&ipmi_to, 0);
+
 			outb(KCS_CMD_READ, KCS_PORT_DATA);
 		} else if (state == KCS_IDLE_STATE) {
 			data[count] = read_data();
+			EXIT_ON_TIMEOUT(&ipmi_to, 0);
+
 			break;
 		} else {
 			/*
@@ -164,6 +205,9 @@ unsigned char read_result(void)
 	}
 
 	return data[2]; /* Return completion code */
+
+timed_out:
+	return 0xff;
 }
 
 /*
@@ -190,15 +234,22 @@ int issue_ipmi_cmd(const unsigned char *cmd, int size)
 	 */
 	for (i = 0; i < 3; i++) {
 		ret = write_ipmi_cmd(cmd, size);
+		EXIT_ON_TIMEOUT(&ipmi_to, 0);
+
 		if (ret < 0)
 			continue;
 
 		comp_code = read_result();
+		EXIT_ON_TIMEOUT(&ipmi_to, 0);
+
 		if (comp_code == 0)
 			break; /* succeeded */
 	}
 
 	return (i < 3) ? 0 : -1;
+
+timed_out:
+	return -1;
 }
 
 int do_start_wdt(void)
@@ -207,7 +258,11 @@ int do_start_wdt(void)
 
 	printf("IPMI: starting watchdog timer...");
 	ret = issue_ipmi_cmd(cmd_start_wdt, sizeof(cmd_start_wdt));
-	printf("done\n");
+
+	if (ret == 0)
+		printf("done\n");
+	else
+		printf("failed\n");
 
 	return ret;
 }
@@ -218,13 +273,19 @@ int do_stop_wdt(void)
 
 	printf("IPMI: stopping watchdog timer...");
 	ret = issue_ipmi_cmd(cmd_stop_wdt, sizeof(cmd_stop_wdt));
-	printf("done\n");
+
+	if (ret == 0)
+		printf("done\n");
+	else
+		printf("failed\n");
 
 	return ret;
 }
 
 void ipmi_wdt_start_stop(void)
 {
+	init_timeout(&ipmi_to, 5);
+
 	if (ipmi_wdt & IPMI_WDT_START)
 		do_start_wdt();
 	else if (ipmi_wdt & IPMI_WDT_STOP)



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
