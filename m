Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CF0C55167
	for <kexec@archiver.kernel.org>; Fri, 31 Jul 2026 07:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dSMQ2bKPq0zdk+Cmja7/t3KRwGXqemKsiLLvQYd6FgQ=; b=GdQGkFbgPJB1Lzkpb7AeLzsh8c
	WSQ58RzdJ6bkAXcFy7KJWsgigd6bXE6JJDpM7UsU4B4MbZJdVdqFcsTejy7vA/cSUwi65EifhOfDL
	0yMQ1FdoxvBV0FXWtGhZFaKpvxoSMxXQDoatVJblWqOpYwiEVWkcrt5W/psCJB37pkya3g3Tq8c+h
	NYhxSnmFCQyd8iLw4WZ5ZDM2MUQ5XUuzDRZHIaokH75G14QRzGn88M4zV+7t7jOdGJAO0RhXAy/Ql
	GyD/f4ZPmtf4KhUyuEqCycFoKyMWT7WHV3tx9mcKNFU7be8eFBZV/fYNv0cO3XWs1qpEQRQVMOG8D
	DGBV34LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wphMr-0000000BvqR-0bx1;
	Fri, 31 Jul 2026 07:09:17 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wphMo-0000000BvpY-1lLi
	for kexec@lists.infradead.org;
	Fri, 31 Jul 2026 07:09:15 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785481732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dSMQ2bKPq0zdk+Cmja7/t3KRwGXqemKsiLLvQYd6FgQ=;
	b=wr7rHdxqTL40HfUju/7rV7DxeT32ljDlmTQEJCfAXb1T/vuywN8ChoL5vO3TY0oQ7DC4R5
	2P33f3pEvTuEp6zuvxyCh3fVIc7H4gMX45HuOgmy2tPkyPTTkNIxkXt/ZJj60npiDFc+tQ
	BBqp/mZaneVJ4dDvlETEEl3xm3UlAqpb8w+w8u7BqgSlAJ0ZwfunJNxtxHGxUNYv/p9+o+
	3Iw8ooXAQT3P3wonr+bNm24tDWDdhxW5cQLyKSx0JKuffnURRymHzBKb46QhEQZ/DdBYFI
	JXieafIaPJpte2ECSqTPiUrMoC9LEgyIUIWiekKabkmvLwoP5waYZkd+zPkGvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785481732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dSMQ2bKPq0zdk+Cmja7/t3KRwGXqemKsiLLvQYd6FgQ=;
	b=Em1aH6OU1p4VdxzlT4lLu8aVr48FHdPUaNBPKWoSF7S02z9urwCwo3crvSeR+PlkrhtX1O
	ieGUGcoAd8wdhOBQ==
To: Serapheim Dimitropoulos <serapheimd@gmail.com>, kexec@lists.infradead.org
Cc: Simon Horman <horms@kernel.org>, Petr Mladek <pmladek@suse.com>, Philipp
 Rudo <prudo@redhat.com>, Baoquan He <bhe@redhat.com>, Serapheim
 Dimitropoulos <sdimitropoulos@coreweave.com>
Subject: Re: [PATCH kexec-tools] util_lib/elf_info: stream lockless printk
 ring records
In-Reply-To: <20260729-vmcore-dmesg-stream-upstream-v1-1-a00b5d5489f0@coreweave.com>
References: <20260729-vmcore-dmesg-stream-upstream-v1-1-a00b5d5489f0@coreweave.com>
Date: Fri, 31 Jul 2026 09:14:52 +0206
Message-ID: <87o6fnws8r.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_000914_601377_7FACCAE4 
X-CRM114-Status: GOOD (  12.18  )
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

Hi Serapheim,

On 2026-07-29, Serapheim Dimitropoulos <serapheimd@gmail.com> wrote:
> From: Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>
>
> We came across this while testing kdump on an arm64 system with a 64 MiB
> printk text ring and an 850 MiB capture kernel. vmcore-dmesg was run from
> the capture kernel before makedumpfile, but it was killed with SIGKILL
> before it could produce any output.
>
> The lockless ringbuffer reader copies the complete descriptor, info, and
> text rings before it starts processing records. For the above setup
> these copies raised peak RSS to about 345 MiB. This is a significant
> part of the memory available to the capture kernel, and most of the
> copied data is only visited once.
>
> Stream the active records directly from the dump instead. We initially
> considered using exact reads for every field. That keeps memory use
> bounded, but turns every record into several small reads.

Is that really a problem? The code would be much simpler and easier to
review and verify if you did it this way.

At least, I would expect a patch that does this implementation
conversion first. Then, if you really need the caching optimiziation, a
second patch that adds the layer of caching.

Also, I would expect the caching to be a generic mechanism that can be
used for all kcore reading, not just the printk ringbuffer.

(I do not have any authoritative role for the kexec-tools. Just sharing
my thoughts on this patch.)

John Ogness

