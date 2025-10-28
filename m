Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB5CCCD1BF
	for <kexec@archiver.kernel.org>; Tue, 28 Oct 2025 12:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qv3GohWqQgrGHwaxj2d2Xaf/EkkHHeIVB+/xSV7yFv4=; b=d/grMArRg6XdUyCmq0xmJyCAjH
	JsMg2tdQV2cHGhn8lmc2g1UGMMDTGAhxTz4wvTeKeASLm6jYfQLlyHz0Zo3mA7/NRlnZUZE30ZQcZ
	/IHJtaYrZUNxSCAaqLjBolesUQ/ANod9HddA5PpubQnBiEXvyeKn1Eq+6GrM62kVlzw+iKTy9YbMi
	JrLP5rHuBmErejO4/iTUSzZSxKY+g6y66v5z2Yu9qq7+mKV7uc+qFTuJYmPiRidwsJsQ5yCVGG51a
	6uTclVsK/nnT7oKDTg7ojMwEduf0QHeCr0Sn20IV34TIrMwxmDQsXzG/KiP8AgLRaT/eJe7rQdQ2/
	Loq/X1qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDjII-0000000FyeR-2V3H;
	Tue, 28 Oct 2025 12:59:22 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDjIG-0000000Fydx-1fRD
	for kexec@lists.infradead.org;
	Tue, 28 Oct 2025 12:59:21 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761656352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qv3GohWqQgrGHwaxj2d2Xaf/EkkHHeIVB+/xSV7yFv4=;
	b=NE7okjrhYT+Phe6z31Nw+rc4ReQOJbVOhEpDE0z7KFgiM3Q/3cN/zek9aIeCo9gGbJyX1y
	M671Iw2qv7qi0MON7KLZwUOZ4cdId0WZ4M+ZFIzoLHPMGkqKg1TCfV5Q73lhXEZ+bFI05v
	ZG6b+y7VoJfXX8OIuowC6DaTFd2R64VkaaTYrzEWfyfVDHKIytM0z+oUWbawWDu5GkVfj8
	+XaFEcHKI0p/bAHWnBVxH6dRoDRvZA3uFm0qZktS9YQl3Vdwmd/5rZOYXSB7c9BDQ4Rg0u
	7XJz0ljMHA71Uz+Zxv6/yctqaAjEuQJtKO2xcvKv50oJZJtbBMbClt8samzpCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761656352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qv3GohWqQgrGHwaxj2d2Xaf/EkkHHeIVB+/xSV7yFv4=;
	b=O66dcqLcRsfw63bXuc/kWIr3HD97R+qJW70ShL4pAweT0heNzZ124tHYRZqer8Z4SUGdP/
	WElduijmtsTraaAQ==
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Waiman Long
 <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Andrew
 Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Ingo
 Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Valentin Schneider <vschneid@redhat.com>, "Rafael
 J. Wysocki" <rafael.j.wysocki@intel.com>, Joel Granados
 <joel.granados@kernel.org>
Subject: Re: [RFC 2/3] kernel/cpu: Mark nonboot cpus as inactive when
 shutting down nonboot cpus
In-Reply-To: <aQAvnjVvJOUx78Nk@fedora>
References: <20251022121345.23496-1-piliu@redhat.com>
 <20251022121345.23496-3-piliu@redhat.com> <877bwgw9yf.ffs@tglx>
 <aQAvnjVvJOUx78Nk@fedora>
Date: Tue, 28 Oct 2025 13:59:11 +0100
Message-ID: <87qzunuqqo.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_055920_575944_4167DC5C 
X-CRM114-Status: GOOD (  11.59  )
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

On Tue, Oct 28 2025 at 10:51, Pingfan Liu wrote:
> On Mon, Oct 27, 2025 at 06:06:32PM +0100, Thomas Gleixner wrote:
>> When kexec() is in progress, then running user space tasks at all is a
>> completely pointless exercise.
>> 
>> So the obvious solution to the problem is to freeze all user space tasks
>
> I agree, but what about a less intrusive approach? Simply stopping the 
> DL tasks should suffice, as everything works correctly without them.

What's intrusive about that? Task freezing exists already.

> I have a draft patch ready. Let's discuss it and go from there.
>
>> when kexec() is invoked. No horrible hacks in the deadline scheduler and
>> elsewhere required to make that work. No?
>
> To clarify, skipping the dl_bw_deactivate() validation is necessary 
> because it prevents CPU hot-removal.

If you freeze stuff there is nothing to do. Hibernation works exactly
that way without any magic hacks in a particular scheduling class, no?

Thanks,

        tglx

