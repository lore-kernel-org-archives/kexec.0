Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga06.intel.com ([134.134.136.21] helo=orsmga101.jf.intel.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1M2C3v-0008TS-7i
	for kexec@lists.infradead.org; Thu, 07 May 2009 22:27:38 +0000
From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: [PATCH 06/14] x86: add a Kconfig symbol for when relocations are
	needed
Date: Thu,  7 May 2009 15:26:54 -0700
Message-Id: <1241735222-6640-7-git-send-email-hpa@linux.intel.com>
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

We only need to build relocations when we are building a 32-bit
relocatable kernel.  Rather than unnecessarily complicating the
Makefiles, make an explicit Kbuild symbol for this.

[ Impact: permits future cleanup ]

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 arch/x86/Kconfig |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 13b3a5a..cd76de1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1516,6 +1516,11 @@ config RELOCATABLE
 	  it has been loaded at and the compile time physical address
 	  (CONFIG_PHYSICAL_START) is ignored.
 
+# Relocation on x86-32 needs some additional build support
+config X86_NEED_RELOCS
+	def_bool y
+	depends on X86_32 && RELOCATABLE
+
 config PHYSICAL_ALIGN
 	hex
 	prompt "Alignment value to which kernel should be aligned" if X86_32
-- 
1.6.0.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
