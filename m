Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1bCpot-0007Hd-8Z
 for kexec@lists.infradead.org; Tue, 14 Jun 2016 14:59:59 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5EEsVkT042060
 for <kexec@lists.infradead.org>; Tue, 14 Jun 2016 10:59:38 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23je2ke1uf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 14 Jun 2016 10:59:35 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 14 Jun 2016 11:59:33 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id A31BA352005C
 for <kexec@lists.infradead.org>; Tue, 14 Jun 2016 10:59:14 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5EExUQc25755968
 for <kexec@lists.infradead.org>; Tue, 14 Jun 2016 11:59:30 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5EExUle017697
 for <kexec@lists.infradead.org>; Tue, 14 Jun 2016 11:59:30 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v2 1/9] kexec_file: Remove unused members from struct
 kexec_buf.
Date: Tue, 14 Jun 2016 11:59:01 -0300
In-Reply-To: <1465916349-3398-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1465916349-3398-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1465916349-3398-2-git-send-email-bauerman@linux.vnet.ibm.com>
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
To: linuxppc-dev@lists.ozlabs.org
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>

kexec_add_buffer uses kexec_buf.buffer and kexec_buf.bufsz to pass along
its own arguments buffer and bufsz, but since they aren't used anywhere
else, it's pointless.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Dave Young <dyoung@redhat.com>
---
 kernel/kexec_file.c     | 6 ++----
 kernel/kexec_internal.h | 2 --
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 01ab82a40d22..b6eec7527e9f 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -464,8 +464,6 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
 	memset(&buf, 0, sizeof(struct kexec_buf));
 	kbuf = &buf;
 	kbuf->image = image;
-	kbuf->buffer = buffer;
-	kbuf->bufsz = bufsz;
 
 	kbuf->memsz = ALIGN(memsz, PAGE_SIZE);
 	kbuf->buf_align = max(buf_align, PAGE_SIZE);
@@ -489,8 +487,8 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
 
 	/* Found a suitable memory range */
 	ksegment = &image->segment[image->nr_segments];
-	ksegment->kbuf = kbuf->buffer;
-	ksegment->bufsz = kbuf->bufsz;
+	ksegment->kbuf = buffer;
+	ksegment->bufsz = bufsz;
 	ksegment->mem = kbuf->mem;
 	ksegment->memsz = kbuf->memsz;
 	image->nr_segments++;
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 0a52315d9c62..eefd5bf960c2 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -26,8 +26,6 @@ struct kexec_sha_region {
  */
 struct kexec_buf {
 	struct kimage *image;
-	char *buffer;
-	unsigned long bufsz;
 	unsigned long mem;
 	unsigned long memsz;
 	unsigned long buf_align;
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
