Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA60C369C2
	for <kexec@archiver.kernel.org>; Sun, 20 Apr 2025 12:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S6B7H0sl7eejbWsBOT80A+X1SXdpkkOS21qiU9XGhAk=; b=kom71yAWg7kXD9GqST4k06X0nl
	BzNlsXSjjRKmXZht4IHcGMMGt0jI5cLZ/80Pe+ddOi5FdrAmM8cUHxkVPx3G4adUcdEHmjVRx+LDz
	gcfKo1KH/ofzaQcjepQsg7IL7jfP4hCQBMIHVJprf6cKAyA7HtbP8dZ89PabV9D2EuWpp57H79yvB
	u9ONMQ0V2LYbu67IjUwjJ1xrrS+geM2s3AAZXkXiRQGi5l11wdHtG8k9S1PeLLryusBXsP6noVksS
	rgtDAdQHQoqnQt8L3K2yL11y9J5rKSfeXX5Tv7n3VNHqC0mA1CdRXZhpWKfLT5fLAODIa6eGT8GGB
	OalQU7mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6Tff-00000002XdW-4APO;
	Sun, 20 Apr 2025 12:21:15 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6TfY-00000002Xc0-2Faf
	for kexec@lists.infradead.org;
	Sun, 20 Apr 2025 12:21:12 +0000
Received: from [100.70.200.26] (unknown [20.110.218.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id 715EB2052525;
	Sun, 20 Apr 2025 05:21:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 715EB2052525
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745151666;
	bh=S6B7H0sl7eejbWsBOT80A+X1SXdpkkOS21qiU9XGhAk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Sz1r5ZgH0eN5ZQZi7sPpR/CBz3lY2fwwK1tGF11xyRv9VXMM4keeCkkT+/63Xjyo6
	 iwy5a0ddelImoGAxwDn23U1B49quNLup2fRwlaEM8wN5rzdeSNgrYzBXwqcSfpwIZO
	 u7S4cLaCowM7K0ri1YvGiXIdginhNQnMhGhxqKIk=
Message-ID: <b786b537-19e0-497c-b32f-c9df6e88e6b9@linux.microsoft.com>
Date: Sun, 20 Apr 2025 05:21:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/9] ima: kexec: measure events between kexec load and
 execute
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com
References: <20250416021028.1403-1-chenste@linux.microsoft.com>
 <4a2f7fde-99ee-4bcd-a97d-fe0db418fd5f@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <4a2f7fde-99ee-4bcd-a97d-fe0db418fd5f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250420_052108_601860_5E388FC2 
X-CRM114-Status: GOOD (  10.61  )
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

On 4/16/2025 6:09 PM, Stefan Berger wrote:
>
>
> On 4/15/25 10:10 PM, steven chen wrote:
>> From: Steven Chen <chenste@linux.microsoft.com>
>>
>> The current kernel behavior is IMA measurements snapshot is taken at
>> kexec 'load' and not at kexec 'execute'.  IMA log is then carried
>> over to the new kernel after kexec 'execute'.
>>
>> Currently, the kernel behavior during kexec load is to fetch the IMA
>> measurements log from TPM PCRs and store it in a buffer. When a kexec
>> reboot is triggered, this stored log buffer is carried over to the 
>> second
>> kernel. However, the time gap between kexec load and kexec reboot can be
>> very long. During this time window, new events extended into TPM PCRs 
>> miss
>> the chance to be carried over to the second kernel. This results in
>> mismatch between TPM PCR quotes and the actual IMA measurements list 
>> after
>> kexec soft reboot, which in turn results in remote attestation failure.
>
> Tested-by: Stefan Berger <stefanb@linux.ibm.com> # ppc64/kvm

Hi Stefan,

Thank you very much!

Steven


