Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f6gt1-0003IV-Jw
 for kexec@lists.infradead.org; Thu, 12 Apr 2018 18:23:57 +0000
Subject: [PATCH v1 2/2] kexec: Remove "weak" from arch_kexec_walk_mem()
 declaration
From: Bjorn Helgaas <helgaas@kernel.org>
Date: Thu, 12 Apr 2018 13:23:43 -0500
Message-ID: <152355742351.36693.10357998251441779301.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152355706051.36693.9856090891621551967.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152355706051.36693.9856090891621551967.stgit@bhelgaas-glaptop.roam.corp.google.com>
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
To: Eric Biederman <ebiederm@xmission.com>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Weak header file declarations are error-prone because they make every
definition weak, and the linker chooses one based on link order (see
10629d711ed7 ("PCI: Remove __weak annotation from pcibios_get_phb_of_node
decl")).

kernel/kexec_file.c contains a weak definition of arch_kexec_walk_mem() and
arch/powerpc/kernel/machine_kexec_file_64.c contains a definition intended
to be non-weak.  But the annotation in the header file makes *both*
definitions weak, so it's unclear which one will be used.

Remove the "weak" attribute from the declaration so we always prefer a
non-weak definition over the weak one.

Fixes: 60fe3910bb02 ("kexec_file: Allow arch-specific memory walking for kexec_add_buffer")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: stable@vger.kernel.org      # v4.10+
---
 include/linux/kexec.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 8bf0ff90885c..e7db550c5fb6 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -159,8 +159,8 @@ struct kexec_buf {
 	bool top_down;
 };
 
-int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
-			       int (*func)(struct resource *, void *));
+int arch_kexec_walk_mem(struct kexec_buf *kbuf,
+			int (*func)(struct resource *, void *));
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
 int kexec_locate_mem_hole(struct kexec_buf *kbuf);
 #endif /* CONFIG_KEXEC_FILE */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
