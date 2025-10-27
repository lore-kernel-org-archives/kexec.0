Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590D4CCF9EB
	for <kexec@archiver.kernel.org>; Mon, 27 Oct 2025 17:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ly9lHTV7pGY90o2gDvQwQAclp/mCDZvMngSMfxYBzBs=; b=gUpTHpis2NYPFsbAtoIceNGdDz
	t27ymF6P25cUyYoVhBs1LE9EsmhTMNdItw9i6Z0WXDlfAqXIHrsxmC5XCi6nMUN9IaXqjyMy3GvW5
	2JKUs/WLFvQIzMvXsinJ5oU0BjGfiDeVHnhZljzUyQ2RGKGDtf45wx6NFTfXTx5q8yXD4t9XvnPdh
	CJsiRG21AGo2eGjk9Ud8XtGVRUXePZGdY6H5+pg8dibu0FAG18GvPzKpCMIHHY/Be33k49DBA8AB0
	TfSJzGvBbkAPt0907o/88/7I0VG/n+xw5nT3qUtSWnmz2Rkk9ojTcxWBYoJlwxZWhZOiiOBaW2zQy
	eHHhwzPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDQg2-0000000EOZl-0CHn;
	Mon, 27 Oct 2025 17:06:38 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDQfz-0000000EOZ4-1z7C
	for kexec@lists.infradead.org;
	Mon, 27 Oct 2025 17:06:36 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761584792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ly9lHTV7pGY90o2gDvQwQAclp/mCDZvMngSMfxYBzBs=;
	b=XIKUsAiRLj71JSTXYtA2mvzg6OMGGpuSU8qzaHKQUJZ0ab4AQFETnXDP2GVyChQeLFzf3g
	WwzI6+5+I4uQYFF2jU9T+wLerdcq7aGP2o2AnlV7KpYy6sbUd2yHt6hxe4faLYrs9TUA/f
	2VWLXjNTUR8RwGsyWEFiKxuWlQj02Bu6tj1hPkqUgvDITwXLKBZxwb7hslyjH8M0K1vnCf
	2mZB22hTiYKODkWAPmRDG+2L5WVoTBTnRbuHC7faUWspZjcIZs9V+GUHefKCdC3+cY2sgf
	5nA+Cxhmgysw9/aT9aAjiB+Lx1cbezKHzcJIMQSlLOO6QCESy30k/VcZNwJkxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761584792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ly9lHTV7pGY90o2gDvQwQAclp/mCDZvMngSMfxYBzBs=;
	b=pMhrivgTZh57ymMKQy8Hd6JF87LtmQ3sUEJmyqMg4YHzO/xjHuYYrFs6VrupPkvWdFjteF
	a3C8TxB+WyvqmMBw==
To: Pingfan Liu <piliu@redhat.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>, Waiman Long <longman@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Ingo Molnar
 <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, Joel Granados <joel.granados@kernel.org>
Subject: Re: [RFC 2/3] kernel/cpu: Mark nonboot cpus as inactive when
 shutting down nonboot cpus
In-Reply-To: <20251022121345.23496-3-piliu@redhat.com>
References: <20251022121345.23496-1-piliu@redhat.com>
 <20251022121345.23496-3-piliu@redhat.com>
Date: Mon, 27 Oct 2025 18:06:32 +0100
Message-ID: <877bwgw9yf.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_100635_655518_C3EB10CE 
X-CRM114-Status: GOOD (  11.61  )
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

On Wed, Oct 22 2025 at 20:13, Pingfan Liu wrote:
> The previous patch lifted the deadline bandwidth check during the kexec

Once this is applied 'The previous patch' is meaningless.

> process, which raises a potential issue: as the number of online CPUs
> decreases, DL tasks may be crowded onto a few CPUs, which may starve the
> CPU hotplug kthread. As a result, the hot-removal cannot proceed in
> practice.  On the other hand, as CPUs are offlined one by one, all tasks
> will eventually be migrated to the kexec CPU.
>
> Therefore, this patch marks all other CPUs as inactive to signal the

git grep "This patch" Documentation/process/

> scheduler to migrate tasks to the kexec CPU during hot-removal.

I'm not seeing what this solves. It just changes the timing of moving
tasks off to the boot CPU where they compete for the CPU for nothing.

When kexec() is in progress, then running user space tasks at all is a
completely pointless exercise.

So the obvious solution to the problem is to freeze all user space tasks
when kexec() is invoked. No horrible hacks in the deadline scheduler and
elsewhere required to make that work. No?

Thanks,

        tglx

