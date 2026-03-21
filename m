Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEE11099B58
	for <kexec@archiver.kernel.org>; Sat, 21 Mar 2026 01:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+jB3wVb8b41+AhY+FGn1IfBV7nGIdJUQVJNEPUCsiQs=; b=cy+rn9LRzShDzOUQI9NJ3KgVWI
	a/yIjgDzmivT6HGQxBgpbb20JQxuoDne3ID/gErrx6bmzwTeA1j3XHaStrNjh4oNncfkAs92YkpB3
	Fu+S8DZREC6cvLPFjp4Oe14ZTZeicGQaI7tV8Dko+tgcKVgmPGK6BcK3rfnt3aK6Nv2V7sPI5KcF9
	CBsSJNFPY8rgmT6ZVOV2HDeK5oroCCUGVKMPp1EqTtl9tOCckpp8Cke6aDzmiB1VsbcMpLMfIKo99
	7s7vZvwqnRZaGQdwA5w6wigZ+eWiwhPriDdW3ofrFCRyd1+u9haqoXQly4YZINqXta3/NrEqdk5Ix
	Gk2+4oyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3l4G-0000000DsiQ-1Lor;
	Sat, 21 Mar 2026 01:23:56 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3l4D-0000000Dsi3-3uVH
	for kexec@lists.infradead.org;
	Sat, 21 Mar 2026 01:23:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id F2A4F445A0;
	Sat, 21 Mar 2026 01:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF70C4CEF7;
	Sat, 21 Mar 2026 01:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774056232;
	bh=rnrB+r9upjuRc+mL3xjhUHiIFwtv9f3pu+ODqRoiEwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KYI1iLRkjpOcMtcGWhWI/CIiVv3M0XEkmgOw+PNHtt+ULqlxzMo4WftpXVrrKPtYj
	 FqeLjp7rFmN+uPb6hqwOrQL5pzJpVL9JO9Qf48H1JHtkM31dPeMvjRqReZmBRp50jx
	 CgIIj80gZKOAnJnSwrCytPR64i6NrAp4ucIDozrE=
Date: Fri, 20 Mar 2026 18:23:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport
 <rppt@kernel.org>, Baoquan He <bhe@redhat.com>, Pratyush Yadav
 <pratyush@kernel.org>, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/5] liveupdate: block outgoing session updates during
 reboot
Message-Id: <20260320182352.ca6c88e409ff12d0368b03ae@linux-foundation.org>
In-Reply-To: <20260320163720.100456-1-oskar@gerlicz.space>
References: <20260320163720.100456-1-oskar@gerlicz.space>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_182354_015867_ED3B7DBD 
X-CRM114-Status: GOOD (  10.09  )
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

On Fri, 20 Mar 2026 17:37:16 +0100 Oskar Gerlicz Kowalczuk <oskar@gerlicz.space> wrote:

> When kernel_kexec() starts a live update handover, LUO serializes
> outgoing sessions before the reboot path freezes tasks or shuts
> devices down. That leaves a window where close() and
> LIVEUPDATE_SESSION_PRESERVE_FD can still mutate an existing outgoing
> session after luo_session_serialize() has already captured it.
> 
> The race is dangerous because the next kernel may inherit stale file
> metadata or references to memory that userspace has already
> unpreserved. That breaks handover consistency and can later trigger
> restore failures on already torn down state.
> 
> Mark the outgoing session set as rebooting while serialization is in
> progress, reject new mutations with -EBUSY, and make release wait
> until rebooting finishes before unpreserving files. Reset the flag and
> wake waiters when serialization rolls back, and use READ_ONCE() and
> WRITE_ONCE() so the state is visible across CPUs.

Sashiko AI review has quite a few questions:
	https://sashiko.dev/#/patchset/20260320163720.100456-1-oskar@gerlicz.space

