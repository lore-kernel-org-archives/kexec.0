Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07920C83F09
	for <kexec@archiver.kernel.org>; Tue,  8 Jul 2025 21:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3L1ef6hd7qzJsbtqnjFn7w5Q93p0hd/zD9modXpIwCg=; b=YasMy5gZO7vOw0YcjDYdhggWrU
	i4sJRpZvBpYoVUjCu4Wac4IjPiby0LSkxurBxrd9aLOOdpx1iuChksQNr/9h+g3TMw1fLrWdEOhbl
	WR5IM1FuVfQ6JkIqT8VD92WNgUiyrSCkSPPLO1+pOC5oLH+gJnSWY2TkFRhK3ceb9ezKi1n1e9ko/
	o7yyn9CWR0TEJpYuc6HSiM7pnGw/gLViDQNW5Mz5aAqRs+Cuz8Zthx3yMsxfuz4+wYbhaC7jMkzqL
	fHn6VHK/O6ZleywNuqEaiNW5saTGVmZZ024zJ18Y7aeuWCSyVtf2r8PCteCjixu6BYPtsGXsRNzNk
	t8NDTq+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZFoV-00000006ejb-2HwW;
	Tue, 08 Jul 2025 21:25:19 +0000
Received: from ded1.1wt.eu ([163.172.96.212] helo=1wt.eu)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZFCs-00000006YJW-0hd0
	for kexec@lists.infradead.org;
	Tue, 08 Jul 2025 20:46:28 +0000
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 568Kk7On005652;
	Tue, 8 Jul 2025 22:46:07 +0200
Date: Tue, 8 Jul 2025 22:46:07 +0200
From: Willy Tarreau <w@1wt.eu>
To: Pavel Machek <pavel@ucw.cz>
Cc: Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, patches@lists.linux.dev,
        stable@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
        Nat Wittstock <nat@fardog.io>, Lucian Langa <lucilanga@7pot.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, rafael@kernel.org,
        len.brown@intel.com, linux-pm@vger.kernel.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
Message-ID: <20250708204607.GA5648@1wt.eu>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org>
 <aG2AcbhWmFwaHT6C@lappy>
 <aG2BjYoCUYUaLGsJ@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG2BjYoCUYUaLGsJ@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_134627_138768_B8E1726F 
X-CRM114-Status: UNSURE (   7.86  )
X-CRM114-Notice: Please train this message.
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

On Tue, Jul 08, 2025 at 10:37:33PM +0200, Pavel Machek wrote:
> On Tue 2025-07-08 16:32:49, Sasha Levin wrote:
> > I've gone ahead and added you to the list of people who AUTOSEL will
> > skip, so no need to worry about wasting your time here.
> 
> Can you read?
> 
> Your stupid robot is sending junk to the list. And you simply
> blacklist people who complain? Resulting in more junk in autosel?

No, he said autosel will now skip patches from you, not ignore your
complaint. So eventually only those who are fine with autosel's job
will have their patches selected and the other ones not. This will
result in less patches there.

Willy

