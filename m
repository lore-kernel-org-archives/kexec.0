Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD02C021B3
	for <kexec@archiver.kernel.org>; Fri, 21 Feb 2025 19:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=heDO+gAI4iMzWupr9MuQuH5tFKokm/yoJasfRTU3cp0=; b=iDGjsxg0bN7u1pkFhiWsvjJwFB
	CUTUbgSu+AKfyEoybxuW+VuNuR/B/Y5kpe6MkZ+GWxDIrwGfymgwnVElA3selFA+tMZAdepLz3/An
	7Jhn5H1P/I2SjPOtQ/iCxOeqP0qUrY3FtA9JTjjQQ3l5HH96RlF0AePvWlvZ45N5TAx7w8E5u1R91
	xJzkyVJMaWVCgDVx0SH9fPfq6/TFVKDdJnWRWc5a53tq/2wK5/3LmN4j413Ag0+3MgfdtLsGW35dI
	BusXWeLWzpmYZdB1U6mdg8LoSPfwO7mLsDcXq9f1DGjQR1uPB9KRQ96C3qTZmeoaylMBszP5DfYVa
	AvSfS1JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlYN5-00000006bLS-1CR1;
	Fri, 21 Feb 2025 19:07:35 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlYN3-00000006bL0-1DSS
	for kexec@lists.infradead.org;
	Fri, 21 Feb 2025 19:07:34 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LIMe4x031829;
	Fri, 21 Feb 2025 19:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=heDO+g
	AI4iMzWupr9MuQuH5tFKokm/yoJasfRTU3cp0=; b=Qj+db7xuvQd+nLbmOaiux2
	t+dRcrAR5dmeYNxeHzpBkasiuD429gJdAjnZDSxHONM9ufyDtezX5oGPoWAtvtOf
	ODXcoEubCilZiTOwHVyLuyW/4I1TcywKpvsk9S3Gr9O3UtvUOiku5JWNAkxhBbhn
	nQIazWPTtCUMDzxxV9BAb3EZZYrN7giiqGkzy0vOAiwsqzjbSg5TTHuc4mgkh18D
	0x6tPCQliBF4xyVQKSAcPdd92tbI5m9jkeNO5Xr7In9Gd0IO6ZbIkMotkpL9uoVB
	Hbm0DJIEXtsKbo9B+zqK/Wy7eWKlCqeMH9P/KzLvza6FaH657PpkisP2ZvKdJ6uQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xgb0ck69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 19:07:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51LIkAsL002433;
	Fri, 21 Feb 2025 19:07:13 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03xhnkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 19:07:13 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51LJ7DoQ32244352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 19:07:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39CA158052;
	Fri, 21 Feb 2025 19:07:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1634658065;
	Fri, 21 Feb 2025 19:07:12 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.108.12])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Feb 2025 19:07:12 +0000 (GMT)
Message-ID: <36f8cb5131c51f784fa6e7a062b6318b30c9cc28.camel@linux.ibm.com>
Subject: Re: [PATCH v8 4/7] ima: kexec: define functions to copy IMA log at
 soft boot
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
Date: Fri, 21 Feb 2025 14:07:11 -0500
In-Reply-To: <20250218225502.747963-5-chenste@linux.microsoft.com>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
	 <20250218225502.747963-5-chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tl1t-f3xrxoME_Ejbk6c9jgxYK4Zw_1d
X-Proofpoint-ORIG-GUID: tl1t-f3xrxoME_Ejbk6c9jgxYK4Zw_1d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_07,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210131
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250221_110733_448411_37031E42 
X-CRM114-Status: GOOD (  27.07  )
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

