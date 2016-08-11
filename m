Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bXz1u-00045D-P5
 for kexec@lists.infradead.org; Thu, 11 Aug 2016 23:04:53 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BN4ER9062118
 for <kexec@lists.infradead.org>; Thu, 11 Aug 2016 19:04:30 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24rtx3ksu9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 11 Aug 2016 19:04:29 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 11 Aug 2016 20:04:27 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v2 1/2] kexec: add dtb info to struct kimage
Date: Thu, 11 Aug 2016 20:03:57 -0300
In-Reply-To: <1470956638-3589-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1470956638-3589-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1470956638-3589-2-git-send-email-bauerman@linux.vnet.ibm.com>
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
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Mark Rutland <mark.rutland@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, David Laight <David.Laight@ACULAB.COM>, Eric Biederman <ebiederm@xmission.com>, Michael Ellerman <mpe@ellerman.id.au>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

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
 kernel/kexec_file.c   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index d7437777baaa..4f85d284ed0b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -192,6 +192,9 @@ struct kimage {
 	char *cmdline_buf;
 	unsigned long cmdline_buf_len;
 
+	void *dtb_buf;
+	unsigned long dtb_buf_len;
+
 	/* File operations provided by image loader */
 	struct kexec_file_ops *fops;
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 503bc2d348e5..113af2f219b9 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -92,6 +92,9 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	vfree(image->initrd_buf);
 	image->initrd_buf = NULL;
 
+	vfree(image->dtb_buf);
+	image->dtb_buf = NULL;
+
 	kfree(image->cmdline_buf);
 	image->cmdline_buf = NULL;
 
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
