Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC475C021AA
	for <kexec@archiver.kernel.org>; Wed, 19 Feb 2025 16:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/ByoZqd8u++NPkeRg9hvAGqzK470D8TBdBzDzkEQn4E=; b=EUpbpytdkyJGg7Jwq7OJcH/UXD
	mJH8W3wgYuq33FYUGaP/5xR2+TorJEwATC9U3cv95gMpU3gq4LtWnJFsE/X/uAJCRvipHSyw9gejS
	/HZOHCvUICNgoQgYGI7IXHT4eOQqw1njM/JQaRD9dkjfIc90LXW3P+4KGnMmZquvv/bp7GpoiRBo9
	JhBSwBIrQfd5poPOqIxxHby9xShfrJt7HYOvFMzdtFn5np/mrZO6ocpmV08f9LWxT7PkeNhG/6VLI
	JDxGYrYXRfeWPjPNgCPymCW6ZMycz9BSYDZPF4JrWMD5zeHRv0cTmNha/kMFPDGnBJGGGEs8WTdK9
	lPRQimDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkmrr-0000000DnTO-1YhB;
	Wed, 19 Feb 2025 16:24:11 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkmrb-0000000DnP7-0Q1W
	for kexec@lists.infradead.org;
	Wed, 19 Feb 2025 16:23:56 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J7Wi95002867;
	Wed, 19 Feb 2025 16:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/ByoZq
	d8u++NPkeRg9hvAGqzK470D8TBdBzDzkEQn4E=; b=KRzTfYF6TH1zKrTXX0r3dg
	G7tToRBYs5Uy5gAR00atpLlXLL+XPwux0asgkXJX+/LGYgxuCrY+kKG62O/HxgFc
	PvvbnfEJGQl588yC3s3fOLfEt0de40V+zl8suI5stZCj6liUmPIswAgWwAk5sSjK
	2R1/fH2VzUDkkasvgxCuC+GKk2DwGxqL0v7yDRsgjtwaYUxQlQVrTABZUC458Mkk
	QfnSGquMKszWleqyT6/tUIuccHaQssqtFfFbCEwH30JHbshn7+MWdUNllZz2VGHm
	CBQFMdybn3lX5SwMeCBplUhJSeQdbT9GKnWITbgr2uUmC9R1f4k8TeybKEVFeMBg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wb0ntk8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 16:23:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51JEA4wi002323;
	Wed, 19 Feb 2025 16:23:42 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03x4y7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 16:23:42 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51JGNfGK65470814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 16:23:41 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 695A858043;
	Wed, 19 Feb 2025 16:23:41 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FDAD5805F;
	Wed, 19 Feb 2025 16:23:40 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2025 16:23:40 +0000 (GMT)
Message-ID: <152e2efc-732f-40bf-9aeb-6e50faa018c0@linux.ibm.com>
Date: Wed, 19 Feb 2025 11:23:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/7] ima: measure kexec load and exec events as
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
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
 <20250218225502.747963-8-chenste@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250218225502.747963-8-chenste@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UD3M901qbtwd14gJmin1wBVnIcZ3kR0j
X-Proofpoint-GUID: UD3M901qbtwd14gJmin1wBVnIcZ3kR0j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_07,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190124
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250219_082355_266327_5EAB71F1 
X-CRM114-Status: GOOD (  29.39  )
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



On 2/18/25 5:55 PM, steven chen wrote:
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
> The 'kexec_load' event IMA log can be found using the following command:
> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements |
>     grep kexec_load
> 
> The 'kexec_load' event IMA log can be found using the following command:
> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements |
>     grep kexec_execute
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> ---
>   security/integrity/ima/ima.h       |  6 ++++++
>   security/integrity/ima/ima_kexec.c | 21 +++++++++++++++++++++
>   security/integrity/ima/ima_queue.c |  5 +++++
>   3 files changed, 32 insertions(+)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 4428fcf42167..1452c98242a4 100644
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
> index 6c8c203ad81e..8d0782e51ffa 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -17,6 +17,8 @@
>   #include "ima.h"
>   
>   #ifdef CONFIG_IMA_KEXEC
> +#define IMA_KEXEC_EVENT_LEN 256
> +
>   static struct seq_file ima_kexec_file;
>   static void *ima_kexec_buffer;
>   static size_t kexec_segment_size;
> @@ -36,6 +38,24 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
>   	ima_reset_kexec_file(sf);
>   }
>   
> +void ima_measure_kexec_event(const char *event_name)
> +{
> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
> +	size_t buf_size = 0;
> +	long len;
> +
> +	buf_size = ima_get_binary_runtime_size();
> +	len = atomic_long_read(&ima_htable.len);
> +
> +	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
> +		  "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
> +		 "ima_runtime_measurements_count=%ld;",
> +		 kexec_segment_size, buf_size, len);

Indentation and n = scnprintf(...), as Mimi mentioned in v7.

> +
> +	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event,
> +				  strlen(ima_kexec_event), false, NULL, 0);

Replace strlen(ima_kexec_event) with 'n'.

With these fixes:

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> +}
> +
>   static int ima_alloc_kexec_file_buf(size_t segment_size)
>   {
>   	/*
> @@ -58,6 +78,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
>   out:
>   	ima_kexec_file.read_pos = 0;
>   	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
> +	ima_measure_kexec_event("kexec_load");
>   
>   	return 0;
>   }
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index 3dfd178d4292..6afb46989cf6 100644
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


