Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E90EB64D9
	for <kexec@archiver.kernel.org>; Fri,  7 Jul 2023 15:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rMggVTPrjRMKJNIeUSQ2kbjPZZvJ+nIdcl6sFBxd23g=; b=Y29gSj2xTcNA8l
	IksuXlivImXXeuj5eCmkaMQuxkvDQ1CARzhzmhv+/aZWpFH3aTD7FgU8JoUGf7lqTyLAKxHX14TbV
	7Y1oK7jMhjD3tER/QREEnefdATq9B0HKOHdJ5padbcV5wQDtc0m4CpPn3wHWdTp+DM1yfAGBh2Qxy
	4gyVz69JtwidlrKNM/IM/YKyCw4KN/zYa75HFcy19a2Ci3+GFmPwcmz1i5Ddf/3BI7zojHGgJJmWb
	ujJV3/4mSM4OSm7T+TybHfo/3clUUW/zzO8g1XT7iEyon7FHVfLQlnwxVCKf3td8DH+I18MZPVFQ5
	Azf6dt4MDOj/iRWoW6uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHmzG-004xvT-2h;
	Fri, 07 Jul 2023 15:03:10 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHmzE-004xuL-32
	for kexec@lists.infradead.org;
	Fri, 07 Jul 2023 15:03:10 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367EqJX8030176;
	Fri, 7 Jul 2023 15:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=e4L2IAnPOuCma6RJoU3QN8PWjT78HhgqR2PhYWPWuDg=;
 b=l5Sc+o6uFol8YlkTS6zHzuqqyEnGMVIc1OhbY366Ej0Zxpe4oJpjRATAyCFKIRQdg/tO
 7sGARC5GiLKmSIXfqA8AZH7q5t91g8odbVpV+I3LrqkR1oBPTWrLsdH3Fs2x4shcNhd2
 Gh71tVznf38fE4RiZvcAH76H1vMrAqgjhATla3rmbliv0wcAfaKoTFp/Rcy1p9MC+MeI
 CkduvKP0RbmuGcvjeYgqAFmJkoqvQjk0a755nGTfSWszJFuWbL72m/e8nip09+gj1Hx3
 lwkvFqStxpS8VcgiDgVvQQJIrozW+aAoggIjbegPi7lhrOV1wP9uWb+P/EYOJBASQPwz +w== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpmuhr7jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jul 2023 15:02:51 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
	by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 367Ag2Rc022997;
	Fri, 7 Jul 2023 15:01:50 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
	by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3rjbs5wwmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jul 2023 15:01:50 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 367F1ndi64356838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Jul 2023 15:01:49 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D89E5805E;
	Fri,  7 Jul 2023 15:01:49 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1B9258051;
	Fri,  7 Jul 2023 15:01:48 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.7.157])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Jul 2023 15:01:48 +0000 (GMT)
Message-ID: <5cd5b5efc443cbdce9dce3b121f4dbfd2db6dea3.camel@linux.ibm.com>
Subject: Re: [PATCH 06/10] ima: update buffer at kexec execute with ima
 measurements
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Fri, 07 Jul 2023 11:01:48 -0400
In-Reply-To: <20230703215709.1195644-7-tusharsu@linux.microsoft.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
	 <20230703215709.1195644-7-tusharsu@linux.microsoft.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S_68gnkbdCDoAkCtxBx-RJ6sGlfqDlYw
X-Proofpoint-ORIG-GUID: S_68gnkbdCDoAkCtxBx-RJ6sGlfqDlYw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 malwarescore=0 impostorscore=0 spamscore=0 mlxlogscore=956
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070139
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230707_080308_993323_346C71E2 
X-CRM114-Status: GOOD (  19.00  )
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

Hi Tushar,

On Mon, 2023-07-03 at 14:57 -0700, Tushar Sugandhi wrote:

> +/*
> + * Called during kexec execute so that IMA can update the measurement list.
> + */
> +static int ima_update_kexec_buffer(struct notifier_block *self,
> +				   unsigned long action, void *data)
> +{
> +	void *new_buffer = NULL;
> +	size_t new_buffer_size, cur_buffer_size;
> +	bool resume = false;
> +
> +	if (!kexec_in_progress) {
> +		pr_info("%s: No kexec in progress.\n", __func__);
> +		return NOTIFY_OK;
> +	}
> +
> +	if (!ima_kexec_buffer) {
> +		pr_err("%s: Kexec buffer not set.\n", __func__);
> +		return NOTIFY_OK;
> +	}
> +
> +	ima_measurements_suspend();
> +
> +	cur_buffer_size = kexec_segment_size - sizeof(struct ima_kexec_hdr);
> +	new_buffer_size = ima_get_binary_runtime_size();
> +	if (new_buffer_size > cur_buffer_size) {
> +		pr_err("%s: Measurement list grew too large.\n", __func__);
> +		resume = true;
> +		goto out;
> +	}

This changes the current behavior of carrying as many measurements
across kexec as possible.  True the measurement list won't verify
against the TPM PCRs, but not copying the measurements leaves the
impression there weren't any previous measurements.

This also explains the reason for allocating an IMA buffer (patch 1/10)
and not writing the measurements directly into the kexec buffer.

> +	ima_populate_buf_at_kexec_execute(&new_buffer_size, &new_buffer);
> +
> +	if (!new_buffer) {
> +		pr_err("%s: Dump measurements failed.\n", __func__);
> +		resume = true;
> +		goto out;
> +	}
> +	memcpy(ima_kexec_buffer, new_buffer, new_buffer_size);
> +out:
> +	kimage_unmap_segment(ima_kexec_buffer);
> +	ima_kexec_buffer = NULL;
> +
> +	if (resume)
> +		ima_measurements_resume();
> +
> +	return NOTIFY_OK;
> +}
> +
>  #endif /* IMA_KEXEC */
>  
>  /*

-- 
thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
