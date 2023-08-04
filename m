Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89011C001DE
	for <kexec@archiver.kernel.org>; Fri,  4 Aug 2023 17:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ogviVbwSwQNe9nCat9FBBe8XiI689EzeQ0Du93B51kw=; b=jzCFtTAaLdMxNS
	6N3P5wlsz1Mf5wsFeeUjDQm010CgpZjEx0xoVMB9mccTbRuq9yDQbS6PMKm+bEN+foY4eMkvUXGJr
	WOOPb9tiTPSo05rCxMHgUunLgDSlj5YO1xxXrt+mj0ureaHkjLBI8aBKWAMAFH7yltJqHWaWBW/XD
	nhxTJpZSClNwOOujEtFtOCp/bfgwEBKrBr21tzKr9566LTwvcmuS8b8F/rJxChppnAnGRyrC2sOGM
	mcwncO7V09P7LO7/wixJpVLP9jBIhT1DgqAN/jh5izGQUwJ8d00auVw9TKpqI5frqtlPNpnp7+Ih7
	SCz1UAKIDoiYFoAItd6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRyMk-00CsWa-1u;
	Fri, 04 Aug 2023 17:13:30 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRyMh-00CsVt-39
	for kexec@lists.infradead.org;
	Fri, 04 Aug 2023 17:13:29 +0000
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 12E3B207F58A;
	Fri,  4 Aug 2023 10:13:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 12E3B207F58A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1691169207;
	bh=/kopZg2eS8L3J5NXUqMLlqBVgWBXjlwKr8Cpu2BqWjQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hTmQNlFmuXlrJqcQKWn0IsHDa0iEoxbj338XLljMguLNxyx1bBA+4QdBlDFaWtg3H
	 AmSIp/VtYAFUkBiPXiStLTjDPWj/7I7ppO9iZSw5ruGmlSChKOf9ks5oX42lmAdyOO
	 l32G4ey9gOnVZ7PrFLQDEspM+2pvdWPsjTjWyQQs=
Message-ID: <dbe58fc4-80f6-664f-e834-c27d64a8c60a@linux.microsoft.com>
Date: Fri, 4 Aug 2023 10:13:26 -0700
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
 <b9a77076-d6ac-a1ec-5e75-ab066dfade69@linux.microsoft.com>
 <7da13140fd4ab43e797214f08bf7bca07640c238.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <7da13140fd4ab43e797214f08bf7bca07640c238.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230804_101328_042682_FF22D233 
X-CRM114-Status: GOOD (  10.19  )
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



On 8/3/23 18:22, Mimi Zohar wrote:
> On Thu, 2023-08-03 at 16:01 -0700, Tushar Sugandhi wrote:
>>>> +    scnprintf(buf, IMA_TPM_UPDATE_CTR_BUF_SIZE, "update_counter=%u;",
>>>> +                      update_counter);
>>>> +
>>>> +    buf_len = strlen(buf);
>>>> +
>>>> +    result = ima_measure_critical_data("tpm_pcr_update_counter", event_name,
>>>> +                              buf, buf_len, false, NULL, 0);
>>>>
>>> The new record should contain everything needed to verify the
>>> pcrCounter.  For example, each IMA measurement record updates the
>>> pcrCounter for each TPM bank enabled.  So the number of enabled TPM
>>> banks and number of IMA measurements should also be included in this
>>> record.
>> Agreed. That should be valuable information.
>> How does the below format look like for the buf above?
>>
>> version=<N>.<N>.<N>;num_enabled_pcr_banks=<N>;pcrUpdateCounter=<N>;num_ima_measurements=<N>;
> Refer to comment in 5/6.
Responded.
>>> Perhaps include a version number as well, so that if we ever want to
>>> include other information, we could.
>> By version number, do you mean kernel_version, or a new version
>> number specific to this record? Or something else?
> This is a record version type number.  The record format shouldn't
> change, but we should be prepared for it changing.  A single number
> should be fine.
>
Sounds good.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
