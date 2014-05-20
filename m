Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wmm6A-0003q5-3W
 for kexec@lists.infradead.org; Tue, 20 May 2014 15:37:02 +0000
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <brking@linux.vnet.ibm.com>;
 Tue, 20 May 2014 11:36:39 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 02977C90040
 for <kexec@lists.infradead.org>; Tue, 20 May 2014 11:36:32 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4KFaSuM44761320
 for <kexec@lists.infradead.org>; Tue, 20 May 2014 15:36:37 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4KFa4h1030197
 for <kexec@lists.infradead.org>; Tue, 20 May 2014 11:36:04 -0400
Message-ID: <537B764A.7040801@linux.vnet.ibm.com>
Date: Tue, 20 May 2014 10:35:38 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [PATCH 2/3] kexec: Export kexec_in_progress
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
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: kexec@lists.infradead.org, ebiederm@xmission.com, linux-scsi <linux-scsi@vger.kernel.org>, Wen Xiong <wenxiong@us.ibm.com>


Export kexec_in_progress for use by device drivers and other modules
to optimize kexec boot.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 kernel/kexec.c |    2 ++
 1 file changed, 2 insertions(+)

diff -puN kernel/kexec.c~kexec_export_in_prog kernel/kexec.c
--- linux/kernel/kexec.c~kexec_export_in_prog	2014-05-13 16:59:19.000000000 -0500
+++ linux-bjking1/kernel/kexec.c	2014-05-13 16:59:19.000000000 -0500
@@ -1712,3 +1712,5 @@ int kernel_kexec(void)
 	mutex_unlock(&kexec_mutex);
 	return error;
 }
+
+EXPORT_SYMBOL_GPL(kexec_in_progress);
_


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
