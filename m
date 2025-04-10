Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7A2C369A6
	for <kexec@archiver.kernel.org>; Thu, 10 Apr 2025 14:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C8ms2drYX3b/coVXj+lhvtPuBfcvsMd9srrchobseXI=; b=O18D7WhbNr1jT4q4Pq/KG8hzXS
	hiLXqLsVUEACV2YSQVZmP64J5/GcrVoHkFEuj8y4mutjDIpZoHSMzjdc0jOHe73JJjqkNCsR+vFg4
	kR4pRJvEGeYCyBTyj1nnrz1v+n3Jme113jhhm7Qz8vauibnKSHTrNTxpNCrx1SWXH7+PshPr8ZNdX
	RzUvhHT7sspRT3l//D+KSFFT69Cne+SunhhFjrP1u3b+n0tqIl+SItag1Cy+lil/O9ZHyUi2/MS+L
	JnzisFR6QrFqEIEc6tdBxla/CkestZD7WxouvYZ7WARmF0nitMaaauHU8bHrTE2RszQdXEWUAEmx5
	nO+msQXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2sfE-0000000Ant1-2KqB;
	Thu, 10 Apr 2025 14:13:56 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2sfC-0000000AnsO-21xX
	for kexec@lists.infradead.org;
	Thu, 10 Apr 2025 14:13:55 +0000
Received: from [100.70.200.180] (unknown [20.110.218.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id 60AC32114DA5;
	Thu, 10 Apr 2025 07:13:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 60AC32114DA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744294433;
	bh=C8ms2drYX3b/coVXj+lhvtPuBfcvsMd9srrchobseXI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SAx6X8MCrg6kMd78jooH+IKG21F8FQ28qatQJMcBMm07hc1ThblOgBn53uw5gXP13
	 Jl14Vei+YllF1a0krFo2xaqgPT7c34QPBjr0qNVKYowrNUePFQrtT+Rhpoig5EweBm
	 QfaxHha1qECQcUo4/fB/0WoHAYTPaTzmsZgYFIWA=
Message-ID: <51203aaf-b3a2-4352-b5a0-1ad6094d0243@linux.microsoft.com>
Date: Thu, 10 Apr 2025 07:13:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 5/9] ima: kexec: define functions to copy IMA log at
 soft boot
To: Mimi Zohar <zohar@linux.ibm.com>, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
 <20250402124725.5601-6-chenste@linux.microsoft.com>
 <90fff5f793fb48659e20fa69cb5895867f51e021.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <90fff5f793fb48659e20fa69cb5895867f51e021.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_071354_543665_48CFD28F 
X-CRM114-Status: GOOD (  15.15  )
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

On 4/8/2025 7:21 AM, Mimi Zohar wrote:
> On Wed, 2025-04-02 at 05:47 -0700, steven chen wrote:
>> The IMA log is currently copied to the new kernel during kexec 'load'
>> using ima_dump_measurement_list(). However, the log copied at kexec
>> 'load' may result in loss of IMA measurements that only occurred after
>> kexec "load'.
> Ok
>
>> Therefore, the log needs to be copied during kexec
>> 'execute'.
> The above line is unnecessary.
>
>> Setup the needed infrastructure to move the IMA log copy from
>> kexec 'load' to 'execute'.
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
>> IMA log copy operation will happen at the end of the operation chain, which
>> is crucial for maintaining the integrity of the logs
> Instead of ", which is crucial for maintaining the integrity of the logs"
> say something like ", so that all the IMA measurement records extended into the
> TPM are copied."

Hi Mimi,

I will update in next version.

Thanks,

Steven

>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Vivek Goyal <vgoyal@redhat.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Thanks, Steven.  With the change to use INT_MIN, the "kexec_execute" record is
> now added to the IMA measurement list, extended into the PCR, and included in
> the IMA measurement list records copied.
>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>



