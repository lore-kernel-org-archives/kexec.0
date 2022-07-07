Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF219C43334
	for <kexec@archiver.kernel.org>; Thu,  7 Jul 2022 17:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=mjKyQvvqw6LhUOR5cbftrYpYtyUOd2Dbmace4cMXJCM=; b=kHhCHkK30fG+/M
	qMvEX7OHz2xRbuzZ6DSwwJrfiXGCL3qTipaDmGwJ27v58Sq0dss25/ZZBKJ/8TfgyK5RYGOyMlOEf
	+XpKDIYxMFCRBY48th0oNkb1Z0M8YurYPu2M96SYfBV2vbU5ng/UvjDGunBScAMRxYP1pOjpnGs7v
	PX9Xrx5lxYyt8wRcXVpQuWepaPLgP972qwoSU1RWyGZ6cNiQagUSl+I5zX3vNzQP2ydlEpiIDtXJf
	fQ28xIXB6Lqk7pIy0qNmlzi6vBlcSMSwCCI4580Hhs32X9yhMMxrESZdUnPlLg/+FXN6smJAdg3ev
	3PATGXtHgshFFAuHxvJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9VBE-00HCRm-5z; Thu, 07 Jul 2022 17:20:44 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9VBB-00HCRH-Ij
	for kexec@lists.infradead.org; Thu, 07 Jul 2022 17:20:42 +0000
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267GCI6P030257;
	Thu, 7 Jul 2022 17:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=11HVfaN7Zq6GV9odnxLyanv9E96qUOLdZgTN/eB4b+Q=;
 b=D3TwKW57zWVNSZUyDWhYxeQnLzoWrMflKzSxXdOVqt2XYXrwFbFuIHwLF2vUbt2P/2MS
 QaJW5+aNl6sG9s+c9xFWgeX343C/1PdUS56coNmF3nORftOE3ImmPqYoJPTL7QW6iHVx
 VI79oFq1UoKIELz4LEuHqj9yfU/QMos0h8DVSiC2s7FhbbO1Fcq/hOZbuWcoRZYaUsAy
 REudoeLdL5+XagmEjpg8Y4WIoj/XYQil1ksI3UUrGnRwszDkqq8AW1ybp2SDtHbf8rq1
 oZG6zh6vLKT2kI2VGqvbcgFZIdwMRTNZq1wp8KicxG9eUTlN+Ji2oXeW60joCvCCX41E PA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h62t1hy8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Jul 2022 17:20:40 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
	by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 267HKdXh014714;
	Thu, 7 Jul 2022 17:20:39 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
	by ppma02dal.us.ibm.com with ESMTP id 3h4ugffxd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Jul 2022 17:20:39 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
	by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 267HKci536897258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Jul 2022 17:20:38 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6BC77805E;
	Thu,  7 Jul 2022 17:20:37 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 650387805C;
	Thu,  7 Jul 2022 17:20:37 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
	Thu,  7 Jul 2022 17:20:37 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v6 0/6] tpm: Preserve TPM measurement log across kexec (ppc64)
Date: Thu,  7 Jul 2022 13:20:20 -0400
Message-Id: <20220707172026.831614-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZiDwN58-pptELGWj4NDKOBKurrm4IewM
X-Proofpoint-ORIG-GUID: ZiDwN58-pptELGWj4NDKOBKurrm4IewM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_13,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=654 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070068
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220707_102041_665401_D243B0D6 
X-CRM114-Status: GOOD (  18.51  )
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

The of-tree subsystem does not currently preserve the IBM vTPM 1.2 and
vTPM 2.0 measurement logs across a kexec on PowerVM and PowerKVM. This
series fixes this for the kexec_file_load() syscall using the flattened
device tree (fdt) to carry the TPM measurement log's buffer across kexec.

   Stefan

v6:
 - Add __init to get_kexec_buffer as suggested by Jonathan
 - Fixed issue detected by kernel test robot

v5:
 - Rebased on 1 more patch that would otherwise create merge conflicts

v4:
 - Rebased on 2 patches that would otherwise create merge conflicts;
   posting these patches in this series with several tags removed so
   krobot can test the series already
 - Changes to individual patches documented in patch descripitons

v3:
 - Moved TPM Open Firmware related function to drivers/char/tpm/eventlog/tpm_of.c

v2:
 - rearranged patches
 - fixed compilation issues for x86


Jonathan McDowell (1):
  x86/kexec: Carry forward IMA measurement log on kexec

Palmer Dabbelt (1):
  drivers: of: kexec ima: Support 32-bit platforms

Stefan Berger (3):
  tpm: of: Make of-tree specific function commonly available
  of: kexec: Refactor IMA buffer related functions to make them reusable
  tpm/kexec: Duplicate TPM measurement log in of-tree for kexec

Vaibhav Jain (1):
  of: check previous kernel's ima-kexec-buffer against memory bounds

 arch/x86/Kconfig                      |   1 +
 arch/x86/include/uapi/asm/bootparam.h |   9 +
 arch/x86/kernel/e820.c                |   6 +-
 arch/x86/kernel/kexec-bzimage64.c     |  42 +++-
 arch/x86/kernel/setup.c               |  63 +++++
 drivers/char/tpm/eventlog/of.c        |  31 +--
 drivers/of/kexec.c                    | 342 ++++++++++++++++++++++----
 include/linux/ima.h                   |   5 +
 include/linux/kexec.h                 |   6 +
 include/linux/of.h                    |  11 +-
 include/linux/tpm.h                   |  27 ++
 kernel/kexec_file.c                   |   6 +
 security/integrity/ima/ima_kexec.c    |   2 +-
 13 files changed, 469 insertions(+), 82 deletions(-)


base-commit: 88084a3df1672e131ddc1b4e39eeacfd39864acf
-- 
2.35.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
