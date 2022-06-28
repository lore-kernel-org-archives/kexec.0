Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C07DC433EF
	for <kexec@archiver.kernel.org>; Tue, 28 Jun 2022 16:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=N5485BnUFyNxvgQ8btfxIpb3QI8heXMnm7tAn4opkRg=; b=q0LLdoN99/VhG8
	5+vu1oKWacRHZ24YXKtlhkfDsyJ76dYUMqoYQHOtJYSgeTH+uz/Xx8wzDXpsz0HcQWF2He1V5UXZ8
	IFBgod5JVz7X92a6A30I88Q5QWkelUGVvGTOCz4CljgrreMT3DcFc3T2B62fLL5VCABiBMrF0xMBl
	9FM1Q5mRVexdFq6Z/L9WZB09jiQlYBvJnvzDsb4pxJBDk50f5l++wSQtLQB862UIcG8wINn1RW1bL
	9XEGewpcOpGqlXAg90NESbN0/1Z6zeOD+2cKGF3tzPIHKlH/iBMHQCrD8X9oqPIzXRXJuYxlBKljN
	gsW0pEhWnUZTI9nw5x4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6EXr-007IWz-Cg; Tue, 28 Jun 2022 16:58:35 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6EXo-007IWR-QO
	for kexec@lists.infradead.org; Tue, 28 Jun 2022 16:58:34 +0000
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SGl9Ww011924;
	Tue, 28 Jun 2022 16:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=f4B1ImZ7XM6K5BfXq7KonhhMPz+AJbwRUxuww96TMQo=;
 b=PfowYJaW8i8D21QiK+Wiqnx22mBSt6CMeOWjS0FGcT5z3GXZvYUoKxYLkz9I8bRB7+9i
 IXPJvsDK5Nc3XCwj9/nomvldWPdVTDrUuf7Cue0bS8hskpjIvZKsDsJsgNaAM4W3/BEe
 6QSgDiX/cFeQ6v7lRANZVtUbdOyBw16K4e0lwSJzK3XZk4gyf2iem+8gJO5XGBYdV2EU
 aEgez3Jx4vk1YyHR7mO2/qf9o0jLbss0VZhuMciLm5HPMwwmvMifrfQKTbn74YK+y4nh
 rE6m1a/BOTfX4LPSR/FWqmy5E5hpw7RN7Gysi0Jq1cJkNcH3Sqmj5MoRAOW9MFmshZE4 1w== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h05fh0968-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jun 2022 16:58:26 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
	by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25SGpCrM004960;
	Tue, 28 Jun 2022 16:58:26 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
	by ppma04wdc.us.ibm.com with ESMTP id 3gwt09prnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jun 2022 16:58:26 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25SGwPbu36700590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jun 2022 16:58:25 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3483578063;
	Tue, 28 Jun 2022 16:58:25 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DDB27805F;
	Tue, 28 Jun 2022 16:58:24 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jun 2022 16:58:24 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 0/3] tpm: Preserve TPM measurement log across kexec (ppc64)
Date: Tue, 28 Jun 2022 12:58:17 -0400
Message-Id: <20220628165820.883222-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wh3F66djYth6a8xOx_jH1HsxXCNGeG_H
X-Proofpoint-GUID: wh3F66djYth6a8xOx_jH1HsxXCNGeG_H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-28_09,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxlogscore=705
 malwarescore=0 clxscore=1011 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206280065
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220628_095833_234987_783FA15F 
X-CRM114-Status: GOOD (  17.37  )
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
vTPM 2.0 measurement logs across a kexec on ppc64. This series fixes this
for the kexec_file_load() syscall using the flattened device tree (fdt) to
carry the measurement log's buffer across kexec.

   Stefan

Stefan Berger (3):
  tpm: of: Make of-tree specific function commonly available
  of: kexec: Refactor IMA buffer related functions to make them reusable
  tpm/kexec: Duplicate TPM measurement log in of-tree for kexec

 drivers/char/Makefile              |   1 +
 drivers/char/tpm/Makefile          |   1 +
 drivers/char/tpm/eventlog/of.c     |  31 +--
 drivers/char/tpm/eventlog/tpm_of.c |  27 +++
 drivers/of/kexec.c                 | 293 +++++++++++++++++++++++++----
 include/linux/kexec.h              |   6 +
 include/linux/of.h                 |   8 +-
 include/linux/tpm.h                |   5 +
 kernel/kexec_file.c                |   6 +
 9 files changed, 315 insertions(+), 63 deletions(-)
 create mode 100644 drivers/char/tpm/eventlog/tpm_of.c

-- 
2.35.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
