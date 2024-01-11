Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CC2C47077
	for <kexec@archiver.kernel.org>; Thu, 11 Jan 2024 18:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H8HYZ309yE+JI2hLBKE3PaY1uPivGKdmhnU+NaOOI+s=; b=rzpEfOzBdianyf
	FD3DkUqryBosK4W6PonSuemDCz+nr9ffOXLM0pUEcg1CKI9qV0nEhE8gv76d9akJn481zro1owvdl
	JTOhMY8KKjiVHjezBJaprB38bost3z7x4xdHRR68eqAf9EFdc8chnSLYvC4ONdvv2dzQEcR2I402U
	gGLZL27GgwI87p5ZjHXKcd9T+gxD9ID0XZ8qrT+dUcLMVFlAoJtpAazZitBYUTjb5rquhfFLo968s
	Ups3or1gqbYK8YivQxTuT3yRpI/x+PTPGfVJXr9mM5DUxTAytKVcSEoRB+TuQe45QY44mM62In5l6
	5hzHTbpVU2pMJaoeq8uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNzct-000ovT-2t;
	Thu, 11 Jan 2024 18:17:59 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNzcr-000ov8-08
	for kexec@lists.infradead.org;
	Thu, 11 Jan 2024 18:17:58 +0000
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 36D8020B3CC1;
	Thu, 11 Jan 2024 10:17:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 36D8020B3CC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704997076;
	bh=seE6BYr+cMuO0qFfh44sOOBr4O2KLpUiZvXYO2myDXA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RkX1TdGnmCwd7Fpw3cOxfW2QLaLgHaAQKdt6LgNOXvic6KI2SMQX89U/qSUDFbYVv
	 OahNZFv0VCmlcHbGGKzQU8As5/owEkkx6+3yGHXwndeQE+1Z4d0G08oLrwulfF2Azi
	 WqZfT/uSoTWoQgXvI8S0DJluLdrDH9zXlQPcVmu8=
Message-ID: <97681564-5930-4604-b8b9-b208873fc05f@linux.microsoft.com>
Date: Thu, 11 Jan 2024 10:17:48 -0800
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
 <7ed7dccf-8482-4285-b21e-d518cb20d9e9@linux.microsoft.com>
 <10d5bc81db27c21613dacace9bedad345705dcea.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <10d5bc81db27c21613dacace9bedad345705dcea.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240111_101757_128947_D96B774F 
X-CRM114-Status: GOOD (  25.73  )
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



On 1/11/24 09:30, Mimi Zohar wrote:
> On Fri, 2024-01-05 at 11:50 -0800, Tushar Sugandhi wrote:
>>
>> On 12/20/23 12:44, Mimi Zohar wrote:
>>> On Fri, 2023-12-15 at 17:07 -0800, Tushar Sugandhi wrote:
>>>> If the new measurements are added to the IMA log while it is being
>>>> being copied to the kexec buffer during kexec 'execute', it can miss
>>>> copying those new measurements to the kexec buffer, and the buffer can go
>>>> out of sync with TPM PCRs.  This could result in breaking the integrity
>>>> of the measurements after the kexec soft reboot to the new Kernel.
>>>>
>>>> Add a check in the ima_add_template_entry() function not to measure
>>>> events and return from the function early when 'suspend_ima_measurements'
>>>> flag is set.
>>>>
>>>> This ensures the consistency of the IMA measurement list while copying
>>>> them to the kexec buffer.  When the 'suspend_ima_measurements' flag is
>>>> set, any new measurements will be ignored until the flag is unset.  This
>>>> allows the buffer to be safely copied without worrying about concurrent
>>>> modifications to the measurement list.  This is crucial for maintaining
>>>> the integrity of the measurements during a kexec soft reboot.
>>>>
>>>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>>> ---
>>>>    security/integrity/ima/ima_queue.c | 13 +++++++++++++
>>>>    1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
>>>> index cb9abc02a304..5946a26a2849 100644
>>>> --- a/security/integrity/ima/ima_queue.c
>>>> +++ b/security/integrity/ima/ima_queue.c
>>>> @@ -195,6 +195,19 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
>>>>    		}
>>>>    	}
>>>>    
>>>> +	/*
>>>> +	 * suspend_ima_measurements will be set if the system is
>>>> +	 * undergoing kexec soft boot to a new kernel.
>>>> +	 * suspending measurements in this short window ensures the
>>>> +	 * consistency of the IMA measurement list during copying
>>>> +	 * of the kexec buffer.
>>>> +	 */
>>>> +	if (atomic_read(&suspend_ima_measurements)) {
>>>> +		audit_cause = "measurements_suspended";
>>>> +		audit_info = 0;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>>    	result = ima_add_digest_entry(entry,
>>>>    				      !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE));
>>>>    	if (result < 0) {
>>>
>>> I assume you meant to include the suspend/resume code in "ima: kexec:
>>> move ima log copy from kexec load to execute"  in this patch.
>>>
>>
>> Sure, I can move the suspend/resume code from Patch 2/7 of this series
>> to this patch (5/7).
>>
>> Earlier I introduced the suspend/resume functionality in patch 2 because
>> it was used in the functions in that patch.
>>
>> But shifting it hear will make the patches cleaner.
> 
> Just a reminder this isn't the only issued mentioned in 2/7.  Please refer to it
> for the other comments (e.g. make not including/verifying the IMA segment hash a
> separate patch).
> 
> Before reposting, please remember to test after applying each patch in the patch
> set to ensure that the measurement list is properly carried across kexec.

Yes, I had read your responses on patch 2/7.
I have been meaning to respond to you on 2/7, but I kept getting 
distracted by some other work-items on my plate. Really sorry :(

I will respond to your comments on 2/7 by end of the day, and 
incorporate the feedback before reposting.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
