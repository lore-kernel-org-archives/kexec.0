Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C2EC02194
	for <kexec@archiver.kernel.org>; Fri,  7 Feb 2025 19:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZFrW49+Epm/QRPQlGO4LNK3NBVsNDkvRNdGiTRRz3oo=; b=PAKgzbs7G2wZIUrxxaBQD6S+EH
	INhhIqnVTGkalfA7y8PGdnEc1Z7HMdTVLJ+CnGWWTSCdUzpvRevIiGFOOzNk5LudXsNrVdQEm1owF
	y7i0bwx3pNYW08lYL3Au2cmQYtJ/5CwCjlBx6hx0rEYb4Td+GBzz8FHaoM7ig8fZClUHIXta26DNg
	NMITbdloXk55fHPy9f1brhUYeXy5bDWm2vWM5M0lbqqSDZ4RZ005KH/vqPhrWH1F9Rgv2HuWEjyCt
	fYXZDRKWw/04EvYBSC9cXVgdFvKg1o0xysBt0BudCno3NqiASpNB1HDG+AZFfHueqGhDqg2yVgz+P
	u57jVYQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgTkc-0000000ArYO-1lyk;
	Fri, 07 Feb 2025 19:10:54 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgTka-0000000ArXi-0HlX
	for kexec@lists.infradead.org;
	Fri, 07 Feb 2025 19:10:53 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517Hc8H6004422;
	Fri, 7 Feb 2025 19:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZFrW49
	+Epm/QRPQlGO4LNK3NBVsNDkvRNdGiTRRz3oo=; b=aX7z8Xh8Gae3wzDbqnDo9v
	ivhvizxT73A7ioZ6QfW+BOmKp5h+iQ15bQo60qqsRgRcfCeaETCT7vVYn3+QOA38
	Sph4SMrd3WtX32rfd4lv5jzLhRCoRwqeobX9D2AFeEnv01EMq5+v6z9wNgP8YsQ9
	u1laprOsb+/1zGPM00bB+j1tLc1/Jkv8aooIW//DfWI8F7RwNOUTzG8fRlpjmrse
	M/Zt7vDnC/aw9lEPh9NyHna4uwBpnFdEE2fDT6e1DeawTo5OMheoUs9IWwq3/cIO
	yhMoUJg2PHgbjP4pqBoIfm2jHCYYf7O5MUIEmSmrSnwJe4U407shKQ26f6K0kwVg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44nfn5jwns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 19:10:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 517H0QAV021508;
	Fri, 7 Feb 2025 19:10:35 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j0n1vqs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 19:10:35 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 517JAZfD65077650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Feb 2025 19:10:35 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B8F15805D;
	Fri,  7 Feb 2025 19:10:35 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0F1858043;
	Fri,  7 Feb 2025 19:10:32 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.80.253])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Feb 2025 19:10:32 +0000 (GMT)
Message-ID: <1a7e9cf84715386b7ac3dc2103fd38ba180dd216.camel@linux.ibm.com>
Subject: Re: [PATCH v7 1/7] ima: define and call ima_alloc_kexec_file_buf
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com
Date: Fri, 07 Feb 2025 14:10:32 -0500
In-Reply-To: <20250203232033.64123-2-chenste@linux.microsoft.com>
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
	 <20250203232033.64123-2-chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7QGSpxPfaoZwyEkN0gvx2kdN2Zxuv-kP
X-Proofpoint-GUID: 7QGSpxPfaoZwyEkN0gvx2kdN2Zxuv-kP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_09,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070142
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_111052_122932_72568CBF 
X-CRM114-Status: GOOD (  27.02  )
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

On Mon, 2025-02-03 at 15:20 -0800, steven chen wrote:
> Carrying the IMA measurement list across kexec requires allocating a
> buffer and copying the measurement records.=C2=A0 Separate allocating the
> buffer and copying the measurement records into separate functions in
> order to allocate the buffer at kexec 'load' and copy the measurements
> at kexec 'execute'.
>=20
> This patch includes the following changes:
> =C2=A0- Refactor ima_dump_measurement_list() to move the memory allocatio=
n
> =C2=A0=C2=A0 to a separate function ima_alloc_kexec_file_buf() which allo=
cates
> =C2=A0=C2=A0 buffer of size 'kexec_segment_size' at kexec 'load'.
> =C2=A0- Make the local variable ima_kexec_file in ima_dump_measurement_li=
st()
> =C2=A0=C2=A0 a local static to the file, so that it can be accessed from=
=20
> =C2=A0=C2=A0 ima_alloc_kexec_file_buf(). Compare actual memory required t=
o ensure=20
> =C2=A0=C2=A0 there is enough memory for the entire measurement record.
> =C2=A0- Copy as many measurement events as possible.
> =C2=A0- Make necessary changes to the function ima_add_kexec_buffer() to =
call
> =C2=A0=C2=A0 the above two functions.
> =C2=A0- Compared the memory size allocated with memory size of the entire=
=20
> =C2=A0=C2=A0 measurement record. If there is not enough memory, it will c=
opy as many
> =C2=A0=C2=A0 IMA measurement records as possible, and this situation will=
 result
