Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD60CDB474
	for <kexec@archiver.kernel.org>; Fri, 13 Oct 2023 00:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:Subject:From:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dwXL5YONqlM4ajnOAQHDHOUDZJyim3RONzXCeO2vybY=; b=dPggg289awFQ4o
	LTEdQrZQci8i1yNc0JH/4bCkFJIgQ7OHXd75KTUmHChAYQOjYJ3Mf4qFF8TPjps0NxOYmeG0gLWug
	NnAN0TkAqjxl3z4DdlvfuMkFu14/yszoTaPMvjy2DyVG9QfUa4Lh1fAm0Xc7E4i67RtQvebp2xxFi
	HSe75iJfCxOpWRpp+nvsQfvY7s/3MBJvxygPWDeHftAzCqcI9ej60dBzpE06/Rvd8m9tmNb+dIqa+
	UuQL2mEyN9NVrWyVTUCTMkpAXcmfSOr8Tl1hJUfPDvWmAyIin17aHY5nMYqT7KaDp8wiO0Dryw4rO
	28bVkXXWy0i8Wqs7d/8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qr672-002BQI-20;
	Fri, 13 Oct 2023 00:33:08 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qr66w-002BPj-0N
	for kexec@lists.infradead.org;
	Fri, 13 Oct 2023 00:33:07 +0000
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39D0WNM5029862;
	Fri, 13 Oct 2023 00:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=QFDAdbz6IO/rkmU1fZPGXAWRswAPYJoE5J/2syw0pfs=;
 b=CEtJ0EWnJW+Hw2yK2kES57nktMUd9pcjw7MLyPmSdO7l1ZM52+y3Loye2IsIREDJn8Hz
 FkRn5JADeEcmf0LfINmQ1jG3m1u3R/qTkyzfcEbVrUjWoOBQS06YMf0WE+xNq8AB0rMk
 9CfjPjt3K8ULgo2GG8zN1zZlP82yCaVy7zzbVJRW9rAlqcivRi9oXHODlIo3GXsGaLfn
 JcVHDEm61/1fV09wQ/PIAT/Yl/QKag5T0vGYydRobwhIxndruTn0UI2KrBDphIoKpHp+
 bnfomXQyxdKi+apyEPfOL7M+JYtxMfSbkzuzE1TfkRl7fkBhkJvsABaUgjvIIjXWUsNP Wg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpuej00c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Oct 2023 00:32:51 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39CN4CXJ007572;
	Fri, 13 Oct 2023 00:27:50 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tpt5a8e2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Oct 2023 00:27:50 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39D0Rnxa20054646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Oct 2023 00:27:49 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B895958056;
	Fri, 13 Oct 2023 00:27:49 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E00758052;
	Fri, 13 Oct 2023 00:27:49 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Oct 2023 00:27:48 +0000 (GMT)
Message-ID: <50477765-05f3-9fc6-4e85-cd822d212d95@linux.ibm.com>
Date: Thu, 12 Oct 2023 20:27:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 7/7] ima: record log size at kexec load and execute
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, zohar@linux.ibm.com,
        ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-8-tusharsu@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20231005182602.634615-8-tusharsu@linux.microsoft.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MU23Lv7Xr-ccznOMI_ZQXwKs7JrpBMm9
X-Proofpoint-ORIG-GUID: MU23Lv7Xr-ccznOMI_ZQXwKs7JrpBMm9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_14,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 mlxlogscore=842
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130003
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231012_173305_946955_F0FC3543 
X-CRM114-Status: GOOD (  31.75  )
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


On 10/5/23 14:26, Tushar Sugandhi wrote:
> The window between kexec 'load' and 'execute' could be arbitrarily long.
> Even with the large chunk of memory allocated at kexec 'load', it may
> run out which would result in missing events in IMA log after the system
> soft reboots to the new Kernel.  This would result in IMA measurements
> getting out of sync with the TPM PCR quotes which would result in remote
> attestation failing for that system.  There is currently no way for the
> new Kernel to know if the IMA log TPM PCR quote out of sync problem is
> because of the missing measurements during kexec.
>
> Define two new IMA events, 'kexec_load' and 'kexec_execute', to be
> measured at kexec 'load' and 'execute' respectively.
>
> IMA measures 'boot_aggregate' as the first event when the system boots -
> either cold boot or kexec soft boot.  In case when the system goes
> through multiple soft reboots, the number of 'boot_aggregate' events in
> IMA log corresponds to total number of boots (cold boot plus multiple
> kexec soft reboots).  With this change, there would be additional
> 'kexec_load' and 'kexec_execute' events in between the two
> 'boot_aggregate' events.  In rare cases, when the system runs out of
> memory during kexec soft reboot, 'kexec_execute' won't be copied since
> its one of the very last event measured just before kexec soft reboot.
> The absence of the event 'kexec_execute' in between the two
> boot_aggregate' events would signal the attestation service that the IMA
> log on the system is out of sync with TPM PCR quotes and the system needs
> to be cold booted for the remote attestation to succeed again.
>
>
> @@ -198,6 +208,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>   static int ima_update_kexec_buffer(struct notifier_block *self,
>   				   unsigned long action, void *data)
>   {
> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
>   	void *buf = NULL;
>   	size_t buf_size;
>   	bool resume = false;
> @@ -213,9 +224,31 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
>   		return NOTIFY_OK;
>   	}
>   
> +	buf_size = ima_get_binary_runtime_size();
> +	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
> +		  "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;",
> +		  kexec_segment_size, buf_size);
> +
> +	/*
> +	 * This is one of the very last events measured by IMA before kexec
> +	 * soft rebooting into the new Kernal.
> +	 * This event can be used as a marker after the system soft reboots
> +	 * to the new Kernel to check if there was sufficient memory allocated
> +	 * at kexec 'load' to capture the events measured between the window
> +	 * of kexec 'load' and 'execute'.
> +	 * This event needs to be present in the IMA log, in between the two
> +	 * 'boot_aggregate' events that are logged for the previous boot and
> +	 * the current soft reboot. If it is not present after the system soft
> +	 * reboots into the new Kernel, it would mean the IMA log is not
> +	 * consistent with the TPM PCR quotes, and the system needs to be
> +	 * cold-booted for the attestation to succeed again.
> +	 */
> +	ima_measure_critical_data("ima_kexec", "kexec_execute",
> +				  ima_kexec_event, strlen(ima_kexec_event),
> +				  false, NULL, 0);
> +
>   	ima_measurements_suspend();
>   
> -	buf_size = ima_get_binary_runtime_size();

This should be removed earlier, in 2/7.



>   	ret = ima_dump_measurement_list(&buf_size, &buf,
>   					kexec_segment_size);
>   

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
