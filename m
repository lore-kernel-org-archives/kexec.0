Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF30C3ABA5
	for <kexec@archiver.kernel.org>; Tue, 29 Apr 2025 18:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UwMh+pFsxitu0VIc46oNnCKoAPFDBx3kLVDwDqBe6b0=; b=4eKRby1hyfbfuzUSkwAa4d4vMx
	9QkM4WrnrUyq8ScKIqD604qEdN5dqGwoCPY8ujLCLU5fpVYJBOJN+M4qg5MZS7EcbAGjQJb83zJaK
	ftyw6S1vfBmcXq5FBo5zJzLm28GbgyoAnA3SDS0mhZz6RU8By0FY7y0QXSH8H0Svb7895m0+81B3+
	PONHSgK010PPjDarJ2rqNpOgSeQnsitvBDRnxbyFa8DF26/b/ezDRwq36RPiRmrss7TdPJK2ZPMek
	N/CnsVdECOCyGOj2rCtU/UdeRe8xoFtHfEZH+AV6BdRnRiDgVYHYCpGCD4yXRJbQ9TAn1PAqhEl7o
	sof0HLZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9pXr-0000000AVXN-2l01;
	Tue, 29 Apr 2025 18:19:03 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9pXo-0000000AVWn-3oOo
	for kexec@lists.infradead.org;
	Tue, 29 Apr 2025 18:19:02 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TA4ShA000528;
	Tue, 29 Apr 2025 18:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UwMh+p
	Fsxitu0VIc46oNnCKoAPFDBx3kLVDwDqBe6b0=; b=mVUoS7i1oXR83WrkdxObnK
	eVATcPM2PYAFmKP3oQji3XFwGzM7Uhw6P5H0OBX3RQrliSTegtCdaOY1kFG8qbRJ
	T2kPNZJEuvYvz/m+kHYMlFESjTgGxlxWuDNggNwtBIz54ZvUoxuzJGyDHU6Ojybv
	wfnn4ZCvgsDPV1iK+zXAITvPUB797ph3gYzxiOChNdRr03zV4vHq+1fWM4CZeLES
	aD0YqLAPQVex4Gr4p64Xpl8CNSreCKsNJoG06kx8oqXw0eElaKUkZT30eic5seRa
	3rSGY3ZoPleb2bPbHGcqexv4LZCWKJE97E2KUbI1FXjK/r7Fp0Xpfl4FFUbPkBRw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46avpkab89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 18:18:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53TI1vqX001830;
	Tue, 29 Apr 2025 18:18:41 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469bammct3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 18:18:41 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53TIIcwD53084634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 18:18:38 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83CEC5805A;
	Tue, 29 Apr 2025 18:18:41 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 086F65805D;
	Tue, 29 Apr 2025 18:18:40 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Apr 2025 18:18:39 +0000 (GMT)
Message-ID: <678c762f-e1f9-4a35-a9c3-c88b662001a4@linux.ibm.com>
Date: Tue, 29 Apr 2025 14:18:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 9/9] ima: measure kexec load and exec events as
 critical data
To: steven chen <chenste@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com
References: <20250421222516.9830-1-chenste@linux.microsoft.com>
 <20250421222516.9830-10-chenste@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250421222516.9830-10-chenste@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=68111803 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=yMhMjlubAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=52e223D3gOybuSLWcPIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GV2KzMfb5jEMwKuIbcSmRtEjN6C31epg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDEzMyBTYWx0ZWRfX9DZy+G/pcGu2 4fhuvNRD/AVhK7ee4oybSV9Eb/n/v7JRJE8mD1odm3Q76GarP0Q0VXjaV5byyjkaZXn1YcIZhiX XE4JSLeirSjkg0P8CRkZs+4C6qFiXaiuztZWo4HBt9/NFjTWvI4g/iyVRJnCXTTcdJT4uFamrh0
 VJpN/e5JFkCv03WFWdZLTqsrG7PZ6i6uSc3shkc/vhDF0lCjpD97NmnYhZ4kMxwVRTN7pZ+dCZ6 zjl/frLBY7eZwhBTM6qj/ChvZWDVQVPYGiooluoPWJPxYSLP2AQqhXZWOSMqtOLzE1a8FFoaeuV +Fj4VvT5OLYh5eB+txYe0+UZ9gA49t1OV3SkTutz1v4RFk3JLJ2Y/cBHjawzJq3KOGMtCZ6en5/
 V5KXuGh8qXjrdk1oJ1PMwOHLw9s1Y+plsT01w5jMpvmLRDh7TFdewm24QRKK/z9HuR+Ta8y6
