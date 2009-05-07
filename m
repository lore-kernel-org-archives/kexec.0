Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga06.intel.com ([134.134.136.21] helo=orsmga101.jf.intel.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1M2C49-0008Sn-TV
	for kexec@lists.infradead.org; Thu, 07 May 2009 22:27:53 +0000
From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: [PATCH 12/14] x86, boot: zero EFLAGS on 32 bits
Date: Thu,  7 May 2009 15:27:00 -0700
Message-Id: <1241735222-6640-13-git-send-email-hpa@linux.intel.com>
In-Reply-To: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
References: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, kexec@lists.infradead.org, hbabu@us.ibm.com, ebiederm@xmission.com, ying.huang@intel.com, mingo@elte.hu, sam@ravnborg.org, tglx@linutronix.de, vgoyal@redhat.com

From: H. Peter Anvin <hpa@zytor.com>

The 64-bit code already clears EFLAGS as soon as it has a stack.  This
seems like a reasonable precaution, so do it on 32 bits as well.

[ Impact: extra paranoia ]

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
---
 arch/x86/boot/compressed/head_32.S |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 47636b3..48c2047 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -12,9 +12,9 @@
  * the page directory. [According to comments etc elsewhere on a compressed
  * kernel it will end up at 0x1000 + 1Mb I hope so as I assume this. - AC]
  *
- * Page 0 is deliberately kept safe, since System Management Mode code in 
+ * Page 0 is deliberately kept safe, since System Management Mode code in
  * laptops may need to access the BIOS data stored there.  This is also
- * useful for future device drivers that either access the BIOS via VM86 
+ * useful for future device drivers that either access the BIOS via VM86
  * mode.
  */
 
@@ -84,6 +84,12 @@ ENTRY(startup_32)
 	leal boot_stack_end(%ebx), %esp
 
 /*
+ * Zero EFLAGS
+ */
+	pushl $0
+	popfl
+
+/*
  * Copy the compressed kernel to the end of our buffer
  * where decompression in place becomes safe.
  */
-- 
1.6.0.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
