Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BB0C43334
	for <kexec@archiver.kernel.org>; Mon, 20 Jun 2022 07:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jKRep6MvD2PSXxU76RFC50Boishlb4UKrkE1+QovZHY=; b=UyzSikFF5wfA9Y
	Cstqjr2lMWAOSAUK/vocHett0ObBd0lGLFP6FY3fZPcpn1ockkwu1qW46dUFVmfmVoPoaOthswQlv
	ECBdtoDCUWFGenvibY8akF1/zFii+3aAliD3gh089WEhxnxcdRm8nI4Hv2rvyxvqDKB/g4YyqS03C
	XzpbAb2d+Zp1SId3xeKA7J13nif7BAg3HKd7h+ZKnM6V+r3uODl/mHKpA9iA8b2SpGAJ9uLRR1YqY
	H0d5C44kxste9D7ZQgv/Eoly95lKmsQqLOEbRd246DfhyvPdfpQAqG85V+ilngGgljkmzaly0+G2S
	YQfXNU4pbZ2Lpv7BNZmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3BPe-00GZGa-72; Mon, 20 Jun 2022 07:01:30 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3BPa-00GZEs-Ci
	for kexec@lists.infradead.org; Mon, 20 Jun 2022 07:01:27 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25K4xx8U016865;
	Mon, 20 Jun 2022 07:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=l2BXL8Ux5CSCQHgi0bRfPfX3/58R+yewBUVWgFr1e/c=;
 b=dQioFICBKBW+yFOnGqFzI7QYPJxFxmiz7d6V9Q/vufkhf8cuYKf82Pmj4gjMcg/lLwCv
 OHzuRzbTprKUTjtrbq/pDdMfUqwfRgQWxCIwTYDsDNyh68QYOGsQjZ1djS1oeIQTF8Fk
 737SRmYElwwfy8nB9XzNGrZO4sg4TF2j3oD5gaJYAkYlzj7YIo89X+jZkQhWOgjBersU
 +o1T86OvpQl6/m3mLGkYW5HROX+XtDAyn1wkTKcBa823ZAxgIZhZH4kkM2UWkvptk5sC
 4lJRIgXx5l0rT7AhVwV62NEa8+JySY2EhY5sJvd775mYI9bxNgo1Wcb8xBuhqVoRyV4w ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gsrqt0f4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jun 2022 07:01:22 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25K6sqQ0002262;
	Mon, 20 Jun 2022 07:01:21 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gsrqt0f3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jun 2022 07:01:21 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25K6otjX001990;
	Mon, 20 Jun 2022 07:01:20 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
	by ppma06ams.nl.ibm.com with ESMTP id 3gs5yhj2b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jun 2022 07:01:20 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25K70ZJI22610290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jun 2022 07:00:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F6F0A4057;
	Mon, 20 Jun 2022 07:01:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB0E6A4040;
	Mon, 20 Jun 2022 07:01:14 +0000 (GMT)
Received: from sjain014.ibmuc.com (unknown [9.43.109.136])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jun 2022 07:01:14 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v5 2/5] powerpc/crash hp: update kimage_arch struct
Date: Mon, 20 Jun 2022 12:31:03 +0530
Message-Id: <20220620070106.93141-3-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620070106.93141-1-sourabhjain@linux.ibm.com>
References: <20220620070106.93141-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CAoFq7ZhlDrl8F98oeso47NhDCdoUmIh
X-Proofpoint-ORIG-GUID: 8bPl2ogcXGbVDcIwE15e_vwyFgsVRkj1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-20_04,2022-06-17_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206200030
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220620_000126_601549_3BDABF87 
X-CRM114-Status: GOOD (  17.10  )
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

Once the kimage is prepared the only way to identify which kexec segment
holds FDT is by looping through all kexec segments. To avoid this a new
member "fdt_index" is added to kimage_arch struct. The new member holds
the index of FDT segment in the kexec segment array which gives direct
access to FDT segment.

The fdt_index will be populated during kexec load for both kexec_load
and kexec_file_load case.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/include/asm/kexec.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index c8040c93b15a..9489e5ca93fb 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -106,6 +106,9 @@ extern const struct kexec_file_ops kexec_elf64_ops;
 struct kimage_arch {
 	struct crash_mem *exclude_ranges;
 
+#if defined(CONFIG_HOTPLUG_CPU)
+	int fdt_index;
+#endif
 	unsigned long backup_start;
 	void *backup_buf;
 	void *fdt;
-- 
2.36.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