> =C2=A0=C2=A0 in a failure of remote attestation.
>=20
> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> ---
> =C2=A0security/integrity/ima/ima.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 1 +
> =C2=A0security/integrity/ima/ima_kexec.c | 105 +++++++++++++++++++++-----=
---
> =C2=A0security/integrity/ima/ima_queue.c |=C2=A0=C2=A0 4 +-
> =C2=A03 files changed, 80 insertions(+), 30 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 3c323ca213d4..447a6eb07c2d 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -274,6 +274,7 @@ bool ima_template_has_modsig(const struct ima_templat=
e_desc
> *ima_template);
> =C2=A0int ima_restore_measurement_entry(struct ima_template_entry *entry)=
;
> =C2=A0int ima_restore_measurement_list(loff_t bufsize, void *buf);
> =C2=A0int ima_measurements_show(struct seq_file *m, void *v);
> +int ima_get_binary_runtime_entry_size(struct ima_template_entry *entry);
> =C2=A0unsigned long ima_get_binary_runtime_size(void);
> =C2=A0int ima_init_template(void);
> =C2=A0void ima_init_template_list(void);
> diff --git a/security/integrity/ima/ima_kexec.c
> b/security/integrity/ima/ima_kexec.c
> index 52e00332defe..b60a902460e2 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -15,62 +15,99 @@
> =C2=A0#include "ima.h"
> =C2=A0
> =C2=A0#ifdef CONFIG_IMA_KEXEC
> +static struct seq_file ima_kexec_file;
> +
> +static void ima_reset_kexec_file(struct seq_file *sf)
> +{
> +	sf->buf =3D NULL;
> +	sf->size =3D 0;
> +	sf->read_pos =3D 0;
> +	sf->count =3D 0;
> +}
> +
> +static void ima_free_kexec_file_buf(struct seq_file *sf)
> +{
> +	vfree(sf->buf);
> +	ima_reset_kexec_file(sf);
> +}
> +
> +static int ima_alloc_kexec_file_buf(size_t segment_size)
> +{
> +	/*
> +	 * kexec 'load' may be called multiple times.
> +	 * Free and realloc the buffer only if the segment_size is
> +	 * changed from the previous kexec 'load' call.
> +	 */
> +	if (ima_kexec_file.buf &&
> +		(ima_kexec_file.size =3D=3D segment_size)) {
> +		goto out;
> +	}

Nice cleanup from v5.  The line doesn't doesn't need to be split.  Both the
parenthesis and the brackets can be removed.

In the future, before posting patches, please use scripts/checkpatch.pl.

CHECK: Unnecessary parentheses around 'ima_kexec_file.size =3D=3D segment_s=
ize'
#82: FILE: security/integrity/ima/ima_kexec.c:41:
+	if (ima_kexec_file.buf &&
+		(ima_kexec_file.size =3D=3D segment_size)) {

CHECK: Alignment should match open parenthesis
#83: FILE: security/integrity/ima/ima_kexec.c:42:
+	if (ima_kexec_file.buf &&
+		(ima_kexec_file.size =3D=3D segment_size)) {

Or simply join the two lines.

thanks,

Mimi

> +
> +	ima_free_kexec_file_buf(&ima_kexec_file);
> +
> +	/* segment size can't change between kexec load and execute */
> +	ima_kexec_file.buf =3D vmalloc(segment_size);
> +	if (!ima_kexec_file.buf)
> +		return -ENOMEM;
> +
> +	ima_kexec_file.size =3D segment_size;
> +
> +out:
> +	ima_kexec_file.read_pos =3D 0;
> +	ima_kexec_file.count =3D sizeof(struct ima_kexec_hdr);	/* reserved spac=
e
> */
> +
> +	return 0;
> +}
>=20


