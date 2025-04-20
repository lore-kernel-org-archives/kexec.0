Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED81C369C2
	for <kexec@archiver.kernel.org>; Sun, 20 Apr 2025 12:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=np2gxTjaHDpb1rtQXoHJcdS3uyHNDSp77IUqwm4GRBs=; b=aONFwUjzGTfGzqrCZiIHurUrGs
	nnxIxrz9aDYPtrvFE6ic68jRLwwhhr/2549qjLUfheb4HH8BE4XV8WfAc7pzA/nG7TBOOQOyO19XA
	gtD2bSpWkUCfA4sf0dO9TNTdqL/zVX7vzXEcls/vHnhcPJht2Hj+ct5s4ZNXcDWA3A074ETUM1Rl+
	2gGT+vrBHklkgaWaqkZ4L3fuK4kDGstogI8CQ2xSezRgwmK4PilJM0d+J1AgyAAupGeIO32ufqwYD
	blvMeB+gC1Gmrnwz0ByV//rsWD0s4dPJpR+qg2rWCObmB6zjLVoQqY/M+JoTZVcYyTCloGOnbuG4r
	ocvB0i+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6TrJ-00000002Yso-38BX;
	Sun, 20 Apr 2025 12:33:17 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6TrH-00000002YsS-1US5
	for kexec@lists.infradead.org;
	Sun, 20 Apr 2025 12:33:16 +0000
Received: from [100.70.200.26] (unknown [20.114.144.49])
	by linux.microsoft.com (Postfix) with ESMTPSA id 077892052525;
	Sun, 20 Apr 2025 05:33:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 077892052525
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745152395;
	bh=np2gxTjaHDpb1rtQXoHJcdS3uyHNDSp77IUqwm4GRBs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bXWMcxxeSTBTuvhzky/PK/kzwiTKenzUefcYBTl40OvexVFJ34QfeeXJWhmErVzrF
	 URG/kDn+nEc6SjsPehefverHc4IrfRRLD2gNlmV4/h/SUvvAdBbn0719UhQfx3nAcG
	 rREeBW6sTr2HEXjlNli8RsW0B+svH1w1pJuv4+Do=
Message-ID: <6a4ecd66-4249-476c-87fa-b5a3806fae5e@linux.microsoft.com>
Date: Sun, 20 Apr 2025 05:33:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 5/9] ima: kexec: define functions to copy IMA log at
 soft boot
To: Baoquan He <bhe@redhat.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
 nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 vgoyal@redhat.com, dyoung@redhat.com
References: <20250416021028.1403-1-chenste@linux.microsoft.com>
 <20250416021028.1403-6-chenste@linux.microsoft.com>
 <aAIB9ga3wPWb5sC8@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <aAIB9ga3wPWb5sC8@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250420_053315_444698_EA08C2DD 
X-CRM114-Status: GOOD (  22.55  )
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

On 4/18/2025 12:40 AM, Baoquan He wrote:
> On 04/15/25 at 07:10pm, steven chen wrote:
>> From: Steven Chen <chenste@linux.microsoft.com>
>>
>> The IMA log is currently copied to the new kernel during kexec 'load'
>> using ima_dump_measurement_list(). However, the log copied at kexec
>> 'load' may result in loss of IMA measurements that only occurred after
>> kexec "load'. Setup the needed infrastructure to move the IMA log copy
>> from kexec 'load' to 'execute'.
>>
>> Define a new IMA hook ima_update_kexec_buffer() as a stub function.
>> It will be used to call ima_dump_measurement_list() during kexec 'execute'.
>>
>> Implement ima_kexec_post_load() function to be invoked after the new
>> Kernel image has been loaded for kexec. ima_kexec_post_load() maps the
>> IMA buffer to a segment in the newly loaded Kernel.  It also registers
>> the reboot notifier_block to trigger ima_update_kexec_buffer() at
>> kexec 'execute'.
>>
>> Set the priority of register_reboot_notifier to INT_MIN to ensure that the
>> IMA log copy operation will happen at the end of the operation chain, so
>> that all the IMA measurement records extended into the TPM are copied
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>    ^^^
>
>   The tag
Hi Baoquan,

I will add Co-developed-by tag in next version.

Thanks,

Steven
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Vivek Goyal <vgoyal@redhat.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>> ---
>>   include/linux/ima.h                |  3 ++
>>   security/integrity/ima/ima_kexec.c | 47 ++++++++++++++++++++++++++++++
>>   2 files changed, 50 insertions(+)
> Other than the tag, this looks good to me:
>
> Acked-by: Baoquan He <bhe@redhat.com>
>
>> diff --git a/include/linux/ima.h b/include/linux/ima.h
>> index 0bae61a15b60..8e29cb4e6a01 100644
>> --- a/include/linux/ima.h
>> +++ b/include/linux/ima.h
>> @@ -32,6 +32,9 @@ static inline void ima_appraise_parse_cmdline(void) {}
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>>   extern void ima_add_kexec_buffer(struct kimage *image);
>> +extern void ima_kexec_post_load(struct kimage *image);
>> +#else
>> +static inline void ima_kexec_post_load(struct kimage *image) {}
>>   #endif
>>   
>>   #else
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index 7e0a19c3483f..e79f6caf895b 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -12,10 +12,14 @@
>>   #include <linux/kexec.h>
>>   #include <linux/of.h>
>>   #include <linux/ima.h>
>> +#include <linux/reboot.h>
>> +#include <asm/page.h>
>>   #include "ima.h"
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>> +static bool ima_kexec_update_registered;
>>   static struct seq_file ima_kexec_file;
>> +static void *ima_kexec_buffer;
>>   
>>   static void ima_free_kexec_file_buf(struct seq_file *sf)
>>   {
>> @@ -162,6 +166,49 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
>>   		      kbuf.mem);
>>   }
>> +
>> +/*
>> + * Called during kexec execute so that IMA can update the measurement list.
>> + */
>> +static int ima_update_kexec_buffer(struct notifier_block *self,
>> +				   unsigned long action, void *data)
>> +{
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block update_buffer_nb = {
>> +	.notifier_call = ima_update_kexec_buffer,
>> +	.priority = INT_MIN
>> +};
>> +
>> +/*
>> + * Create a mapping for the source pages that contain the IMA buffer
>> + * so we can update it later.
>> + */
>> +void ima_kexec_post_load(struct kimage *image)
>> +{
>> +	if (ima_kexec_buffer) {
>> +		kimage_unmap_segment(ima_kexec_buffer);
>> +		ima_kexec_buffer = NULL;
>> +	}
>> +
>> +	if (!image->ima_buffer_addr)
>> +		return;
>> +
>> +	ima_kexec_buffer = kimage_map_segment(image,
>> +					      image->ima_buffer_addr,
>> +					      image->ima_buffer_size);
>> +	if (!ima_kexec_buffer) {
>> +		pr_err("Could not map measurements buffer.\n");
>> +		return;
>> +	}
>> +
>> +	if (!ima_kexec_update_registered) {
>> +		register_reboot_notifier(&update_buffer_nb);
>> +		ima_kexec_update_registered = true;
>> +	}
>> +}
>> +
>>   #endif /* IMA_KEXEC */
>>   
>>   /*
>> -- 
>> 2.43.0
>>


