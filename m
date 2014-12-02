Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XvsUe-0002lQ-MK
 for kexec@lists.infradead.org; Tue, 02 Dec 2014 18:48:13 +0000
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <brking@linux.vnet.ibm.com>;
 Tue, 2 Dec 2014 13:47:47 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 8A9E9C90041
 for <kexec@lists.infradead.org>; Tue,  2 Dec 2014 13:39:47 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB2IlhTJ28573934
 for <kexec@lists.infradead.org>; Tue, 2 Dec 2014 18:47:43 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB2IlgRM002364
 for <kexec@lists.infradead.org>; Tue, 2 Dec 2014 13:47:43 -0500
Message-Id: <201412021847.sB2Ilfvc002145@d01av04.pok.ibm.com>
Subject: [PATCH RESEND 2/5] kexec: Export kexec_in_progress
From: Brian King <brking@linux.vnet.ibm.com>
Date: Tue, 02 Dec 2014 12:47:41 -0600
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
To: James.Bottomley@HansenPartnership.com
Cc: wenxiong@linux.vnet.ibm.com, linux-scsi@vger.kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com, brking@linux.vnet.ibm.com, hch@lst.de, anton@samba.org


A kexec boot for some ipr SAS adapters was seen to take ~20 seconds
just doing ipr adapter initialization. This is due to the fact that
a kexec invokes the driver's shutdown handler which places the adapter
into a state that requires a hard reset and resulting firmware initialization
to be usable again, which takes significant time. By exporting kexec_in_progress,
this process can be optimized significantly in the driver by essentially
placing the adapter into a state where this hardware reset and re-initialization
can be bypassed, eliminating this delay in kexec boot.

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: kexec <kexec@lists.infradead.org>
Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 kernel/kexec.c |    2 ++
 1 file changed, 2 insertions(+)

diff -puN kernel/kexec.c~kexec_export_in_prog kernel/kexec.c
--- scsi-queue/kernel/kexec.c~kexec_export_in_prog	2014-12-02 12:13:22.820325731 -0600
+++ scsi-queue-bjking1/kernel/kexec.c	2014-12-02 12:13:22.825325687 -0600
@@ -2768,3 +2768,5 @@ int kernel_kexec(void)
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
