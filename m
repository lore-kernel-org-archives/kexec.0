Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3B1C3ABCC
	for <kexec@archiver.kernel.org>; Tue, 13 May 2025 15:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y9RPGzLmrUiEcchYpmRDbjr7mMuYIu/wlN9gxwkC/4A=; b=l8PCk9SeKsUD1Pz1H3XBJr6jiV
	lNdap6qT9YHJ9D9Q1wEEI1ijZIt6d6tePERH3mQHEVLsmNlOgBM6JCcIolK+/RyI6HV4D4d5iMA10
	324YKAVLWyl4z9KG9zXnTOex+PeP2nRFWVrqgAYmoQnVFDWA+FfkgLR64ftwToWXQa/9j1pk3kl94
	8rVugS40ZC8S4gt7Hgf6hTqP6jwzVbNZLm+mBC4tYyZEYtKwYy3PphxaDz+vr5Dhp7/2AMheueqe0
	D1VAALOao1uaKYy8Pg+tNedh1AyvmKz9GJ2mMV8l6AEfVk1P35/84JUTDWJukgqIcuHtN19xIxviR
	Xm5AEEaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uErbE-0000000CnGx-3gIq;
	Tue, 13 May 2025 15:31:20 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uErb8-0000000CnGE-2xRh
	for kexec@lists.infradead.org;
	Tue, 13 May 2025 15:31:19 +0000
Received: from [100.70.65.85] (unknown [20.230.14.159])
	by linux.microsoft.com (Postfix) with ESMTPSA id AAE6E201DB14;
	Tue, 13 May 2025 08:31:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AAE6E201DB14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747150273;
	bh=Y9RPGzLmrUiEcchYpmRDbjr7mMuYIu/wlN9gxwkC/4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XOKUeYrSVMAsfifIegp/YsbM7SdcAo9hKsJLPyjC3hRsq+LnYpGnXph1jbd+OYTOj
	 9c4h+8Ejp9LvH8K2l7W6xB98Ss2TQVVF7VJs2x1I6GDGptgWeM2iugJVKNwP7kult2
	 7lXoDBsVRKUZ+bsnayWvQMgVeb1WDyZfFkxZ+QMQ=
Message-ID: <7d1b7bea-e85a-474f-85d2-1a0ce27d2044@linux.microsoft.com>
Date: Tue, 13 May 2025 08:31:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ima: Kdump kernel doesn't need IMA to do integrity
 measurement
To: Mimi Zohar <zohar@linux.ibm.com>, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, bhe@redhat.com
References: <20250502200337.6293-1-chenste@linux.microsoft.com>
 <71973027bb0fbc436a95e8bb7fbd2b7d2eab95b4.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <71973027bb0fbc436a95e8bb7fbd2b7d2eab95b4.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_083114_774573_6257D2BE 
X-CRM114-Status: UNSURE (   9.44  )
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

On 5/13/2025 4:41 AM, Mimi Zohar wrote:
> Hi Steven,
>
> On Fri, 2025-05-02 at 13:03 -0700, steven chen wrote:
>> From: Steven Chen <chenste@linux.microsoft.com>
>>
>> Kdump kernel doesn't need IMA to do integrity measurement.
>> Hence the measurement list in 1st kernel doesn't need to be copied to
>> kdump kenrel.
> ^kernel
>
> Please use "scripts/checkpatch.pl --codespell" to check for typos.
>
> Mimi
Will update. Thanks!
>> Here skip allocating buffer for measurement list copying if loading
>> kdump kernel. Then there won't be the later handling related to
>> ima_kexec_buffer.
>>
>> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>



