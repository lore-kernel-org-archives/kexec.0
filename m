Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEACAC001DB
	for <kexec@archiver.kernel.org>; Thu,  3 Aug 2023 23:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PU0w4ZWIXo39VtYaWwNUG9auwnmIM9BZasxablB8XZQ=; b=Q9OQThksU27RGi
	cYRLHfVPRDxVDVWDHqzfxOsfT1dUnpADN23KpVOo3cKrGSgVQ6LiWA95yx8AiKRVE4w0Q6Iz7YskR
	Ssdg+aTz//jRJ2ytZ7dzPlJvzXLG2KUzj6fJDEwpNR+RJVgpJgh6QkLuzm0HGdBbaeYKJ34dvw1u6
	nJCzRl/nLNkbBkV4RncunuqSKKdscewDfiZfs3H/A39mkQGsKjAEnvCA4YcNa2xd+tXUq7p1Zigt7
	21y6JEI4JSjc9r9KNcEOn/E+W7PCu2QHFK9dNSRZ2cuo5XH7k0doQyYpuWEZJtOG8fjmSfvYg6l6g
	bkPLOPBTXAff5Vf7gUJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRhKW-00B3Dv-0O;
	Thu, 03 Aug 2023 23:02:04 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRhKT-00B3Bn-0F
	for kexec@lists.infradead.org;
	Thu, 03 Aug 2023 23:02:02 +0000
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 81566207F5B2;
	Thu,  3 Aug 2023 16:01:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 81566207F5B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1691103717;
	bh=wb6/cOS27R9v5HDFW3pHzcqDeGWkZFwt7EZjsyRl/e0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U/nq6a2qhFgN7h4+2VQuJZSP9VtGTW0X9pwv0aUHGVncstNdE+B5ieWOhlRjS7dRp
	 P74i9eJ8Yt9E6FW9G43056xCM30Hg5lXxipc1rqgs8HM7LTMs9Y5elz4BC3XHwtcJj
	 HetADTR+jYH1MtqnrYy4zn9bVPzYdTFIpRHuU7hQ=
Message-ID: <b9a77076-d6ac-a1ec-5e75-ab066dfade69@linux.microsoft.com>
Date: Thu, 3 Aug 2023 16:01:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/6] ima: implement functionality to measure TPM update
 counter
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, noodles@fb.com, bauermann@kolabnow.com,
 ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
 kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <20230801181917.8535-5-tusharsu@linux.microsoft.com>
 <a2d9af7f54f364da9aeaef3dc6e03b7412957c23.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <a2d9af7f54f364da9aeaef3dc6e03b7412957c23.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_160201_169097_4D0908EE 
X-CRM114-Status: GOOD (  23.04  )
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

Thanks for the review Mimi.

On 8/3/23 14:42, Mimi Zohar wrote:
> On Tue, 2023-08-01 at 11:19 -0700, Tushar Sugandhi wrote:
>> Currently TPM update counter is not available external to the system,
>> for instance, a remote attestation service.  It is a problem because
>> the service cannot easily determine if the IMA log entries are missing.
>> The IMA functionality needs to be extended to measure the TPM update
>> counter from various subsystems in Linux kernel to help detect if
>> the IMA log entries are missing.
>>
>> Implement a function, 'ima_measure_update_counter()' which would retrieve
>> the TPM update counter using the previously defined function
>> 'ima_tpm_get_update_counter()'.  Format it as a string with the value
>> "update_counter=<N>;", and measure it using the function
>> 'ima_measure_critical_data()'.
>>
>> The function takes an event name as input, and the update counter value
>> is measured as part of this event.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Explicit TPM2 quote commands do not return the quoted PCR values or the
> pcrCounter value.  Define and include a new IMA measurement record
> containing the pcrCounter, other TPM info, and IMA info in the IMA
> measurement list to help simplify detecting a trimmed/truncated
> measurement list.
Sounds good.
>> ---
>>   include/linux/ima.h               |  1 +
>>   security/integrity/ima/ima.h      |  1 +
>>   security/integrity/ima/ima_main.c | 28 ++++++++++++++++++++++++++++
>>   3 files changed, 30 insertions(+)
>>
>> diff --git a/include/linux/ima.h b/include/linux/ima.h
>> index 86b57757c7b1..f15f3a6a4c72 100644
>> --- a/include/linux/ima.h
>> +++ b/include/linux/ima.h
>> @@ -40,6 +40,7 @@ extern int ima_measure_critical_data(const char *event_label,
>>   				     const char *event_name,
>>   				     const void *buf, size_t buf_len,
>>   				     bool hash, u8 *digest, size_t digest_len);
>> +int ima_measure_update_counter(const char *event_name);
>>   
>>   #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
>>   extern void ima_appraise_parse_cmdline(void);
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index 4acd0e5a830f..5484bd362237 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -168,6 +168,7 @@ int __init ima_init_digests(void);
>>   int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
>>   			  void *lsm_data);
>>   int ima_tpm_get_update_counter(u32 *cpu_update_counter);
>> +int ima_measure_update_counter(const char *event_name);
>>   
>>   /*
>>    * used to protect h_table and sha_table
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index d66a0a36415e..1bcd45cc5a6a 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -1071,6 +1071,34 @@ int ima_measure_critical_data(const char *event_label,
>>   }
>>   EXPORT_SYMBOL_GPL(ima_measure_critical_data);
>>   
>> +#define IMA_TPM_UPDATE_CTR_BUF_SIZE 128
>> +int ima_measure_update_counter(const char *event_name)
>> +{
>> +	int result;
>> +	u32 update_counter = 0;
>> +	char buf[IMA_TPM_UPDATE_CTR_BUF_SIZE];
>> +	int buf_len;
>> +
>> +	if (!event_name)
>> +		return -ENOPARAM;
>> +
>> +	result = ima_tpm_get_update_counter(&update_counter);
>> +
>> +	if (result != 0)
>> +		return result;
>> +
>> +	scnprintf(buf, IMA_TPM_UPDATE_CTR_BUF_SIZE, "update_counter=%u;",
>> +			  update_counter);
>> +
>> +	buf_len = strlen(buf);
>> +
>> +	result = ima_measure_critical_data("tpm_pcr_update_counter", event_name,
>> +				  buf, buf_len, false, NULL, 0);
>>
> The new record should contain everything needed to verify the
> pcrCounter.  For example, each IMA measurement record updates the
> pcrCounter for each TPM bank enabled.  So the number of enabled TPM
> banks and number of IMA measurements should also be included in this
> record.
Agreed. That should be valuable information.
How does the below format look like for the buf above?

version=<N>.<N>.<N>;num_enabled_pcr_banks=<N>;pcrUpdateCounter=<N>;num_ima_measurements=<N>;

>
> Perhaps include a version number as well, so that if we ever want to
> include other information, we could.
By version number, do you mean kernel_version, or a new version
number specific to this record? Or something else?

~Tushar
> Mimi
>
>
>> +
>> +	return result;
>> +}
>> +EXPORT_SYMBOL_GPL(ima_measure_update_counter);
>> +
>>   static int __init init_ima(void)
>>   {
>>   	int error;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
