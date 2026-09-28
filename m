Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA54DC9833E
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 08:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2V0T/QH1NxZzr7ALdjEKUfyiN/ir/ewgEkREcbHU8GI=; b=4LvGov6ZvpJyNJTulXgeGE0ILe
	xcR7/H3iGp+JB8AOGthc+hTqk0FCkr/ZVKCu5z3UwymGWF5DDQGU6qrFEdCLOLw1lMnEiKEWxRRth
	gtOAjTUGUq2gfSHsiWxxVrbRSNes6fjhrNLS3T4ZswDgNTpeprXmEUEbQgsvV77crqsWo986rLKrO
	4UcuxwskExXrwQBqUz1kTc0DpSpBZ50Wk7MEEeVEmG6fjCmQ88sLw3bRRO1/eRNuPq6ZLH3Nl8rQy
	auiJn6XY62XnWwpRYfQe3GX7zCQXEftHPpKI1uylkayda80kJvP8j7cjPMY6PeRTMH5jBLjd1El8+
	1Vv4XyHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB6nV-000000005z8-0aDa;
	Mon, 28 Sep 2026 08:33:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB6nT-000000005yr-42gh
	for kexec@bombadil.infradead.org;
	Mon, 28 Sep 2026 08:33:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=2V0T/QH1NxZzr7ALdjEKUfyiN/ir/ewgEkREcbHU8GI=; b=Fo1GZfvLOSYxSRD/nNTxEC0anR
	bZbMT1Vralkp4yxQEtEYfyzxo731UB/gHp4BTl/SVK5l8Zom26NDMgK21TOT5UHItfj/rEm6ilVpb
	EfR+CJ9aL9yQoqKkSh9mnECxqW9ai2JoGqwFWgg8UzxHbM1bw5VPNZePQCsbsjq2P0qbJXuR8835E
	6e6xOV04iJBxlWNjQ4Fdqst6duglCEPDAdCpKSOU9/M4vQXfYcR00dc9qqdF7Y6eNisEVkk2iyH5F
	3C41qQuqdY3WjuUouCsPeMigATs358HaEunQ9pnQsKBfGPMwLGa8XTJSMD/UD0rdAJjC2ApkmRewx
	Rkzslghw==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xB6nP-00000001EZk-3eGD
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 08:33:14 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S85Z8S3545312;
	Mon, 28 Sep 2026 08:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2V0T/QH1NxZzr7ALdjEKUfyiN/ir/ewgEkREcbHU8
	GI=; b=O9HiGk/4PBANUXJNkTMFqidb9JrLCW0ZjUoaPgOhlxGhW1YANKtXzKRvy
	fMcXIKcvnfVoz5//BNhxE8t8qAM+37zm/J/GiBqUxXLT+jZX8bT1e0b4yGLTX+8J
	GcYK1KVcZ8w561GiIsO+Q/v5OC3GI07QHmb3T92xqtNMKHPsxyTFpAThhiMHZ2OT
	N37bev3e6xvVVayUQSMLuJtyVPnMvSXFMfeSv6pnszOXeC8bl8wW1LIKv1K13DAm
	H3qzjTsyhd6lS6BlLOoAQY0TdYKKjORsoEeVjV6M/Nb+Ckr7VabZH8uM8QG4MWXP
	wKKBMaNMg7WM4NiEr1FWuDN/0UsAQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fdyyuy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 08:32:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S82UDg4036587;
	Mon, 28 Sep 2026 08:32:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxu2y45j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 08:32:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68S8Wct250987286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 08:32:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5167820043;
	Mon, 28 Sep 2026 08:32:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E25BB20040;
	Mon, 28 Sep 2026 08:32:33 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 08:32:33 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: kexec@lists.infradead.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Alexander Graf <graf@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Mike Rapoport <rppt@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 0/2] powerpc: enable Kexec HandOver (KHO)
Date: Mon, 28 Sep 2026 14:02:24 +0530
Message-ID: <20260928083226.107807-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6aba262b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=vggBfdFIAAAA:8
 a=Z4Rwk6OoAAAA:8 a=pGLkceISAAAA:8 a=7ipKWUHlAAAA:8 a=voM4FWlXAAAA:8
 a=itPyUPzOZQCiFHcQqVsA:9 a=HkZW87K1Qel5hWWM3VKY:22 a=gpc5p9EgBqZVLdJeV_V1:22
 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzMiBTYWx0ZWRfX4f+kgIpPIGVj
 uwaG28rTrKEHIVdkZvig/T2b0K2y423NKMNJoO3nOja5TdnkcYkuLzg10lYlz8rkO1nLvx91snl
 pKr4tArX/ihyRX009CGAx64RQajKNZw=
