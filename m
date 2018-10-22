Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gEggt-0002mT-ML
 for kexec@lists.infradead.org; Mon, 22 Oct 2018 20:20:45 +0000
Received: by mail-pl1-f193.google.com with SMTP id p5-v6so4666654plq.8
 for <kexec@lists.infradead.org>; Mon, 22 Oct 2018 13:20:32 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH] arm64: If 'getrandom' syscall fails,
 don't error out - just warn and proceed.
Date: Tue, 23 Oct 2018 01:50:20 +0530
Message-Id: <1540239620-29321-1-git-send-email-bhsharma@redhat.com>
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
To: kexec@lists.infradead.org
Cc: takahiro.akashi@linaro.org, bhsharma@redhat.com, bhupesh.linux@gmail.com, horms@verge.net.au

For calculating the random 'kaslr-seed' value to be passed to the
secondary kernel (kexec or kdump), we invoke the 'getrandom' syscall
inside 'setup_2nd_dtb()' function.

Normally on most arm64 systems this syscall doesn't fail when the
initrd scriptware (which arms kdump service) invokes the same.
However, recently I noticed that on the 'hp-moonshot' arm64 boards,
we have an issue with the newer kernels which causes the same
to fail. As a result, the kdump service fails and we are not able
to use the kdump infrastructure just after boot. As expected, once the
random pool is sufficiently populated and we launch the kdump service
arming scripts again (manually), then the kdump service is properly
enabled.

Lets handle the same, by not error'ing out if 'getrandom' syscall fails.
Rather lets warn the user and proceed further by setting the
'kaslr-seed' value as 0 for the secondary kernel - which implies that it
boots in a 'nokaslr' mode.

Tested on my 'hp-moonshot' and 'qualcomm-amberwing' arm64 boards.

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 kexec/arch/arm64/kexec-arm64.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 7a124795f3d0..b143e861f7d9 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -492,10 +492,21 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
 				GRND_NONBLOCK);
 
 		if(result == -1) {
-			dbgprintf("%s: Reading random bytes failed.\n",
+			fprintf(stderr, "%s: Reading random bytes failed.\n",
+					__func__);
+
+			/* Currently on some arm64 platforms this
+			 * 'getrandom' system call fails while booting
+			 * the platform.
+			 *
+			 * In case, this happens at best we can set
+			 * the 'kaslr_seed' as 0, indicating that the
+			 * 2nd kernel will be booted with a 'nokaslr'
+			 * like behaviour.
+			 */
+			fdt_val64 = 0UL;
+			dbgprintf("%s: Disabling KASLR in secondary kernel.\n",
 					__func__);
-			result = -EINVAL;
-			goto on_error;
 		}
 
 		nodeoffset = fdt_path_offset(new_buf, "/chosen");
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
