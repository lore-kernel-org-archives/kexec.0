Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084E0C282D0
	for <kexec@archiver.kernel.org>; Wed,  5 Mar 2025 00:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u9vQn02/NSDQfKQiARKmi0huzx7fugITS4b2YeoInKQ=; b=MBm3FuZFiJFp2uNnvcizEOmFS8
	5/ahsf27JhIsZntyhWf9mp4waYiqgXXBc22UDumgLOHSlPb0azC3Wdm+IUTAD0tADwL8D+hTh/Gwa
	qoEd767FHg4+L9GjregwDQnxOlcbeGRY0m7UH6SXJdOEBnhr9OkOfnU8k+A9wSDVZL6exowtEYcm6
	Zzzg4mMw9xZZHQgy8slWeLGhiAtc3KybHVyEjLgniNaSix5PDqGxnQ3+ckjHJ8zaRJvkTZu+0eAb8
	fOpb2yBGy+45jujn4a5COVjxPWsAXiVPD2IHy1faz5P9462noQrxlPuBs7XVXjq0b/mSTeebwPLcp
	kVCE1KkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpd4i-00000006fwJ-3gOY;
	Wed, 05 Mar 2025 00:57:28 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpd4h-00000006fvx-43Zj
	for kexec@bombadil.infradead.org;
	Wed, 05 Mar 2025 00:57:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=u9vQn02/NSDQfKQiARKmi0huzx7fugITS4b2YeoInKQ=; b=k1eCiVuB9nF9oEj7Wu39gIRt8I
	Ur8cV/OTqbK5aDbAGZeZGSpoC80EjB2gMjz3LY1o7JiDhmB3FYwVykBx+/xXJ+iRwKB+iEcnCoGi7
	etvN1G19gq1aJCWwnKlUFMvRb6ZnM9JYrp1EJ0n9tm6K+p9AQBlpKjdUvK5GBROwUVW7roxat/JGt
	mba42o6Xbeo66kwt+kUXRq3oBezZSbrsroUb//q0mnepAD+d7FnYyJKlRCCsfL4RJZ20x+0MjIYSq
	z7kNEJ6bS6Z/0XqQGyZe+3hiLW4PTVjyBfW8TrNKtplifStoF8Z+oXeYfYPrVTWuzw172ii5B1FKL
	JADMFT7g==;
Received: from linux.microsoft.com ([13.77.154.182])
	by desiato.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpd4e-00000000HxD-0Ezn
	for kexec@lists.infradead.org;
	Wed, 05 Mar 2025 00:57:26 +0000
Received: from [10.17.64.124] (unknown [131.107.8.124])
	by linux.microsoft.com (Postfix) with ESMTPSA id 49D90210EAF8;
	Tue,  4 Mar 2025 16:57:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 49D90210EAF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741136237;
	bh=u9vQn02/NSDQfKQiARKmi0huzx7fugITS4b2YeoInKQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xq4Wif5fdHC2k1tO26664vgomhoS0IDrsqqB+zG+wRaMsb68EkOJjwuyYOSFL6gQB
	 50NFwYoChZbRG0s8O25HsHex7q652dcWhgMIIiMlO2dknDD9NMdI7rVLSQfiOzVnVa
	 2qF7djP4plkm8kN7DBQWU1iFnssRYaQ8yr9tJlp8=
Message-ID: <0dadaf7d-c607-43c9-9e82-1decfac0d545@linux.microsoft.com>
Date: Tue, 4 Mar 2025 16:57:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 7/7] ima: measure kexec load and exec events as
 critical data
To: Mimi Zohar <zohar@linux.ibm.com>, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com
References: <20250304190351.96975-1-chenste@linux.microsoft.com>
 <20250304190351.96975-8-chenste@linux.microsoft.com>
 <330dbd19bf0c0fbf34908d4629cbcc548eb9c254.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <330dbd19bf0c0fbf34908d4629cbcc548eb9c254.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_005724_546366_84CD8976 
X-CRM114-Status: UNSURE (   8.58  )
X-CRM114-Notice: Please train this message.
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

On 3/4/2025 4:25 PM, Mimi Zohar wrote:
> Hi Steven,
>
> On Tue, 2025-03-04 at 11:03 -0800, steven chen wrote:
>> +void ima_measure_kexec_event(const char *event_name)
>> +{
>> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
>> +	size_t buf_size = 0;
>> +	long len;
>> +
>> +	buf_size = ima_get_binary_runtime_size();
>> +	len = atomic_long_read(&ima_htable.len);
>> +
>> +	int n = scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>> +					"kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
>> +					"ima_runtime_measurements_count=%ld;",
>> +					kexec_segment_size, buf_size, len);
> Variables should not be defined inline, but at the beginning of the function.
> After doing that, scripts/checkpatch.pl complains about the formatting.
>
> Mimi

Hi Mimi,

I will update it in next release.

Thanks,

Steven

>> +
>> +	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event, n, false, NULL, 0);
>> +}
>> +



