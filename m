Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KJbdi-0001cu-5B
	for kexec@lists.infradead.org; Thu, 17 Jul 2008 22:07:54 +0000
Date: Fri, 18 Jul 2008 00:07:45 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: kdump: Report actual value of VMCOREINFO_OSRELEASE in VMCOREINFO
Message-ID: <20080718000745.51d32607@kopernikus.site>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, vgoyal@redhat.com

The current implementation reports the structure name as
VMCOREINFO_OSRELEASE in VMCOREINFO, e.g.

        VMCOREINFO_OSRELEASE=init_uts_ns.name.release

That doesn't make sense because it's always the same. Instead, use the
value, e.g.

        VMCOREINFO_OSRELEASE=2.6.26-rc3

That's also what the 'makedumpfile -g' does.

Signed-off-by: Bernhard Walle <bwalle@suse.de>

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 3265968..3c7784d 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -127,8 +127,8 @@ void vmcoreinfo_append_str(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 unsigned long paddr_vmcoreinfo_note(void);
 
-#define VMCOREINFO_OSRELEASE(name) \
-	vmcoreinfo_append_str("OSRELEASE=%s\n", #name)
+#define VMCOREINFO_OSRELEASE(value) \
+	vmcoreinfo_append_str("OSRELEASE=%s\n", value)
 #define VMCOREINFO_PAGESIZE(value) \
 	vmcoreinfo_append_str("PAGESIZE=%ld\n", value)
 #define VMCOREINFO_SYMBOL(name) \

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
