Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B4CF99C78
	for <kexec@archiver.kernel.org>; Sat, 18 Apr 2026 08:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uS6XkAUImtXIADuxL3SYKYJhW2yqQ6A1rbk7T8OpT98=; b=pUt9WPTfPbxEj0/ZmSYbVyw4lf
	/26h/oRDCSHLxHY+jRaqW1KxUnHkci3u9bicwYLDIeyQ76Xb9M27EY4eqQqCiaSiw+gGgELpyporL
	OMEvlMRiQon93VVflwQk3yPY4GQbBv04HAVKXL89nCFBtNtNEGIqQ7Ef+wkK9FZk6CKiLcxv/gnJF
	imer5W9Kb316a2EBZzsMBt0sIESb/XLt4gE8EotJPvL5oLaZlAB0WWRorLF4aYE5lfCPOrJPDCs1j
	nRjLdvLk87QPypE+JvWRx50kiWqsz5WdjncdjfHVYNAVTvqWagbY7l6VwYgJ7VLNVM6PK83nrs5Ru
	oVVDbJ8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE0de-00000004pWb-2XI0;
	Sat, 18 Apr 2026 08:02:50 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE0db-00000004pWF-3LSo
	for kexec@lists.infradead.org;
	Sat, 18 Apr 2026 08:02:49 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63I7RArQ3715939;
	Sat, 18 Apr 2026 08:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=uS6XkAUImtXIADuxL3SYKYJhW2yqQ6A1rbk7T8OpT
	98=; b=rX0r0yCvXPtUhvzMyTOi0v+ElADVbxKMlf9fD5w1UZmYYGDI+rQYL8Cjb
	/aPI8TY2vkGYOPae6X2/Eko79++jN6Jlk76MeIm1NMJMw14WUnfDdTqv2RuPmCM3
	YwLTt5CVDdtIhXSQfkugQh0Z8WqKoZYGYCmGpDimYFImliLEdtKtKwZETorLCYrp
	a6DcqrywFzR97qn00kx0gTDWpJynIa6dAu3E7rTsTcuUFIfK1+1zYwb0Ci+iUobB
	QfdOWSitQmqeRdrbXEncuUak6orzqk06KYK6BG++MT9ii6upt1lzL/Oz6h0MSX8T
	mR9LywcT2iY8EaPzkrDgUyCoCGwSQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k0genr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Apr 2026 08:02:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63I7oRaH003209;
	Sat, 18 Apr 2026 08:02:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dm239gjmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Apr 2026 08:02:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63I82gGI17105214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Apr 2026 08:02:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3F7320043;
	Sat, 18 Apr 2026 08:02:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E33620040;
	Sat, 18 Apr 2026 08:02:40 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.124.217.81])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 18 Apr 2026 08:02:39 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: akpm@linux-foundation.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: remove stale kdump project URL
Date: Sat, 18 Apr 2026 13:32:26 +0530
Message-ID: <20260418080226.40415-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wDuCuc_VERqIOu9-260B9A3FgwJxEIXg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDA3MSBTYWx0ZWRfX9ie9wsIKjhWV
 AA1y7WDE54t8+I5F5Wrcd5vVYH45z4H4gzYRd/N7mIrdqNOqPrBH8lCfIS9BsQZD74BWkZxk6Ec
 VA1xH1e3Ye1fXM1QKPVha3VCM7xhCU9kGM6LjRrxSDtMdaNNH8W3QeNXWwmG9YtyImS/kZPNdiy
 9UIIJvmpsCFTyewLhfbXXA9v5zRh1bRb7efPtXAdv3ARZm7X/Upfb78Elzi8iL9zIDxU61BGyYw
 48uGCSXtgClQ+Y7rkR0w5SvfdmEFjBxxiPTW2fZKTsryAEwuR7pfrOJNOBqrccRrJF59g5qrcVO
 dNgFMBWoO8HGqTssyyfugxDtvGxd86a1+9ITWlGzKL8IMTdoJvzHQSRI1paY4estycSiPSPO7sP
 sBTMGkGWbCF96erqIvgC3IE4sqsMLBittMRRa2yOjBYRmXObHTVP4/yqYkVyT18tqEcCFeFMdWF
 KDGLQyCVL01+mgcRRFg==
X-Authority-Analysis: v=2.4 cv=PtujqQM3 c=1 sm=1 tr=0 ts=69e33aa4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=FP58Ms26AAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=JfrnYn6hAAAA:8 a=ljaXgjZVgEGuH4GNExYA:9 a=zZCYzV9kfG8A:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: wDuCuc_VERqIOu9-260B9A3FgwJxEIXg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604180071
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260418_010248_049187_B0707B64 
X-CRM114-Status: GOOD (  11.30  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The kdump project URL in MAINTAINERS points to
http://lse.sourceforge.net/kdump/, but it is no longer maintained.

Remove this outdated link to avoid confusion and keep the file
up to date.

Discussion to remove this link:
https://lore.kernel.org/all/e1e9e200-17d7-4ae9-b0eb-71300f4eb1ac@linux.ibm.com/

Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 288866c32ade..46aa9a48ec15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13870,7 +13870,6 @@ R:	Vivek Goyal <vgoyal@redhat.com>
 R:	Dave Young <dyoung@redhat.com>
 L:	kexec@lists.infradead.org
 S:	Maintained
-W:	http://lse.sourceforge.net/kdump/
 F:	Documentation/admin-guide/kdump/
 F:	fs/proc/vmcore.c
 F:	include/linux/crash_core.h
-- 
2.52.0


