Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2ABCF2567
	for <kexec@archiver.kernel.org>; Wed, 19 Nov 2025 07:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vdrsuAUdpbqqunVqp58ReSXW32+mjpcLGlUNrIEe4eE=; b=vkAzSRimPFHsh1EOqyHtbVytaJ
	EwD1XmHtj9rLgQfR88U/FUABbUD6CIkNsBcjsooJ+RaMWpmKX57e20aZjCAjsHhBuOkPwodSTIYYX
	08rDg22bYVus3PJWSqcJ1jMyCLC9CGHvLfzF8drYHG43aAXuNLO2uvtcXLQKyx5oiGiOAlkXjB8u3
	IGgM15G54XKEJRDHnJRmzifvRnuZpRtbZtagXCX3VQbhrkyyjoRxjK2qx5DEEXuHvUIY/a0WhC1QB
	wGDYcq3AIaasTbicIUBpmcwNDa4Wrj61TXYpv9h263AmIbNDcc9FXG5tXYbddEgRBtbPRJTXkI03M
	fm+Akhlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLcjh-00000002iqg-199E;
	Wed, 19 Nov 2025 07:36:17 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLcjf-00000002iqY-3V7h
	for kexec@lists.infradead.org;
	Wed, 19 Nov 2025 07:36:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D5BE460203;
	Wed, 19 Nov 2025 07:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18C1C2BC86;
	Wed, 19 Nov 2025 07:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763537774;
	bh=1Wyir4dUb411OJQcXtSbnzdCRtoxa2Xp8KUJcJ3isiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t3NbtU5eN3FF6zsiJiXq1AUAzSh7rwLD677imzgwtElqgiiZBB12fdPuxr3vmbCln
	 UnAvNFc26kqOfagNuvvLFcPyJfcFOenRr7BKPOzgQOgJYV/1VUSTDeaTOp1EvpIGlA
	 KOX9ejJhtRoMceQOxstmIpYyZSno0JPW9NgO7tNo=
Date: Wed, 19 Nov 2025 02:36:09 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add test_kho to KHO's entry
Message-ID: <2025111944-tracing-unwieldy-1769@gregkh>
References: <20251118182416.70660-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118182416.70660-1-pratyush@kernel.org>
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

On Tue, Nov 18, 2025 at 07:24:15PM +0100, Pratyush Yadav wrote:
> Commit b753522bed0b7 ("kho: add test for kexec handover") introduced the
> KHO test but missed adding it to KHO's MAINTAINERS entry. Add it so the
> KHO maintainers can get patches for its test.
> 
> Cc: stable@vger.kernel.org

Why is this a patch for stable trees?

