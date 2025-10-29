Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D183CCCD1BF
	for <kexec@archiver.kernel.org>; Wed, 29 Oct 2025 02:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WYTH6r4pMzG++s76D15s6Jao2UHZD14Avc7KSLviCz4=; b=FdNLQubLQwjdgTl7B1ywPRtAHu
	YkIfZt7gyAY8ELg/x9pClGzHZHPWxNk76mbXcgWkFAU7RDyZU4WqJEuE9VbePdnXTfgZVzWu+ZL6A
	+4N6ojmnwXp9L/4r+ydxri7qpgjxV15yoTxn8/J38lGQHU5tFWBMXer6jRzyZ1w7yBP0QdQjz4wr2
	hY3ZFnZyTcb6OXxEPVR3AoFKHNe8bqLOsqzNywjYmTUbKZ2faXFf9R5bjpv903+2KLxb2o1ByWsNY
	iU2O4ysHh2mYHHHVxNkSFSu1zySv8LmDgbRoD6uGIzLfqRj55otqxc0rgIV1hcqqfB5BJm+FVxoT8
	QSpBnmNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDvV9-0000000GxZV-1Rrq;
	Wed, 29 Oct 2025 02:01:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDvV5-0000000GxZ4-3uom
	for kexec@lists.infradead.org;
	Wed, 29 Oct 2025 02:01:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761703282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WYTH6r4pMzG++s76D15s6Jao2UHZD14Avc7KSLviCz4=;
	b=HXgoPSN+NijHLb+/7Ucn0mFnuct+hQnLawIhWOsXmdg8+tURCI9qb2xKc1sR/4fV1RH6Yi
	AvhHX5j5OfRYMl0yEd7vkdHkjk5VZVqMGpT+KqPY8EoCWddPY9nuFumRCG1nY3zy9A1xer
	CIc9HZ+MOdmXd7jr7LYTsc9ikBOWLp8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-BuRRDu5BMS6XHxBgXgGynA-1; Tue,
 28 Oct 2025 22:01:18 -0400
X-MC-Unique: BuRRDu5BMS6XHxBgXgGynA-1
X-Mimecast-MFC-AGG-ID: BuRRDu5BMS6XHxBgXgGynA_1761703276
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E4A519541B7;
	Wed, 29 Oct 2025 02:01:15 +0000 (UTC)
Received: from localhost (unknown [10.72.112.80])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E3FD180035A;
	Wed, 29 Oct 2025 02:01:12 +0000 (UTC)
Date: Wed, 29 Oct 2025 10:01:09 +0800
From: Pingfan Liu <piliu@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Baoquan He <bhe@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Joel Granados <joel.granados@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCHv2 2/2] kernel/kexec: Stop all userspace deadline tasks
Message-ID: <aQF1ZZfjLBXuRl-s@fedora>
References: <20251028030914.9520-1-piliu@redhat.com>
 <20251028030914.9520-3-piliu@redhat.com>
 <20251028163911.98990cbf1516d1c6d221f92b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028163911.98990cbf1516d1c6d221f92b@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_190124_075078_2AA03574 
X-CRM114-Status: GOOD (  24.66  )
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

On Tue, Oct 28, 2025 at 04:39:11PM -0700, Andrew Morton wrote:
> On Tue, 28 Oct 2025 11:09:14 +0800 Pingfan Liu <piliu@redhat.com> wrote:
> 
> > Now that the deadline bandwidth check has been skipped, there is nothing
> > to prevent CPUs from being unplugged. But as deadline tasks are crowded
> > onto the remaining CPUs, they may starve normal tasks, especially the
> > hotplug kthreads. As a result, the kexec process will hang indefinitely.
> > 
> > Send SIGSTOP to all userspace deadline tasks at the beginning of kexec
> > to allow other tasks to run as CPUs are unplugged.
> 
> This all looks a bit hacky.
> 
> What's special about kexec?  If many CPUs are being unplugged via other
> means, won't the kernel still hit the very problems which are being
> addressed here for kexec?  If so, we should seek a general fix for these

No, they are in different situations. For normal CPU hot-removal, the
deadline bandwidth validation will prevent the CPU hot-removal if the
bandwidth requirements are not met. But in the kexec case, there is no
way to roll back, so it must try its best to proceed. That is why the
previous patch is introduced.

> issues rather than a kexec-specific one?
> 
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -1132,6 +1132,18 @@ bool kexec_load_permitted(int kexec_image_type)
> >  	return true;
> >  }
> >  
> > +static void stop_user_deadline_tasks(void)
> > +{
> > +	struct task_struct *task;
> > +
> > +	rcu_read_lock();
> > +	for_each_process(task) {
> > +		if (task->policy == SCHED_DEADLINE && task->mm)
> > +			send_sig(SIGSTOP, task, 1);
> > +	}
> > +	rcu_read_unlock();
> > +}
> 
> If we can safely stop all SCHED_DEADLINE user tasks then presumably we
> can safely stop all user tasks.  Why not do that?
> 

I think it can be done that way.  Normal user tasks cannot block the CPU
hotplug kthread. Once the other CPUs are offlined, kexec can jump to the
new kernel immediately. However, DL tasks may starve the hotplug kthread
and kexec task, which is why I take this cautious approach.


Thanks,

Pingfan


