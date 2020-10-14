Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSd2V-0006S6-US
 for kexec@lists.infradead.org; Wed, 14 Oct 2020 09:25:44 +0000
From: Kairui Song <kasong@redhat.com>
Subject: [PATCH 1/2] x86/kexec: Use up-to-dated screen_info copy to fill boot
 params
Date: Wed, 14 Oct 2020 17:24:28 +0800
Message-Id: <20201014092429.1415040-2-kasong@redhat.com>
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

kexec_file_load now just reuse the old boot_params.screen_info.
But if drivers have change the hardware state, boot_param.screen_info
could contain invalid info.

For example, the video type might be no longer VGA, or frame buffer
address changed. If kexec kernel keep using the old screen_info,
kexec'ed kernel may attempt to write to an invalid framebuffer
memory region.

There are two screen_info globally available, boot_params.screen_info
and screen_info. Later one is a copy, and could be updated by drivers.

So let kexec_file_load use the updated copy.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 57c2ecf43134..ce831f9448e7 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -200,8 +200,7 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 	params->hdr.hardware_subarch = boot_params.hdr.hardware_subarch;
 
 	/* Copying screen_info will do? */
-	memcpy(&params->screen_info, &boot_params.screen_info,
-				sizeof(struct screen_info));
+	memcpy(&params->screen_info, &screen_info, sizeof(struct screen_info));
 
 	/* Fill in memsize later */
 	params->screen_info.ext_mem_k = 0;
-- 
2.28.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