X-Proofpoint-ORIG-GUID: dwrLQ9ljU_LN2RkMYCllj3KVN-DgVXNQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzMiBTYWx0ZWRfXydZ5+LBSAB3g
 DWOGDyZye/X6SynjJforcAVntJNPIhcxmnwOyepSuiMXjWaylAmShseTZgO+PV/S2Lg+rftrb2d
 Bg97yNlihEL1vOJ5JPakg+DR5sWm2BNUmAUm6GqDmcGsZ9eS9L0X2/+me1T0gX+4U5GoeVYyFss
 58C19/UdJ/5G75GcUAwIS7hYy8FJAnO7bqC69ilR2EU3lYMzU+BjjVN8hj5AZRsSfqtChHW7WUO
 pZc6sIlFHid4RJ+g/HdhtO8gA5J38PnMUxxca1x2aBgIEZ8tGvqihF7uFZGp1PTEIuk5JI+eZwx
 pF73eFstl73Jz53utDrWs9V+sAD2n2O6XV3LtsiJ1uJaj+MHogaIWPjo7x+SpoIRlEQhfm4PZPk
 aLxBZNxLyINNIiCSy+KqgeYlGLethLX20vGMGNY4Hh/78PQP4HFNeZF/5s+dhvbUbt/O8n+Mn/r
 AygC3bFghR/bJOJCvbg==
X-Proofpoint-GUID: 4SGsXfmGwyZu8BRXa6Efo3WVi6WdezfJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280032
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_093312_259090_550C08A5 
X-CRM114-Status: GOOD (  21.51  )
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

The first patch fixes the KHO scratch alignment check by moving it from
a compile-time static assertion to a runtime check. On powerpc,
CMA_MIN_ALIGNMENT_BYTES can depend on pageblock_order and it may not be a
compile-time constant with some configurations. The runtime check
allows KHO to be enabled for these configurations and disables KHO if
the required scratch alignment is not met.

The second patch enables KHO support for powerpc and adds the call to
early_init_dt_check_kho() from the powerpc architecture setup path,
where KHO information needs to be checked early during boot.
early_init_dt_check_kho() is also made public so that the powerpc code
can make use of it.

There is a generic issue with KHO scratch sizing when other memory
reservations, such as crashkernel, are made before the KHO scratch
reservation. Such reservations can be included when calculating the
scratch size and may cause the KHO scratch reservation to fail. This
will be addressed separately in a follow-up patch. To know more on
this [1]

Testing:
========
This series was tested in the following two environments with
CONFIG_TEST_KEXEC_HANDOVER enabled and the kho_test kernel module:

- pSeries LPAR
- pSeries guest running on PowerNV
- pSeries guest running on Pseries LPAR

The KHO test module successfully verified KHO state restoration:
> dmesg | grep -i kho

Linux version 7.3.0-rc4kho-ppc-upstream+ (root@ltcrain85-lp7.ltc.tadn.ibm.com) (gcc (GCC) 15.3.1 20260722 (Red Hat 15.3.1-1), GNU ld version 2.45.1-5.fc43) #2 SMP PREEMPT_DYNAMIC
KHO: found kexec handover data.
Kernel command line: BOOT_IMAGE=(ieee1275//vdevice/v-scsi@3000006b/disk@8100000000000000,gpt2)/vmlinuz-7.3.0-rc4kho-ppc-upstream+ root=/dev/mapper/fedora_root ro rd.lvm.lv=fedora
KHO: exec from: 7.3.0-rc4kho-ppc-upstream+ (count 5)
test_kho: KHO restore succeeded

Changelog:
==========

RFC: https://lore.kernel.org/all/20260821105609.983622-1-sourabhjain@linux.ibm.com/ [1]

v1:
- Drop the first patch from the RFC series, which added KEXEC_FILE as a
  dependency of KEXEC_HANDOVER, and use select instead.
- Replace the SCRATCH_ALIGNMENT_BYTES static assertion with a runtime
  check to fix the build failure on powerpc configurations where
  CMA_MIN_ALIGNMENT_BYTES is not a compile-time constant.
- Remove the CRASH_DUMP dependency from ARCH_SUPPORTS_KEXEC_HANDOVER.
- Reuse the existing early_init_dt_check_kho() function to process the
  KHO FDT properties.

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org

Sourabh Jain (2):
  kho: check scratch vs CMA alignment at runtime
  powerpc: add support for Kexec HandOver (KHO)

 arch/powerpc/Kconfig               |  3 +++
 arch/powerpc/kernel/setup-common.c |  2 ++
 drivers/of/fdt.c                   |  2 +-
 include/linux/of_fdt.h             |  1 +
 kernel/liveupdate/kexec_handover.c | 23 +++++++++++++++--------
 5 files changed, 22 insertions(+), 9 deletions(-)

-- 
2.55.0


