Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB77C3ABD9
	for <kexec@archiver.kernel.org>; Wed, 14 May 2025 13:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/ltR3xE1jIxqOWOOYkUnrtjTiBPuiBIUhmryLaCAdZY=; b=sD9KP3/pndCRxbcO0ZWMS/LFc6
	pmIwJo9LWxLY1/FUJeWOZr9TrryoU2picirWtueO66hMy7AOzxMPEKnLhT6ywRtZsH/vU3s6ulaLi
	7enjJ3Hb2M5InY6thcuPPr10Gim0Tvr2jfcZm+SGauNiP2sLhBqrhDaEZmXgoFrcgk/mtbDTdQaW3
	6mHFMu60S1ODlBmeEjGCyTXzxDBjWGzZS4aZrU9+KISDirngKIyr6OwUxLLabmknpPitmvtBYqYnr
	63jpHZ0DuYbMdCy+SkHKe844FfM6OGJ4bpmbPSQEFK2sO56wwiwfU669+H8N6nexLGsM4yookfbIY
	Eu9IHRQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFCZ1-0000000FJCh-1kDX;
	Wed, 14 May 2025 13:54:27 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFBPy-0000000F77u-01HT
	for kexec@lists.infradead.org;
	Wed, 14 May 2025 12:41:03 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E743OT003207;
	Wed, 14 May 2025 12:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/ltR3x
	E1jIxqOWOOYkUnrtjTiBPuiBIUhmryLaCAdZY=; b=G9rlyfQZgDSitkauVm37X7
	BHyB8FK7hr6A5Gsr62t0bH4q8Py5mggMPDUKguvc7WESApV/lRbzxQMMTg0SX4ra
	Sw4k+jhxM2P21VSrrgqIKv3hgmO6WXCCsIXO87FWeeOW5XaQQA4p+56iQsIiVntK
	RhyJO1rrmrIBds5OGJhg7ldrbKDzVQWpbSLwiWgxfMReLT4xgDaWZxFsHV1rMzVa
	JlmMAlG+59dfqJZn4Ueu7XBp5N0G3Mo65J4cQGQLA7Ak47l0Ory83iOFx5kiyxhz
	o00IvQb+vZvoXC7F/W7bl5lh9uvVCJ+bkGjlf6h7jw/uYKGEXdBWD7k76d9Q1LNQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mbh1475f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 12:40:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54E9xiIb024281;
	Wed, 14 May 2025 12:40:42 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfs45d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 12:40:42 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54ECefVe2687684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 12:40:42 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D644F58060;
	Wed, 14 May 2025 12:40:41 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 533225804E;
	Wed, 14 May 2025 12:40:40 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.143.84])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 May 2025 12:40:40 +0000 (GMT)
Message-ID: <47edc9708d0ca75489d59ef4b9b6ef2f5de21fe9.camel@linux.ibm.com>
Subject: Re: [PATCH V2] ima: do not copy measurement list to kdump kernel
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com, bhe@redhat.com
Date: Wed, 14 May 2025 08:40:39 -0400
In-Reply-To: <20250513143129.1165-1-chenste@linux.microsoft.com>
References: <20250513143129.1165-1-chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RpTFLDmK c=1 sm=1 tr=0 ts=68248f4b cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=yMhMjlubAAAA:8 a=20KFwNOVAAAA:8 a=1v2mA-L8tnUgDz3cNWsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: KFtkED7iNBqTTVFsvX40P1QhtKzqui76
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDExMSBTYWx0ZWRfX3pqPk3C/XJkr r3Cjk9ibS4n+GvwREoqEgmdxsP/iKvaO9gdEi9N1YlgFW2RYO95N/kkV18+YylD/9VdR7krRWyc TbcjDMX3p4vP/1tge40WSi0IB1A5Pu2N2kNItezM8WAqnk67Fb+63uNMAtsfEQK1Z/LUxeSTnYA
 iUA2W0L3idNEBZtMzTsq9lr4YEggrO9HqMqCDniCS6QWG+36DOL+HJ3g4BPW1YvFZvcm6lmVW3s HuAiLjC89URa2AglwefOIGQPr8XvsX0Tl0DajMG8XRqAdHt7YOQaIiDMeLG5qp9MwqFL+WasE/4 FMP42jOupTfaIc+zGMk+DjP//R5H8MJuZNbaUxHPY16ptrrQCLNQkbbCJ34JWO2AOTz+ahqKfRd
 rqMe7WGWp8FC0FwfmMEq2ScZ7jw128Mt51vRO72sspwFHZKsfdzzzrcqtQP4E5x9W5yf3+vo
X-Proofpoint-ORIG-GUID: KFtkED7iNBqTTVFsvX40P1QhtKzqui76
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250514_054102_161757_228D5A7C 
X-CRM114-Status: GOOD (  12.68  )
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

On Tue, 2025-05-13 at 07:31 -0700, steven chen wrote:
> From: Steven Chen <chenste@linux.microsoft.com>
>=20
> Kdump kernel doesn't need IMA to do integrity measurement.
> Hence the measurement list in 1st kernel doesn't need to be copied to
> kdump kernel.
>=20
> Here skip allocating buffer for measurement list copying if loading
> kdump kernel. Then there won't be the later handling related to
> ima_kexec_buffer.
>=20
> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
> Tested-by: Baoquan He <bhe@redhat.com>
> Acked-by: Baoquan He <bhe@redhat.com>

Thanks, Boaquan, Steven.

This patch is now queued in next-integrity and next-integrity-testing.

Mimi


