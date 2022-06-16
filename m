Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717F7C43334
	for <kexec@archiver.kernel.org>; Thu, 16 Jun 2022 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qg95F5y17bco9lBYptD2SKVvxpnR/U0WNP3/JRBCL6o=; b=B0D6iKEVeTgT7j
	mz2iuA+d7v3a1pR0MNkiWdQHbGQ23+bgoSGnC52NK0PbxriPBbGa+UuZDyLoq6VTIATciUeKpkd+W
	3QBjV8mB1xXxYE1HTOZIo+fnycn280xHOCS0+1ZPyypcZaL9HnP1jWcsZCW0bYEp2t4Kq6nJO/brk
	ahGUGjDe0zSrOPLQTgFLyoTq+6zb4Kgbq8IwRObl1oqXwG/HRKSGhnEEkai1eBlAxi0oOgKYRZdBn
	TbH3r1YPmCpgJQOLXY+83Dx+4yH7uL3lomMSgUHvA8nD+aqO6eL/QhO+m5nTUNZzG01RLdUIbTyst
	OuGlKk/YaK4CDBaYg29g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1rcr-003DGX-B5; Thu, 16 Jun 2022 15:41:41 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1rcn-003DEX-N3
	for kexec@lists.infradead.org; Thu, 16 Jun 2022 15:41:39 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25GFeMNR028468;
	Thu, 16 Jun 2022 15:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=8s+zvtwiO1CS+cnTENaFYIn0D6GAMQ3InBKiqizdwks=;
 b=QSUK8Ph/Cwu9VCwdXoT5VYZaLpycnfmn92q1shdKZs3r8EEuq1s6/2ls+XroxODtO5Ts
 yzALtYxmLt/VckqphHskSVfhiHmr2M0V1VhsQnGNS3XKlBL6txImNNkqNC1oaPlnQ857
 2Nzgcz7SiVWEw0YMI7dYqXKAbwLobQvRYsg+fIAzUtZmBkWyLkQYzt/3W9lNEaLU7Qfv
 BBxYi3DTPTbz7dtbsuZ26RLMprNkdLuQhD63iWQgkZXB0y+ftmrJ4beS0kb+Q1Ffxg2k
 aT8ubA5U/TIfTwx3LsTbNOA9g3dZY/3XI/MqztConXTP22zx11iIuLUyLkJq/m7dT2wz Kg== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gqj4j0c4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jun 2022 15:41:35 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
	by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25GFZOPK012977;
	Thu, 16 Jun 2022 15:41:35 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
	by ppma03dal.us.ibm.com with ESMTP id 3gmjpaba18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jun 2022 15:41:35 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
	by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25GFfXHo45154768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jun 2022 15:41:33 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20F07AC05B;
	Thu, 16 Jun 2022 15:41:33 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A23BAC05F;
	Thu, 16 Jun 2022 15:41:33 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jun 2022 15:41:32 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc: nayna@linux.ibm.com, nasastry@in.ibm.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 0/3] tpm: Preserve TPM measurement log across kexec
Date: Thu, 16 Jun 2022 11:41:27 -0400
Message-Id: <20220616154130.2052541-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LSo2FsPlZKT44LYR16aNGIJ6kqQkuQj9
X-Proofpoint-ORIG-GUID: LSo2FsPlZKT44LYR16aNGIJ6kqQkuQj9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-16_12,2022-06-16_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=693 clxscore=1015 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206160064
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220616_084137_910768_8C5407DB 
X-CRM114-Status: GOOD (  17.00  )
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

The of-tree driver does not currently preserve the IBM vTPM 1.2 and
vTPM 2.0 measurement logs across a kexec. This series fixes this for the
kexec_file_load() syscall using the flattened device tree (fdt) to
carry the measurement log's buffer across kexec.

   Stefan

v2:
 - rearranged patches
 - fixed compilation issues for x86

Stefan Berger (3):
  tpm: of: Move of-tree specific code from tpm driver into of driver
  of: kexec: Refactor IMA buffer related functions to make them reusable
  tpm/kexec: Duplicate TPM measurement log in of-tree for kexec

 drivers/char/tpm/eventlog/of.c |  31 +---
 drivers/of/Makefile            |   2 +-
 drivers/of/device_node.c       |  27 +++
 drivers/of/kexec.c             | 293 +++++++++++++++++++++++++++++----
 include/linux/kexec.h          |   6 +
 include/linux/of.h             |   8 +-
 include/linux/of_device_node.h |   9 +
 kernel/kexec_file.c            |   6 +
 8 files changed, 318 insertions(+), 64 deletions(-)
 create mode 100644 drivers/of/device_node.c
 create mode 100644 include/linux/of_device_node.h

-- 
2.35.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
