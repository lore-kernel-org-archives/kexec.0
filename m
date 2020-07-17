Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwa65-0007aU-Pv
 for kexec@lists.infradead.org; Fri, 17 Jul 2020 23:49:01 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 4/4] ipconfig: cleanup printk usage
Date: Sat, 18 Jul 2020 01:54:18 +0206
Message-Id: <20200717234818.8622-5-john.ogness@linutronix.de>
In-Reply-To: <20200717234818.8622-1-john.ogness@linutronix.de>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
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
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

The use of pr_info() and pr_cont() was not ordered correctly for
all cases. Order it so that all cases provide the expected output.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 net/ipv4/ipconfig.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 561f15b5a944..0f4bd7a59310 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -1442,6 +1442,9 @@ static int __init ip_auto_config(void)
 #endif
 	int err;
 	unsigned int i;
+#ifndef IPCONFIG_SILENT
+	bool pr0;
+#endif
 
 	/* Initialise all name servers and NTP servers to NONE (but only if the
 	 * "ip=" or "nfsaddrs=" kernel command line parameters weren't decoded,
@@ -1575,31 +1578,37 @@ static int __init ip_auto_config(void)
 	if (ic_dev_mtu)
 		pr_cont(", mtu=%d", ic_dev_mtu);
 	/* Name servers (if any): */
+	pr0 = false;
 	for (i = 0; i < CONF_NAMESERVERS_MAX; i++) {
 		if (ic_nameservers[i] != NONE) {
-			if (i == 0)
+			if (!pr0) {
 				pr_info("     nameserver%u=%pI4",
 					i, &ic_nameservers[i]);
-			else
+				pr0 = true;
+			} else {
 				pr_cont(", nameserver%u=%pI4",
 					i, &ic_nameservers[i]);
+			}
 		}
-		if (i + 1 == CONF_NAMESERVERS_MAX)
-			pr_cont("\n");
 	}
+	if (pr0)
+		pr_cont("\n");
 	/* NTP servers (if any): */
+	pr0 = false;
 	for (i = 0; i < CONF_NTP_SERVERS_MAX; i++) {
 		if (ic_ntp_servers[i] != NONE) {
-			if (i == 0)
+			if (!pr0) {
 				pr_info("     ntpserver%u=%pI4",
 					i, &ic_ntp_servers[i]);
-			else
+				pr0 = true;
+			} else {
 				pr_cont(", ntpserver%u=%pI4",
 					i, &ic_ntp_servers[i]);
+			}
 		}
-		if (i + 1 == CONF_NTP_SERVERS_MAX)
-			pr_cont("\n");
 	}
+	if (pr0)
+		pr_cont("\n");
 #endif /* !SILENT */
 
 	/*
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
