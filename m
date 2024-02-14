Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3DDC48BC3
	for <kexec@archiver.kernel.org>; Wed, 14 Feb 2024 20:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wvppPKWdZauQ3Y3f8pbMjOPCVRBd1G90CbIxSbji6GQ=; b=qFDzPQNwpoANfI
	ZYrYZ9+uehY/HFOhpyYieMRakRFv6NjXSO6gwdEU5Hn+ki5+L10gbjhREl83zx261HPGfnKagdGp1
	FYwhnAhLQoGIbSHqkAut/vXyfehhiXCCzU9bEG/Q9OxIzNgF53F+R2j0pBpwFFcOfR4QG8z4SGcFj
	nCTeDYENnaNivnfJ9kE/7Vzk7C0JYparmIWrXbm4SJ5RmIyC6uKXpoXAYfZq3+Lv/qBOn2TxUp79v
	3JNfuTnakOY/JA7Rr3sYs8XBWG57iBCLuOLphUu3nrV534DAb7/Ywbwjm3AfnuEdnxD/2Og1DjVdL
	VbAH68tADIyhLaypeE1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raML2-0000000EFTK-3N3F;
	Wed, 14 Feb 2024 20:58:40 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raML0-0000000EFSS-0HfL
	for kexec@lists.infradead.org;
	Wed, 14 Feb 2024 20:58:39 +0000
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EKXjfE000917;
	Wed, 14 Feb 2024 20:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GJ2ceaBkZxHpVES/ZP9cHn5Q9twU8fLKz6g5Aue/k6M=;
 b=ARYuiWSSWI8cwWIbey0nSWH+zdiq3UGIq0oqeHC6q8AQH5IiZe12gMXX5VgSmEeK8c6R
 fiIvWJgzVW93uhFDCQyISv5z2pzim/bTooMKbDoaHouFSfOG7YXpALRFmdsufY3TapPW
 1L7BiaQ+G8uPLu0HkegONJKfTjlFS+GqAK0X5ILuGp/RxyxjbkiRkd7FeqGQlpGtFdut
 VCgrs6UZuxoVQ7K3JE44EW1Pkg5mS7qpmIi7AiSp71KQVbbOA0jcbvjoI2vMBOhG65ez
 b5rDlsgb1yjrW4oJzK9cxk1BBdpP6SaBd1ZegBQxWeY9GHM8YyJ/jQ0hU64V8U6Uawy0 Rg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w94nq0e3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 20:58:15 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41EJ2Xgg024908;
	Wed, 14 Feb 2024 20:58:14 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfpgemp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 20:58:14 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41EKwBre61866256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 20:58:14 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91C9258055;
	Wed, 14 Feb 2024 20:58:11 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83E3A5805D;
	Wed, 14 Feb 2024 20:58:10 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Feb 2024 20:58:10 +0000 (GMT)
Message-ID: <f12c1987-3626-4e0e-bd2a-f2b6d09a436f@linux.ibm.com>
Date: Wed, 14 Feb 2024 15:58:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/8] ima: kexec: move IMA log copy from kexec load to
 execute
Content-Language: en-US
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
        bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
 <20240214153827.1087657-6-tusharsu@linux.microsoft.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240214153827.1087657-6-tusharsu@linux.microsoft.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YUDg7gbaRKonO9IBq_uTOE3cdas-WkoF
X-Proofpoint-GUID: YUDg7gbaRKonO9IBq_uTOE3cdas-WkoF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_13,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140163
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_125838_369120_945F0F1B 
X-CRM114-Status: GOOD (  30.61  )
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



