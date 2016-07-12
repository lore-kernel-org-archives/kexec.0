Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x231.google.com ([2607:f8b0:400e:c03::231])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bMmdx-0004iP-Dd
 for kexec@lists.infradead.org; Tue, 12 Jul 2016 01:37:51 +0000
Received: by mail-pa0-x231.google.com with SMTP id ks6so798883pab.0
 for <kexec@lists.infradead.org>; Mon, 11 Jul 2016 18:37:28 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 2/3] kexec: add dtb info to struct kimage
Date: Tue, 12 Jul 2016 10:42:00 +0900
Message-Id: <20160712014201.11456-3-takahiro.akashi@linaro.org>
In-Reply-To: <20160712014201.11456-1-takahiro.akashi@linaro.org>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
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
To: ebiederm@xmission.com, vgoyal@redhat.com, dyoung@redhat.com, bhe@redhat.com, bauerman@linux.vnet.ibm.com, arnd@arndb.de
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>

Device tree blob must be passed to a second kernel on DTB-capable
archs, like powerpc and arm64, but the current kernel interface
lacks this support.

This patch adds dtb buffer information to struct kimage.
When users don't specify dtb explicitly and the one used for the current
kernel can be re-used, this change will be good enough for implementing
kexec_file_load feature.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 include/linux/kexec.h | 3 +++
 kernel/kexec_file.c   | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index e8acb2b..554c848 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -190,6 +190,9 @@ struct kimage {
 	char *cmdline_buf;
 	unsigned long cmdline_buf_len;
 
+	void *dtb_buf;
+	unsigned long dtb_buf_len;
+
 	/* File operations provided by image loader */
 	struct kexec_file_ops *fops;
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 9891464..7278329 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -96,6 +96,11 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 		image->initrd_buf = NULL;
 	}
 
+	if (image->dtb_buf) {
+		vfree(image->dtb_buf);
+		image->dtb_buf = NULL;
+	}
+
 	if (image->cmdline_buf) {
 		kfree(image->cmdline_buf);
 		image->cmdline_buf = NULL;
-- 
2.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
