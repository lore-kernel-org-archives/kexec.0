Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tb4mg-00068O-G5
 for kexec@lists.infradead.org; Wed, 21 Nov 2012 07:31:48 +0000
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v3 3/4] kexec,
 x86: set ext_cmd_line_ptr when boot_param is above 4g
Date: Tue, 20 Nov 2012 23:31:37 -0800
Message-Id: <1353483098-14883-4-git-send-email-yinghai@kernel.org>
In-Reply-To: <1353483098-14883-1-git-send-email-yinghai@kernel.org>
References: <1353483098-14883-1-git-send-email-yinghai@kernel.org>
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

update ext_cmd_line_ptr for bzImage from protocal 2.12
that could have command line above 4g.

-v2: update ext_... handling to the way that Eric likes.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 kexec/arch/i386/x86-linux-setup.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index 3c31f64..d12dab1 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -103,7 +103,12 @@ void setup_linux_bootloader_parameters(
 		/* setup_move_size */
 	/* } */
 	if (real_mode->protocol_version >= 0x0202) {
-		real_mode->cmd_line_ptr = real_mode_base + cmdline_offset;
+		unsigned long cmd_line_ptr = real_mode_base + cmdline_offset;
+
+		real_mode->cmd_line_ptr = cmd_line_ptr & 0xffffffffUL;
+		if ((real_mode->protocol_version >= 0x020c) &&
+		    ((cmd_line_ptr & 0xffffffffUL) != cmd_line_ptr))
+			real_mode->ext_cmd_line_ptr = cmd_line_ptr >> 32;
 	}
 
 	/* Fill in the command line */
-- 
1.7.7


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
