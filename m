Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnlYY-008UIb-Ta
 for kexec@lists.infradead.org; Thu, 18 Nov 2021 17:50:44 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [RFC v1 6/8] crash hp: Add x86 crash hotplug state items to kimage
Date: Thu, 18 Nov 2021 12:49:46 -0500
Message-Id: <20211118174948.37435-7-eric.devolder@oracle.com>
In-Reply-To: <20211118174948.37435-1-eric.devolder@oracle.com>
References: <20211118174948.37435-1-eric.devolder@oracle.com>
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
To: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com, dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de, rppt@kernel.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, eric.devolder@oracle.com

To facilitate hotplug updates of the crash elfcorehdr, a few members
are added to the kimage arch struct.

The indices of the elfcorehdr and purgatory segments are recorded
here so that upon a hotplug event, those segments can be efficiently
located and updated accordingly.

The purgatory image also requires a few register context values in
order to transition from purgatory to the next/capture kernel.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/include/asm/kexec.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 11b7c06e2828..b08fe56239c8 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -150,6 +150,16 @@ struct kimage_arch {
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+#ifdef CONFIG_CRASH_HOTPLUG
+	struct {
+		int elf_index;
+		int purg_index;
+		unsigned long rbx;
+		unsigned long rsi;
+		unsigned long rip;
+		unsigned long rsp;
+	} hp;
+#endif
 };
 #endif /* CONFIG_X86_32 */
 
-- 
2.27.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