On Tue, 2025-02-18 at 14:54 -0800, steven chen wrote:
> IMA log is copied to the new Kernel during kexec 'load' using=20
> ima_dump_measurement_list().=C2=A0 The log copy at kexec 'load' may resul=
t in
> loss of IMA measurements during kexec soft reboot.=C2=A0 It needs to be c=
opied
> over during kexec 'execute'.=C2=A0 Setup the needed infrastructure to mov=
e the
> IMA log copy from kexec 'load' to 'execute'.=20
>=20
> Define a new IMA hook ima_update_kexec_buffer() as a stub function.
> It will be used to call ima_dump_measurement_list() during kexec=20
> 'execute'.=C2=A0=C2=A0=20
>=20
> Implement ima_kexec_post_load() function to be invoked after the new=20
> Kernel image has been loaded for kexec. ima_kexec_post_load() maps the=
=20
> IMA buffer to a segment in the newly loaded Kernel.=C2=A0 It also registe=
rs=20
> the reboot notifier_block to trigger ima_update_kexec_buffer() at=20
> exec 'execute'.
>=20
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> ---
> =C2=A0include/linux/ima.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++
> =C2=A0security/integrity/ima/ima_kexec.c | 46 +++++++++++++++++++++++++++=
+++
> =C2=A02 files changed, 49 insertions(+)
>=20
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 0bae61a15b60..8e29cb4e6a01 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -32,6 +32,9 @@ static inline void ima_appraise_parse_cmdline(void) {}
> =C2=A0
> =C2=A0#ifdef CONFIG_IMA_KEXEC
> =C2=A0extern void ima_add_kexec_buffer(struct kimage *image);
> +extern void ima_kexec_post_load(struct kimage *image);
> +#else
> +static inline void ima_kexec_post_load(struct kimage *image) {}
> =C2=A0#endif
> =C2=A0
> =C2=A0#else
> diff --git a/security/integrity/ima/ima_kexec.c
> b/security/integrity/ima/ima_kexec.c
> index 704676fa6615..0fa65f91414b 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -12,10 +12,14 @@
> =C2=A0#include <linux/kexec.h>
> =C2=A0#include <linux/of.h>
> =C2=A0#include <linux/ima.h>
> +#include <linux/reboot.h>
> +#include <asm/page.h>
> =C2=A0#include "ima.h"
> =C2=A0
> =C2=A0#ifdef CONFIG_IMA_KEXEC
> =C2=A0static struct seq_file ima_kexec_file;
> +static void *ima_kexec_buffer;
> +static bool ima_kexec_update_registered;
> =C2=A0
> =C2=A0static void ima_reset_kexec_file(struct seq_file *sf)
> =C2=A0{
> @@ -183,6 +187,48 @@ void ima_add_kexec_buffer(struct kimage *image)
> =C2=A0	kexec_dprintk("kexec measurement buffer for the loaded kernel at
> 0x%lx.\n",
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kbuf.mem);
> =C2=A0}
> +
> +/*
> + * Called during kexec execute so that IMA can update the measurement li=
st.
> + */
> +static int ima_update_kexec_buffer(struct notifier_block *self,
> +				=C2=A0=C2=A0 unsigned long action, void *data)
> +{
> +	return NOTIFY_OK;
> +}
> +
> +struct notifier_block update_buffer_nb =3D {
> +	.notifier_call =3D ima_update_kexec_buffer,
> +};
> +
> +/*
> + * Create a mapping for the source pages that contain the IMA buffer
> + * so we can update it later.
> + */

Hi Steven,

It does more than just that.  It also registers a second IMA reboot notifie=
r.=20
(Is a second reboot notifier really necessary?)  It seems that the
ima_reboot_notifier() is executed after this one, otherwise the kexec_execu=
te
would be missing.  However, I'm not sure that is guaranteed.

I'm wondering if this patch should be limited to saving the map segments.  =
In
any case, using the reboot notifier is relatively new and should at least b=
e
reflected here and in the patch description.

thanks,

Mimi

> +void ima_kexec_post_load(struct kimage *image)
> +{
> +	if (ima_kexec_buffer) {
> +		kimage_unmap_segment(ima_kexec_buffer);
> +		ima_kexec_buffer =3D NULL;
> +	}
> +
> +	if (!image->ima_buffer_addr)
> +		return;
> +
> +	ima_kexec_buffer =3D kimage_map_segment(image,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 image->ima_buffer_addr,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 image->ima_buffer_size);
> +	if (!ima_kexec_buffer) {
> +		pr_err("Could not map measurements buffer.\n");
> +		return;
> +	}
> +
> +	if (!ima_kexec_update_registered) {
> +		register_reboot_notifier(&update_buffer_nb);
> +		ima_kexec_update_registered =3D true;
> +	}
> +}
> +
> =C2=A0#endif /* IMA_KEXEC */
> =C2=A0
> =C2=A0/*


