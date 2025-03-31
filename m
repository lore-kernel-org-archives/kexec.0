Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B78AC3600B
	for <kexec@archiver.kernel.org>; Mon, 31 Mar 2025 12:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DAS3QfVduVCmO3oX+ysteuIaBnDDCBZMqPHqxm0kNe8=; b=O57CGYBjEsqZEo8WlcBGVG17/F
	cOMSZCZ7JIe+X5Bgv4L171BxoMm4uUoWWacdTje6e92uHtOtyQmefv/2YoXuGt5+GZYG2lfO/f8ok
	Qx+4O5WPdPaA6IKpG0QaSl+eZGwb8KmEW0KPJd3rZrDpMIIMyA3x6rRnOUOhfqdP2TBeT3QZHJFSK
	wh9xDvsivR4yvuX0qrgBtrMzF/HCnqmYADhzYWvR4x7nl6RZLwCUPPmcem/QwpYToikD/zAuU4U7d
	vOcyrwY2PdOc4h2s5N+68f0W5bAznWrmCNop2ISPKPGloVIzDlppb2QEcsJv9Gm2acX3BJcyCT0Bh
	+W7rd5cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzE48-00000000JNl-0tar;
	Mon, 31 Mar 2025 12:16:32 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzE2q-00000000JHK-2Vqx
	for kexec@lists.infradead.org;
	Mon, 31 Mar 2025 12:15:13 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VA6Z4a002260;
	Mon, 31 Mar 2025 12:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DAS3Qf
	VduVCmO3oX+ysteuIaBnDDCBZMqPHqxm0kNe8=; b=oGk0LocNUBfehVIwZr/grj
	UvMef8S9twmN3yxGUvo552Ofwt1juMQMZn8aJiHSjlGakHRobWQt89NmpS8Hu5QY
	IcvEFhyByTnfVveMgKc8oYP7k+gV6Kmj52N6Pu82xhpE3mDHOmlGdcm39FoZtavS
	miEVv9XfBFtxEa4Wm61pnXq8femlwKyNZWwH4UEA0ZztJ4ZcJMuNneP3kaVAJaEw
	SPirWiiu1U3sCGdFrfV731ZOUD8HznAamsvRpUmbieyza1tN68yJD1x6DRYgtQXr
	Kvlc+VtpaOYriDmZk9jpzuMrWEDGviceu97LkKk0/YjJmCF7wlbG/7yTPXFlvwqw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45q602m8d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 12:15:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52V9sde8009923;
	Mon, 31 Mar 2025 12:15:09 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pv6nnp6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 12:15:09 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52VCF9AD14942800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 12:15:09 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3672758067;
	Mon, 31 Mar 2025 12:15:09 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF44658065;
	Mon, 31 Mar 2025 12:15:08 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.25.252])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Mar 2025 12:15:08 +0000 (GMT)
Message-ID: <b1eba83a9f68ed9a19100f6c0dc5aca7aff437d5.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
From: Mimi Zohar <zohar@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Date: Mon, 31 Mar 2025 08:15:08 -0400
In-Reply-To: <20250331061611.253919-1-bhe@redhat.com>
References: <20250331061611.253919-1-bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6HTO2PTXK2LFu8-IhktYn7Za56xczjAB
X-Proofpoint-ORIG-GUID: 6HTO2PTXK2LFu8-IhktYn7Za56xczjAB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_05,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503310085
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250331_051512_648092_48A9C4A0 
X-CRM114-Status: GOOD (  22.57  )
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

On Mon, 2025-03-31 at 14:16 +0800, Baoquan He wrote:
> It doesn't make sense to run IMA functionality in kdump kernel, and that
> will cost extra memory. It would be great to allow IMA to be disabled on
> purpose, e.g for kdump kernel.
>=20
> Hence add a knob here to allow people to disable IMA if needed.
>=20
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  security/integrity/ima/ima_main.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 28b8b0db6f9b..5d677d1389fe 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -38,11 +38,27 @@ int ima_appraise;
> =20
>  int __ro_after_init ima_hash_algo =3D HASH_ALGO_SHA1;
>  static int hash_setup_done;
> +static int ima_disabled =3D 0;
> =20
>  static struct notifier_block ima_lsm_policy_notifier =3D {
>  	.notifier_call =3D ima_lsm_policy_change,
>  };
> =20
> +static int __init ima_setup(char *str)
> +{
> +	if (strncmp(str, "off", 3) =3D=3D 0)
> +                ima_disabled =3D 1;
> +        else if (strncmp(str, "on", 2) =3D=3D 0)
> +                ima_disabled =3D 0;
> +        else
> +                pr_err("invalid ima setup option: \"%s\" ", str);
> +
> +	return 1;
> +}
> +__setup("ima=3D", ima_setup);

I understand your wanting to disable IMA for Kdump, but this goes way beyon=
d
that.  Please don't make it generic like this.

Please refer to ima_appraise_parse_cmdline().

Mimi

> +
> +
> +
>  static int __init hash_setup(char *str)
>  {
>  	struct ima_template_desc *template_desc =3D ima_template_desc_current()=
;
> @@ -1176,6 +1192,11 @@ static int __init init_ima(void)
>  {
>  	int error;
> =20
> +	if (ima_disabled) {
> +		pr_info("IMA functionality is disabled on purpose!");
> +		return 0;
> +	}
> +
>  	ima_appraise_parse_cmdline();
>  	ima_init_template_list();
>  	hash_setup(CONFIG_IMA_DEFAULT_HASH);


