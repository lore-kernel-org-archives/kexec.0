Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289D7C36002
	for <kexec@archiver.kernel.org>; Fri, 21 Mar 2025 16:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bREkR7Q4lq1SSvQYMg6DzgXSYgZuwjodek6Of27CdyE=; b=k33svK2jVttAZBNKI0qU4blNqU
	tFgUF6JMmcbU+lEPUSUzueeed10n1O0TUiQS2m/+CfQubccIlUvjjtfvBcjfjVsbrK8XrVv8g2sBN
	dusgIJFgBLdfgXdtSu7CYf36/TfYmdbxfjQH89EKRJ4jPedZF/85fr0qqnW1VXAijV+B4Liqq56/o
	5byQwfaQLFmVlpSjbf7gSYkmY48cQr+rlY5PVAiq1//zdWI9v3Stz6nKTi1Zg5vsaqh6gtPfFOMIJ
	pxYG5W3ZD2Oo2557leluY5W8wz7eQ/dtaofgMzLCwyIGNGU0oT5NbA8FgxSbU8johHdSFZTsIghAV
	vAqmsdHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvf4i-0000000FTEN-3lk5;
	Fri, 21 Mar 2025 16:18:24 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvf4g-0000000FTDM-3kHR
	for kexec@lists.infradead.org;
	Fri, 21 Mar 2025 16:18:24 +0000
Received: from [10.17.64.97] (unknown [131.107.174.225])
	by linux.microsoft.com (Postfix) with ESMTPSA id 95414202537E;
	Fri, 21 Mar 2025 09:18:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 95414202537E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742573901;
	bh=bREkR7Q4lq1SSvQYMg6DzgXSYgZuwjodek6Of27CdyE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kfOmQNWAKkEYR30lvRiIVJDKpN6tjU/J3lpJFFShJOuoaAUJh5Y9O7BnWZFvlebN1
	 Hq2OHcxk8rSb9nvfQjnXFP3u9xTUlTc1vW5lqrd8oIlWKoOaMuPAPvAdmkX6+3M7lI
	 9Dt1QL2GGYad15+DeADgtjzAZ9WfRd4w2AIobkZI=
Message-ID: <798d64a7-eb93-433d-ab6b-37a7c5d89412@linux.microsoft.com>
Date: Fri, 21 Mar 2025 09:18:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/8] ima: define and call ima_alloc_kexec_file_buf()
To: Mimi Zohar <zohar@linux.ibm.com>, Baoquan He <bhe@redhat.com>
Cc: stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, ebiederm@xmission.com,
 paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@hansenpartnership.com, vgoyal@redhat.com, dyoung@redhat.com
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-3-chenste@linux.microsoft.com>
 <Z9p7rwXqjB3vjCpj@MiWiFi-R3L-srv>
 <447b1bf7b31e936ab959b8ba13f09a9c25bb3977.camel@linux.ibm.com>
 <Z9t0h5vvxP+meMkO@MiWiFi-R3L-srv>
 <a8368f2402e1145c134e445d015c434140874e06.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <a8368f2402e1145c134e445d015c434140874e06.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_091822_952594_DF43EFF5 
X-CRM114-Status: GOOD (  13.34  )
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

On 3/20/2025 6:06 AM, Mimi Zohar wrote:
> On Thu, 2025-03-20 at 09:51 +0800, Baoquan He wrote:
>>>>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>>>>> index 8567619889d1..45170e283272 100644
>>>>> --- a/security/integrity/ima/ima_kexec.c
>>>>> +++ b/security/integrity/ima/ima_kexec.c
>>>>> @@ -15,6 +15,48 @@
>>>>>    #include "ima.h"
>>>>>    
>>>>>    #ifdef CONFIG_IMA_KEXEC
>>>>> +static struct seq_file ima_kexec_file;
>>>>> +
>>>>> +static void ima_reset_kexec_file(struct seq_file *sf)
>>>>> +{
>>>>> +	sf->buf = NULL;
>>>>> +	sf->size = 0;
>>>>> +	sf->read_pos = 0;
>>>>> +	sf->count = 0;
>>>>> +}
>>>>> +
>>>>> +static void ima_free_kexec_file_buf(struct seq_file *sf)
>>>>> +{
>>>>> +	vfree(sf->buf);
>>>>> +	ima_reset_kexec_file(sf);
>>>>> +}
>>>>> +
>>>>> +static int ima_alloc_kexec_file_buf(size_t segment_size)
>>>>> +{
>>>>> +	/*
>>>>> +	 * kexec 'load' may be called multiple times.
>>>>> +	 * Free and realloc the buffer only if the segment_size is
>>>>> +	 * changed from the previous kexec 'load' call.
>>>>> +	 */
>>>>> +	if (ima_kexec_file.buf && ima_kexec_file.size == segment_size)
>>>>> +		goto out;
>>> The call to ima_reset_kexec_file() in ima_add_kexec_buffer() resets
>>> ima_kexec_file.buf() hiding the fact that the above test always fails and falls
>>> through.  As a result, 'buf' is always being re-allocated.
> Hi Steven,
>
> [Reiterating the comment in the "ima: kexec: move IMA log copy from kexec load
> to execute" thread, here, for completeness.]
>
> Instead of adding and then removing the ima_reset_kexec_file() call from
> ima_add_kexec_buffer(), defer adding the segment size test to when it is
> actually possible for the segment size to change. Please make the segment size
> test as a separate patch.
>
> ima_reset_kexec_file() will then only be called by ima_free_kexec_file_buf().
> Inline the ima_reset_kexec_file() code in ima_free_kexec_file_buf().
>
> thanks,
>
> Mimi

Hi Mimi,

I will update in next version.

Thanks,

Steven


