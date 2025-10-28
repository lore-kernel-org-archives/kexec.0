Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F6CCCF9E5
	for <kexec@archiver.kernel.org>; Tue, 28 Oct 2025 02:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6bHyVAfRhdtoMkPIMCM0f6+n/GpxOic0/cT5m6U1ju4=; b=JSbUyofH4FGJ4IHrzXaOyaEPH3
	M4TvYnkjTNJGvijNiZ3llJmdmS1b0w1ARxwq+khj3HSZ4xNECF5iMk1DsgrZ5fmk+igLoorNGj1wK
	btZ4of+sUZbj8cu9+L33KareACd6NWOol/MYSD5jgMZXj0DdbFi6OnijrCXvx38XCMBiUlxwKGys1
	QF0tBUIR7/wmnLiHaqjwEC7e9s0pMiowX0GG4FrrH6OST8bYXdFM53L9IdMrRCqL0+gmNhuf7xn1E
	mqg8/KDN/CNE+o8FBdFkmiMGJDNzCGitQKuhLZbpczJE4EDUrFqjGFNmIalVNxHmm+jTJh8DYDzlh
	Er/WbLPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDZo3-0000000F8Ob-3ug6;
	Tue, 28 Oct 2025 02:51:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDZo0-0000000F8O9-1eol
	for kexec@lists.infradead.org;
	Tue, 28 Oct 2025 02:51:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761619884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6bHyVAfRhdtoMkPIMCM0f6+n/GpxOic0/cT5m6U1ju4=;
	b=GY8uqeElvsxpBXJsP3BBKimzUAs6NoFn0tSSH8suBcUwjRfJKWtAWRIVlSp4jLy/QJUt/q
	eLQtvwLNj1yiN2B+OerCgVM4GhUHVek+yKNOU2m2dqm2EUVsh28Noh6wQTILYmNRfids3q
	ihVrBKKxSyLKdEI+ALVTTAZcu9IkrV0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-sEyS3Qa7N72ZSQg-1oyOLg-1; Mon,
 27 Oct 2025 22:51:19 -0400
X-MC-Unique: sEyS3Qa7N72ZSQg-1oyOLg-1
X-Mimecast-MFC-AGG-ID: sEyS3Qa7N72ZSQg-1oyOLg_1761619878
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0910B180035A;
	Tue, 28 Oct 2025 02:51:17 +0000 (UTC)
Received: from localhost (unknown [10.72.112.84])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 94F2D30001A2;
	Tue, 28 Oct 2025 02:51:13 +0000 (UTC)
Date: Tue, 28 Oct 2025 10:51:10 +0800
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
Message-ID: <aQAvnjVvJOUx78Nk@fedora>
References: <20251022121345.23496-1-piliu@redhat.com>
 <20251022121345.23496-3-piliu@redhat.com>
 <877bwgw9yf.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877bwgw9yf.ffs@tglx>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_195128_517193_B076DDC3 
X-CRM114-Status: GOOD (  20.03  )
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

On Mon, Oct 27, 2025 at 06:06:32PM +0100, Thomas Gleixner wrote:
> On Wed, Oct 22 2025 at 20:13, Pingfan Liu wrote:
> > The previous patch lifted the deadline bandwidth check during the kexec
> 
> Once this is applied 'The previous patch' is meaningless.
> 

I will rephrase it.
> > process, which raises a potential issue: as the number of online CPUs
> > decreases, DL tasks may be crowded onto a few CPUs, which may starve the
> > CPU hotplug kthread. As a result, the hot-removal cannot proceed in
> > practice.  On the other hand, as CPUs are offlined one by one, all tasks
> > will eventually be migrated to the kexec CPU.
> >
> > Therefore, this patch marks all other CPUs as inactive to signal the
> 
> git grep "This patch" Documentation/process/
> 

I will rephrase it.
> > scheduler to migrate tasks to the kexec CPU during hot-removal.
> 
> I'm not seeing what this solves. It just changes the timing of moving
> tasks off to the boot CPU where they compete for the CPU for nothing.
> 
> When kexec() is in progress, then running user space tasks at all is a
> completely pointless exercise.
> 
> So the obvious solution to the problem is to freeze all user space tasks

I agree, but what about a less intrusive approach? Simply stopping the 
DL tasks should suffice, as everything works correctly without them.

I have a draft patch ready. Let's discuss it and go from there.

> when kexec() is invoked. No horrible hacks in the deadline scheduler and
> elsewhere required to make that work. No?
> 

To clarify, skipping the dl_bw_deactivate() validation is necessary 
because it prevents CPU hot-removal.


Thanks,

Pingfan


