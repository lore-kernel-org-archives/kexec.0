Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15A1C77B75
	for <kexec@archiver.kernel.org>; Tue, 18 Apr 2023 13:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=496Or5/dP62mVn0hWJT5Zp/V27LAkyZKRsX03eImvDw=; b=Rh+gGt6oSF6XT3
	k6uEz97J0O0FT5RsW7dhhM1fytqbvKOxE5g9eTowEy8w5iYycMApcNLMwD4AqTaKr95OY9WaBfVZv
	3LMWYU5LlpmnTOrFGjaNAQ+B/45ggSWOXReVWmaKLd/RYqfFQFTYhw4D+4HOYDw2TKxKVb6d6WZTK
	l+q4UQhngR+mU2p09aOywaitkRGMl8MS439+Yv6iJfufLV+cLqRU57cyVuN0af95cwg5Qq0cceaXb
	/g0kHef/vPNt7Bu1wT/lPtgvj4ZGCQGhW7cJpztGfFRweNRfsu77dD/GvfpvSq0tO9J9KB0sYXj8M
	3SmxErVEkt5osRDLE1/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poldB-002J5j-2O;
	Tue, 18 Apr 2023 13:44:25 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pold8-002J4E-2W
	for kexec@lists.infradead.org;
	Tue, 18 Apr 2023 13:44:24 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33ID4Nhx032623;
	Tue, 18 Apr 2023 13:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=3rTxPXcrDEqRa/DaBHbZhPe1zpvsDR1Y31o1ZvJjF3s=;
 b=cwpLlpRCIH9kcNaFoDBJilVOnpiAWFvWxJEO8D6qQjW1yFy7604PuDFE/fhKsjkC9Xmh
 KAOdmKnjk60hUCkXgGXRKyCW12vWiIS0n4p97Ut4gujiJULcNsS2NbNjT/NFui/UsBcP
 qzZfQifUGxLFgYHEkowMjV7Ckje1s0vYmyvItK1Qa56F92sKtb2bQu3i2FWUJKV3VJag
 2Eh5Z2WVJlNvxdQu9HGccEWkLxuR9JLxcQtucQCAvVLuj0cqI905Iq4s1sUeMc0B0kuM
 d3TOYGAX9MMxvaktOU7UREMNdasQ6ePFSn+6fz4TsV/q7aYoLNhmwCWH/1anUhk3148B rg== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q1ntu4nru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Apr 2023 13:44:15 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
	by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33IDFZf9026543;
	Tue, 18 Apr 2023 13:44:15 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
	by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3q1uxd84kp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Apr 2023 13:44:14 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33IDiB6i13894254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Apr 2023 13:44:12 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E74F558059;
	Tue, 18 Apr 2023 13:44:11 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1351D58055;
	Tue, 18 Apr 2023 13:44:11 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Apr 2023 13:44:10 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v9 0/4] tpm: Preserve TPM measurement log across kexec (ppc64)
Date: Tue, 18 Apr 2023 09:44:05 -0400
Message-Id: <20230418134409.177485-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j07xjsakL0WB2dbjHPPqgUvcVeaj2IS1
X-Proofpoint-ORIG-GUID: j07xjsakL0WB2dbjHPPqgUvcVeaj2IS1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_09,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011 mlxlogscore=674
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304180118
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_064422_962458_EB28F08E 
X-CRM114-Status: GOOD (  17.12  )
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

v9:
 - 2/4: Rebased on 6.3-rc7: call tpm_read_log_memory_region if -ENODEV returned

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

 drivers/char/tpm/eventlog/of.c |  30 +--
 drivers/of/kexec.c             | 336 ++++++++++++++++++++++++++++-----
 include/linux/kexec.h          |   6 +
 include/linux/of.h             |   6 +
 include/linux/tpm.h            |  36 ++++
 kernel/kexec_file.c            |   6 +
 6 files changed, 344 insertions(+), 76 deletions(-)


base-commit: 6a8f57ae2eb07ab39a6f0ccad60c760743051026
-- 
2.38.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
