Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDECBC021AA
	for <kexec@archiver.kernel.org>; Wed, 19 Feb 2025 19:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pu/UW7PCLv8X83zZl5RWnpubpgAZ6B+Swf12/QdxSxQ=; b=dzhXtNqmfMJ3K9YmlyVxaon7y4
	rPhnYjFZ5g5GWFhVJY+vlfJsAR2xRy3lNWwtjQiAD7j5G8jYkP1rEysz0XCNgDfrROFlnnLynNhoG
	GNdXiB4LoS9l/eolx1Da7YOtn4W9iXjfloOyHdG97mSvcik1ROHPcSed5C5OmZe2oK+NjGmjnjunQ
	Q6sy+O0dKEzafHkh/8X7p0yyLDxfLRRcPxUQtgrocj1/C0X7LM6DmNL5FTj9dtKghOmp26+vcrrnP
	y0KieWwSrYhHb8RKHQedsxapd8wXceUcN5iNUTAID2bmpmQFPOOFSH5vwZDATQ/YsjSH/STZDc0J9
	Hj22RKMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkpwC-0000000EhFH-2K9T;
	Wed, 19 Feb 2025 19:40:52 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkpdt-0000000EavO-2GMb
	for kexec@lists.infradead.org;
	Wed, 19 Feb 2025 19:21:58 +0000
Received: from [10.17.64.130] (unknown [131.107.147.130])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9903B2043DE8;
	Wed, 19 Feb 2025 11:21:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9903B2043DE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739992914;
	bh=pu/UW7PCLv8X83zZl5RWnpubpgAZ6B+Swf12/QdxSxQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j5kJaBRWrM6equjNG9/ULVyGXaOGZkWvh/d9z/GERoOxMPje1JSbf/+HpyTUSdUZ2
	 MTeGmqRCHLphVU8p/RB6vUleYWgDhv4FaXYdwfqMNqAwnlNDUjBwBrrVcdcFeAKHAH
	 5LSb12vWUDz53yAyCcC6+JpCIUSLDSoIbnoDZlSc=
Message-ID: <05eadac7-fa98-42a5-88a8-079e7c99c0b9@linux.microsoft.com>
Date: Wed, 19 Feb 2025 11:21:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/7] ima: kexec: define functions to copy IMA log at
 soft boot
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
 <20250218225502.747963-5-chenste@linux.microsoft.com>
 <f102607b-963a-40c6-a14f-0803f8b059cc@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <f102607b-963a-40c6-a14f-0803f8b059cc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250219_112157_630375_263BFE4D 
X-CRM114-Status: GOOD (  22.06  )
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

On 2/19/2025 7:37 AM, Stefan Berger wrote:
>
>
> On 2/18/25 5:54 PM, steven chen wrote:
>> IMA log is copied to the new Kernel during kexec 'load' using
>
> The IMA log is currently copied to the new kernel ...
>
>
>> ima_dump_measurement_list().  The log copy at kexec 'load' may result in
>> loss of IMA measurements during kexec soft reboot.  It needs to be 
>> copied
>
> However, the log copied at kexec 'load' may result in loss of IMA 
> measurements due to missed measurements that only occurred after kexec 
> 'load'. Therefore, the log needs to be copied during kexec 'execute'. 
> Setup the ...
>
>> over during kexec 'execute'.  Setup the needed infrastructure to move 
>> the
>> IMA log copy from kexec 'load' to 'execute'.
>>
>> Define a new IMA hook ima_update_kexec_buffer() as a stub function.
>> It will be used to call ima_dump_measurement_list() during kexec
>> 'execute'.
>>
>> Implement ima_kexec_post_load() function to be invoked after the new
>> Kernel image has been loaded for kexec. ima_kexec_post_load() maps the
>> IMA buffer to a segment in the newly loaded Kernel.  It also registers
>> the reboot notifier_block to trigger ima_update_kexec_buffer() at
>> exec 'execute'.
>
> kexec 'execute'
>
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>
> With the above changes:
>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>
>> ---
>>   include/linux/ima.h                |  3 ++
>>   security/integrity/ima/ima_kexec.c | 46 ++++++++++++++++++++++++++++++
>>   2 files changed, 49 insertions(+)
>>
>> diff --git a/include/linux/ima.h b/include/linux/ima.h
>> index 0bae61a15b60..8e29cb4e6a01 100644
>> --- a/include/linux/ima.h
>> +++ b/include/linux/ima.h
>> @@ -32,6 +32,9 @@ static inline void ima_appraise_parse_cmdline(void) {}
>>     #ifdef CONFIG_IMA_KEXEC
>>   extern void ima_add_kexec_buffer(struct kimage *image);
>> +extern void ima_kexec_post_load(struct kimage *image);
>> +#else
>> +static inline void ima_kexec_post_load(struct kimage *image) {}
>>   #endif
>>     #else
>> diff --git a/security/integrity/ima/ima_kexec.c 
>> b/security/integrity/ima/ima_kexec.c
>> index 704676fa6615..0fa65f91414b 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -12,10 +12,14 @@
>>   #include <linux/kexec.h>
>>   #include <linux/of.h>
>>   #include <linux/ima.h>
>> +#include <linux/reboot.h>
>> +#include <asm/page.h>
>>   #include "ima.h"
>>     #ifdef CONFIG_IMA_KEXEC
>>   static struct seq_file ima_kexec_file;
>> +static void *ima_kexec_buffer;
>> +static bool ima_kexec_update_registered;
>>     static void ima_reset_kexec_file(struct seq_file *sf)
>>   {
>> @@ -183,6 +187,48 @@ void ima_add_kexec_buffer(struct kimage *image)
>>       kexec_dprintk("kexec measurement buffer for the loaded kernel 
>> at 0x%lx.\n",
>>                 kbuf.mem);
>>   }
>> +
>> +/*
>> + * Called during kexec execute so that IMA can update the 
>> measurement list.
>> + */
>> +static int ima_update_kexec_buffer(struct notifier_block *self,
>> +                   unsigned long action, void *data)
>> +{
>> +    return NOTIFY_OK;
>> +}
>> +
>> +struct notifier_block update_buffer_nb = {
>> +    .notifier_call = ima_update_kexec_buffer,
>> +};
>> +
>> +/*
>> + * Create a mapping for the source pages that contain the IMA buffer
>> + * so we can update it later.
>> + */
>> +void ima_kexec_post_load(struct kimage *image)
>> +{
>> +    if (ima_kexec_buffer) {
>> +        kimage_unmap_segment(ima_kexec_buffer);
>> +        ima_kexec_buffer = NULL;
>> +    }
>> +
>> +    if (!image->ima_buffer_addr)
>> +        return;
>> +
>> +    ima_kexec_buffer = kimage_map_segment(image,
>> +                          image->ima_buffer_addr,
>> +                          image->ima_buffer_size);
>> +    if (!ima_kexec_buffer) {
>> +        pr_err("Could not map measurements buffer.\n");
>> +        return;
>> +    }
>> +
>> +    if (!ima_kexec_update_registered) {
>> +        register_reboot_notifier(&update_buffer_nb);
>> +        ima_kexec_update_registered = true;
>> +    }
>> +}
>> +
>>   #endif /* IMA_KEXEC */
>>     /*

Hi Stefan, thanks for your comments. I will update in next version.


