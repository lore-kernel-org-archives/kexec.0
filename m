Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C2AC3DA6E
	for <kexec@archiver.kernel.org>; Fri,  5 Jan 2024 19:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QXLGS8s+GkKKoOV1WWnuJMOJ2Pr4vsG4GKDI6Eo9WXw=; b=4pVl/7KIv+VcMv
	dYTAwCyeaaDu/vKg5eCfPYEqFg5MR9lq734Jn4b8kdVZKRtrmjyJcPuacIfipT5zLcCwNrH3gXIpU
	4KrnWD370qXg8UG5vv7r4JRnbcxsbXhoH+pcatuxwrqOFj/kLvBppszz8YXbY1NMjqMS45hFQD1Ax
	AmzcxJwZmWalgaN47EIcUv+3hlpVR7F9Wfe/Mm4CS/zGCf4gmX5IncJdlyNxPr2CJk8SSYTaXfSwf
	OTgN1SAqcmzFavZTLWsv3rdJcbJgdQBFacqGNOWdUO+MXO5GtRcAJU9egNxRbusLx5LHeFda+qy7f
	ln86CDuA8f95xpdImlvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLqDf-0008Bj-0E;
	Fri, 05 Jan 2024 19:51:03 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLqDc-0008BO-1B
	for kexec@lists.infradead.org;
	Fri, 05 Jan 2024 19:51:01 +0000
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id D249A20ACF29;
	Fri,  5 Jan 2024 11:50:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D249A20ACF29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704484259;
	bh=Ql4Awcr9cJ6en22RzD+jHkpP0ibJROvhwbc9bt1K8pk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gO2OaLNCtWWy1nnG/3fhPaCRUgIkpL9T4IN95OCptxklMH14CiTqEC/ghmOV5iJv0
	 4jIVPzYCl43LiX+MzT7UU5ljJGP1clUCwFre7UoqFbdkMrQUzZ4W5SFVNwDagEJHOl
	 xTZFuTxQhRIcj5hcOwNgmSKr6iIvHv3LA7G53gmA=
Message-ID: <7ed7dccf-8482-4285-b21e-d518cb20d9e9@linux.microsoft.com>
Date: Fri, 5 Jan 2024 11:50:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] ima: suspend measurements during buffer copy at
 kexec execute
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, stefanb@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
 <20231216010729.2904751-6-tusharsu@linux.microsoft.com>
 <c174d4d7d3ab646f0e0ebf5aa1dd6894f22dbc02.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <c174d4d7d3ab646f0e0ebf5aa1dd6894f22dbc02.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_115100_467399_0926114E 
X-CRM114-Status: GOOD (  22.61  )
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



On 12/20/23 12:44, Mimi Zohar wrote:
> On Fri, 2023-12-15 at 17:07 -0800, Tushar Sugandhi wrote:
>> If the new measurements are added to the IMA log while it is being
>> being copied to the kexec buffer during kexec 'execute', it can miss
>> copying those new measurements to the kexec buffer, and the buffer can go
>> out of sync with TPM PCRs.  This could result in breaking the integrity
>> of the measurements after the kexec soft reboot to the new Kernel.
>>
>> Add a check in the ima_add_template_entry() function not to measure
>> events and return from the function early when 'suspend_ima_measurements'
>> flag is set.
>>
>> This ensures the consistency of the IMA measurement list while copying
>> them to the kexec buffer.  When the 'suspend_ima_measurements' flag is
>> set, any new measurements will be ignored until the flag is unset.  This
>> allows the buffer to be safely copied without worrying about concurrent
>> modifications to the measurement list.  This is crucial for maintaining
>> the integrity of the measurements during a kexec soft reboot.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima_queue.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
>> index cb9abc02a304..5946a26a2849 100644
>> --- a/security/integrity/ima/ima_queue.c
>> +++ b/security/integrity/ima/ima_queue.c
>> @@ -195,6 +195,19 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
>>   		}
>>   	}
>>   
>> +	/*
>> +	 * suspend_ima_measurements will be set if the system is
>> +	 * undergoing kexec soft boot to a new kernel.
>> +	 * suspending measurements in this short window ensures the
>> +	 * consistency of the IMA measurement list during copying
>> +	 * of the kexec buffer.
>> +	 */
>> +	if (atomic_read(&suspend_ima_measurements)) {
>> +		audit_cause = "measurements_suspended";
>> +		audit_info = 0;
>> +		goto out;
>> +	}
>> +
>>   	result = ima_add_digest_entry(entry,
>>   				      !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE));
>>   	if (result < 0) {
> 
> I assume you meant to include the suspend/resume code in "ima: kexec:
> move ima log copy from kexec load to execute"  in this patch.
> 

Sure, I can move the suspend/resume code from Patch 2/7 of this series
to this patch (5/7).

Earlier I introduced the suspend/resume functionality in patch 2 because
it was used in the functions in that patch.

But shifting it hear will make the patches cleaner.

~Tushar

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
