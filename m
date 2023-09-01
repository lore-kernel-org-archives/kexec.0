Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96815CA0FF3
	for <kexec@archiver.kernel.org>; Fri,  1 Sep 2023 19:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=41vOvkvOdGdmIMfrhh+dXb2CzZwOM8PIoAYTCxyap0g=; b=dJ+PC19obfTYzN
	7cEoeaj/TLgQ5qSZ+D/IshcYjQ1LiCHDbj1jT5M1iBKkXPQ2pUrvgmF+XaCVxbr4ugJ4pBI1YVK9x
	4p9scEH9OGUL79/ai0wwZYgMqbTU6IZp57cyrFUWV8TKYYWUhlQp3aXdK7fq8aOM8L68iiN4fzd14
	+963JSUzGntGXO31e4Z+u3InHvZe2ezLv8uhHlB8jvogPk3pnUYV9P+LGjH0AOkzpKU0CRMXJdAYZ
	63RGrTHtpWYBid5xV1ub04zL/HBD3ilw3SZyCsJe+zvfXc2J4etLoBWBW65TA3CBVDMWK7OD6jVyn
	OL0+sP/RE2lm3z/S3p0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qc9WV-000Jcp-2Y;
	Fri, 01 Sep 2023 19:09:39 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qc9WU-000Jcd-0g
	for kexec@bombadil.infradead.org;
	Fri, 01 Sep 2023 19:09:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=abz7DsaqRVyL3JWeUDJAxMA/No8BSDwXicByVatLfhM=; b=p/b8AtpjHPC/QqHAMNCVDhS2i9
	O4pGPlci5HO1ycln/uhy1x3VvvO5JTrt9WtqINPQbJLwgj8ef5BJ3W8VJF893dBJTrxLm+1PcXFls
	5kUB27tIu6YmmM+B2xDHZaprS1wi1Q1NjGl4ZbwxFGNZaJfCIPeGKoYynkhlLF16iT8AWK/fQ1d3j
	RRLkCBfeMOl2df/zQfbxdxHZbeFLB8O4VQOs5UJil/UT44wId6Q0hxF6JHRGGE6mHHZJOTCThcYLo
	/DzTsksWcKvNpDLBv3+/Dw797kk3DRo055BOyxKriW/iCjVcv8+ePNE49PD8bckepf8tItfADY3UB
	MNdG7jig==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qc9WN-009EdM-Ot
	for kexec@lists.infradead.org; Fri, 01 Sep 2023 19:09:36 +0000
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 381Iuvxe005116;
	Fri, 1 Sep 2023 19:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=abz7DsaqRVyL3JWeUDJAxMA/No8BSDwXicByVatLfhM=;
 b=OSvkeEOlDYCSRMRbOTh/YZo2F9vEgUa76TBcIqjdla/pn0uY9gcYn7dq4TAAIlEczoN+
 zSeTUDBrbYHMagBKQuhqIdFMOkg/h1cdCbUo35jVEiPUk1/yKW/FA3VWgNhlts+jvuSp
 qaqaBEEvcqm0Cn8Iw/Cpl2x6yxtnupAwgnzArhrkMVCBnCJQ2PleBJsWjD94mBiHNX7a
 L1dSBFbud9gwC5WtUJ1j8sgoJukt7C7d6oJgZWqClKKYEjGjwJwcxLH047/38ZOYhXsn
 c/GQHimfMYEYPGqiQoQioXrRVvaDXDJSbwcWjmAyqHPsfWqpW8V0ubSc2cZYfEgywQjU +A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sunpdrj78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Sep 2023 19:05:44 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 381J0V4a016970;
	Fri, 1 Sep 2023 19:05:42 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sunpdrbv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Sep 2023 19:05:38 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 381IcJHp019180;
	Fri, 1 Sep 2023 19:04:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqxe2en48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Sep 2023 19:04:43 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 381J4fcp42271386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Sep 2023 19:04:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1778520043;
	Fri,  1 Sep 2023 19:04:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F9EC20040;
	Fri,  1 Sep 2023 19:04:39 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.87.168])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Sep 2023 19:04:38 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kexec-ml <kexec@lists.infradead.org>
Cc: Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 1/2] vmcore: allow alternate dump capturing methods to export vmcore without is_kdump_kernel()
Date: Sat,  2 Sep 2023 00:34:37 +0530
Message-ID: <20230901190438.375678-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qPGrvZomjqCvGlH34QW5pZjv0TREspuq
X-Proofpoint-GUID: pFVwYX-oi8xbqPIvFe_R4Of1xELHkOzV
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_16,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 spamscore=0 clxscore=1011 mlxscore=0 impostorscore=0 mlxlogscore=994
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010179
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230901_200932_178089_F98DF416 
X-CRM114-Status: GOOD (  22.35  )
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

Currently, is_kdump_kernel() returns true when elfcorehdr_addr is set.
While elfcorehdr_addr is set for kexec based kernel dump mechanism,
alternate dump capturing methods like fadump [1] also set it to export
the vmcore. is_kdump_kernel() is used to restrict resources in crash
dump capture kernel but such restrictions may not be desirable for
fadump. Allow is_kdump_kernel() to be defined differently for such
scenarios. With this, is_kdump_kernel() could be false while vmcore
is usable. So, introduce is_crashdump_kernel() to return true when
elfcorehdr_addr is set and use it for vmcore related checks.

[1] https://docs.kernel.org/powerpc/firmware-assisted-dump.html

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 include/linux/crash_dump.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 0f3a656293b0..1052a0faf0dd 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -50,6 +50,7 @@ void vmcore_cleanup(void);
 #define vmcore_elf64_check_arch(x) (elf_check_arch(x) || vmcore_elf_check_arch_cross(x))
 #endif
 
+#ifndef is_kdump_kernel
 /*
  * is_kdump_kernel() checks whether this kernel is booting after a panic of
  * previous kernel or not. This is determined by checking if previous kernel
@@ -64,6 +65,19 @@ static inline bool is_kdump_kernel(void)
 {
 	return elfcorehdr_addr != ELFCORE_ADDR_MAX;
 }
+#endif
+
+/*
+ * Return true if this is a dump capture kernel, where vmcore needs to be
+ * exported, irrespective of the dump capture mechanism in use.
+ *
+ * Same as is_kdump_kernel() unless arch specific code defines is_kdump_kernel()
+ * differently while supporting other dump capturing mechanisms.
+ */
+static inline bool is_crashdump_kernel(void)
+{
+	return elfcorehdr_addr != ELFCORE_ADDR_MAX;
+}
 
 /* is_vmcore_usable() checks if the kernel is booting after a panic and
  * the vmcore region is usable.
@@ -75,7 +89,7 @@ static inline bool is_kdump_kernel(void)
 
 static inline int is_vmcore_usable(void)
 {
-	return is_kdump_kernel() && elfcorehdr_addr != ELFCORE_ADDR_ERR ? 1 : 0;
+	return is_crashdump_kernel() && elfcorehdr_addr != ELFCORE_ADDR_ERR ? 1 : 0;
 }
 
 /* vmcore_unusable() marks the vmcore as unusable,
@@ -84,7 +98,7 @@ static inline int is_vmcore_usable(void)
 
 static inline void vmcore_unusable(void)
 {
-	if (is_kdump_kernel())
+	if (is_crashdump_kernel())
 		elfcorehdr_addr = ELFCORE_ADDR_ERR;
 }
 
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
