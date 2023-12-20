Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932B6C3DA6E
	for <kexec@archiver.kernel.org>; Wed, 20 Dec 2023 20:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x57cJGFZ4VPGnI8i9AaQ8KPqej3fsKR8n7tzNgfxi80=; b=RBIZyx6b0Rd7EU
	4Nb+PBUS2N/+xpH6OoKRixJl71kBoxTb71eF8Bq3uUqjoA5KJ0O7FWaknTdkcKERUPKAz3BMhWnm7
	ehNLQX684QDfMnr3u677HgMWMB5UWBwL3sHJVkAdfUqwq5c6vqyuDOa9ai14o78YueZ5QnnMNz3VV
	Cj0W2/4aKAIbNwV7CF3z3y+UZuxjeNxw+GMwShJNniFH9p2Cm63aKP0Ku05uBKP/Oo8ZGkdC39SY3
	zkDk167thr4IYEDXYmCpLt6u4ARy/prXHrMqT8YvQ5FTcD9Ptb+hqv0X2loEmBNwFCXJ5eCxAcasd
	saALSSyombawOintdqJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rG3RP-000rxY-2v;
	Wed, 20 Dec 2023 20:45:19 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rG3RM-000rx8-2a
	for kexec@lists.infradead.org;
	Wed, 20 Dec 2023 20:45:18 +0000
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKKKqfg006967;
	Wed, 20 Dec 2023 20:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+eivzMpHiR9dqcoPhr9I2sG8eioSatSje9YLwU5CESU=;
 b=N1Ue48+EGXYfTOf6+L+u7auwyZgani8QyAb6EJqG0R7+wbgyZJx6h22VvHmd9nGreq9k
 p0seXuedVJ6+Zi67Z/B9puxcwVRfmfpAc5nCkoncMu2BnvkuRXanhfD1b9irPQ6wbTbm
 lm/zkqav/xbNNUhZKZQw3Q/gqrPZfPhaZ4x1OWDGj+tfh6fVmeiqz70/qtxL5wpo+3ET
 qdYvgQb2eOYbiZ4wjnkBwUVCbbnlCKIBYWEB85aNzQvm3eJHDDe3JTr3mL2ZKsYjA4Di
 PFPFxOK4NAUX+Jd+rl+Gn09NgYDnUFzYbM87kSom/NlBie8/cEZa1iaQqNUM/Mem6ZjU aw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v44aj5m4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 20:44:53 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKJvwHv010865;
	Wed, 20 Dec 2023 20:44:52 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1q7nrtj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 20:44:52 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BKKip2216974342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 20:44:52 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B87258062;
	Wed, 20 Dec 2023 20:44:51 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB7FA58056;
	Wed, 20 Dec 2023 20:44:50 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.116.58])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Dec 2023 20:44:50 +0000 (GMT)
Message-ID: <c174d4d7d3ab646f0e0ebf5aa1dd6894f22dbc02.camel@linux.ibm.com>
Subject: Re: [PATCH v3 5/7] ima: suspend measurements during buffer copy at
 kexec execute
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Wed, 20 Dec 2023 15:44:50 -0500
In-Reply-To: <20231216010729.2904751-6-tusharsu@linux.microsoft.com>
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
	 <20231216010729.2904751-6-tusharsu@linux.microsoft.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wgZH-AtCnqNFLdBJVvwFqby10oaP38qr
X-Proofpoint-ORIG-GUID: wgZH-AtCnqNFLdBJVvwFqby10oaP38qr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_13,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312200146
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231220_124516_854221_757DFB49 
X-CRM114-Status: GOOD (  31.85  )
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

On Fri, 2023-12-15 at 17:07 -0800, Tushar Sugandhi wrote:
> If the new measurements are added to the IMA log while it is being 
> being copied to the kexec buffer during kexec 'execute', it can miss
> copying those new measurements to the kexec buffer, and the buffer can go
> out of sync with TPM PCRs.  This could result in breaking the integrity
> of the measurements after the kexec soft reboot to the new Kernel.
> 
> Add a check in the ima_add_template_entry() function not to measure
> events and return from the function early when 'suspend_ima_measurements'
> flag is set.
> 
> This ensures the consistency of the IMA measurement list while copying 
> them to the kexec buffer.  When the 'suspend_ima_measurements' flag is
> set, any new measurements will be ignored until the flag is unset.  This
> allows the buffer to be safely copied without worrying about concurrent
> modifications to the measurement list.  This is crucial for maintaining
> the integrity of the measurements during a kexec soft reboot.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_queue.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index cb9abc02a304..5946a26a2849 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -195,6 +195,19 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
>  		}
>  	}
>  
> +	/*
> +	 * suspend_ima_measurements will be set if the system is
> +	 * undergoing kexec soft boot to a new kernel.
> +	 * suspending measurements in this short window ensures the
> +	 * consistency of the IMA measurement list during copying
> +	 * of the kexec buffer.
> +	 */
> +	if (atomic_read(&suspend_ima_measurements)) {
> +		audit_cause = "measurements_suspended";
> +		audit_info = 0;
> +		goto out;
> +	}
> +
>  	result = ima_add_digest_entry(entry,
>  				      !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE));
>  	if (result < 0) {

I assume you meant to include the suspend/resume code in "ima: kexec:
move ima log copy from kexec load to execute"  in this patch.

-- 
thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
