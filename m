Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20813C48260
	for <kexec@archiver.kernel.org>; Tue, 13 Feb 2024 11:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fak9oXyxVJmksStsSLYYZ2Ut16P1fycuu3isbbx4YPY=; b=ULCBtSbWsn6P6r
	Np+EmaVtTFgHOoTIo6XpQGZVaYAlcWPc8XCvT0fiSDTLtk90YTqexu1is3UQYs6X6kAe6bCLPAZch
	9V6fj/NBFCru7lG4gkHyMwVQzrS9AttZ8BJT/yqsusuMTPaO+C7VElAXQeBcDFNcd/49U6twmmU6x
	egL+siG6gJ/3o+s31xSWqfw+CvYQ/Ra0NPOLoaT5UiUGb6hz5feoDfLgIVb16R88gve6obRDZoDWO
	OiXU87N/2IgQPfbor7BLs4mQLNcePndPuL4IcvbtwBXqAcRWNye2jrOhv5mWZYkY6DxsqcFtGaHLU
	XLtVzGqskJvRD0NMUvqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZr1J-000000091kq-3Isu;
	Tue, 13 Feb 2024 11:32:13 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZr1G-000000091jN-3FYu
	for kexec@lists.infradead.org;
	Tue, 13 Feb 2024 11:32:11 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DB2XCx001458;
	Tue, 13 Feb 2024 11:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=H4n7Gti0DQpKf+Lev3b2U1UIu6/NC1ZAUUgGWt0NH4A=;
 b=BeY7dFlpHB6ll/tirYvog5WZor0e08M9RwzIDLCdajD8RcPgPmPBpw8P+Xwt1PMtpkkE
 IRdtCe5jvojDDhkMe5gWU3l071WgfKkkt/FfvJbpvVRrb8TC0fsSi731fwBJXgStszAD
 Xwr9bH5wXcHUhdGtJJPq1w9mXDF3AnQWXHlhzkQyEUYNSTOD+40EpEWKXoS7RSv+Ikin
 +yV5OWIc3r+ew/ShuWEFnhQomJ9X6V6zCf//rSVATxvB0qj3N9TH+ab7Mk35sfNckzg9
 FD01/xh6LXzX7zbtsWEn4MU8X6VdeYo2ZeSrbPuPJPCuzSzvkcmf5960nwaHc+t46GvB VA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w876tgk5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 11:32:03 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41DBP74E020242;
	Tue, 13 Feb 2024 11:32:03 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w876tgk41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 11:32:02 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41D9kDhE009728;
	Tue, 13 Feb 2024 11:32:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6p62phjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 11:32:01 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41DBVvkY31326602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 11:31:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 192002004B;
	Tue, 13 Feb 2024 11:31:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 525FA20040;
	Tue, 13 Feb 2024 11:31:54 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.203.115.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Feb 2024 11:31:54 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kexec-ml <kexec@lists.infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH linux-next 1/3] kexec/kdump: make struct crash_mem available without CONFIG_CRASH_DUMP
Date: Tue, 13 Feb 2024 17:01:47 +0530
Message-ID: <20240213113150.1148276-2-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213113150.1148276-1-hbathini@linux.ibm.com>
References: <20240213113150.1148276-1-hbathini@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TVZ2HrHNgGxAqkRWyrbg9EsaotK3-Ut3
X-Proofpoint-GUID: W03R_p21SDHzPOy2M12oBn2E8MCT4U5z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_06,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130091
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240213_033210_843000_92D0C5A1 
X-CRM114-Status: GOOD (  18.42  )
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
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
