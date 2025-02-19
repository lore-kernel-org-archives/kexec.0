Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFC7C021AA
	for <kexec@archiver.kernel.org>; Wed, 19 Feb 2025 16:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GutrDSyCSH/AB96WUJAY2Xow2tXi6nzxIQdwxOo5sWo=; b=l8gyiNCnwavAug7jLgQvucmkEt
	JpBfZrR1XHEy0CfOULw+26fJXeUBGJ9FCDLHxrmbVFnlVPAP79t+gEdtr/ZZJqy6pqWPnlk2NbkHM
	foaRTLF523iBkrX8mcbqU9U43NXULfr/paRygCFz5cvZ8OOuAkUfBNZm7HImob4xlulaQe0zPqqyo
	Nz9Zrtve1RuNLmrmyl33VXn8kx6WDKs0GyiYj+3fhsJUJcrEC30Zq5erdzVVub2MpEQPMvuFZYsOG
	ZZN8RxL0Qbbkd2D9LQQ4vPCZwh1C308pMm787jkX0NtslSvljfL4fl6f1mG9w/Qwn4omqIOQNWrkw
	t04xKbvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkn8Q-0000000DsRL-0oHl;
	Wed, 19 Feb 2025 16:41:18 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkm8t-0000000DaPt-29KS
	for kexec@lists.infradead.org;
	Wed, 19 Feb 2025 15:37:44 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JFbA2D011660;
	Wed, 19 Feb 2025 15:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GutrDS
	yCSH/AB96WUJAY2Xow2tXi6nzxIQdwxOo5sWo=; b=fgSfp0ldBCTrxRSd+1r43A
	oC+6tvhhoqMgzNUaL++C9/fvailI0YIt/IGxi6zNIX5FL1dg5eSH3AHLog2oUmYU
	SD0RQLjLr3vZraDHyYcAApytTd9OB1WwS+T+kVT6s8yQEXW/sPOtajNTWqyfyRvo
	0/PhMggfDO3pfyovjwiPipR9fjp920p+aWvDDHE2oXYVQ6SNjZc52oxERrBcqIU1
	HCGH3JdHtG6NFaKwBVh565ksw7/Wgla1oaWzENaSShMe5gEC/zeo+81MHX8VEb8r
	YelHwIgleSF/haIJ0WyJTCD6rnSjQgoChPA+Lbd0akiqQVkYJuvF86+A+PWjJ9oA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44w5c9bpwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 15:37:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51JE289l009646;
	Wed, 19 Feb 2025 15:37:13 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03y4sg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 15:37:13 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51JFbCpg29950608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 15:37:13 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAEB058059;
	Wed, 19 Feb 2025 15:37:12 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D913B58043;
	Wed, 19 Feb 2025 15:37:11 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2025 15:37:11 +0000 (GMT)
Message-ID: <f102607b-963a-40c6-a14f-0803f8b059cc@linux.ibm.com>
Date: Wed, 19 Feb 2025 10:37:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/7] ima: kexec: define functions to copy IMA log at
 soft boot
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
 <20250218225502.747963-5-chenste@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250218225502.747963-5-chenste@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _2h1PqhZlz4EX5Bg4hbV1qibYy_kiHN-
X-Proofpoint-GUID: _2h1PqhZlz4EX5Bg4hbV1qibYy_kiHN-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250219_073743_568366_40A47BF4 
X-CRM114-Status: GOOD (  27.80  )
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



On 2/18/25 5:54 PM, steven chen wrote:
> IMA log is copied to the new Kernel during kexec 'load' using

The IMA log is currently copied to the new kernel ...


> ima_dump_measurement_list().  The log copy at kexec 'load' may result in
> loss of IMA measurements during kexec soft reboot.  It needs to be copied

However, the log copied at kexec 'load' may result in loss of IMA 
measurements due to missed measurements that only occurred after kexec 
'load'. Therefore, the log needs to be copied during kexec 'execute'. 
Setup the ...

> over during kexec 'execute'.  Setup the needed infrastructure to move the
> IMA log copy from kexec 'load' to 'execute'.
> 
> Define a new IMA hook ima_update_kexec_buffer() as a stub function.
> It will be used to call ima_dump_measurement_list() during kexec
> 'execute'.
> 
> Implement ima_kexec_post_load() function to be invoked after the new
> Kernel image has been loaded for kexec. ima_kexec_post_load() maps the
> IMA buffer to a segment in the newly loaded Kernel.  It also registers
> the reboot notifier_block to trigger ima_update_kexec_buffer() at
> exec 'execute'.

kexec 'execute'

> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>

With the above changes:

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   include/linux/ima.h                |  3 ++
>   security/integrity/ima/ima_kexec.c | 46 ++++++++++++++++++++++++++++++
>   2 files changed, 49 insertions(+)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 0bae61a15b60..8e29cb4e6a01 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -32,6 +32,9 @@ static inline void ima_appraise_parse_cmdline(void) {}
>   
>   #ifdef CONFIG_IMA_KEXEC
>   extern void ima_add_kexec_buffer(struct kimage *image);
> +extern void ima_kexec_post_load(struct kimage *image);
> +#else
> +static inline void ima_kexec_post_load(struct kimage *image) {}
>   #endif
>   
>   #else
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 704676fa6615..0fa65f91414b 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -12,10 +12,14 @@
>   #include <linux/kexec.h>
>   #include <linux/of.h>
>   #include <linux/ima.h>
> +#include <linux/reboot.h>
> +#include <asm/page.h>
>   #include "ima.h"
>   
>   #ifdef CONFIG_IMA_KEXEC
>   static struct seq_file ima_kexec_file;
> +static void *ima_kexec_buffer;
> +static bool ima_kexec_update_registered;
>   
>   static void ima_reset_kexec_file(struct seq_file *sf)
>   {
> @@ -183,6 +187,48 @@ void ima_add_kexec_buffer(struct kimage *image)
>   	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
>   		      kbuf.mem);
>   }
> +
> +/*
> + * Called during kexec execute so that IMA can update the measurement list.
> + */
> +static int ima_update_kexec_buffer(struct notifier_block *self,
> +				   unsigned long action, void *data)
> +{
> +	return NOTIFY_OK;
> +}
> +
> +struct notifier_block update_buffer_nb = {
> +	.notifier_call = ima_update_kexec_buffer,
> +};
> +
> +/*
> + * Create a mapping for the source pages that contain the IMA buffer
> + * so we can update it later.
> + */
> +void ima_kexec_post_load(struct kimage *image)
> +{
> +	if (ima_kexec_buffer) {
> +		kimage_unmap_segment(ima_kexec_buffer);
> +		ima_kexec_buffer = NULL;
> +	}
> +
> +	if (!image->ima_buffer_addr)
> +		return;
> +
> +	ima_kexec_buffer = kimage_map_segment(image,
> +					      image->ima_buffer_addr,
> +					      image->ima_buffer_size);
> +	if (!ima_kexec_buffer) {
> +		pr_err("Could not map measurements buffer.\n");
> +		return;
> +	}
> +
> +	if (!ima_kexec_update_registered) {
> +		register_reboot_notifier(&update_buffer_nb);
> +		ima_kexec_update_registered = true;
> +	}
> +}
> +
>   #endif /* IMA_KEXEC */
>   
>   /*


