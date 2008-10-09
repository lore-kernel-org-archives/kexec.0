Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58] helo=smtp.tuxdriver.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KnxLb-0002gB-Ku
	for kexec@lists.infradead.org; Thu, 09 Oct 2008 15:22:39 +0000
Date: Thu, 9 Oct 2008 11:20:27 -0400
From: Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH] add additional symbols to /sys/kernel/vmcoreinfo data for
	ppc(64)
Message-ID: <20081009151408.GA25268@hmsendeavour.rdu.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, vgoyal@redhat.com, hbabu@us.ibm.com
Cc: nhorman@tuxdriver.com

Hey-
	The makdumpdile dump filtering program, in some modes of operation needs
the node_data and/or contig_page_data symbols to function properly.  These
symbols are missing from the powerpc kernel.  This patch adds those symbols in
properly.  Tested successfully by myself and the reporter.

Regards
Neil

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>


 machine_kexec.c |   10 ++++++++++
 1 file changed, 10 insertions(+)


diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index aab7688..2f9b5aa 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -44,6 +44,16 @@ void machine_kexec_cleanup(struct kimage *image)
 		ppc_md.machine_kexec_cleanup(image);
 }
 
+void arch_crash_save_vmcoreinfo(void)
+{
+#ifdef CONFIG_NEED_MULTIPLE_NODES
+	VMCOREINFO_SYMBOL(node_data);
+	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
+#else
+	VMCOREINFO_SYMBOL(contig_page_data);
+#endif
+}
+
 /*
  * Do not allocate memory (or fail in any way) in machine_kexec().
  * We are past the point of no return, committed to rebooting now.
-- 
/***************************************************
 *Neil Horman
 *nhorman@tuxdriver.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