X-Proofpoint-GUID: GV2KzMfb5jEMwKuIbcSmRtEjN6C31epg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290133
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_111900_958992_3088D789 
X-CRM114-Status: GOOD (  28.24  )
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



On 4/21/25 6:25 PM, steven chen wrote:
> From: Steven Chen <chenste@linux.microsoft.com>
> 
> The amount of memory allocated at kexec load, even with the extra memory
> allocated, might not be large enough for the entire measurement list.  The
> indeterminate interval between kexec 'load' and 'execute' could exacerbate
> this problem.
> 
> Define two new IMA events, 'kexec_load' and 'kexec_execute', to be
> measured as critical data at kexec 'load' and 'execute' respectively.
> Report the allocated kexec segment size, IMA binary log size and the
> runtime measurements count as part of those events.
> 
> These events, and the values reported through them, serve as markers in
> the IMA log to verify the IMA events are captured during kexec soft
> reboot.  The presence of a 'kexec_load' event in between the last two
> 'boot_aggregate' events in the IMA log implies this is a kexec soft
> reboot, and not a cold-boot. And the absence of 'kexec_execute' event
> after kexec soft reboot implies missing events in that window which
> results in inconsistency with TPM PCR quotes, necessitating a cold boot
> for a successful remote attestation.
> 
> These critical data events are displayed as hex encoded ascii in the
> ascii_runtime_measurement_list.  Verifying the critical data hash requires
> calculating the hash of the decoded ascii string.
> 
> For example, to verify the 'kexec_load' data hash:
> 
> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements
> | grep  kexec_load | cut -d' ' -f 6 | xxd -r -p | sha256sum
> 
> 
> To verify the 'kexec_execute' data hash:
> 
> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements
> | grep kexec_execute | cut -d' ' -f 6 | xxd -r -p | sha256sum
> 
> Co-developed-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Acked-by: Baoquan He <bhe@redhat.com>
 > --->   security/integrity/ima/ima.h       |  6 ++++++
>   security/integrity/ima/ima_kexec.c | 21 +++++++++++++++++++++
>   security/integrity/ima/ima_queue.c |  5 +++++
>   3 files changed, 32 insertions(+)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 24d09ea91b87..34815baf5e21 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -240,6 +240,12 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
>   				   unsigned long flags, bool create);
>   #endif
>   
> +#ifdef CONFIG_IMA_KEXEC
> +void ima_measure_kexec_event(const char *event_name);
> +#else
> +static inline void ima_measure_kexec_event(const char *event_name) {}
> +#endif
> +
>   /*
>    * The default binary_runtime_measurements list format is defined as the
>    * platform native format.  The canonical format is defined as little-endian.
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index d1c9d369ba08..38cb2500f4c3 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -17,6 +17,8 @@
>   #include "ima.h"
>   
>   #ifdef CONFIG_IMA_KEXEC
> +#define IMA_KEXEC_EVENT_LEN 256
> +
>   static bool ima_kexec_update_registered;
>   static struct seq_file ima_kexec_file;
>   static size_t kexec_segment_size;
> @@ -31,6 +33,24 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
>   	sf->count = 0;
>   }
>   
> +void ima_measure_kexec_event(const char *event_name)
> +{
> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
> +	size_t buf_size = 0;
> +	long len;
> +	int n;
> +
> +	buf_size = ima_get_binary_runtime_size();
> +	len = atomic_long_read(&ima_htable.len);
> +
> +	n = scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
> +		      "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
> +		      "ima_runtime_measurements_count=%ld;",
> +		      kexec_segment_size, buf_size, len);
> +
> +	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event, n, false, NULL, 0);
> +}
> +
>   static int ima_alloc_kexec_file_buf(size_t segment_size)
>   {
>   	/*
> @@ -53,6 +73,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
>   out:
>   	ima_kexec_file.read_pos = 0;
>   	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
> +	ima_measure_kexec_event("kexec_load");
>   
>   	return 0;
>   }
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index 83d53824aa98..590637e81ad1 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -241,6 +241,11 @@ static int ima_reboot_notifier(struct notifier_block *nb,
>   			       unsigned long action,
>   			       void *data)
>   {
> +#ifdef CONFIG_IMA_KEXEC
> +	if (action == SYS_RESTART && data && !strcmp(data, "kexec reboot"))
> +		ima_measure_kexec_event("kexec_execute");
> +#endif
> +
>   	ima_measurements_suspend();
>   
>   	return NOTIFY_DONE;

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


