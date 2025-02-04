Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229E4C02192
	for <kexec@archiver.kernel.org>; Tue,  4 Feb 2025 00:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8wiA7A5oplocwPTbfHbf28Kt1oSZNYikOUM55aAquNU=; b=RI4oQJF1Tu+mYjk39LKBjY2l6R
	l1YyKgL0xsCLfb2YVa8BY10IMC3pIQkWXBoJ+8c2SHzuP7wa1JI42/zelI1+BVIhYMtQ0a3esYiOh
	0sICyyT5Gh6O5lWD3ULjQ+y20RBaHVJeB4PPNv93e1Izy5wnVzHGt6M90exmwnDEXqoBEqFn8K5nS
	TCp/o9EjQ+5e7rD7F1pnXQNkUBDW90U59f7NsAK/TbFTjoVEDYBfy+QiAE88zeQUjIf82GNg/e12h
	Wp2TVIzKkAawD9tzYj7JOCLhSGFhzbPZqUf9giG8ZOedEOaXtl6vyMBA04/eUGVViX6zCNQ9JzqOJ
	INL/vVIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tf7Es-0000000H0i6-2dsl;
	Tue, 04 Feb 2025 00:56:30 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tf7Eq-0000000H0hk-0cpV
	for kexec@lists.infradead.org;
	Tue, 04 Feb 2025 00:56:29 +0000
Received: from [10.17.64.74] (unknown [131.107.8.74])
	by linux.microsoft.com (Postfix) with ESMTPSA id E896B205493B;
	Mon,  3 Feb 2025 16:56:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E896B205493B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738630587;
	bh=8wiA7A5oplocwPTbfHbf28Kt1oSZNYikOUM55aAquNU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=atLHGOwBOcjpVxbjMIkShaTJjqRpjXXbwi6BYhHWxRjiAJFniD9fNWQtEmFEb3XRJ
	 gZ+/2EVFp1VTDXW6DpR8cA2F6BtL1/9WwqGYNSizCmKWZm3guE50d8lo6gLusvHLgs
	 ZAArZYgabwqImy0Z1BwGQmyTlFQvkGpZzrrya/l0=
Message-ID: <b07a4b44-b76f-4691-ac01-6e91b6b83672@linux.microsoft.com>
Date: Mon, 3 Feb 2025 16:56:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/7] ima: kexec: measure events between kexec load and
 excute
To: Mimi Zohar <zohar@linux.ibm.com>, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com
References: <20250203184558.61367-1-chenste@linux.microsoft.com>
 <eb2d3b5f-7aca-42c8-9b34-8ca07b8bc060@linux.microsoft.com>
 <8091ed0d942806e16f995e8444da29df7843df62.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <8091ed0d942806e16f995e8444da29df7843df62.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_165628_223930_246BD7D3 
X-CRM114-Status: UNSURE (   9.45  )
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

On 2/3/2025 4:50 PM, Mimi Zohar wrote:
> On Mon, 2025-02-03 at 15:25 -0800, steven chen wrote:
>> Hi all,
>>
>> The below is the correct version for review.
>>
>> [PATCH v7 0/7] ima: kexec: measure events between kexec load and excute
>> <
>> https://lore.kernel.org/linux-integrity/20250203232033.64123-1-chenste@linux.microso
>> ft.com/T/#t>
>>
>> Please ignore the this version because patch 5 is missing.
>>
>> I am really sorry to have troubled you.
> Thanks, Steven.  I was able to apply the patch set to v6.13.  For some reason, b4
> downloads a duplicate 4/7 patch.
>
> Mimi

Hi Mimi,

Please use the one below

[PATCH v7 0/7] ima: kexec: measure events between kexec load and excute 
<https://lore.kernel.org/linux-integrity/20250203232033.64123-1-chenste@linux.microsoft.com/T/#t>

Please ignore the this version because patch 5 is missing.

I am really sorry.

Steven


