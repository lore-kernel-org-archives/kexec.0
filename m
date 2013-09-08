Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from ud10.udmedia.de ([194.117.254.50] helo=mail.ud10.udmedia.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VIdpK-00020P-5k
 for kexec@lists.infradead.org; Sun, 08 Sep 2013 12:10:50 +0000
Date: Sun, 8 Sep 2013 14:10:27 +0200
From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: [PATCH 1/3] kexec: get rid of late printk
Message-ID: <20130908121027.GB360@x4>
References: <20130908120947.GA360@x4>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130908120947.GA360@x4>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexdeucher@gmail.com>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>

kexec calls:
 printk(KERN_EMERG "Starting new kernel\n");
late before calling machine_shutdown().
However at this point the underlying fb device may have already been
shutdown. This causes the kernel to hang.
Fix by simply getting rid of the printk call.

Signed-off-by: Markus Trippelsdorf <markus@trippelsdorf.de>
---
 kernel/kexec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 59f7b55..f33fa9f 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1679,7 +1679,6 @@ int kernel_kexec(void)
 #endif
 	{
 		kernel_restart_prepare(NULL);
-		printk(KERN_EMERG "Starting new kernel\n");
 		machine_shutdown();
 	}
 
-- 
Markus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
