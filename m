Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE0DC021B2
	for <kexec@archiver.kernel.org>; Thu, 20 Feb 2025 21:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ocxn2vITOhCMlyY2Lv+YIJet0NEDux7ShrMIeChy5p4=; b=kYDw/VP9LcsD3k5bNIyqDR6pGF
	UAhOnqP+cb/O2FTn+VKRdpYzYBXolwPJcPLhIzeUKqbCuRMOszHhFtX2zx3wD/ao1bR3K/8n+2mnt
	b8hRiv3//ZAjc2SIlE2LGORSx+XUCIG6rYiExXGlKfOpVpY9NulLBj+ocp9mq2C2F2ZpTFYYW0WSJ
	5Wg8QiledOYnCPBZCV3uUNqTP4Dyt7VSm8AwQ91UcVJIVg2J0j5vRd8OQwOoxEi6gfuE2x9cMDDvN
	QGxwKgdhzu+8Tqi+7t4RS+Hti4hPPwnrt8EPSuUFElCxL5uG+FqwbWCZqzk6KZfUuljBGzu75GUTy
	5j/3W8OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlEFk-00000002ziu-1KBt;
	Thu, 20 Feb 2025 21:38:40 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlEDm-00000002yyn-1pA6
	for kexec@lists.infradead.org;
	Thu, 20 Feb 2025 21:36:39 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KH2MDn010151;
	Thu, 20 Feb 2025 21:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ocxn2v
	ITOhCMlyY2Lv+YIJet0NEDux7ShrMIeChy5p4=; b=TmylOpIOcTcHOHXCMfW2rA
	Us2ztmKa3wjRUjjQSaqbV/XzKhG5RC2w65RfgOxjLT+cYMLy8Uk7d9BSWJ2sYRUu
	UwfECa7oUKaCqlZFYIrDtqml+hmJMlDjzuHhaaRzW+bqksx+IeESpSuqZ42LwN9a
	xiOb4TiKzSWCeVGgvr+kwJBGmWUaPlePIVWFNTIoBo33BHm3v5Q1a5FycrkY5Spr
	6t8hvYh0KpZBWHRB0YYSfIOOD1JkUHRaq3aXnbZ5Wujuf8JmNR5mU9SQ6nyRV6TO
	452G4r13BRVqJvPoVuQKDVURF7undN7MPzw5KJPdpY8J5uziPUVIeAhc4O5Yth7A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wtfa5hfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 21:36:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KL0SZO029296;
	Thu, 20 Feb 2025 21:36:21 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w024md7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 21:36:21 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KLaKQF20382326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 21:36:21 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C60A45805A;
	Thu, 20 Feb 2025 21:36:20 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23F875805D;
	Thu, 20 Feb 2025 21:36:19 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.103.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2025 21:36:19 +0000 (GMT)
Message-ID: <44a2c7cb424c769c6c8863324c522533cb70b0a5.camel@linux.ibm.com>
Subject: Re: [PATCH v8 6/7] ima: make the kexec extra memory configurable
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com
Date: Thu, 20 Feb 2025 16:36:18 -0500
In-Reply-To: <20250218225502.747963-7-chenste@linux.microsoft.com>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
	 <20250218225502.747963-7-chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YqhkbFQcJ59BFj7mB8ysqI2pJLMKyAve
X-Proofpoint-GUID: YqhkbFQcJ59BFj7mB8ysqI2pJLMKyAve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200143
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_133638_479582_B51D511D 
X-CRM114-Status: GOOD (  12.80  )
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

On Tue, 2025-02-18 at 14:55 -0800, steven chen wrote:
> The extra memory allocated for carrying the IMA measurement list across
> kexec is hard-coded as half a PAGE.=C2=A0 Make it configurable.
>=20
> Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure the
> extra memory (in kb) to be allocated for IMA measurements added during
> kexec soft reboot.=C2=A0 Ensure the default value of the option is set su=
ch
> that extra half a page of memory for additional measurements is allocated
> for the additional measurements.
>=20
> Update ima_add_kexec_buffer() function to allocate memory based on the
> Kconfig option value, rather than the currently hard-coded one.
>=20
> Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>



