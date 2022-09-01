Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E125C6FA83
	for <kexec@archiver.kernel.org>; Thu,  1 Sep 2022 21:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zxwMS9mq9f/GdcPWBusSghkNvU3v6nBxVCXN9NPCyTo=; b=isCNmJuQ0acjt1
	1JDqLRd6cGR5I7cD4pAKrP9mAw1aWAZTpMXcDlUdCSApfHNW+UT/DTvsCL3f9ESILMWF6BEslLvPE
	NTV6SVvSSvM/dVICBLnvo6KHSCfk5cJ9ywLlRR9uRHT0X1LxE3HeF8bmTtXr4qTgZkqFkusAep9db
	a7bL9jvrbSe+2AnPBZ4D+f72/yPrAGYvkmWJYACJNlwALyx+wfvdib9GLjzuMEond9QvTb/KgWFK6
	AmLduLf4YRySWfOW6QVIGtGpsdrzZzxIwLCY3Ps6uOOkUIE8VRKhSxNbpTqTEBLd43fxPXZyDFXAE
	QENRb+W5jeSTCxX/rOFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTs1B-00F0Pw-AF; Thu, 01 Sep 2022 21:46:33 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTs18-00F0Nd-ON
	for kexec@lists.infradead.org; Thu, 01 Sep 2022 21:46:32 +0000
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 281LUgSW031933;
	Thu, 1 Sep 2022 21:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=r2ZqQzsxMzMBvy51gRpn7fAMC1irQrpsOuT7QpcOflw=;
 b=Ket3w1/Aq7qOEsc1YWBmSvfDetKV0jycPNgjtk3WQz4+UqU9QmMUv2aY7WA9w2pHCekL
 wO0oTAuRi0TJNALLyyK9+8vfuOAWj20F2UsS+5D7XPsKaWI3WG/SEbT5aygf8que9ukB
 5GUp+vkg8ka3NP9Hl4yvISnny3swTxU1LyF+rF07evkOPGS2C+MCbwHtU0/6eulxYlNp
 Pk00G4vRokI7ualg5vnFn418SdkAS1PmPLqVM59mqzSF7M96TtdAXVOPw4lh73yocgeQ
 HMTtznSqxXpH4uxnh/hpcr+7btmzBHJiXYsOiYiQCuGxkmV3qnzA9z5JPYnHJ2qrUH9E 8A== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jb4qg0h3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Sep 2022 21:46:23 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
	by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 281LaGBO019083;
	Thu, 1 Sep 2022 21:46:22 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by ppma02dal.us.ibm.com with ESMTP id 3j7awa4v52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Sep 2022 21:46:22 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 281LkL3S15860208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Sep 2022 21:46:21 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E35A5C6057;
	Thu,  1 Sep 2022 21:46:20 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DE01C6055;
	Thu,  1 Sep 2022 21:46:20 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
	Thu,  1 Sep 2022 21:46:20 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v8 0/4] tpm: Preserve TPM measurement log across kexec (ppc64)
Date: Thu,  1 Sep 2022 17:46:06 -0400
Message-Id: <20220901214610.768645-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GsA1unPRsVQRw4jZ6R8Ro8Eu6KpIZ5_9
X-Proofpoint-GUID: GsA1unPRsVQRw4jZ6R8Ro8Eu6KpIZ5_9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=757 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010094
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_144631_158141_B54F253A 
X-CRM114-Status: GOOD (  18.59  )
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

v8:
 - Added Jarkko's, Coiby's, and Rob's tags
 - Rebase on v6.0-rc3 that absorbed 2 already upstreamed patches

v7:
 - Added Nageswara's Tested-by tags
 - Added back original comment to inline function and removed Jarkko's R-b tag

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

Palmer Dabbelt (1):
  drivers: of: kexec ima: Support 32-bit platforms

Stefan Berger (3):
  tpm: of: Make of-tree specific function commonly available
  of: kexec: Refactor IMA buffer related functions to make them reusable
  tpm/kexec: Duplicate TPM measurement log in of-tree for kexec

 drivers/char/tpm/eventlog/of.c |  31 +--
 drivers/of/kexec.c             | 336 ++++++++++++++++++++++++++++-----
 include/linux/kexec.h          |   6 +
 include/linux/of.h             |   9 +-
 include/linux/tpm.h            |  36 ++++
 kernel/kexec_file.c            |   6 +
 6 files changed, 346 insertions(+), 78 deletions(-)


base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
-- 
2.35.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
