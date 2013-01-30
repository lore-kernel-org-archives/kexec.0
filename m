Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U0f9p-0005zv-O4
 for kexec@lists.infradead.org; Wed, 30 Jan 2013 21:25:26 +0000
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v8 1/7] kexec, x86: set booloader id in setup_header
Date: Wed, 30 Jan 2013 13:25:14 -0800
Message-Id: <1359581120-24397-2-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359581120-24397-1-git-send-email-yinghai@kernel.org>
References: <1359581120-24397-1-git-send-email-yinghai@kernel.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org

set LOADER_TYPE_KEXEC

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 include/x86/x86-linux.h           |    1 +
 kexec/arch/i386/x86-linux-setup.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/x86/x86-linux.h b/include/x86/x86-linux.h
index 8f7a797..ea11042 100644
--- a/include/x86/x86-linux.h
+++ b/include/x86/x86-linux.h
@@ -142,6 +142,7 @@ struct x86_linux_param_header {
 #define LOADER_TYPE_BOOTSECT_LOADER 2
 #define LOADER_TYPE_SYSLINUX        3
 #define LOADER_TYPE_ETHERBOOT       4
+#define LOADER_TYPE_KEXEC           0x0D
 #define LOADER_TYPE_UNKNOWN         0xFF
 	uint8_t  loader_flags;			/* 0x211 */
 	uint8_t  reserved12[2];			/* 0x212 */
diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index ef62553..d09c6ce 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -56,7 +56,7 @@ void setup_linux_bootloader_parameters(
 	unsigned long initrd_base, initrd_addr_max;
 
 	/* Say I'm a boot loader */
-	real_mode->loader_type = LOADER_TYPE_UNKNOWN;
+	real_mode->loader_type = LOADER_TYPE_KEXEC << 4;
 
 	/* No loader flags */
 	real_mode->loader_flags = 0;
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
