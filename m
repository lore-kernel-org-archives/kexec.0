Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt6DA-0002lk-1U
 for kexec@lists.infradead.org; Mon, 11 Feb 2019 07:41:05 +0000
Date: Mon, 11 Feb 2019 15:40:56 +0800
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 1/3] x86/boot: Add xloadflags bits for 5-level kernel
 checking
Message-ID: <20190211074056.GB2332@localhost>
References: <20190125022817.29506-1-bhe@redhat.com>
 <20190125022817.29506-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190125022817.29506-2-bhe@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, kexec@lists.infradead.org, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, mingo@kernel.org, kirill.shutemov@linux.intel.com

Add two bits XLF_5LEVEL and XLF_5LEVEL_ENABLED for 5-level kernel.
Bit XLF_5LEVEL indicates if 5-level related code is contained
in this kernel.
Bit XLF_5LEVEL_ENABLED indicates if CONFIG_X86_5LEVEL=y is set.

They are being used in later patch to check if kexec/kdump kernel
is loaded in right place.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
v1->v2:
  Change the wrong term in subject pointed out by tglx.

 arch/x86/boot/header.S                | 12 +++++++++++-
 arch/x86/include/uapi/asm/bootparam.h |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 850b8762e889..be19f4199727 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -419,7 +419,17 @@ xloadflags:
 # define XLF4 0
 #endif
 
-			.word XLF0 | XLF1 | XLF23 | XLF4
+#ifdef CONFIG_X86_64
+#ifdef CONFIG_X86_5LEVEL
+#define XLF56 (XLF_5LEVEL|XLF_5LEVEL_ENABLED)
+#else
+#define XLF56 XLF_5LEVEL
+#endif
+#else
+#define XLF56 0
+#endif
+
+			.word XLF0 | XLF1 | XLF23 | XLF4 | XLF56
 
 cmdline_size:   .long   COMMAND_LINE_SIZE-1     #length of the command line,
                                                 #added with boot protocol
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 60733f137e9a..c895df5482c5 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -29,6 +29,8 @@
 #define XLF_EFI_HANDOVER_32		(1<<2)
 #define XLF_EFI_HANDOVER_64		(1<<3)
 #define XLF_EFI_KEXEC			(1<<4)
+#define XLF_5LEVEL			(1<<5)
+#define XLF_5LEVEL_ENABLED		(1<<6)
 
 #ifndef __ASSEMBLY__
 
-- 
2.17.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
