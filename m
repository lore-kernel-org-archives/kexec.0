Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WroSI-0001Rc-Pe
 for kexec@lists.infradead.org; Tue, 03 Jun 2014 13:08:43 +0000
From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 02/13] kernel: Build bin2c based on config option
 CONFIG_BUILD_BIN2C
Date: Tue,  3 Jun 2014 09:06:51 -0400
Message-Id: <1401800822-27425-3-git-send-email-vgoyal@redhat.com>
In-Reply-To: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
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
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, jkosina@suse.cz, hpa@zytor.com, Vivek Goyal <vgoyal@redhat.com>, bp@alien8.de, ebiederm@xmission.com, greg@kroah.com, akpm@linux-foundation.org, dyoung@redhat.com, chaowang@redhat.com

currently bin2c builds only if CONFIG_IKCONFIG=y. But bin2c will now be
used by kexec too.  So make it compilation dependent on CONFIG_BUILD_BIN2C
and this config option can be selected by CONFIG_KEXEC and CONFIG_IKCONFIG.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 arch/x86/Kconfig       | 1 +
 init/Kconfig           | 5 +++++
 scripts/basic/Makefile | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 25d2c6f..213308a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1555,6 +1555,7 @@ source kernel/Kconfig.hz
 
 config KEXEC
 	bool "kexec system call"
+	select BUILD_BIN2C
 	---help---
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
diff --git a/init/Kconfig b/init/Kconfig
index 9d3585b..de59f0e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -773,8 +773,13 @@ endchoice
 
 endmenu # "RCU Subsystem"
 
+config BUILD_BIN2C
+	bool
+	default n
+
 config IKCONFIG
 	tristate "Kernel .config support"
+	select BUILD_BIN2C
 	---help---
 	  This option enables the complete Linux kernel ".config" file
 	  contents to be saved in the kernel. It provides documentation
diff --git a/scripts/basic/Makefile b/scripts/basic/Makefile
index afbc1cd..ec10d93 100644
--- a/scripts/basic/Makefile
+++ b/scripts/basic/Makefile
@@ -9,7 +9,7 @@
 # fixdep: 	 Used to generate dependency information during build process
 
 hostprogs-y	:= fixdep
-hostprogs-$(CONFIG_IKCONFIG)     += bin2c
+hostprogs-$(CONFIG_BUILD_BIN2C)     += bin2c
 always		:= $(hostprogs-y)
 
 # fixdep is needed to compile other host programs
-- 
1.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
