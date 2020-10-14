Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSd2a-0006T6-Pd
 for kexec@lists.infradead.org; Wed, 14 Oct 2020 09:25:49 +0000
From: Kairui Song <kasong@redhat.com>
Subject: [PATCH 2/2] hyperv_fb: Update screen_info after removing old
 framebuffer
Date: Wed, 14 Oct 2020 17:24:29 +0800
Message-Id: <20201014092429.1415040-3-kasong@redhat.com>
In-Reply-To: <20201014092429.1415040-1-kasong@redhat.com>
References: <20201014092429.1415040-1-kasong@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: Wei Liu <wei.liu@kernel.org>, Kairui Song <kasong@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kexec@lists.infradead.org, Haiyang Zhang <haiyangz@microsoft.com>, x86@kernel.org, Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "K. Y. Srinivasan" <kys@microsoft.com>, Dave Young <dyoung@redhat.com>, Ard Biesheuvel <ardb@kernel.org>

On gen2 HyperV VM, hyperv_fb will remove the old framebuffer, the
new allocated framebuffer address could be at a differnt location,
and it's no longer VGA framebuffer. Update screen_info
so that after kexec, kernel won't try to reuse the old invalid
framebuffer address as VGA.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 drivers/video/fbdev/hyperv_fb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 02411d89cb46..e36fb1a0ecdb 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1114,8 +1114,15 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 getmem_done:
 	remove_conflicting_framebuffers(info->apertures,
 					KBUILD_MODNAME, false);
-	if (!gen2vm)
+
+	if (gen2vm) {
+		/* framebuffer is reallocated, clear screen_info to avoid misuse from kexec */
+		screen_info.lfb_size = 0;
+		screen_info.lfb_base = 0;
+		screen_info.orig_video_isVGA = 0;
+	} else {
 		pci_dev_put(pdev);
+	}
 	kfree(info->apertures);
 
 	return 0;
-- 
2.28.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
