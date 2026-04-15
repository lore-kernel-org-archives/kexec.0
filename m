Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDC7FA0C26
	for <kexec@archiver.kernel.org>; Wed, 15 Apr 2026 04:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=y4KZrQMDfblyxxgEDgknqegAHg6OHlXI7xKtQafK0fY=; b=4AYXfVb8FV7FInb0mqFqL9TdLj
	yXf2uFLH6fHyCe0ARMNn8hu1NB5inndHCZfyrHEvE0dzbvR26dmQz0zRIegxhAuvJpklsxC+Uymy9
	ZW9HWRVoSVeLvqfK4ysMkIjUmBHJOBkCTwFWdVitHn8o7bFVp502VNmZOaKYbO0eXZixqf7B+SAV2
	aR/tmcqi/5lJFFKpfa5wSYIGShVGhmyQmbvo2L29fZUeLpsOnVdc5wBnRSGCOskL96WdJ4xNBN810
	IzXq9VIlJ6LMsFlhosI5pyPIpo19w0gO5ZFn0WkGfEWnztcYIZpiRy5TD8HQAj4aH+4WAqk24VomW
	rNwhocVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCsIm-00000000ZsO-1qsb;
	Wed, 15 Apr 2026 04:56:36 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCsIj-00000000Zs0-2SAS
	for kexec@lists.infradead.org;
	Wed, 15 Apr 2026 04:56:35 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F4Y3qP1833140;
	Wed, 15 Apr 2026 04:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=y4KZrQMDfblyxxgEDgknqegAHg6O
	HlXI7xKtQafK0fY=; b=XcB1cLP7QKggEG08181OI9DtqqqmXTF6A0tYg93yD2QS
	0rvQQkyMaryncvtOvpFWRCWA594akMjYEeJ2jM7riVGswxwx/SqJuY/y9hGWeTN7
	hOFts3SPnRsvpmfoNguC7sxLqIJ5tZ+KKwxeCmM/4WoP7jSew7BFQfkTe6YLAvx9
	E/z7Y58e4rT7j837lUaawksJK0KMiodph0atmob2JRbCGhGJG1Vx1va0qcpTUhHV
	tHSvDZ2hrYoox54JvBDmUXl0KrRp6oOSNdTsnVNfU+5+MtrwtnTP1DyMUzZPg2Rj
	rrkSz+jcoiBMuTVHhyC0Ytew03aiqbhClKn2IcwZZg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89recx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 04:56:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63F2DH58015206;
	Wed, 15 Apr 2026 04:56:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0msmw6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 04:56:25 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63F4uNuv54919476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 04:56:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55FBA2004B;
	Wed, 15 Apr 2026 04:56:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A26720040;
	Wed, 15 Apr 2026 04:56:22 +0000 (GMT)
Received: from [9.124.217.147] (unknown [9.124.217.147])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 04:56:21 +0000 (GMT)
Message-ID: <e1e9e200-17d7-4ae9-b0eb-71300f4eb1ac@linux.ibm.com>
Date: Wed, 15 Apr 2026 10:26:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>, ruirui.yang@linux.dev
From: Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Dead link in kdump section of MAINTAINERS file
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA0MiBTYWx0ZWRfX2ftJ0zQBAncI
 AW6XORXZV1pnzG9M9sv7ZID3pW4OrhCSZLlw8M/EU/uMUd/3Lu1aXIHe2zRpOACSyriR4wD3l0J
 zmnPF2QRpmzroc6fRGP7NQ8Ss6viiSAjeb51tjb9P2uARTWKTbatbAbRh3xHJsEqfpn5Y7Uk30I
 U9y/CtN3aOpFgUbj/HwSXBKs1XGZaOLpM6IpYzzZFNlk+PLcqk3qZdChLzaFFYoZ/R5st7xiBCF
 dgt8JlnObnlYpIUvTbSlFD1p+OMkScdtGsYDqlS5j1BYgPocxcQxQBYEiqdyRtWqzI3T4pZ1EF8
 hGtp3HPkM2u2LjDXphIdyl+aVmXEzzAB1jvnNAGWdCNAqIYvYyhoNpLsBVrZZvktgyHlXfh50I+
 6U4UuDg3uw/1H24iLhbtpqr5ejOybNmANFmLL12Z5kyLxdbKTjtuNuvZH2W0/LjYJDBOdlKYRt6
 Y+oM3fZSAxs6VZ5L9sA==
X-Proofpoint-ORIG-GUID: J28FC9Ufpu-rm2L5jZuq_Yapo9EUnVfy
X-Proofpoint-GUID: J28FC9Ufpu-rm2L5jZuq_Yapo9EUnVfy
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69df1a7a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=FP58Ms26AAAA:8
 a=w-4yxqKs_pY_4eoHH6EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150042
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_215633_662342_4D6184BC 
X-CRM114-Status: UNSURE (   7.47  )
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

Hi all,

Noticed a dead link in the kdump section of the MAINTAINERS file:

W: http://lse.sourceforge.net/kdump/

The URL no longer seems to be accessible. Could this be updated
or replaced with a valid reference?

- Sourabh Jain

