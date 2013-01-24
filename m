Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TyTf0-0004zy-J2
 for kexec@lists.infradead.org; Thu, 24 Jan 2013 20:44:38 +0000
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v7 2/7] kexec, x86: clean boot_params area for entry-32bit path
Date: Thu, 24 Jan 2013 12:44:19 -0800
Message-Id: <1359060264-10671-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359060264-10671-1-git-send-email-yinghai@kernel.org>
References: <1359060264-10671-1-git-send-email-yinghai@kernel.org>
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

kexec bzImage path setup data is shared with real-mode path, and
setup_header is copied together with setup_code.
Later 32bit just use whole area as boot_params for real_mode_data.
but those area for boot_params around setup_header is
not cleaned that will leave some field in boot_param as
non-zero value.

So clean around setup_header area for non real-mode entry path.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 kexec/arch/i386/kexec-bzImage.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index 0605909..4cc394d 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -98,6 +98,19 @@ void bzImage_usage(void)
        
 }
 
+static void clean_boot_params(unsigned char *real_mode, unsigned long size)
+{
+	unsigned long end;
+
+	/* clear value before header */
+	memset(real_mode, 0, 0x1f1);
+	/* clear value after setup_header  */
+	end = *(real_mode + 0x201);
+	end += 0x202;
+	if (end < size)
+		memset(real_mode + end, 0, size - end);
+}
+
 int do_bzImage_load(struct kexec_info *info,
 	const char *kernel, off_t kernel_len,
 	const char *command_line, off_t command_line_len,
@@ -212,6 +225,9 @@ int do_bzImage_load(struct kexec_info *info,
 	setup_size = kern16_size + command_line_len + PURGATORY_CMDLINE_SIZE;
 	real_mode = xmalloc(setup_size);
 	memcpy(real_mode, kernel, kern16_size);
+	if (!real_mode_entry)
+		clean_boot_params((unsigned char *)real_mode, kern16_size);
+	real_mode->xloadflags &= ~(1<<0); /* clear CAN_BE_LOADED_ABOVE_4G */
 
 	if (info->kexec_flags & (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)) {
 		/* If using bzImage for capture kernel, then we will not be
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
