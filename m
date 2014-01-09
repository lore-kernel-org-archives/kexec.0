Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W17Ma-0001Vq-M6
 for kexec@lists.infradead.org; Thu, 09 Jan 2014 04:37:01 +0000
Date: Thu, 9 Jan 2014 12:36:30 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH v2] makedumpfile: -v shows if lzo or snappy support enabled
 or not
Message-ID: <20140109043630.GA25090@dhcp-17-89.nay.redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org, Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

It would be great to have makedumpfile -v to show if lzo or snappy
support is enabled or not, since --help prints too much and we have to
scroll back three screens to check it out.

For exmaple, If lzo and snappy support are enabled,

	$ ./makedumpfile -v
	makedumpfile: version 1.5.5 (released on 18 Dec 2013)
	lzo	enabled
	snappy	enabled

If both of them are disabled,

	$ ./makedumpfile -v
	makedumpfile: version 1.5.5 (released on 18 Dec 2013)
	lzo	disabled
	snappy	disabled

Signed-off-by: WANG Chao <chaowang@redhat.com>
---
 print_info.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/print_info.c b/print_info.c
index 90b6cee..ddaa642 100644
--- a/print_info.c
+++ b/print_info.c
@@ -26,6 +26,16 @@ void
 show_version(void)
 {
 	MSG("makedumpfile: version " VERSION " (released on " RELEASE_DATE ")\n");
+#ifdef USELZO
+	MSG("lzo\tenabled\n");
+#else
+	MSG("lzo\tdisabled\n");
+#endif
+#ifdef USESNAPPY
+	MSG("snappy\tenabled\n");
+#else
+	MSG("snappy\tdisabled\n");
+#endif
 	MSG("\n");
 }
 
-- 
1.8.4.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
