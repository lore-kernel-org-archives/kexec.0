Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CADCCFA18
	for <kexec@archiver.kernel.org>; Tue, 11 Nov 2025 13:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oeet2MfqPeJUMhuAI+TJhp3djZ7JBxlA/AaPoYju+08=; b=u8g3G+nemNWimclzxoBquvZOd5
	7ZiEzqWn8Agb+U8BDa6d2wGvxiayKS6I0vSzqUkCxKxlDRXLWcqEhz8rErtrOyh79zk5Zih0MkTBp
	fMBHKpIWZIZmAsksyHXWWqmsI9mZS7xPqJiZWSk0BwyzLC4jGGeanKKYexWLqkJkYyb5EgCuk3Ane
	mjCMjSyke0ABwjGPJc6Uap83vTmklg+ZXpJGKt2B+wZ7Hj5yKOnQazZSw0I8acpLSkGbqH4WgVip6
	hqxMV7ijH32+vAJzC57Xqc7jg/wdDKR4kdqiganNMTpuGuHKq3QSLdvUVNLNSWTWySD2Iv6FmV3qZ
	3dRRbWew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIo2F-00000007Ded-0yNu;
	Tue, 11 Nov 2025 13:03:47 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIo2E-00000007DeR-004Z
	for kexec@lists.infradead.org;
	Tue, 11 Nov 2025 13:03:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 27EAF61909;
	Tue, 11 Nov 2025 13:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D0BC19422;
	Tue, 11 Nov 2025 13:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762866224;
	bh=MnQGngUYZB/AuquYMcvngj/vv0fvRZTP9N1ik/AuqZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nx4cjvlP88r0deet2wJMyBpLgRhoG5z585/MuON0PuaxnYs55RYvZ1IzQY6H9JByx
	 8bGGRsHDFEvVTPi1GFJlU1oIwYPn4M5SdsrRJX9Ooy1u69MchU64Wfpv/JPxpTWG9G
	 Jd1uIKXHmujcrw3CK2LUloly/bMW6Kp56MhenOxEz5AqeC4WvXoDBmB62K7MIbcOr2
	 h3C1DHdEyZHl7Lgag9Xlyn8nJ0JAgy5Jqng9hzmKIWQeVkRyD6exr1QQxCHV71J19m
	 hTyHcpPVc0vcXqTTz+mZd4mabIbcZX23RiHeq+5QDwdiewLoAsuK7FiLsyaYQ/tQg+
	 EL34ZgyDgZJCw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  akpm@linux-foundation.org,
  graf@amazon.com,  pratyush@kernel.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH] liveupdate: kho: Enable KHO by default
In-Reply-To: <aRIwSEF8Y0I6q8Cy@kernel.org> (Mike Rapoport's message of "Mon,
	10 Nov 2025 20:34:48 +0200")
References: <20251110180715.602807-1-pasha.tatashin@soleen.com>
	<aRIwSEF8Y0I6q8Cy@kernel.org>
Date: Tue, 11 Nov 2025 14:03:42 +0100
Message-ID: <mafs0cy5oafgx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, Nov 10 2025, Mike Rapoport wrote:

> On Mon, Nov 10, 2025 at 01:07:15PM -0500, Pasha Tatashin wrote:
>>
>> Subject: [PATCH] liveupdate: kho: Enable KHO by default
>
> No need to put a directory (liveupdate) prefix here. "kho: " is enough.

+1

>
> With that fixed
>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

>
>> Upcoming LUO requires KHO for its operations, the requirement to place
>> both KHO=on and liveupdate=on becomes redundant. Set KHO to be enabled
>> by default.
>> 
>> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> ---
>>  kernel/liveupdate/kexec_handover.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>> index b54ca665e005..568cd9fe9aca 100644
>> --- a/kernel/liveupdate/kexec_handover.c
>> +++ b/kernel/liveupdate/kexec_handover.c
>> @@ -51,7 +51,7 @@ union kho_page_info {
>>  
>>  static_assert(sizeof(union kho_page_info) == sizeof(((struct page *)0)->private));
>>  
>> -static bool kho_enable __ro_after_init;
>> +static bool kho_enable __ro_after_init = true;
>>  
>>  bool kho_is_enabled(void)
>>  {
>> 
>> base-commit: ab40c92c74c6b0c611c89516794502b3a3173966
>> -- 
>> 2.51.2.1041.gc1ab5b90ca-goog
>> 

-- 
Regards,
Pratyush Yadav

