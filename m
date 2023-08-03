Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CAFC001DF
	for <kexec@archiver.kernel.org>; Thu,  3 Aug 2023 21:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sxyn3i1p4tBAgqQHkL/zshhubNrY9m7nul1RaQtA9jY=; b=KHJ6pKMX1dt3L4
	wy12wzQuX7XXbrEentALfzwm3ywHgJ80TcIBzjZp3+MMK5kAs2SYO4o6fsTM90+oVuipJyErVE6HV
	SKbjwh+X5SdrI0WWMT0J3s+NGO2FFOSxNeOyP8EHxVaSkTPo8FbAa0JEwNmLSehuH1ZN4fAfD9MTB
	88HT3dIigusxlHWa+6Zei/oYx+g59vihtRidm+mljoFVzi6UZBTB6yR3SOLMCj6cnzG6p/xi5Xbjl
	4/PEiIpazGj0R6g6KSjmDcP4cvaBNdzcsf93ryWZy6ZvajK/TViOCZILAoteurWTmoKf1cwAtErKb
	cyWPM9elOsz3u5znw0UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRg5j-00Avph-38;
	Thu, 03 Aug 2023 21:42:43 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRg5g-00Avp7-1V
	for kexec@lists.infradead.org;
	Thu, 03 Aug 2023 21:42:42 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373LXomO019747;
	Thu, 3 Aug 2023 21:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ugLomY/JfB8vUngfKL97UkxInHdNew7EyAPZdCQmptQ=;
 b=NG954qITGIrjRLpE6QnS8kmahCwbhreUedwPXQl1dLRfTeQR0vglgKmc+xBtVlJjOB3Q
 rkcvEWH9pxLjSGJZ96stVw6XmqNcaIdU1WW7OCgdsdsfmfNy0Wajb9w/HV9L01+H6aX0
 ahqJLohLKnGKY669EseBiuycW2pKwlnQjjkXeahEXwDeRBwYlQ2bgrnEncOGfeP33WPN
 050iacA1yze4ikXer+nyWsrTFOEUuZfufekd6MYwqNG/cN6Jw34TcjkIgt3IUqVqOQUS
 q/h2ZRZFEuJAXXeka9oyyOActD6TTwkRha6fv76dPQLSKchGzwdxsn4f4GGNM4hynAuQ Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8m8y078q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Aug 2023 21:42:20 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 373LXwx1020020;
	Thu, 3 Aug 2023 21:42:19 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8m8y078e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Aug 2023 21:42:19 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 373KnqpZ023561;
	Thu, 3 Aug 2023 21:42:18 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s8km9gade-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Aug 2023 21:42:18 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 373LgIPI6750886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Aug 2023 21:42:18 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CDEA58043;
	Thu,  3 Aug 2023 21:42:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3E6858055;
	Thu,  3 Aug 2023 21:42:16 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.157.226])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Aug 2023 21:42:16 +0000 (GMT)
Message-ID: <a2d9af7f54f364da9aeaef3dc6e03b7412957c23.camel@linux.ibm.com>
Subject: Re: [PATCH 4/6] ima: implement functionality to measure TPM update
 counter
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, noodles@fb.com,
        bauermann@kolabnow.com, ebiederm@xmission.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Thu, 03 Aug 2023 17:42:16 -0400
In-Reply-To: <20230801181917.8535-5-tusharsu@linux.microsoft.com>
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
	 <20230801181917.8535-5-tusharsu@linux.microsoft.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 85J_Im33qHtA5ebPz7cOWzzqT5rb2VwT
X-Proofpoint-ORIG-GUID: KfCJLifidZsnGW1bjz_S3C15-2qqu6UI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_22,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030193
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_144240_844905_D897E1AA 
X-CRM114-Status: GOOD (  31.02  )
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

On Tue, 2023-08-01 at 11:19 -0700, Tushar Sugandhi wrote:
> Currently TPM update counter is not available external to the system,
> for instance, a remote attestation service.  It is a problem because
> the service cannot easily determine if the IMA log entries are missing.
> The IMA functionality needs to be extended to measure the TPM update
> counter from various subsystems in Linux kernel to help detect if
> the IMA log entries are missing.
> 
> Implement a function, 'ima_measure_update_counter()' which would retrieve
> the TPM update counter using the previously defined function
> 'ima_tpm_get_update_counter()'.  Format it as a string with the value 
> "update_counter=<N>;", and measure it using the function
> 'ima_measure_critical_data()'.
> 
> The function takes an event name as input, and the update counter value
> is measured as part of this event.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>

Explicit TPM2 quote commands do not return the quoted PCR values or the
pcrCounter value.  Define and include a new IMA measurement record
containing the pcrCounter, other TPM info, and IMA info in the IMA
measurement list to help simplify detecting a trimmed/truncated
measurement list.

> ---
>  include/linux/ima.h               |  1 +
>  security/integrity/ima/ima.h      |  1 +
>  security/integrity/ima/ima_main.c | 28 ++++++++++++++++++++++++++++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 86b57757c7b1..f15f3a6a4c72 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -40,6 +40,7 @@ extern int ima_measure_critical_data(const char *event_label,
>  				     const char *event_name,
>  				     const void *buf, size_t buf_len,
>  				     bool hash, u8 *digest, size_t digest_len);
> +int ima_measure_update_counter(const char *event_name);
>  
>  #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
>  extern void ima_appraise_parse_cmdline(void);
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 4acd0e5a830f..5484bd362237 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -168,6 +168,7 @@ int __init ima_init_digests(void);
>  int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
>  			  void *lsm_data);
>  int ima_tpm_get_update_counter(u32 *cpu_update_counter);
> +int ima_measure_update_counter(const char *event_name);
>  
>  /*
>   * used to protect h_table and sha_table
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index d66a0a36415e..1bcd45cc5a6a 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -1071,6 +1071,34 @@ int ima_measure_critical_data(const char *event_label,
>  }
>  EXPORT_SYMBOL_GPL(ima_measure_critical_data);
>  
> +#define IMA_TPM_UPDATE_CTR_BUF_SIZE 128
> +int ima_measure_update_counter(const char *event_name)
> +{
> +	int result;
> +	u32 update_counter = 0;
> +	char buf[IMA_TPM_UPDATE_CTR_BUF_SIZE];
> +	int buf_len;
> +
> +	if (!event_name)
> +		return -ENOPARAM;
> +
> +	result = ima_tpm_get_update_counter(&update_counter);
> +
> +	if (result != 0)
> +		return result;
> +
> +	scnprintf(buf, IMA_TPM_UPDATE_CTR_BUF_SIZE, "update_counter=%u;",
> +			  update_counter);
> +
> +	buf_len = strlen(buf);
> +
> +	result = ima_measure_critical_data("tpm_pcr_update_counter", event_name,
> +				  buf, buf_len, false, NULL, 0);
> 

The new record should contain everything needed to verify the
pcrCounter.  For example, each IMA measurement record updates the
pcrCounter for each TPM bank enabled.  So the number of enabled TPM
banks and number of IMA measurements should also be included in this
record.

Perhaps include a version number as well, so that if we ever want to
include other information, we could.

Mimi


> +
> +	return result;
> +}
> +EXPORT_SYMBOL_GPL(ima_measure_update_counter);
> +
>  static int __init init_ima(void)
>  {
>  	int error;



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
