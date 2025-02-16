Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8974C02198
	for <kexec@archiver.kernel.org>; Sun, 16 Feb 2025 14:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Cc:Date:Message-Id:
	Subject:Mime-Version:Content-Transfer-Encoding:Content-Type:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XzCGYRBydUXu4RE+1YR673QjfYosj/ZQ+0EkfdbbZ6g=; b=XKEQJRM4Jl3k+FR4qA/sfll2Em
	AC2ExSZEF/DPMORWudbY3OWVpT835m7TqxxhTTOLVXWDJGNEPp4oflFsx3eIKK/xf5ilsq6BBqgZy
	/eoUy1GH4uUxQ5AO5I9V8aLv4NLqkbxC2DHvD8eHn0m3jJVTWRNv3bdDrWQwMcKp/a5NwBR/k+3Ef
	a/gi18Wvgpdg3AmZGqkfkwqB9L4t/2u6BZe1dDxp2RHitzMcHPc15+x2wOxsz85y+wYGxMeCeONJO
	g/o1krCkzwLbQ2qdN5IyaOkmY1bs/+qn7XGNFjkiXFjz4fQpsOlEtkMTMy4cHaHCrcabLK8y6cEXP
	YYUcSiGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tjflj-00000001wy3-48y1;
	Sun, 16 Feb 2025 14:37:16 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tjfle-00000001wxO-1TeD
	for kexec@lists.infradead.org;
	Sun, 16 Feb 2025 14:37:11 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51GDroZJ021213;
	Sun, 16 Feb 2025 14:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=XzCGYRBydUXu4RE+1YR673QjfYos
	j/ZQ+0EkfdbbZ6g=; b=Aw5CEZRJg5rzQI6gNKBuI8NY8PQAoGmebxgl3u1iWiVu
	KtqkAbiCYjdA1j0lWq+P17VK/vunt+QWhxjua3Zj7phnKSeBoi51/gl/aqiNT7Sf
	a0OSNuNnJnTimJpjZH0t68Oivt3ms+XZG263paX20LJyNvXHXQJMyOsXT6ZOdtst
	jAJoUlsUWEoyfKq0Vq7u19cvANQjqPHlNx7JWpPTG9pYldH7zp5JtAVyFAwwnrLM
	TeLnzCfnoKOxTmTQWCTF392hHNS+to/JjSzAFg8XKNYmIsHIv21GlWJygXGjqN+0
	B5dHPqwjVRSYjUzqrecZTOgZMdD8TJHwoNps62beow==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44twrtm8bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Feb 2025 14:36:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51G8vqse024883;
	Sun, 16 Feb 2025 14:36:50 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44u7y19r86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Feb 2025 14:36:50 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51GEamiI29754050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 16 Feb 2025 14:36:48 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9ABA58059;
	Sun, 16 Feb 2025 14:36:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77C1058057;
	Sun, 16 Feb 2025 14:36:45 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.242.32])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 16 Feb 2025 14:36:45 +0000 (GMT)
From: Venkat <venkat88@linux.ibm.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] kexec: Fix kexec_locate_mem_hole() for missing
 CONFIG_KEXEC_HANDOVER
Message-Id: <CDD6EF33-E1A5-4D0D-81D2-F280E23A310A@linux.ibm.com>
Date: Sun, 16 Feb 2025 20:06:31 +0530
Cc: akpm@linux-foundation.org, bhe@redhat.com, graf@amazon.com,
        Hari Bathini <hbathini@linux.ibm.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, maddy@linux.ibm.com, rppt@kernel.org,
        Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TlMFenNNJ55o34LALG77mJKNEPZXoq4D
X-Proofpoint-ORIG-GUID: TlMFenNNJ55o34LALG77mJKNEPZXoq4D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-16_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=350 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 adultscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502160131
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250216_063710_517824_21DA6526 
X-CRM114-Status: UNSURE (   7.08  )
X-CRM114-Notice: Please train this message.
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


Hello,

I have applied the patch on top of 6.14.0-rc2-next-20250212, and =
proposed patch fixes the issue reported.

Please add the below tag.

Tested-By:  Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>

Regards,
Venkat.=

