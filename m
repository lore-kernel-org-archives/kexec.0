Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gQ7lA-0006dz-A9
 for kexec@lists.infradead.org; Fri, 23 Nov 2018 09:28:25 +0000
From: Kairui Song <kasong@redhat.com>
Subject: [PATCH] x86: Clear isVGA flag if current fb driver is mimicking VGA
Date: Fri, 23 Nov 2018 17:28:01 +0800
Message-Id: <20181123092801.16411-1-kasong@redhat.com>
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
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, dyoung@redhat.com, Kairui Song <kasong@redhat.com>

Some device (eg. hyperv_fb) will mimic EFI (or VESA) VGA on first boot
up, but after the real driver is loaded, it will switch to new mode
and no longer compatible with EFI/VESA VGA. Keep setting
orig_video_isVGA to EFI/VESA VGA flag will get wrong driver loaded and
try to manipulate the framebuffer in a wrong way.

As we have already take care of "VESA VGA" and "EFI VGA", just set the
orig_video_isVGA to 0 for any other driver reports as EFI/VESA VGA but
is not EFI/VESA VGA.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 kexec/arch/i386/x86-linux-setup.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index dc785a2..a129812 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -152,6 +152,11 @@ static int setup_linux_vesafb(struct x86_linux_param_header *real_mode)
 		err = get_bootparam(&real_mode->orig_video_isVGA, offset, 1);
 		if (err)
 			goto out;
+
+		if (real_mode->orig_video_isVGA == 0x70 || real_mode->orig_video_isVGA == 0x23) {
+			/* Clear isVGA flag for fb drivers that mimic EFI/VESA VGA */
+			real_mode->orig_video_isVGA = 0;
+		}
 	}
 	close(fd);
 
-- 
2.19.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
