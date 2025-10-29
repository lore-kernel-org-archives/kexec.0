Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D101FCCF9E9
	for <kexec@archiver.kernel.org>; Wed, 29 Oct 2025 11:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JewGrExeY4YUsH2Q4/QPO/3tV8s8JWgMbXOK4V6Kv3s=; b=ShMAX1rk4VWOQBT6CQyqBzHrHX
	KXXEc/d+IHQ3LYu4alKvKuZWwFrDxHcLJUPAiyINTtz87rRSbmAnq0mpgKdZk3MbME2QV50nJO6er
	TLQ+snIS9hnXsE2oJUmFB3cenRb+NOK3OeAO3ik+z6lBQN/OZZfkjn/rnSyrqXhoAVbWYA711mRzD
	SmgvNDDW5mQuvZiVYxQN0lZiid19/dfuRP3XaUwRZ+hY6/h3Zgr2RZvJHH6WTiMyC1wL+28M8y+As
	XFsyGdnfupYQ5qVch/WmOTT2v9HHmYQN0bCk64Xk5LJyAfWIqYWzpzHg7lQlXFyNirUibRqpJqycs
	STEy5d9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE4Tq-0000000113U-2tj6;
	Wed, 29 Oct 2025 11:36:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE4Tl-0000000112r-18zd
	for kexec@lists.infradead.org;
	Wed, 29 Oct 2025 11:36:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761737794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JewGrExeY4YUsH2Q4/QPO/3tV8s8JWgMbXOK4V6Kv3s=;
	b=SFkRDNgzLsdotOoOf2BK3saCnMdbNtwxVy7OPAUKCn/0QZG5UK/lsxwZinN35m96BIAcC8
	sUD8KCaz4xP4vCLuMVHf0IGkMsSVxgSg1IJphnDn6bntdKvUmmOmPPrrqu1Qwefp3Xai2y
	BLeFt1d+U0/70H+MypHdcyMJukUHKvI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-YWvrsIZNM_63qENBF2bUfQ-1; Wed,
 29 Oct 2025 07:36:29 -0400
X-MC-Unique: YWvrsIZNM_63qENBF2bUfQ-1
X-Mimecast-MFC-AGG-ID: YWvrsIZNM_63qENBF2bUfQ_1761737786
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF401180899A;
	Wed, 29 Oct 2025 11:36:24 +0000 (UTC)
Received: from localhost (unknown [10.72.112.80])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 015433000223;
	Wed, 29 Oct 2025 11:36:20 +0000 (UTC)
Date: Wed, 29 Oct 2025 19:36:08 +0800
From: Pingfan Liu <piliu@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Joel Granados <joel.granados@kernel.org>
Subject: Re: [RFC 2/3] kernel/cpu: Mark nonboot cpus as inactive when
 shutting down nonboot cpus
Message-ID: <aQH8KJ8RsnzbLfN2@fedora>
References: <20251022121345.23496-1-piliu@redhat.com>
 <20251022121345.23496-3-piliu@redhat.com>
 <877bwgw9yf.ffs@tglx>
 <aQAvnjVvJOUx78Nk@fedora>
 <87qzunuqqo.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzunuqqo.ffs@tglx>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_043637_381330_220CD627 
X-CRM114-Status: GOOD (  20.72  )
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

On Tue, Oct 28, 2025 at 01:59:11PM +0100, Thomas Gleixner wrote:
> On Tue, Oct 28 2025 at 10:51, Pingfan Liu wrote:
> > On Mon, Oct 27, 2025 at 06:06:32PM +0100, Thomas Gleixner wrote:
> >> When kexec() is in progress, then running user space tasks at all is a
> >> completely pointless exercise.
> >> 
> >> So the obvious solution to the problem is to freeze all user space tasks
> >
> > I agree, but what about a less intrusive approach? Simply stopping the 
> > DL tasks should suffice, as everything works correctly without them.
> 
> What's intrusive about that? Task freezing exists already.
> 

Thanks for your guidance. That's a good point -- system suspending is a
good analogy. I will check how PM handles it.

> > I have a draft patch ready. Let's discuss it and go from there.
> >
> >> when kexec() is invoked. No horrible hacks in the deadline scheduler and
> >> elsewhere required to make that work. No?
> >
> > To clarify, skipping the dl_bw_deactivate() validation is necessary 
> > because it prevents CPU hot-removal.
> 
> If you freeze stuff there is nothing to do. Hibernation works exactly
> that way without any magic hacks in a particular scheduling class, no?
> 

There is a nuance: DL bandwidth represents a commitment, not necessarily
the actual payload. Even a blocked DL task still occupies DL bandwidth.
The system's DL bandwidth remains unchanged as long as the CPUs stay
online, which is the case in hibernation.


Best Regards,

Pingfan


