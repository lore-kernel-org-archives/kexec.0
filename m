Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E77ACD6E60
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 16:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bQ18P4Rtva2V1dnwLC35V2xECHbwpYcWUGfZy2CqNMI=; b=NjUbqwV37UqpudzWXI3h9dWfNN
	QVYyuxRF2hEE30R/oyQnLWV+NL6RhrVwyyHh3n3d9cZ/zllL0J/Kfw0BOSlmOrkLBTV0SOYiWVGW9
	8fImV+MWsZ/qvuOe57knISGqIUpB9Mnr4A3AAF4dxpBpHR4DQDUuPR3Ez9KWVYRGdJ75WH9oUdwEA
	pFMmuKIXc6l/SzQz3Zj7hYK2GYqTZJbneKdpelehg6xLGjl4v98KRfjyAzE6JqyWAgeNICWm4R94v
	PN2/hP3BYe4qdL2SyLUnBaNAyQaL2AdqJp+AtRy9QG4DZcrusv8XUOui/pDOHJHcOgceDiZ8Z/eeE
	rztvlDVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUSSA-0000000DVnH-3VVT;
	Tue, 02 Jun 2026 16:58:58 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUSS8-0000000DVmW-3sXW
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 16:58:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2940A41B70;
	Tue,  2 Jun 2026 16:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFD51F00893;
	Tue,  2 Jun 2026 16:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780419535;
	bh=bQ18P4Rtva2V1dnwLC35V2xECHbwpYcWUGfZy2CqNMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=mFkg6QUXdBtOZiOz8FOhkKUhWAbS6Mxo0Q939D8EF/TmogBhU8ec9TTQV4MYbboZi
	 XIoVcBQ6Ze7qt14Bk1JIusq14cc+CcPfDxT3cf/sVeDqNFBlPmhev/uU0797vhxB4R
	 HfWjUm/1pHvbvzTYBhgp69UT3g/Wb9tarzvn4VnEfvmKCiD+vXScZINin5xNiWXYNs
	 9WDR2Vvz2MZoknO5ejAySKQv0U0TzYWBZ5aRjKqO2CMMhFKkHi2fKndcFb+JDozdMp
	 WsPrizDwBo00dWNbCDKYcMlWvdYX62Z2JevZN3e8R9X7pNC+aosPFF853Gk3al+596
	 8Qjy5FXg5vfuQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Michal Clapinski <mclapinski@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Baoquan He <bhe@redhat.com>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Mike Rapoport
 <rppt@kernel.org>,  Pratyush Yadav <pratyush@kernel.org>,
  kexec@lists.infradead.org
Subject: Re: [PATCH] kho: try to allocate contiguous memory for kexec segments
In-Reply-To: <20260601193014.896405-1-mclapinski@google.com> (Michal
	Clapinski's message of "Mon, 1 Jun 2026 21:30:14 +0200")
References: <20260601193014.896405-1-mclapinski@google.com>
Date: Tue, 02 Jun 2026 18:58:52 +0200
Message-ID: <2vxz4ijkev5f.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_095856_987062_0E693D8B 
X-CRM114-Status: GOOD (  10.29  )
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

On Mon, Jun 01 2026, Michal Clapinski wrote:

> This allows us to skip relocations (and maybe checksum calculation
> in the future).

I'm confused. Doesn't your patch "kexec_file: skip checksum verification
when safe" [0] skip the checksum for KHO already? So this only skips the
relocations part then?

And based on the discussion on that thread, relocations don't seem to
take much time. So is there a real need for this patch?

[0] https://lore.kernel.org/kexec/20260602123311.1841746-1-mclapinski@google.com/

>
> kho_scratch is marked as MIGRATE_CMA but isn't actually given to the
> CMA, so it should only contain movable allocations, therefore this
> should always succeed.
>
> Signed-off-by: Michal Clapinski <mclapinski@google.com>
[...]

-- 
Regards,
Pratyush Yadav

