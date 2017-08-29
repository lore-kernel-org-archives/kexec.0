Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dmkTE-0002sn-If
 for kexec@lists.infradead.org; Tue, 29 Aug 2017 17:38:40 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7THYNbF009885
 for <kexec@lists.infradead.org>; Tue, 29 Aug 2017 13:38:12 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cn6sceann-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 29 Aug 2017 13:38:11 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 30 Aug 2017 03:38:09 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7THc6T617367168
 for <kexec@lists.infradead.org>; Wed, 30 Aug 2017 03:38:06 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7THbwpH007325
 for <kexec@lists.infradead.org>; Wed, 30 Aug 2017 03:37:58 +1000
Subject: [PATCH] kexec-tools: ppc64: fix leak while checking for coherent
 device memory
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Tue, 29 Aug 2017 23:08:02 +0530
MIME-Version: 1.0
Message-Id: <150402826929.17885.17434431332871284117.stgit@hbathini.in.ibm.com>
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
To: Simon Horman <horms@verge.net.au>, Kexec-ml <kexec@lists.infradead.org>
Cc: Ankit Kumar <ankit@linux.vnet.ibm.com>

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---

* Follow-up to http://lists.infradead.org/pipermail/kexec/2017-August/019436.html


 kexec/arch/ppc64/crashdump-ppc64.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index 7ea3983..bc9f948 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -217,6 +217,7 @@ static int is_coherent_device_mem(const char *fname)
 			break;
 		}
 		if (!strncmp(buf, "ibm,coherent-device-memory", 26)) {
+			fclose(file);
 			ret = 1;
 			break;
 		}


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