On 2/14/24 10:38, Tushar Sugandhi wrote:
> ima_dump_measurement_list() is called during kexec 'load', which may
> result in loss of IMA measurements during kexec soft reboot.  It needs
> to be called during kexec 'execute'.
> 
> This patch includes the following changes:
>   - Call kimage_file_post_load() from kexec_file_load() syscall only for
>     kexec soft reboot scenarios and not for KEXEC_FILE_ON_CRASH.  It will
>     map the IMA segment, and register reboot notifier for the function
>     ima_update_kexec_buffer() which would copy the IMA log at kexec soft
>     reboot.
>   - Make kexec_segment_size variable local static to the file, for it to be
>     accessible both during kexec 'load' and 'execute'.
>   - Move ima_dump_measurement_list() call from ima_add_kexec_buffer()
>     to ima_update_kexec_buffer().
>   - Remove ima_reset_kexec_file() call from ima_add_kexec_buffer(), now
>     that the buffer is being copied at kexec 'execute', and resetting the
>     file at kexec 'load' will corrupt the buffer.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>   kernel/kexec_file.c                |  3 ++
>   security/integrity/ima/ima_kexec.c | 45 +++++++++++++++++++-----------
>   2 files changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index fe59cb7c179d..2d5df320c34f 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -410,6 +410,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>   
>   	kimage_terminate(image);
>   
> +	if (!(flags & KEXEC_FILE_ON_CRASH))
> +		kimage_file_post_load(image);
> +
>   	ret = machine_kexec_post_load(image);
>   	if (ret)
>   		goto out;
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 1d4d6c122d82..98fc9b9782a2 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -19,6 +19,7 @@
>   #ifdef CONFIG_IMA_KEXEC
>   static struct seq_file ima_kexec_file;
>   static void *ima_kexec_buffer;
> +static size_t kexec_segment_size;
>   static bool ima_kexec_update_registered;
>   
>   static void ima_reset_kexec_file(struct seq_file *sf)
> @@ -129,7 +130,6 @@ void ima_add_kexec_buffer(struct kimage *image)
>   	/* use more understandable variable names than defined in kbuf */
>   	void *kexec_buffer = NULL;
>   	size_t kexec_buffer_size;
> -	size_t kexec_segment_size;
>   	int ret;
>   
>   	/*
> @@ -154,14 +154,6 @@ void ima_add_kexec_buffer(struct kimage *image)
>   		return;
>   	}
>   
> -	ret = ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
> -					kexec_segment_size);
> -	if (ret < 0) {
> -		pr_err("%s: Failed to dump IMA measurements. Error:%d.\n",
> -		       __func__, ret);
> -		return;
> -	}
> -
>   	kbuf.buffer = kexec_buffer;
>   	kbuf.bufsz = kexec_buffer_size;
>   	kbuf.memsz = kexec_segment_size;
> @@ -179,12 +171,6 @@ void ima_add_kexec_buffer(struct kimage *image)
>   	image->ima_segment_index = image->nr_segments - 1;
>   	image->is_ima_segment_index_set = true;
>   
> -	/*
> -	 * kexec owns kexec_buffer after kexec_add_buffer() is called
> -	 * and it will vfree() that buffer.
> -	 */
> -	ima_reset_kexec_file(&ima_kexec_file);
> -
>   	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
>   		      kbuf.mem);
>   }
> @@ -195,7 +181,34 @@ void ima_add_kexec_buffer(struct kimage *image)
>   static int ima_update_kexec_buffer(struct notifier_block *self,
>   				   unsigned long action, void *data)
>   {
> -	return NOTIFY_OK;
> +	void *buf = NULL;
> +	size_t buf_size;
> +	int ret = NOTIFY_OK;
> +
> +	if (!kexec_in_progress) {
> +		pr_info("%s: No kexec in progress.\n", __func__);
> +		return ret;
> +	}
> +
> +	if (!ima_kexec_buffer) {
> +		pr_err("%s: Kexec buffer not set.\n", __func__);
> +		return ret;
> +	}
> +
> +	ret = ima_dump_measurement_list(&buf_size, &buf,
> +					kexec_segment_size);
> +
> +	if (!buf) {

Use 'if (ret)' ? You're setting *buffer = NULL in case of error but ret 
should be used to test for failure.

> +		pr_err("%s: Dump measurements failed. Error:%d\n",
> +		       __func__, ret);
> +		goto out;
> +	}
> +	memcpy(ima_kexec_buffer, buf, buf_size);
> +out:
> +	kimage_unmap_segment(ima_kexec_buffer);
> +	ima_kexec_buffer = NULL;
> +
> +	return ret;
>   }
>   
>   struct notifier_block update_buffer_nb = {

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
