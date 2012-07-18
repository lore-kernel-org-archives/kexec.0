Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SrXtC-0002a0-Vw
 for kexec@lists.infradead.org; Wed, 18 Jul 2012 17:18:20 +0000
Date: Wed, 18 Jul 2012 13:18:12 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH] printk: Export struct log size and member offsets through
 vmcoreinfo
Message-ID: <20120718171812.GC21746@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Kay Sievers <kay@vrfy.org>, Andrew Morton <akpm@linux-foundation.org>, Kexec Mailing List <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>

There are tools like makedumpfile and vmcore-dmesg which can extract
kernel log buffer from vmcore. Since we introduced structured logging,
that functionality is broken. Now user space tools need to know about
"struct log" and offsets of various fields to be able to parse struct
log data and extract text message or dictonary.

This patch exports some of the fields.

Currently I am not exporting log "level" info as that is a bitfield and
offsetof() bitfields can't be calculated. But if people start asking for
log level info in the output then we probably either need to seprate
out "level" or use bit shift operations for flags and level.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 kernel/printk.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux-2.6/kernel/printk.c
===================================================================
--- linux-2.6.orig/kernel/printk.c	2012-07-20 14:02:38.213581253 -0400
+++ linux-2.6/kernel/printk.c	2012-07-20 14:02:42.004581438 -0400
@@ -646,6 +646,15 @@ void log_buf_kexec_setup(void)
 	VMCOREINFO_SYMBOL(log_buf_len);
 	VMCOREINFO_SYMBOL(log_first_idx);
 	VMCOREINFO_SYMBOL(log_next_idx);
+	/*
+	 * Export struct log size and field offsets. User space tools can
+	 * parse it and detect any changes to structure down the line.
+	 */
+	VMCOREINFO_STRUCT_SIZE(log);
+	VMCOREINFO_OFFSET(log, ts_nsec);
+	VMCOREINFO_OFFSET(log, len);
+	VMCOREINFO_OFFSET(log, text_len);
+	VMCOREINFO_OFFSET(log, dict_len);
 }
 #endif
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
