Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80260C4332F
	for <kexec@archiver.kernel.org>; Tue, 14 Nov 2023 22:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SFXDHeohDDDtoGhPXtSZ0rPyeX2Dzc4gkEFKniE0FRM=; b=ztrZRgGuSzruBd
	OTigW+WzBsOjpwNHWSPNwsIF3vlG2cwqxbsoRJ/lg80i6ITOLa8AHJPgExAgAqPAp0wLg8PE7KgVn
	zZQ3U09dR7NbOZqiePc59nm+ZIbdzC7HkBz/PVrv24Hrs/oFeZkj6545MfMpUhUyidsNEPT8xgo1J
	p/l0sPB1UaTN7cV4ZM5TgXR5hO072OcTWuwgBP0Rbibv0NdXv06hRtACQB3ZoL+5D1IXtIyqgiYFK
	MOBLkXkKF2T2gNl1JhWgtDThVruzAm13+wAlxCR5Af8Zw9X4d2D5eEeDnkGLX7jX8XV2H3/kIZXp2
	S5iWiTPw66sDbpD4jadw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r31xs-00GuyT-2l;
	Tue, 14 Nov 2023 22:33:00 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r31xq-00Guxv-0e
	for kexec@lists.infradead.org;
	Tue, 14 Nov 2023 22:32:59 +0000
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1306B20B74C2;
	Tue, 14 Nov 2023 14:32:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1306B20B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700001177;
	bh=R7/pji8gSwiSfK6k5FLodmvIRwrivnz7us3IJ3dk/io=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OuZMcGSPmN9IHi7zLj9D/Vbu68wR1XT9qm2HerVSJz+ApkO2NdMqtdY4v0shN4Ug+
	 afMsJmyqXu+SUwtnyO3d4ne6DTFrndtplOHa7L3ihqoF2XITf+E7FzZqBZoBFC7/e4
	 NjdUaVRq6ledcDEgOJtRFHpLqK6/6XA/EXYJPFIQ=
Message-ID: <2c9e3b71-5416-4336-82f1-cd78e26dd62e@linux.microsoft.com>
Date: Tue, 14 Nov 2023 14:32:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] ima: refactor ima_dump_measurement_list to move
 memory allocation to a separate function
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, kexec@lists.infradead.org,
 linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-2-tusharsu@linux.microsoft.com>
 <1aa5524b52fdb46df4948a21b1139cf833758cde.camel@linux.ibm.com>
 <e4e92a1816475596b91bbbb2fdf33c11ce375cf1.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <e4e92a1816475596b91bbbb2fdf33c11ce375cf1.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231114_143258_282634_94C3D7BD 
X-CRM114-Status: GOOD (  19.74  )
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



On 10/26/23 20:25, Mimi Zohar wrote:
> On Thu, 2023-10-26 at 16:16 -0400, Mimi Zohar wrote:
>> Hi Tushar,
>>
>> According to Documentation/process/submitting-patches.rst, the subject
>> line should be between 70-75 characters.
>>
>> Perhaps something like "ima: define and call ima_alloc_kexec_buffer()".
>>
>> On Thu, 2023-10-05 at 11:25 -0700, Tushar Sugandhi wrote:
>>> IMA allocates memory and dumps the measurement during kexec soft reboot
>>> as a single function call ima_dump_measurement_list().  It gets called
>>> during kexec 'load' operation.  It results in the IMA measurements
>>> between the window of kexec 'load' and 'execute' getting dropped when the
>>> system boots into the new Kernel.  One of the kexec requirements is the
>>> segment size cannot change between the 'load' and the 'execute'.
>>> Therefore, to address this problem, ima_dump_measurement_list() needs
>>> to be refactored to allocate the memory at kexec 'load', and dump the
>>> measurements at kexec 'execute'.  The function that allocates the memory
>>> should handle the scenario where the kexec load is called multiple times
>>
>> The above pragraph is unnecessary.
>>
>>> Refactor ima_dump_measurement_list() to move the memory allocation part
>>> to a separate function ima_alloc_kexec_buf() to allocate buffer of size
>>> 'kexec_segment_size' at kexec 'load'.  Make the local variables in
>>> function ima_dump_measurement_list() global, so that they can be accessed
>>> from ima_alloc_kexec_buf().  Make necessary changes to the function
>>> ima_add_kexec_buffer() to call the above two functions.
>>
>> Fix the wording based on the suggested changes below.
>>
>>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>
>> - Before re-posting this patch set, verify there aren't any
>> "checkpatch.pl --strict" issues.
>> - After applying each patch, compile the kernel and verify it still
>> works.
> 
> Doing this will detect whether or not the patch set is bisect safe.
> 
I usually just do checkpatch.pl <.patch file>.
I didn't know about --strict and it's benefits.
Will do it going forward.


>>> ---
>>>   security/integrity/ima/ima_kexec.c | 126 +++++++++++++++++++++--------
>>>   1 file changed, 93 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>>> index 419dc405c831..307e07991865 100644
>>> --- a/security/integrity/ima/ima_kexec.c
>>> +++ b/security/integrity/ima/ima_kexec.c
>>> @@ -15,61 +15,114 @@
>>>   #include "ima.h"
>>>   
>>>   #ifdef CONFIG_IMA_KEXEC
>>> +struct seq_file ima_kexec_file;
>>
>> Define "ima_kexec_file" as static since it only used in this file.
>> Since the variable does not need to be global, is there still a reason
>> for changing its name?   Minimize code change.
> 
> Adding "static" would make ima_kexec_file a global static variable.
> Please ignore my comment about reverting the variable name change.
> 
> Mimi
> 
Sure :)

~Tushar
...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
