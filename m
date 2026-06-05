Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779AFCD6E74
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 13:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MSUGCFZbkdGQsRUVae3QaiSIyG10l/zFA2SJJnCDFTk=; b=jOarFm0W6+cT0e2Pud4vhlrgVT
	3feGZORxpOPQO2Zi+gGU0CxT1M1LwyOsXL1c/eSwa4FYxAJKCeQ+3Z6YwF42FjuPlvUSnQHXbClXd
	gkxU3UsJ1SjzdDrXNQAFIwjxe7fHQi/7wOm6Y2l+16UJwo+l7NIQtpCMrKGzvIq+2895p413If5dS
	ojlAoOlQqDBSiOiEJo+QJOWMXhHU1VPife4JfNjp6K/xprkhtYRfF2slR4IkVLWopLddJjaKqAHTW
	hVISHv3ILDxn70mxwEUIeAK9486/uMCsbaG5ZRby4ex8S5DBnM7WwjGUyqtuROaHOAmaZV5uyBZq7
	2WEHR8kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVUIm-00000000fDo-3yOs;
	Fri, 05 Jun 2026 13:09:32 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVUIl-00000000fDg-0QUp
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 13:09:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 366D4601F6;
	Fri,  5 Jun 2026 13:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8ED91F0089B;
	Fri,  5 Jun 2026 13:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780664969;
	bh=MSUGCFZbkdGQsRUVae3QaiSIyG10l/zFA2SJJnCDFTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=lshDNLBhgZQFNVje19VffYLe+ZFC9W8lZQs2f3s7kwfrG09Clru/mXdMIUrdWeUvV
	 kCiF9w2g8mOgl6ct8wSWE3zgj4Q2m0tSIaQLC5U8NmLNPDH0Q7owm1jdvRa0jTJaUd
	 hd1p1QmHyhHMXpXP8ZCT1YeChPdn555tDHPz/WzVbZZFQe7xK8RKyQ+TX2kov6EfBu
	 Pk6m0a2CX5c4t+rY/dkGc0irf8OEmopivtpCa5b/mUH9P5Be9vkwWDp3G8iHXiQXVq
	 /vOeGHmozLHEazZGAjZya4DT1m0ZRKC7GALyTNiOFlc2Qmc5jXMxJ2ZKUg143VBDTt
	 UXssIgzG71Qgg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: David Matlack <dmatlack@google.com>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Andrew Morton <akpm@linux-foundation.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>
Subject: Re: [PATCH 0/2] liveupdate: Small FLB fixes
In-Reply-To: <aiENGcp1UCq5XMme@kernel.org> (Mike Rapoport's message of "Thu, 4
	Jun 2026 08:28:57 +0300")
References: <20260528174140.1921129-1-dmatlack@google.com>
	<aiENGcp1UCq5XMme@kernel.org>
Date: Fri, 05 Jun 2026 15:09:27 +0200
Message-ID: <2vxzcxy5i16g.fsf@kernel.org>
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

On Thu, Jun 04 2026, Mike Rapoport wrote:

> On Thu, May 28, 2026 at 05:41:38PM +0000, David Matlack wrote:
>> This series has 2 small fixes to how FLBs are managed. First is to
>> increase the outgoing FLB refcount during liveupdate_flb_get_outgoing()
>> so it cannot be freed while the caller is using it, and to align with
>> the semantics of liveupdate_flb_get_incoming(). The second is to prevent
>> FLB retrieve() from being called multiple times if the first attempt
>> fails.
>> 
>> Both of these changes are needed for the correctness of the PCI core
>> support for Live Update:
>> 
>>   https://lore.kernel.org/linux-pci/20260522202410.3104264-1-dmatlack@google.com/
>
> We are late in the release cycle and since there no in-tree flb users let's
> postpone this after rc1.

Yes, I agree.

[...]

-- 
Regards,
Pratyush Yadav

