Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E29FC021B2
	for <kexec@archiver.kernel.org>; Tue, 25 Feb 2025 18:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oAPMpgeQTX575axIRAvAGNwitPSc2FROHu2Kj3FuMr4=; b=RFyWye7PaGeA4GgQ2aRLEhearr
	A/a1BevcFo8qaNbuMKqcVGMbvpXFw5sPV4px//s4XnadOtw1nghlb+IFLEfUgAlcoX4AvJ9NxrCkA
	88IvSlXO+gNr4YSN1strXOjn2Dr9SVmax0tqG4FiBqTxKRMoZoDe5byAKdoUqVHVhwa3r3gt1GzNu
	mA2F71/MltGSRfOLSiFmeAMMOMpFUlaBjuq24Y5yDP4y76rqzoN+OtplxO5+fstMFjda2aqldQIKW
	eSA0HKgrO95wV8pftJK8VQRxQufARJKYV5nWD1fXcYK3L0wUwiL6XathAA0iEoNBFnxmRD9htbg1y
	/YJN32JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tn020-000000012SH-3HWE;
	Tue, 25 Feb 2025 18:51:48 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmzm7-00000000xlF-3WNn
	for kexec@lists.infradead.org;
	Tue, 25 Feb 2025 18:35:24 +0000
Received: from [10.17.64.147] (unknown [131.107.1.147])
	by linux.microsoft.com (Postfix) with ESMTPSA id 95078203CDDE;
	Tue, 25 Feb 2025 10:35:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 95078203CDDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740508523;
	bh=oAPMpgeQTX575axIRAvAGNwitPSc2FROHu2Kj3FuMr4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oGQjoobXgkyRRqjRFRYg+q70hz6uhg5zsrVj8sKaiZST2hHQzUfdy24mpz723gJq3
	 wk6LbK9qyHkwSvnY/nWhMXJ+/pbvW5MV3urcV4jMxmRXdRhzymB2vjTgPaLEvtvDsr
	 QnlelFhG8GfsJ2T3GYOr1XpVnIav81F+3bT3m/g4=
Message-ID: <8504fd93-8fff-4fd9-8d2d-26b4e1e84bee@linux.microsoft.com>
Date: Tue, 25 Feb 2025 10:35:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/7] kexec: define functions to map and unmap segments
To: Baoquan He <bhe@redhat.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
 nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 vgoyal@redhat.com, dyoung@redhat.com
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
 <20250218225502.747963-3-chenste@linux.microsoft.com>
 <Z7wOPiDfy/vtrkCS@MiWiFi-R3L-srv>
 <658b52e4-a4bb-40fc-a00b-bfdb3bf15b52@linux.microsoft.com>
 <Z70MZD+BssRG4R1H@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <Z70MZD+BssRG4R1H@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_103523_937889_46B00683 
X-CRM114-Status: GOOD (  19.37  )
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

On 2/24/2025 4:18 PM, Baoquan He wrote:
> On 02/24/25 at 03:05pm, steven chen wrote:
>> On 2/23/2025 10:14 PM, Baoquan He wrote:
>>> Hi Steve, Mimi,
>>>
>>> On 02/18/25 at 02:54pm, steven chen wrote:
>>>> Currently, the mechanism to map and unmap segments to the kimage
>>>> structure is not available to the subsystems outside of kexec.  This
>>>> functionality is needed when IMA is allocating the memory segments
>>>> during kexec 'load' operation.  Implement functions to map and unmap
>>>> segments to kimage.
>>> I am done with the whole patchset understanding. My concern is if this
>>> TPM PCRs content can be carried over through newly introduced KHO. I can
>>> see that these patchset doesn't introduce too much new code changes,
>>> while if many conponents need do this, kexec reboot will be patched all
>>> over its body and become ugly and hard to maintain.
>>>
>>> Please check Mike Rapoport's v4 patchset to see if IMA can register
>>> itself to KHO and do somthing during 2nd kernel init to restore those
>>> TPM PCRs content to make sure all measurement logs are read correctly.
>>> [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
>>>
>>> Thanks
>>> Baoquan
>> Hi Baoquan,
>>
>> For IMA, it appears that there are no current issues with TPM PCRs after a
>> kernel soft reboot.
> I mean using KHO to hold in 1st kernel and restore the IMA log in 2nd
> kernel.
>
>> This patches is used to get currently missed IMA measurements during the
>> kexec process copied to new kernel after the kernel soft reboot. I think
>> it's ok to leave it at current location: it will be easy to maintain for
>> IMA.
> Yeah, but I am saying this patchset increase unnecessary code
> complexity in kexec code maintaining.
>
>> Overall, for these patches, do you see any major blockers for kexec?
>>
>> If you have any specific concerns or need further details, please let me
>> know.
> I have no concerns for this patchset implementation itself, I saw you using
> vmap to maping the possible scattered source pages smartly and taking
> the mapped buffer pointers to update later duing kexec jumping. That's very
> great and clever method. BUT I am concerned about the solution, if we
> can make use of the existed way of KHO to implement it more simply. Could
> you please do investigation?

Hi Baoquan,

I will conduct an investigation. Thank you for your comments.

Steven


