Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19461C47258
	for <kexec@archiver.kernel.org>; Tue, 23 Jan 2024 18:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HqJrmDpLhsgMwJF9SvUaOau+APA/IpDWtu51CjkBGQc=; b=oydE4A8ifba6Ma
	WIJ5Y6N5FN2JulD+J16LyvQJ6dx58M941cnk6cFXLo89/gDSlgEoGCYCANVLS8sA67fT917OR4SPU
	+HLuLm/K0o8XxUJWUb6TmjeVdPfdowVzK6MtSsCgnw9UAmRigoN4bHL8bbikPBKUdrpr2twPjxzRn
	Q9V6tNmO7ZYZ+oXY1mkHUCFEhU0FKSjdrJlOBzAfuAQ8HOfhId9WSrKHeRWZPJkOTjoANz9GftXI1
	hz++RjhaZDF4Tx9+3aP7So1LWDMFQgYSRot7xPsfrJjmQBG69EDm8ZFLis/bXPe9H41vmS3BRvrgz
	zc9WKuKBNQlE4qzvmX0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSLM6-00041N-2Z;
	Tue, 23 Jan 2024 18:18:38 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSLM3-00040x-0n
	for kexec@lists.infradead.org;
	Tue, 23 Jan 2024 18:18:37 +0000
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NGfxAt031948;
	Tue, 23 Jan 2024 18:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=thKzIJqvRB52MBDm+eqDNHw32kf/htRwmQEYyPwJtg8=;
 b=NJ0pXjX1RQGfxP4CUVnAi35BxJmx8I+CpnUWU3fOgJKySnUQVgJqDJMtlC/PDN8LM+hX
 /v1zOtEvshmJzMRopqp8Hs/88iQMfNOcO0kJ4lRR4lRzUtqqOpESEbuSDd8zYrn5jpJa
 X93gY6+HOTRHxrNACXId8HBGPUuL5pcZXnrcZD5QIx1edNblpPCYtpS3U9jF6BQzGAZX
 0oENgXBL25WFitWpfpNCrI5jnRUZAPhnHPpsWVqlJKSvNVUL5T1lbMUo3uk2aHeZXpXR
 uwSWvRUUPpLMpjdUCKs/ml3v3ere2IuIWTAYeznRGUushF311ugwCFtp2AmxzCmM7hR7 /w== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vtggxkpad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 18:18:09 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40NGnWca028225;
	Tue, 23 Jan 2024 18:18:08 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vru72gd8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 18:18:08 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40NII8PD48628038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 18:18:08 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1095E5805A;
	Tue, 23 Jan 2024 18:18:08 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BEA258054;
	Tue, 23 Jan 2024 18:18:06 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jan 2024 18:18:06 +0000 (GMT)
Message-ID: <45afcefe-2e12-4e38-906b-cc7c1bc32dcc@linux.ibm.com>
Date: Tue, 23 Jan 2024 13:18:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] ima: suspend measurements during buffer copy at
 kexec execute
Content-Language: en-US
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
        bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
 <20240122183804.3293904-6-tusharsu@linux.microsoft.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240122183804.3293904-6-tusharsu@linux.microsoft.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: X7JvSdBl8OIJluoz5nHWVHT7vhJ3AKjN
X-Proofpoint-GUID: X7JvSdBl8OIJluoz5nHWVHT7vhJ3AKjN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_11,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401230135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_101835_403505_93256BA8 
X-CRM114-Status: GOOD (  34.09  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 1/22/24 13:38, Tushar Sugandhi wrote:
> New measurements added to the IMA log while the log is being copied
> during the kexec 'execute' may not get copied over.  This can cause the
> measurement log to be out of sync with the IMA TPM PCR, which could

It could be out of sync with any PCR that IMA extends, most often only 
the IMA TPM PCR.

> result in breaking the integrity of the measurements after kexec soft
> reboot.
> 
> Implement and call the functions ima_measurements_suspend() and
> ima_measurements_resume() from ima_update_kexec_buffer().
> 
> Add a check in the ima_add_template_entry() function not to measure
> events when 'suspend_ima_measurements' flag is set.
> 
> This ensures the integrity of the IMA log while it is being copied over
> to the new Kernel during kexec 'execute'.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   security/integrity/ima/ima.h       |  2 ++
>   security/integrity/ima/ima_kexec.c |  7 +++++++
>   security/integrity/ima/ima_queue.c | 32 ++++++++++++++++++++++++++++++
>   3 files changed, 41 insertions(+)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index c29db699c996..49a6047dd8eb 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -161,6 +161,8 @@ bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
>   int ima_restore_measurement_entry(struct ima_template_entry *entry);
>   int ima_restore_measurement_list(loff_t bufsize, void *buf);
>   int ima_measurements_show(struct seq_file *m, void *v);
> +void ima_measurements_suspend(void);
> +void ima_measurements_resume(void);
>   unsigned long ima_get_binary_runtime_size(void);
>   int ima_init_template(void);
>   void ima_init_template_list(void);
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 25150bfc7129..f26b5b342d84 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -179,6 +179,7 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
>   	void *buf = NULL;
>   	size_t buf_size;
>   	int ret = NOTIFY_OK;
> +	bool resume = false;
>   
>   	if (!kexec_in_progress) {
>   		pr_info("%s: No kexec in progress.\n", __func__);
> @@ -190,12 +191,15 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
>   		return ret;
>   	}
>   
> +	ima_measurements_suspend();
> +
>   	ret = ima_dump_measurement_list(&buf_size, &buf,
>   					kexec_segment_size);
>   
>   	if (!buf) {
>   		pr_err("%s: Dump measurements failed. Error:%d\n",
>   		       __func__, ret);
> +		resume = true;
>   		goto out;
>   	}
>   	memcpy(ima_kexec_buffer, buf, buf_size);
> @@ -203,6 +207,9 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
>   	kimage_unmap_segment(ima_kexec_buffer);
>   	ima_kexec_buffer = NULL;
>   
> +	if (resume)
> +		ima_measurements_resume();
> +
>   	return ret;
>   }
>   
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index 532da87ce519..5946a26a2849 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -44,6 +44,11 @@ struct ima_h_table ima_htable = {
>    */
>   static DEFINE_MUTEX(ima_extend_list_mutex);
>   
> +/*
> + * Used internally by the kernel to suspend-resume ima measurements.
> + */
> +static atomic_t suspend_ima_measurements;
> +
>   /* lookup up the digest value in the hash table, and return the entry */
>   static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
>   						       int pcr)
> @@ -148,6 +153,20 @@ static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
>   	return result;
>   }
>   
> +void ima_measurements_suspend(void)
> +{
> +	mutex_lock(&ima_extend_list_mutex);
> +	atomic_set(&suspend_ima_measurements, 1);
> +	mutex_unlock(&ima_extend_list_mutex);
> +}
> +
> +void ima_measurements_resume(void)
> +{
> +	mutex_lock(&ima_extend_list_mutex);
> +	atomic_set(&suspend_ima_measurements, 0);
> +	mutex_unlock(&ima_extend_list_mutex);
> +}
> +
>   /*
>    * Add template entry to the measurement list and hash table, and
>    * extend the pcr.
> @@ -176,6 +195,19 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
>   		}
>   	}
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
>   	result = ima_add_digest_entry(entry,
>   				      !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE));
>   	if (result < 0) {

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
