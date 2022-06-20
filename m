Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4899FC43334
	for <kexec@archiver.kernel.org>; Mon, 20 Jun 2022 07:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=osQjZ9vZL8fs3G6cnnCb4GOinuK10NVesbZ8G3jAoOg=; b=oD/wjyQkE8ayDs
	RVcCHGEN1eMj2tcpG4e+I/+fL8X7N5eADeWK+EmpsxkVMk5fa6RzpYiRsxIlqK482aOsBfFNq38j8
	WMg2MtpvtKFdH9x7fYK7p+sQiYrc6tpB0qx/BBDdNsvG5xWf5DEZgP7ASJjwhsVcbu2j4Za2MyEoM
	f2ZWRdW0Yc+FmDHlYKN/VN7vM4SuQ7bl9TkGjdTwOSltIeKexVn3Ptd1VgN7HWvZv9eekCdtfy9Nu
	JdSRNanbWwSLfE/dZfvU7qPmkVJYXtpJX+qqUKmi6GA9dkImB6Q7ZBhPQWyJgFSPlnI74bqHMgNg6
	aqm7i6OnEhN4+yZFxZaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3BPi-00GZIv-QH; Mon, 20 Jun 2022 07:01:34 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3BPf-00GZGu-So
	for kexec@lists.infradead.org; Mon, 20 Jun 2022 07:01:33 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25K5Cce5003353;
	Mon, 20 Jun 2022 07:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Ogqt0HwD0pfpa9e/VMGyOUcwC5orqsxhkCwN8AKXFeQ=;
 b=mLq2FiQ6qApWMMvQ0GY/Jx842AfN/vS3pZjZPXmrbviTs4rhSjFStYpSNzKQ+RRe7/E6
 twBGo3c6EV9IOMYSKf1M3hj8dHsEoNfqOuynj33ux7tycl3ZW/asu9m/QqvLyI6Ns2aY
 SE4FXMVtnWJVLKaLTc0UY+OZ0APRvKxxRMggvVp5trYsgQSyyIDC/XMsorZZk4kbft+r
 iCOD65ffI68a1dZjkkzppsMfYtl+hs72ve2NoALNLmcJZR9dCoyNkTPdZ//fJsmcNhxY
 7FPTPjzDTRg0JULbNeM1NOtNP/UQ82BGeRl2aFgkwUAYLCjtq8Hlcl+TpK5lLHkFAii7 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gsrqt0f7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jun 2022 07:01:28 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25K70nfN005867;
	Mon, 20 Jun 2022 07:01:28 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gsrqt0f6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jun 2022 07:01:27 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25K6ppRh015482;
	Mon, 20 Jun 2022 07:01:26 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by ppma04ams.nl.ibm.com with ESMTP id 3gs6b9220y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jun 2022 07:01:25 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25K71MkI16056662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jun 2022 07:01:22 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F8EBA404D;
	Mon, 20 Jun 2022 07:01:22 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59528A4040;
	Mon, 20 Jun 2022 07:01:20 +0000 (GMT)
Received: from sjain014.ibmuc.com (unknown [9.43.109.136])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jun 2022 07:01:20 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v5 4/5] powerpc/crash hp: add crash hotplug support for kexec_load
Date: Mon, 20 Jun 2022 12:31:05 +0530
Message-Id: <20220620070106.93141-5-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620070106.93141-1-sourabhjain@linux.ibm.com>
References: <20220620070106.93141-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qxJF6idcc_96luZsRZVHBRkrbC4E7N6_
X-Proofpoint-ORIG-GUID: FmeecNCz8l66oN_Nv-hj-x9K0pCTY2eY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-20_04,2022-06-17_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206200030
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220620_000132_068484_C185FECD 
X-CRM114-Status: GOOD (  20.38  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: eric.devolder@oracle.com, bhe@redhat.com, kexec@lists.infradead.org, ldufour@linux.ibm.com, hbathini@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

A common crash hotplug handler is used for both kexec_load and
kexec_file_load, which is already implemented in earlier patches while
adding support for kexec_file_load.

To enable the crash hotplug handler to work for kexec_load case the
fdt_index attribute of kimage_arch needs to be populated with index of
FDT segment in kexec segment array.

After loading kexec segments the FDT segment is identified by looping
through all the kexec segments and fdt_index is updated accordingly.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/kexec/core_64.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 6d448b55dfad..373cb46bcc0e 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -74,6 +74,31 @@ int machine_kexec_prepare(struct kimage *image)
 	return 0;
 }
 
+#if defined(CONFIG_HOTPLUG_CPU)
+int machine_kexec_post_load(struct kimage *kimage)
+{
+	int i;
+	void *ptr;
+	unsigned long mem;
+
+	if (kimage->type != KEXEC_TYPE_CRASH)
+		return 0;
+
+	/* Mark fdt_index invalid */
+	kimage->arch.fdt_index = -1;
+
+	for (i = 0; i < kimage->nr_segments; i++) {
+		mem = kimage->segment[i].mem;
+		ptr = __va(mem);
+
+		if (ptr && fdt_magic(ptr) == FDT_MAGIC)
+			kimage->arch.fdt_index = i;
+	}
+
+	return 0;
+}
+#endif
+
 /* Called during kexec sequence with MMU off */
 static notrace void copy_segments(unsigned long ind)
 {
-- 
2.36.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
