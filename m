Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmp6r-000DDL-QF
 for kexec@lists.infradead.org; Tue, 16 Nov 2021 03:26:15 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 1/2] s390/kexec: check the return value of ipl_report_finish
Date: Tue, 16 Nov 2021 11:25:56 +0800
Message-Id: <20211116032557.14075-1-bhe@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, kexec@lists.infradead.org, hca@linux.ibm.com, prudo@redhat.com, Baoquan He <bhe@redhat.com>

In function ipl_report_finish(), it could fail by memory allocation
failure, so check the return value to handle the case.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/s390/include/asm/ipl.h           | 2 +-
 arch/s390/kernel/ipl.c                | 6 ++++--
 arch/s390/kernel/machine_kexec_file.c | 5 ++++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/ipl.h b/arch/s390/include/asm/ipl.h
index 3f8ee257f9aa..864ab5d2890c 100644
--- a/arch/s390/include/asm/ipl.h
+++ b/arch/s390/include/asm/ipl.h
@@ -122,7 +122,7 @@ struct ipl_report_certificate {
 
 struct kexec_buf;
 struct ipl_report *ipl_report_init(struct ipl_parameter_block *ipib);
-void *ipl_report_finish(struct ipl_report *report);
+int ipl_report_finish(struct ipl_report *report, void **ipl_buf);
 int ipl_report_free(struct ipl_report *report);
 int ipl_report_add_component(struct ipl_report *report, struct kexec_buf *kbuf,
 			     unsigned char flags, unsigned short cert);
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index e2cc35775b99..a0af0b23148d 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -2144,7 +2144,7 @@ struct ipl_report *ipl_report_init(struct ipl_parameter_block *ipib)
 	return report;
 }
 
-void *ipl_report_finish(struct ipl_report *report)
+int ipl_report_finish(struct ipl_report *report, void **ipl_buf)
 {
 	struct ipl_report_certificate *cert;
 	struct ipl_report_component *comp;
@@ -2195,7 +2195,9 @@ void *ipl_report_finish(struct ipl_report *report)
 	}
 
 	BUG_ON(ptr > buf + report->size);
-	return buf;
+	*ipl_buf = buf;
+
+	return 0;
 }
 
 int ipl_report_free(struct ipl_report *report)
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 528edff085d9..17e961975624 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -170,6 +170,7 @@ static int kexec_file_add_ipl_report(struct kimage *image,
 	struct kexec_buf buf;
 	unsigned long addr;
 	void *ptr, *end;
+	int ret;
 
 	buf.image = image;
 
@@ -199,7 +200,9 @@ static int kexec_file_add_ipl_report(struct kimage *image,
 		ptr += len;
 	}
 
-	buf.buffer = ipl_report_finish(data->report);
+	ret = ipl_report_finish(data->report, &buf.buffer);
+	if (ret)
+		return ret;
 	buf.bufsz = data->report->size;
 	buf.memsz = buf.bufsz;
 
-- 
2.17.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
