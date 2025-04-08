Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756D7C3600C
	for <kexec@archiver.kernel.org>; Tue,  8 Apr 2025 04:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YvB+GCv95InVqLU0AIlukc3jsAEcfMFGSNvBp6QgU0E=; b=tUbrGJaxsd2FaaDNUO3WNDiiYK
	10QMggJTjY3Cv1dIcTV04JhImQr3IydzsE2UC0WuFvjQRqzaf4dgBMKmt0uTKSKC5zeZx2VMuSWyG
	M5Y08Rol/1sHUbYgyVuSpqDy4tFGfTpKAAd6PU9X51CNNuCkM4un/2bIJ1300ABNzxLjCOaztTZAn
	s3ExImEO5H61MPWOmDhczuphylGu3Q4breBfqafU8hyG4MAPmixiUo7Pfp+UgFfZaFmw8Ka34pUc0
	kG60NnQi5z1glk0jxTPLVylVKsgDiF2r//vFW5klsaecKYieGtRJseQmL4d5cmmfF9h0ukts2/z28
	5C++Z3zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u20Ft-00000002fua-0iN5;
	Tue, 08 Apr 2025 04:08:09 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u20Fq-00000002fu2-44ef
	for kexec@lists.infradead.org;
	Tue, 08 Apr 2025 04:08:08 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537KcxuV029216;
	Tue, 8 Apr 2025 04:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YvB+GC
	v95InVqLU0AIlukc3jsAEcfMFGSNvBp6QgU0E=; b=HbuQvAxeFtnI124hzczh2Q
	T+TB4CwUzHI8HJxsgOu9mJbITu3rrCV9mnuj6+27RbUP3fu1wKWc7+Qn13VpDsIP
	sRZcd/c6Up9HKLRnXZmCbQIY0FY4WAPB/awzoScKEWzvJdRvSKZFl6rEG+lhlzDo
	1sWWeS4eybBI/C6vS+3dSuAH30LGw+OGzf5vWZH5wQShfQVw8dfZjDTCyIx90Z4R
	8PCtM+z88xgp6ySPwG4eZLO3wPXGJ/mlY08iXCW8t7ufCXNJDGud+doyuqUMtz26
	x/I0+vD7h0q6t772j+Zl9Mck5SerKQy3BEaR0bOSzmrGKBD73AdSINxKH8FWBQmA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45vnx0hcy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 04:07:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5383Ru7I013932;
	Tue, 8 Apr 2025 04:07:45 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufungyfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 04:07:45 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53847il140894916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Apr 2025 04:07:44 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8ABB558045;
	Tue,  8 Apr 2025 04:07:44 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B006558056;
	Tue,  8 Apr 2025 04:07:42 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.146.87])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Apr 2025 04:07:42 +0000 (GMT)
Message-ID: <a293ed27094f7fa7a36f1641a9e6b17a49e26fa0.camel@linux.ibm.com>
Subject: Re: [PATCH v11 2/9] ima: define and call ima_alloc_kexec_file_buf()
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
Date: Tue, 08 Apr 2025 00:07:42 -0400
In-Reply-To: <20250402124725.5601-3-chenste@linux.microsoft.com>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
	 <20250402124725.5601-3-chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qq2Ty_CRuz33wUrMjLXD0GCtcegHGBk6
X-Proofpoint-ORIG-GUID: Qq2Ty_CRuz33wUrMjLXD0GCtcegHGBk6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_01,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080026
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_210807_131578_E77074A7 
X-CRM114-Status: GOOD (  21.44  )
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

On Wed, 2025-04-02 at 05:47 -0700, steven chen wrote:
> In the current implementation, the ima_dump_measurement_list() API is=20
> called during the kexec "load" phase, where a buffer is allocated and=20
> the measurement records are copied. Due to this, new events added after
> kexec load but before kexec execute are not carried over to the new kerne=
l
> during kexec operation

Repeating this here is unnecessary.
>=20
> To allow the buffer allocation and population to be separated into distin=
ct
> steps, make the function local seq_file "ima_kexec_file" to a file variab=
le.

This change was already made in [PATCH v11 1/9] ima: rename variable the
set_file "file" to "ima_kexec_file".  Please remove.

>=20
> Carrying the IMA measurement list across kexec requires allocating a
> buffer and copying the measurement records.  Separate allocating the
> buffer and copying the measurement records into separate functions in
> order to allocate the buffer at kexec 'load' and copy the measurements
> at kexec 'execute'.
>=20
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_kexec.c | 46 +++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 11 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/=
ima_kexec.c
> index 650beb74346c..b12ac3619b8f 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -15,26 +15,46 @@
>  #include "ima.h"
> =20
>  #ifdef CONFIG_IMA_KEXEC
> +static struct seq_file ima_kexec_file;
> +
> +static void ima_free_kexec_file_buf(struct seq_file *sf)
> +{
> +	vfree(sf->buf);
> +	sf->buf =3D NULL;
> +	sf->size =3D 0;
> +	sf->read_pos =3D 0;
> +	sf->count =3D 0;
> +}
> +
> +static int ima_alloc_kexec_file_buf(size_t segment_size)
> +{
> +	ima_free_kexec_file_buf(&ima_kexec_file);

After moving the vfree() here at this stage in the patch set, the IMA
measurement list fails to verify when doing two consecutive "kexec -s -l"
with/without a "kexec -s -u" in between.  Only after "ima: kexec: move IMA =
log
copy from kexec load to execute" the IMA measurement list verifies properly=
 with
the vfree() here.

> +
> +	/* segment size can't change between kexec load and execute */
> +	ima_kexec_file.buf =3D vmalloc(segment_size);
> +	if (!ima_kexec_file.buf)
> +		return -ENOMEM;
> +
> +	ima_kexec_file.size =3D segment_size;
> +	ima_kexec_file.read_pos =3D 0;
> +	ima_kexec_file.count =3D sizeof(struct ima_kexec_hdr);	/* reserved spac=
e */
> +
> +	return 0;
> +}
> +


