Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083A5CD343F
	for <kexec@archiver.kernel.org>; Mon, 18 May 2026 19:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+w6R6IigdyQN6IOxgpsJUgNwtXZPEURhPU7T8xIlS1g=; b=jhDE/sZpjVnsgHfrB+1FgE8P4K
	jZdEl9oh54ezHCoS2z8pUOSSwS/HQTo0I5QOFclX9PL1FTJOvdMlZhtBqfV5XtcoFK9nQr4hSU/k7
	Dvr9xt+qml7f6UrQ96kqRoQHvtvyBiODzoirHpDhCVLthGi4WodTiH96b5RAfUjzOT3Rnc/VcxxcE
	wmKTgYh5uDfv1ScvMBuJ2n/BYljQ7lhAjfXUbw0KTG4UCbgGOkIGF5ujp5DOVgioeT3lmaWJY8act
	3mhfhsGcSwZND0kZGg96fC399CxkuHXT7jPxWcDpNJaz86KsajZY1fg2hj842nK50I8+N+j/RiB2Z
	IdtfJMLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP3Nw-0000000GeZZ-2v1C;
	Mon, 18 May 2026 19:12:16 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP3Nt-0000000GeYu-2FWa
	for kexec@lists.infradead.org;
	Mon, 18 May 2026 19:12:14 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso1725ad.0
        for <kexec@lists.infradead.org>; Mon, 18 May 2026 12:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779131532; x=1779736332; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+w6R6IigdyQN6IOxgpsJUgNwtXZPEURhPU7T8xIlS1g=;
        b=kFi8QJePhbmzokbU9Ky9V4Phio3QNT45YCefOho4Y7aqNt8X1Low3LWtXmxAsQgTIu
         wp0fCFny0zRhDclZA/OFrRWIF1naKBLZg0E4OSZh2MsDKnCK+6/Qjz4W6+HXDgvq1Dzq
         UdOSoaqL54l3rjCtdwUdlclGNKmCPSw6ajAWKSRIodpJjdCncWA2ngz/Dyyts/ISuuzX
         yiUQXP1+iPUE7bwJupuyvx+zYjiogyeJ5VUZitwxBBfEOugvXmBTd6zScXS2jwY4tunR
         ZMp+nM3emaUyQ+LfMH+MqcxccPLOMA8/9TId3PQhRJpnNHtmLcLQaDakQP9rzRHg/V2P
         EkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779131532; x=1779736332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+w6R6IigdyQN6IOxgpsJUgNwtXZPEURhPU7T8xIlS1g=;
        b=eXhCC8Jq7IH1sA8tMJpb7vvqHcgezWuaDZPP2hzFd+VJNeItAJu3dUlkLUqvLiDNCM
         iGy/7SLruwsaVhuNNN2D2bRdR8D4CRlIaeawPa21BAiqzSlDOrA5S/c8laiQyjYUBVcF
         pP8qxpC5U1uaOyZqzRtZ1SUvnl/bDaBboE/XbVVqApIFiTgSQNPKR8RVSP/QXAdP8s7O
         /JxpZvxo/NyQKtqCSwkpCMguP+6dKOELYTT5BssyiL0sH2yOIJFcrRx3sJ084f51UEGL
         kKmoj055OWWhluaoA8lp00IT76bNjRCkJrH+24ePYSqLAzoPZnA8kyHqoP6H8hcWibxP
         92Nw==
X-Forwarded-Encrypted: i=1; AFNElJ+YN25VUo9VPePCkA+CdrTwIv3Hzb7AdPLP7+FE+ZD+hamCPhD1Ytf9rONFmTPBniLgSEVkEQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy+ABh6uuW47KeAiQDbOfYV1+B9pU0ABPXu5NfFl8zM8eLMr0CX
	KL45Rfr736YuGR65r9/jmEyG+n7Oy/FbTj7aXOOtJHUsmanLyn3RJvNlZCi0ZGTiJQ==
