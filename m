Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9EECFD376
	for <kexec@archiver.kernel.org>; Tue,  2 Dec 2025 10:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4Vo2f7uWgbg8qKIfrlf+n1Rw7dAMuO46RLqn3KQuEdg=; b=gqUOW3w20wyQ85XCgl+YDYk1G7
	Zue7M+YN1mfFA9mc1oMHixWDwl0+NiwCfJujPllVcpns/d5eklj5X/4akkf/IYu2FHCn4l/Cl1Gao
	9lbI0v7E1cxYvwiupjVVbCkVSOtw6WM1bxo1BSaGpNmmcnERp9R2ZTVJxH+Or+JS0o4UFx+R6q486
	OXwWF8KJq5G1c8wzejVkcD4tBASidLJodUu3FsEmWIdMmv3sxDaRZKeilIfUp4ZX7R0u8GFSYN3uV
	roKr4fHaMzlvkX/x8GsewFPCgWcl3u7Xn9oorCMulMg6GDs1Cv/aEW9GbYRRxmT7OAtEC+77kmiQc
	gP3+kXsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQNXI-00000005FFq-191W;
	Tue, 02 Dec 2025 10:23:08 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQNXD-00000005FFF-06hR
	for kexec@lists.infradead.org;
	Tue, 02 Dec 2025 10:23:04 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B26UtVX010434;
	Tue, 2 Dec 2025 10:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=4Vo2f7uWgbg8qKIfrlf+n1Rw7dAMuO46RLqn3KQuE
	dg=; b=rxS8X0bFeFDF23psXXbzfxVcBtz7hY1UMN4GGdanST4j3/WI503nN1sNV
	ij8zbAfEDRNoPEo1OjivZ31rIMdu++D7ac/ZZI8Low/nlCYcdVOlVgHCNmoCVaqa
	tTukcl36bzigdBkmhT0nJ4h5G/n0krhW+qbxKZuxBR6VHb3FxeKuriZ8boy2rr6j
	4NPlemgLZi2EEfzXa5z6DITSSL1Iir/z4dGZkIK16Jrcbaz1CTcL1d2tkvrvSuh/
	3fkKJUoKjeBposHN+N//HA5Y85EPVmB+HnQ3WXDtogAKejMXk03dSrSvA1H2nBWY
	zVvGdiqGOBIQiI3mSglCh0a4PPtxA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrh6ve47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 10:22:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B27XC3p010361;
	Tue, 2 Dec 2025 10:22:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arcnk3nhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 10:22:58 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B2AMsMW45744384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Dec 2025 10:22:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75F6720075;
	Tue,  2 Dec 2025 10:22:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 229F520073;
	Tue,  2 Dec 2025 10:22:52 +0000 (GMT)
Received: from shivang.com (unknown [9.124.219.246])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Dec 2025 10:22:51 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: horms@kernel.org
Cc: shivangu@linux.ibm.com, kexec@lists.infradead.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH kexec-tools] ppc64: Fix minor build warnings
Date: Tue,  2 Dec 2025 15:52:36 +0530
Message-ID: <20251202102236.244985-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dK+rWeZb c=1 sm=1 tr=0 ts=692ebe03 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=73XDS4RdMMiQ3h7TP-sA:9
X-Proofpoint-GUID: s8YBPhNNaJz1-FUymG-kNnBclioabNK_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX8/mEpdXRiUGw
 TuBav0CF+/gimN4qXx0/OnvzZrokGrNC0ODrDlwDq0qnh0g/nFmvjJtEvmoHQI8nT4zP8Ea/YRx
 OQrBz1AFactdkMzar7NSgbRv7R+TSpUcJr78lyvnuRU7St1UN3SUTdYGPDsv9hekQ4ZvyOijgY6
 NN+foDOX9YvcJEoSLWXA3LC32D+0LgIRYJTHEd/AKBNd4qK9KVwqyfxLWuNhhReWt6sAV1ALndx
 T3gPwmdZ9+cGNPamTUXcqO+bnzWZ/34CFQoPjqqDbDpCkLSG4md8Fl0ynfPNoV3fubYSn7mgLiM
 ttgcRWKvGjX5SWloEEUlxcFlOjGaMb4isXD1IHcH993LgHwmoVEDkLi8he3b9pnsm3zc8F0KJYr
 Bkrgt++FHvCgA9/ux/k8ZFtjpoYpbA==
X-Proofpoint-ORIG-GUID: s8YBPhNNaJz1-FUymG-kNnBclioabNK_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251202_022303_436128_9BA1D1A0 
X-CRM114-Status: GOOD (  12.96  )
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

ppc64 target compiles warning free now.

Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 kexec/arch/ppc64/fdt.c                 | 2 +-
 kexec/arch/ppc64/kexec-elf-rel-ppc64.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/ppc64/fdt.c b/kexec/arch/ppc64/fdt.c
index 879240f..bb57b3e 100644
--- a/kexec/arch/ppc64/fdt.c
+++ b/kexec/arch/ppc64/fdt.c
@@ -140,7 +140,7 @@ static int get_threads_per_cpu(char *path)
  *
  * Returns total number of present CPUs on success, -1 on failure.
  */
-static int get_present_cpus()
+static int get_present_cpus(void)
 {
 	char *range;
 	char buf[1024];
diff --git a/kexec/arch/ppc64/kexec-elf-rel-ppc64.c b/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
index 51b1354..4e00848 100644
--- a/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
@@ -104,7 +104,7 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, struct mem_sym *sym,
 		break;
 
 	case R_PPC64_REL32:
-		*(uint32_t *)location = value - (uint32_t)location;
+		*(uint32_t *)location = value - (uintptr_t)location;
 		break;
 
 	case R_PPC64_TOC:
-- 
2.51.0


