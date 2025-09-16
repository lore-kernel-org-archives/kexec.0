Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB122CAC59B
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 13:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IDn0rh7zU8d+rzGbtxh1PQkeYWg/ygdRtn2ehDK3iw4=; b=NYHsoI1BpK8T87LlfIMsj0aYEb
	zaV4g6RlCYNSBxxU3sULzTJDoG0QEFhveV6Bf9ZkMQqXt0HqYriXVtx/1uw6O4y4LXBwOgpyGx1th
	V6qt5KPiT2HTplwm628lSA2jcz+8UWYImr/waP5Mpzy6E3cprFmTmvp1UA/Dufjq/WjlBQ7LdPD06
	VRxN9WHB+dkTkjrxCaSUo+dCvCXEp06n+OSRAHTTALHAbDMBGH0ODgQzjmjqMki6UJKzT//pC4zkc
	51lDjmJlnm93GxwHL4HNTS7kfVKS89P9Qt6xBQIlc1GGru/FOzgzDw1+dqilL7FrUNO48KtPjTGD3
	SyYBrk9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyVct-00000007urF-39jU;
	Tue, 16 Sep 2025 13:21:43 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyVcs-00000007uqE-07i9
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 13:21:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6CE67601A3;
	Tue, 16 Sep 2025 13:21:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1C8C4CEEB;
	Tue, 16 Sep 2025 13:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758028901;
	bh=rAvqEfhmGxEnvdZNyv3LFHPZmEftR6dOMSWOd/EB0bg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ot8VUQUm11Wn2fQsIQd89sBxvXfdHgw1OvkeKD97GN6OOkDmDuOVVGqb6eYdxZcsp
	 XnstJ8uG7ADE2sOM49qgDDarHlUWPbC/wVZieuRlDc1Ob2fxjNmPAtRM41vz6lvuOa
	 hG8a7QgYiScra6ptd4v+NK3BHnst6WXvIBMNNOwbwPWaj+9xFPFjRfPWLdNX/iHsjl
	 seKtbnOBm5FiAXJBR1WBcDvVU7ipceTXOVzyNXnd3AQTNn26gJhMZZhj68mvre2oCY
	 4844jDl91bxcTMG3pzI8j9cBomn3J7lvMB0nNfaN4MzOBf/uLmrdMnxe1IM/8up3Dc
	 YUJGpNEM8vxWw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mike Rapoport <rppt@kernel.org>,  Pratyush Yadav <me@yadavpratyush.com>,
  Pratyush Yadav <pratyush@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Graf <graf@amazon.com>,  Baoquan
 He <bhe@redhat.com>,  Changyuan Lyu <changyuanl@google.com>,  Chris Li
 <chrisl@kernel.org>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kho: add support for preserving vmalloc allocations
In-Reply-To: <20250916130516.GB1086830@nvidia.com>
References: <20250908103528.2179934-1-rppt@kernel.org>
	<20250908103528.2179934-2-rppt@kernel.org> <mafs0ldmon784.fsf@kernel.org>
	<mafs0ldmnlmq0.fsf@yadavpratyush.com> <aMgey9qEC_XUejXm@kernel.org>
	<20250915144335.GL1024672@nvidia.com> <aMhAiR6qnXMA-c8r@kernel.org>
	<20250916130516.GB1086830@nvidia.com>
Date: Tue, 16 Sep 2025 15:21:37 +0200
Message-ID: <mafs0v7lih6se.fsf@kernel.org>
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

On Tue, Sep 16 2025, Jason Gunthorpe wrote:

> On Mon, Sep 15, 2025 at 07:36:25PM +0300, Mike Rapoport wrote:
>> > Under the covers it all uses the generic folio based code we already
>> > have, but we should have appropriate wrappers around that code that
>> > make clear these patterns.
>> 
>> Right, but that does not mean that vmalloc preserve/restore should use the
>> public KHO APIs and avoid using internal methods.
>
> I think it does, the same way vmalloc is layered on top of the buddy
> allocator. Why wouldn't you build things in clean understandable
> layers like this?

+1

-- 
Regards,
Pratyush Yadav

