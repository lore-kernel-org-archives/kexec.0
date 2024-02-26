Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9497C48BF6
	for <kexec@archiver.kernel.org>; Mon, 26 Feb 2024 10:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IdXKE0J4Hmy8nKBGLvojKUTKlbsNqokrornUbMBS6Js=; b=ESr1JWsyiRH+b2
	6ukQewNmcvCIEMiZWQwmLGv+1DwIKGDKfK7Wqg5DEVptxwpp4p65Dpk0IKLXg45Mbwr2Oo2l3lKRl
	8lNjz+6ycQBRsyKuVBfCKvQGvwhHW4tkiJS6SmIULLk0UVq/pHDVRETevt2PQ6t/6IgaC51D2Ot2k
	tCaDnP+btZDwQTzhPyBCyGWQXT4dIbecyntBvhB55rxQEjhSzJbTuGTYUhurZ9sP3USO2RUQNUkHJ
	uva5am7IKdSm5eNKXvMkHSY/JZhd+r6FmRNDjSN5Vv62MWxp7MjIjuP+0iZDlMG/ll89accDeMtgO
	MFnW9B5s7Hl4z22EqpWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reYFy-000000004lx-01ZS;
	Mon, 26 Feb 2024 10:30:46 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reYFj-000000004fT-1yHO
	for kexec@lists.infradead.org;
	Mon, 26 Feb 2024 10:30:44 +0000
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QAUC0k008331;
	Mon, 26 Feb 2024 10:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dI/mBcNNUD2cSvzFhJrEOpTylU3tUmT5GNPFVYNXGTY=;
 b=nm01oJ7+u6s7ujeOu3sGaGa3EtUV6EIzt68KsPlbMMLJ2Bqk/yGlYZ1atLXq1aP4Uygg
 zkOn2CFMRmRGuGPVud2SkbqfvFtVJDytT3Nrbq0FuseOARiPNeoh67crn77iFAsy5t1t
 FH/W3TCiNo61WlbwVoyHtQUB68sIo5VtIaraFMMSCjoRIrOo9TpCZ5lPBtNBzguBfXs7
 DmEMJ7MjjZHmSlm7aarCb+AlPf5Kfu/NrqwVjqYHSnc8RsUw+XA2A4L+MxCl/QTZoGQH
 ncpWpfXdrPav3/qDaFt4b5W3Yvs0ijJuDG7cK+FsqcFEEMNkNASWJVZoxu1WL3yz6KeL Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgmg2e2r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 10:30:25 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41QAUOJC009669;
	Mon, 26 Feb 2024 10:30:24 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgmg2e2qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 10:30:24 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41Q8lCeU008189;
	Mon, 26 Feb 2024 10:30:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9m08qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 10:30:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41QAUHO766716076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 10:30:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A7F920043;
	Mon, 26 Feb 2024 10:30:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4A6020040;
	Mon, 26 Feb 2024 10:30:14 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.203.115.195])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Feb 2024 10:30:14 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kexec-ml <kexec@lists.infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Dave Young <dyoung@redhat.com>
Subject: [PATCH linux-next v2 1/3] kexec/kdump: make struct crash_mem available without CONFIG_CRASH_DUMP
Date: Mon, 26 Feb 2024 16:00:08 +0530
Message-ID: <20240226103010.589537-2-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240226103010.589537-1-hbathini@linux.ibm.com>
References: <20240226103010.589537-1-hbathini@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yzZ7pqNr7dH_VRpsTh9hCqMVno0eizzv
X-Proofpoint-GUID: L4ueQ49CtB466i6VpGELkjM_YWBf-K3N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402260079
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_023031_963045_BA51B5D9 
X-CRM114-Status: GOOD (  18.74  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

struct crash_mem defined under include/linux/crash_core.h represents
a list of memory ranges. While it is used to represent memory ranges
for kdump kernel, it can also be used for other kind of memory ranges.
In fact, KEXEC_FILE_LOAD syscall in powerpc uses this structure to
represent reserved memory ranges and exclude memory ranges needed to
find the right memory regions to load kexec kernel. So, make the
definition of crash_mem structure available for !CONFIG_CRASH_DUMP
case too.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

* No changes in v2.

 include/linux/crash_core.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 23270b16e1db..d33352c2e386 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -8,6 +8,12 @@
 
 struct kimage;
 
+struct crash_mem {
+	unsigned int max_nr_ranges;
+	unsigned int nr_ranges;
+	struct range ranges[] __counted_by(max_nr_ranges);
+};
+
 #ifdef CONFIG_CRASH_DUMP
 
 int crash_shrink_memory(unsigned long new_size);
@@ -51,12 +57,6 @@ static inline unsigned int crash_get_elfcorehdr_size(void) { return 0; }
 /* Alignment required for elf header segment */
 #define ELF_CORE_HEADER_ALIGN   4096
 
-struct crash_mem {
-	unsigned int max_nr_ranges;
-	unsigned int nr_ranges;
-	struct range ranges[] __counted_by(max_nr_ranges);
-};
-
 extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mstart,
 				   unsigned long long mend);
-- 
2.43.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
