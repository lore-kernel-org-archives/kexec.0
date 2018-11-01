Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gILqS-0005wc-Ry
 for kexec@lists.infradead.org; Thu, 01 Nov 2018 22:53:46 +0000
From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Subject: [PATCH] lockdown: allow kexec_file of unsigned images when not under
 lockdown
Date: Thu,  1 Nov 2018 19:53:16 -0300
Message-Id: <20181101225316.18112-1-cascardo@canonical.com>
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
To: David Howells <dhowells@redhat.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

If CONFIG_KEXEC_VERIFY_SIG is enabled, kexec -s with an unsigned image will
fail requiring an image signed with a trusted key. However, that same
kernel will allow kexec to load and boot a kernel, if kexec_file_load is
not used.

Now, lockdown brings a solution to this inconsistency. However, as it is,
it will still prevent an unsigned image to be loaded with kexec -s when the
system is not under lockdown, while still allowing kexec to work.

At the same time, with lockdown, kexec_file_load would still work when
CONFIG_KEXEC_VERIFY_SIG is disabled.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 kernel/kexec_file.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 35cf0ad29718..b64f32fda9ca 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -211,10 +211,17 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 					   image->kernel_buf_len);
 	if (ret) {
 		pr_debug("kernel signature verification failed.\n");
-		goto out;
+	} else {
+		pr_debug("kernel signature verification successful.\n");
 	}
-	pr_debug("kernel signature verification successful.\n");
+#elif
+	ret = -EPERM;
 #endif
+	if (ret && kernel_is_locked_down("kexec of unsigned images"))
+		goto out;
+	else
+		ret = 0;
+
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
 		ret = kernel_read_file_from_fd(initrd_fd, &image->initrd_buf,
-- 
2.19.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
