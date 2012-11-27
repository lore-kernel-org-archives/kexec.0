Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TdLze-0005Qs-P7
 for kexec@lists.infradead.org; Tue, 27 Nov 2012 14:18:35 +0000
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Save PG_compound or PG_head value in VMCOREINFO
Date: Tue, 27 Nov 2012 15:13:32 +0100
Message-ID: <3774326.lMtTTFYZT3@azariah.suse.cz>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

To allow filtering of huge pages, makedumpfile must be able to identify
them in the dump. This can be done by checking for the appropriate
page flag, so communicate its value to makedumpfile through the VMCOREINFO 
interface.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

---
 kernel/kexec.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1511,6 +1511,11 @@ static int __init crash_save_vmcoreinfo_
 	VMCOREINFO_NUMBER(NR_FREE_PAGES);
 	VMCOREINFO_NUMBER(PG_lru);
 	VMCOREINFO_NUMBER(PG_private);
+#ifdef CONFIG_PAGEFLAGS_EXTENDED
+	VMCOREINFO_NUMBER(PG_head);
+#else
+	VMCOREINFO_NUMBER(PG_compound);
+#endif
 	VMCOREINFO_NUMBER(PG_swapcache);
 
 	arch_crash_save_vmcoreinfo();


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
