Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244])
 by casper.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eLguy-0007Mk-4l
 for kexec@lists.infradead.org; Mon, 04 Dec 2017 02:55:42 +0000
Received: by mail-pf0-x244.google.com with SMTP id m26so7464455pfj.11
 for <kexec@lists.infradead.org>; Sun, 03 Dec 2017 18:55:19 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v7 08/11] arm64: kexec_file: enable KEXEC_FILE config
Date: Mon,  4 Dec 2017 11:57:58 +0900
Message-Id: <20171204025801.12161-9-takahiro.akashi@linaro.org>
In-Reply-To: <20171204025801.12161-1-takahiro.akashi@linaro.org>
References: <20171204025801.12161-1-takahiro.akashi@linaro.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: catalin.marinas@arm.com, will.deacon@arm.com, bauerman@linux.vnet.ibm.com, dhowells@redhat.com, vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, akpm@linux-foundation.org, mpe@ellerman.id.au, dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org, julien.thierry@arm.com
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Modify arm64/Kconfig and Makefile to enable kexec_file_load support.
File-format specific hook functions to load a kernel image will
follow this patch.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a93339f5178f..865d110809f9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -794,6 +794,19 @@ config KEXEC
 	  but it is independent of the system firmware.   And like a reboot
 	  you can start any kernel with it, not just Linux.
 
+config KEXEC_FILE
+	bool "kexec file based system call"
+	select KEXEC_CORE
+	select BUILD_BIN2C
+	---help---
+	  This is new version of kexec system call. This system call is
+	  file based and takes file descriptors as system call argument
+	  for kernel and initramfs as opposed to list of segments as
+	  accepted by previous system call.
+
+	  In addition to this option, you need to enable a specific type
+	  of image support.
+
 config CRASH_DUMP
 	bool "Build kdump crash kernel"
 	help
-- 
2.14.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
