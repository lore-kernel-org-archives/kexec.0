Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U8jwB-0008Of-JZ
 for kexec@lists.infradead.org; Fri, 22 Feb 2013 04:08:44 +0000
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v9 3/7] kexec, x86: clean boot_params area for entry-32bit path
Date: Thu, 21 Feb 2013 20:07:52 -0800
Message-Id: <1361506076-13112-4-git-send-email-yinghai@kernel.org>
In-Reply-To: <1361506076-13112-1-git-send-email-yinghai@kernel.org>
References: <1361506076-13112-1-git-send-email-yinghai@kernel.org>
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

kexec bzImage path setup data is shared with real-mode path, and
setup_header is copied together with setup_code.
Later 32bit just use whole area as boot_params for real_mode_data.
but those area for boot_params around setup_header is
not cleaned that will leave some field in boot_param as
non-zero value.

So clean whole buffer at first, and only copy setup_header for non
real-mode entry path.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 kexec/arch/i386/kexec-bzImage.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index 83a023d..35005c7 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -211,7 +211,19 @@ int do_bzImage_load(struct kexec_info *info,
 	/* The argument/parameter segment */
 	setup_size = kern16_size + command_line_len + PURGATORY_CMDLINE_SIZE;
 	real_mode = xmalloc(setup_size);
-	memcpy(real_mode, kernel, kern16_size);
+	memset(real_mode, 0, setup_size);
+	if (!real_mode_entry) {
+		unsigned long setup_header_size = kernel[0x201] + 0x202 - 0x1f1;
+
+		/* only copy setup_header */
+		if (setup_header_size > 0x7f)
+			setup_header_size = 0x7f;
+		memcpy((unsigned char *)real_mode + 0x1f1, kernel + 0x1f1,
+			setup_header_size);
+	} else {
+		/* copy setup code and setup_header */
+		memcpy(real_mode, kernel, kern16_size);
+	}
 
 	if (info->kexec_flags & (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)) {
 		/* If using bzImage for capture kernel, then we will not be
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
