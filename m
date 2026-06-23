Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13C4CDB470
	for <kexec@archiver.kernel.org>; Tue, 23 Jun 2026 09:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oqPSlwE/GnTAhDYuFLm1uNzWqGhqHwtOsXDDbJf6dDk=; b=A1FGIyvjLMUmRuv+ot3yLatEa4
	VQCh09QtrK9Gjxwq5HWsAh44n6s1dgZ9xgI7HJLdkfAHAWuyL29riER1aqTPLFoD/kiZ0+VnGIsGL
	G1Q7n7Pse+DSbwN+m8WQ9amJ9Mvu5t/zhczid7Btv70b9rbFj/q+ZrHm+Nio9CMuVLL6K3ttPEYey
	NIuIC/24xm/so9MzOFHPSHv8+wqUf73hGMDOfPOMjcJZLuP1uNTJV/4t0Ai1j0ZTFcqAanTOa+Pol
	qsoWVQA3J88nYbm1Af0c2jwSqKiNWAWFI95b7CsaDaZOEqFhgVfUSQHCOLFjLDhErAgdc+ZTOZ4ZS
	P4qNvaUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbxcD-000000061WA-2iYe;
	Tue, 23 Jun 2026 09:40:21 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbxcC-000000061Vg-00Bi
	for kexec@lists.infradead.org;
	Tue, 23 Jun 2026 09:40:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 846F6444D1;
	Tue, 23 Jun 2026 09:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC7E1F00A3A;
	Tue, 23 Jun 2026 09:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782207619;
	bh=oqPSlwE/GnTAhDYuFLm1uNzWqGhqHwtOsXDDbJf6dDk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=TAJxScz8EZL6p6hHbdM7gpkpcSCZAhp6wy0FJkKZJ0JUVqHzTjbbgNrB/W+GJo8Eu
	 kewe6TF6w0yX+jEf1dzquEKJUccuqMuBbfFIpg0CD86WPlnIAb8Qx+VuaBf2kSyxhC
	 yTqmHv+O4l13ADleH9FAu2YyDMhGxDRTlLM4gAVTcZNecX9VnitiLqEcpvR6b8o+K+
	 6W+gnhW/MJRDrjsZOWUTtqu4nHIMnBVWgMeUzS3sDYYNwtCdYNkuTbR+Tzbiu8Fg1M
	 iJO3+7idK/BvBKud48YJfIMIbvJJbStarVkiGiF9wqDv6ESeazAZDx/cJc02HW/CfR
	 h4gM2Jw6eevSQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 2/2] luo: Update serialized data to use KHOSER_PTR
From: Mike Rapoport <rppt@kernel.org>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
 Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
 linux-mm@kvack.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260622225736.2961438-3-tarunsahu@google.com>
References: <20260622225736.2961438-1-tarunsahu@google.com>
 <20260622225736.2961438-3-tarunsahu@google.com>
Date: Tue, 23 Jun 2026 12:40:11 +0300
Message-Id: <178220761164.162773.6384380547612711985.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Mon, 22 Jun 2026 22:57:36 +0000, Tarun Sahu <tarunsahu@google.com> wrote:
> Convert raw serialized_data to KHO serializeable pointer (KHOSER_PTR).
> This series also takes care of resolving the bug with memfd of using
> phys_to_virt before checking the args->serialized_data value.

For easier backporting the memfd fix should be a standalone commit that
comes first in the series.

Other than that

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.