X-Gm-Gg: Acq92OFA9PYhPfH1A74uR54ZAvRC1Y1NYukrCETsNDEHQrqUFZFrVd+6h0rOyKKMtxW
	BWpSnGuWOgHncPi8BV133LpedU4HxCMjubVNZGqIAfxs4D7z8jg9PZlj+bS/0WOOP6+KMlKf4U5
	vSbQnDK5PHZJt1U7anUIvLbarTgDIjTa6r/NFDI13lxEaH7jLQIalMx2ADoxCpOdWuXx7NfrUMb
	EhmydRFDfhfz+nTu3NL/0nOO9983a/0nqqNvitmR0BeaUFGpRkxBN9dHAf1KpBWZt903gAEZ9uw
	We2g3Lvod4c86svaUS77ACeXzPifbWjUgwIloO/S4p/jaDypRxEiGkuGKfOdPIgVtVq8qhReNmq
	lPMTDoExZZWskHw2SR0VDnK5lwrojsZenwlayEAJigyrophzt1H2ZyYiVh6L38T//ba61SA3yj+
	V+Ej33XLk/hwpDZdTKYGBo/J9dFvG63QqLk0pRgYYDLbMH/zsxJ/CIkPLUxYksWKPpSHP6XA==
X-Received: by 2002:a17:902:efd1:b0:2bd:bbe:e3a3 with SMTP id d9443c01a7336-2bdb03a42b7mr2583995ad.10.1779131531408;
        Mon, 18 May 2026 12:12:11 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe4973sm159670935ad.41.2026.05.18.12.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 12:12:10 -0700 (PDT)
Date: Mon, 18 May 2026 19:12:05 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	David Matlack <dmatlack@google.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, "open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/3] kho: Add kunit static stubs
Message-ID: <agtkMYr4-boyOQtK@google.com>
References: <20260512195135.804833-1-skhawaja@google.com>
 <20260512195135.804833-2-skhawaja@google.com>
 <aggfP-0A-i-bYlP7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aggfP-0A-i-bYlP7@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_121213_577557_9FCDAE75 
X-CRM114-Status: GOOD (  16.83  )
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

Hi Mike,

On Sat, May 16, 2026 at 10:39:43AM +0300, Mike Rapoport wrote:
>Hi Sami,
>
>On Tue, May 12, 2026 at 07:51:33PM +0000, Samiullah Khawaja wrote:
>> Add kunit stubs in kho_restore_folio() and kho_restore_pages() so the
>> users can mock these functions in kunit tests.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  kernel/liveupdate/kexec_handover.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>> index d5718bef6d4d..1375291d9b07 100644
>> --- a/kernel/liveupdate/kexec_handover.c
>> +++ b/kernel/liveupdate/kexec_handover.c
>> @@ -11,6 +11,7 @@
>>  #define pr_fmt(fmt) "KHO: " fmt
>>
>>  #include <linux/cleanup.h>
>> +#include <kunit/static_stub.h>
>
>Can we include kunit headers before linux headers?

Agreed. I will update this in next revision.
>
>>  #include <linux/cma.h>
>>  #include <linux/kmemleak.h>
>>  #include <linux/count_zeros.h>
>> @@ -437,7 +438,11 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
>>   */
>>  struct folio *kho_restore_folio(phys_addr_t phys)
>>  {
>> -	struct page *page = kho_restore_page(phys, true);
>> +	struct page *page;
>> +
>> +	KUNIT_STATIC_STUB_REDIRECT(kho_restore_folio, phys);
>> +
>> +	page = kho_restore_page(phys, true);
>>
>>  	return page ? page_folio(page) : NULL;
>>  }
>> @@ -459,6 +464,8 @@ struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages)
>>  	const unsigned long end_pfn = start_pfn + nr_pages;
>>  	unsigned long pfn = start_pfn;
>>
>> +	KUNIT_STATIC_STUB_REDIRECT(kho_restore_pages, phys, nr_pages);
>> +
>>  	while (pfn < end_pfn) {
>>  		const unsigned int order =
>>  			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
>> --
>> 2.54.0.563.g4f69b47b94-goog
>>
>
>-- 
>Sincerely yours,
>Mike.

Thanks,
Sami

