Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga06.intel.com ([134.134.136.21] helo=orsmga101.jf.intel.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1M2C3W-0008Sn-Bf
	for kexec@lists.infradead.org; Thu, 07 May 2009 22:27:13 +0000
From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: [PATCH 01/14] x86, boot: align the .bss section in the decompressor
Date: Thu,  7 May 2009 15:26:49 -0700
Message-Id: <1241735222-6640-2-git-send-email-hpa@linux.intel.com>
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

Aligning the .bss section makes it trivially faster, and makes using
larger transfers for the clear slightly easier.

[ Impact: trivial performance enhancement, future patch prep ]

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
---
 arch/x86/boot/compressed/vmlinux.lds.S |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 0d26c92..27c168d 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -42,6 +42,7 @@ SECTIONS
 		*(.data.*)
 		_edata = . ;
 	}
+	. = ALIGN(32);
 	.bss : {
 		_bss = . ;
 		*(.bss)
-- 
1.6.0.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
