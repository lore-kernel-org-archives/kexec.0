Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA98C02194
	for <kexec@archiver.kernel.org>; Fri,  7 Feb 2025 16:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9XMr2ACuOZ3DXn0CmvjvXygdp2UhUHb82FDmLJ1f7Mw=; b=Z6QaFL1lzJ5SRxXYuJGmfrlW0g
	2SCZ6bD0NHlJaE1+/hWYZ0h/1wG3YM52pdV5/S66fvfxQuFvAr6yawNce/7nzY2kT0itdBcyraKKn
	viVwnkxEolydh8V/cfPZPB9a0B6NqUQ2RLV64P0nfc4b7rTy5RlhMyhV5FwmwQeBD2Yc8on/mVgWZ
	R9vLbvVyo+AGfOap5e+Uys/W0Uo7mGPkDgcKdmf+JOcQjNylwTH59r84IyUpOjGJfmt0FKETA0WXY
	eqKrmcx+ZZBYbVfrwY6A/SJEen6h8x2tHsRHpTrcg2ncjOrFLJf3FQu8rFh3ADBIZ3TocmFcsu6rI
	ruzT+u5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgQsO-0000000ADWO-3VYs;
	Fri, 07 Feb 2025 16:06:44 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgQqQ-0000000AD5U-1rZy
	for kexec@lists.infradead.org;
	Fri, 07 Feb 2025 16:04:43 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517EBqNR028628;
	Fri, 7 Feb 2025 16:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9XMr2A
	CuOZ3DXn0CmvjvXygdp2UhUHb82FDmLJ1f7Mw=; b=KH1oL2w5rXOhVP8PvS7o4x
	NSECp8u6spVG23L5twI5ZxV7NEsEiudzYaEB5J2CqN2aeWvjHJP0vPzVszUJzkLZ
	RKmw86ycxoSTLEQLfAIiMFvx5x3C/8iIoQdQny1VOVTZb1vrUQH4poziNAoBnbYT
	9/N9Z/znXUe7pKShVtt2aErXnwrpx2NT60nXBIwbPhmKrfrWzFPlaHOhqmX2lBzT
	YaKiVqteD4SflRoTP92BniUECbDEA3hADe+egmSsg76pniIPLtF3KHcsps7v4ok3
	+1RPyVNHptHuW3RpconkQ1A9dhGRBMbsQ8h5wmI3sPNIyJM4NMcC3mu6/RWvYDmg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44n910bngf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 16:04:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 517CJfj6005266;
	Fri, 7 Feb 2025 16:04:23 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j05kc1qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 16:04:23 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 517G4MHB35127878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Feb 2025 16:04:23 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1FA558052;
	Fri,  7 Feb 2025 16:04:22 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97C6D5805E;
	Fri,  7 Feb 2025 16:04:21 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.150.111])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Feb 2025 16:04:21 +0000 (GMT)
Message-ID: <aa75c604583ba982507dd2ad77668d0f2fb18962.camel@linux.ibm.com>
Subject: Re: [PATCH v7 6/7] ima: make the kexec extra memory configurable
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com
Date: Fri, 07 Feb 2025 11:04:21 -0500
In-Reply-To: <20250203232033.64123-8-chenste@linux.microsoft.com>
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
	 <20250203232033.64123-8-chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UiSiqQgDhdjG_i3TiKAZ_xBBrQZHIQ7Q
X-Proofpoint-GUID: UiSiqQgDhdjG_i3TiKAZ_xBBrQZHIQ7Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_07,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070121
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_080442_603447_DF461236 
X-CRM114-Status: GOOD (  23.60  )
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

Hi Steven,

On Mon, 2025-02-03 at 15:20 -0800, steven chen wrote:
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
> From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> ---
> =C2=A0security/integrity/ima/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +++++++=
+++
> =C2=A0security/integrity/ima/ima_kexec.c | 16 ++++++++++------
> =C2=A02 files changed, 20 insertions(+), 6 deletions(-)
>=20
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kcon=
fig
> index 475c32615006..54b145ae6096 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -321,4 +321,14 @@ config IMA_DISABLE_HTABLE
> =C2=A0	help
> =C2=A0	=C2=A0=C2=A0 This option disables htable to allow measurement of d=
uplicate records.
> =C2=A0
> +config IMA_KEXEC_EXTRA_MEMORY_KB
> +	int "Extra memory for IMA measurements added during kexec soft reboot"
> +	depends on IMA_KEXEC
> +	default 0
> +	help
> +	=C2=A0 IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
> +	=C2=A0 allocated (in kb) for IMA measurements added during kexec soft r=
eboot.
> +	=C2=A0 If set to the default value, an extra half a page of memory for =
those
> +	=C2=A0 additional measurements will be allocated.

-> If set to the default value of 0, an extra half page ...

> +
> =C2=A0endif
> diff --git a/security/integrity/ima/ima_kexec.c
> b/security/integrity/ima/ima_kexec.c
> index d5f004cfeaec..c9c916f69ca7 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -128,22 +128,26 @@ void ima_add_kexec_buffer(struct kimage *image)
> =C2=A0				=C2=A0 .buf_min =3D 0, .buf_max =3D ULONG_MAX,
> =C2=A0				=C2=A0 .top_down =3D true };
> =C2=A0	unsigned long binary_runtime_size;
> -
> +	unsigned long extra_size;
> =C2=A0	/* use more understandable variable names than defined in kbuf */
> =C2=A0	void *kexec_buffer =3D NULL;
> =C2=A0	size_t kexec_buffer_size =3D 0;
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	/*
> -	 * Reserve an extra half page of memory for additional measurements
> -	 * added during the kexec load.
> +	 * Reserve extra memory for measurements added during kexec.
> =C2=A0	 */

Please rename the variable from "extra_size" to "extra_memory".

thanks,

Mimmi

> -	binary_runtime_size =3D ima_get_binary_runtime_size();
> +	if (CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB <=3D 0)
> +		extra_size =3D PAGE_SIZE / 2;
> +	else
> +		extra_size =3D CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
> +	binary_runtime_size =3D ima_get_binary_runtime_size() + extra_size;
> +
> =C2=A0	if (binary_runtime_size >=3D ULONG_MAX - PAGE_SIZE)
> =C2=A0		kexec_segment_size =3D ULONG_MAX;
> =C2=A0	else
> -		kexec_segment_size =3D ALIGN(ima_get_binary_runtime_size() +
> -					=C2=A0=C2=A0 PAGE_SIZE / 2, PAGE_SIZE);
> +		kexec_segment_size =3D ALIGN(binary_runtime_size, PAGE_SIZE);
> +
> =C2=A0	if ((kexec_segment_size =3D=3D ULONG_MAX) ||
> =C2=A0	=C2=A0=C2=A0=C2=A0 ((kexec_segment_size >> PAGE_SHIFT) > totalram_=
pages() / 2)) {
> =C2=A0		pr_err("Binary measurement list too large.\n");


