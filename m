Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAA5CA0ECA
	for <kexec@archiver.kernel.org>; Tue, 12 Sep 2023 08:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=40RrApN79x37XHLFYfCyapVcu/pwWiV7LIvFdhFJkMk=; b=FqmFy8HIKoZ0TN
	+HXv2sqLt+FdKst8/ZS4iy653eKG4HDSR2YeOlaxLdS0wPs8u0TTXXyFxDPN63KBUT4bSR8SlS3kd
	vVDRZX/3EEYpUAvmvO6ugfN6IMLfuN/KQcElDpyyWSeYbxur14fOxZ+2m5WHb6tpgJ1LfQdMTgsIJ
	j103SlLYCQHW+7txxtf/WaDPrUrStmSfR4CiPhxyTAIXecdG+eJ9M1n/QVyYHgtAC4hk8HcJEEnfJ
	5yXv7bMU5AnfUD0v+1wf2cr3h53D4gKRg4sGHtWptdAhTAgKpusok7GgQqNfq3NeHPlufnfaSOksE
	iB2109Xj/5tC8jKXz9PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfymg-002ZnO-0q;
	Tue, 12 Sep 2023 08:30:10 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfymc-002ZlA-21
	for kexec@lists.infradead.org;
	Tue, 12 Sep 2023 08:30:08 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C88xgt024983;
	Tue, 12 Sep 2023 08:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=to9w5yrqCHLi29TMkR3+kZKXKZXXIvDAGsAhn9dw/yI=;
 b=bTwtvG0YmubKG4vqG8tZKYHLnYxe+ArOSp4HTFeQqaoN/Bs1FRyIuVuoVBmKnDdFVkgk
 dcMuQ0Ib2m73Rkuvi83f2SYcTjjRiF58VX4qZP4BsWvJbQL2rseZbiNoVCVFcB2yB4Xz
 h8YVw2qGLQqHiPIhaUYxUj3GO+SS29cdYKfIN0X7WW3Y3IRvu2k/oiMuApLgZ7XdaRe/
 vzqHoVnIM6bc8VUfr2Nj0/LRv7dpFIHjEpKDVEimewfkgnBXGAWyXzgM3L0ZQHKBnCkv
 hg8Xk+kTAzVOyVEIHulor7ukWmOFcxYQsp/naLkJiCTYHwq2v5FLKxWPJJSKTIPLELTG GA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2j5jcbv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Sep 2023 08:29:59 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38C89doZ029507;
	Tue, 12 Sep 2023 08:29:59 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2j5jcbuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Sep 2023 08:29:58 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38C6wIJe002401;
	Tue, 12 Sep 2023 08:29:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t158k18md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Sep 2023 08:29:55 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38C8Tqbk54526208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Sep 2023 08:29:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A093C2004B;
	Tue, 12 Sep 2023 08:29:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E740320040;
	Tue, 12 Sep 2023 08:29:50 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.203.106.137])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Sep 2023 08:29:50 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kexec-ml <kexec@lists.infradead.org>
Cc: Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 1/2] vmcore: remove dependency with is_kdump_kernel() for exporting vmcore
Date: Tue, 12 Sep 2023 13:59:49 +0530
Message-ID: <20230912082950.856977-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EIk-mFTGMjHmkefYEWiZ-GstYmU1pwQ_
X-Proofpoint-ORIG-GUID: 7srt9IEhyvE3vzJikvVf5Z4KGm7-Pkiy
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 mlxlogscore=957 lowpriorityscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120068
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_013006_882061_8539952B 
X-CRM114-Status: GOOD (  20.65  )
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
the vmcore. Since, is_kdump_kernel() is used to restrict resources in
crash dump capture kernel and such restrictions may not be desirable
for fadump, allow is_kdump_kernel() to be defined differently for such
scenarios. With this, is_kdump_kernel() could be false while vmcore is
usable. So, remove unnecessary dependency with is_kdump_kernel(), for
exporting vmcore.

[1] https://docs.kernel.org/powerpc/firmware-assisted-dump.html

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

Changes in v3:
* Decoupled is_vmcore_usable() & vmcore_unusable() from is_kdump_kernel()
  as suggested here: 
    https://lore.kernel.org/linuxppc-dev/ZP7si3UMVpPfYV+w@MiWiFi-R3L-srv/T/#m13ae5a7e4ba6f4d8397f0f66581832292eee3a85


 include/linux/crash_dump.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 0f3a656293b0..acc55626afdc 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -50,6 +50,7 @@ void vmcore_cleanup(void);
 #define vmcore_elf64_check_arch(x) (elf_check_arch(x) || vmcore_elf_check_arch_cross(x))
 #endif
 
+#ifndef is_kdump_kernel
 /*
  * is_kdump_kernel() checks whether this kernel is booting after a panic of
  * previous kernel or not. This is determined by checking if previous kernel
@@ -64,6 +65,7 @@ static inline bool is_kdump_kernel(void)
 {
 	return elfcorehdr_addr != ELFCORE_ADDR_MAX;
 }
+#endif
 
 /* is_vmcore_usable() checks if the kernel is booting after a panic and
  * the vmcore region is usable.
@@ -75,7 +77,8 @@ static inline bool is_kdump_kernel(void)
 
 static inline int is_vmcore_usable(void)
 {
-	return is_kdump_kernel() && elfcorehdr_addr != ELFCORE_ADDR_ERR ? 1 : 0;
+	return elfcorehdr_addr != ELFCORE_ADDR_ERR &&
+		elfcorehdr_addr != ELFCORE_ADDR_MAX ? 1 : 0;
 }
 
 /* vmcore_unusable() marks the vmcore as unusable,
@@ -84,8 +87,7 @@ static inline int is_vmcore_usable(void)
 
 static inline void vmcore_unusable(void)
 {
-	if (is_kdump_kernel())
-		elfcorehdr_addr = ELFCORE_ADDR_ERR;
+	elfcorehdr_addr = ELFCORE_ADDR_ERR;
 }
 
 /**
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
