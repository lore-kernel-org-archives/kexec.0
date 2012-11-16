Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZUxm-0005n6-Cg
 for kexec@lists.infradead.org; Fri, 16 Nov 2012 23:04:45 +0000
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 7/8] x86: put ramdisk high for 64bit bzImage
Date: Fri, 16 Nov 2012 15:04:26 -0800
Message-Id: <1353107067-14564-8-git-send-email-yinghai@kernel.org>
In-Reply-To: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
References: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
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
To: Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org

only do that for 64bit bzImage, and will fall back to low if fail to get high.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 kexec/arch/i386/x86-linux-setup.c |   30 ++++++++++++++++++++++--------
 1 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index 53d9df9..b0e6119 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -69,20 +69,34 @@ void setup_linux_bootloader_parameters(
 	}
 
 	/* Load the initrd if we have one */
+	initrd_base = 0;
 	if (initrd_buf) {
-		initrd_base = add_buffer(info,
-			initrd_buf, initrd_size, initrd_size,
-			4096, INITRD_BASE, initrd_addr_max, -1);
+		if (real_mode->protocol_version >= 0x020c &&
+		    real_mode->code64_start_offset) {
+			initrd_base = add_buffer(info,
+				initrd_buf, initrd_size, initrd_size,
+				4096, 1UL<<32, ULONG_MAX, -1);
+			if (!initrd_base)
+				initrd_base = add_buffer(info,
+					initrd_buf, initrd_size, initrd_size,
+					4096, 1UL<<30, 1UL<<32, -1);
+		}
+		if (!initrd_base)
+			initrd_base = add_buffer(info,
+				initrd_buf, initrd_size, initrd_size,
+				4096, INITRD_BASE, initrd_addr_max, -1);
 		dbgprintf("Loaded initrd at 0x%lx size 0x%lx\n", initrd_base,
 			initrd_size);
-	} else {
-		initrd_base = 0;
+	} else
 		initrd_size = 0;
-	}
 
 	/* Ramdisk address and size */
-	real_mode->initrd_start = initrd_base;
-	real_mode->initrd_size  = initrd_size;
+	real_mode->initrd_start = initrd_base & 0xffffffff;
+	real_mode->initrd_size  = initrd_size & 0xffffffff;
+	if ((initrd_base + initrd_size) > (1ULL<<32)) {
+		real_mode->ext_ramdisk_image = initrd_base >> 32;
+		real_mode->ext_ramdisk_size  = initrd_size >> 32;
+	}
 
 	/* The location of the command line */
 	/* if (real_mode_base == 0x90000) { */
-- 
1.7.7


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
