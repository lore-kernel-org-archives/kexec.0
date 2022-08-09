Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A6DC00140
	for <kexec@archiver.kernel.org>; Mon, 15 Aug 2022 17:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KFgZHargncG+TtNwuzhVx6sUunvCO0owEmopXcOxyUQ=; b=UdRnzLfIO+kfpq
	AZdwy+ynHtAL/9PMrD33K53qvKphkV5fgPGhO6235l6p/H5amnvCbfmIy8HnsvLc8gkuJpz3mQXkn
	yu131A9shqHRM0yzBq6cnumP/3jufQu45LKKllTVRKHoFvLUiCJnmZlxU6LD3LXfqoSB5RHO0U1kB
	KhpkKl6VrTcU9KXS0D4vXJVo4JEuUNjU0qPvKrY8bd3VQZXHHv2455JQ28p2jLo/sYssFhj6FAgnf
	U7QX6d5Djjqh/GU9VbtIK0nDMI/7lOS684/zXeWXrXVQWcFGZTe3ChkKVO51mHHobQcOfkJzvWbPo
	NpTUhEvMfeXSvvMGXXMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNdjK-002A4u-Ub; Mon, 15 Aug 2022 17:18:23 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLTfY-005S5c-O4; Tue, 09 Aug 2022 18:09:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DWkpz8+ByW7L5elLg9cMcWybBCw50VP7bckI/LSep/o=;
	t=1660068572; x=1661278172; b=MXngL74E/uomktifpfXHh+zvL5MDrntMT0wSR3PoSybMo0m
	+SD8wpT2k8XcUdVdfBlExMc9Hhey974e9MaQY6NQYXW5n5anWWFPnQXy8q3APdKKThGm4MUTjSL8/
	Vtx/OM/t76JQBd0QWGN/rsYLoNH8+s70BUToIfRqeUj9sGl7BcB2k5AkYMocmLJJWLeQ7xeRBJcEj
	KnieIUe2Y2CHL4pO167Yl60SLmu6eOSKv/NQ33m8ypnSla3ubduPoOIlboBl5LAH8H/xsgVJ7PBPE
	NPZ8qTn9Hx3TJM4JDAEvN/HT0e9oTw/nKnhYGew2JopiOHgjZ4R4COkj2D7n5myA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1oLTfR-003HXy-0m;
	Tue, 09 Aug 2022 20:09:25 +0200
Message-ID: <54cd8c11428db4c419edf2267db00ca10da7a178.camel@sipsolutions.net>
Subject: Re: [PATCH v2 06/13] um: Improve panic notifiers consistency and
 ordering
From: Johannes Berg <johannes@sipsolutions.net>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, kexec@lists.infradead.org,
  linux-um@lists.infradead.org
Cc: pmladek@suse.com, bhe@redhat.com, akpm@linux-foundation.org, 
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 netdev@vger.kernel.org, x86@kernel.org, kernel-dev@igalia.com,
 kernel@gpiccoli.net,  halves@canonical.com, fabiomirmar@gmail.com,
 alejandro.j.jimenez@oracle.com,  andriy.shevchenko@linux.intel.com,
 arnd@arndb.de, bp@alien8.de, corbet@lwn.net,  d.hatayama@jp.fujitsu.com,
 dave.hansen@linux.intel.com, dyoung@redhat.com,  feng.tang@intel.com,
 gregkh@linuxfoundation.org, mikelley@microsoft.com, 
 hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, 
 keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org,
 mingo@redhat.com,  paulmck@kernel.org, peterz@infradead.org,
 rostedt@goodmis.org,  senozhatsky@chromium.org, stern@rowland.harvard.edu,
 tglx@linutronix.de,  vgoyal@redhat.com, vkuznets@redhat.com,
 will@kernel.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Richard
 Weinberger <richard@nod.at>
Date: Tue, 09 Aug 2022 20:09:23 +0200
In-Reply-To: <5bbc4296-4858-d01c-0c76-09d942377ddf@igalia.com>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
	 <20220719195325.402745-7-gpiccoli@igalia.com>
	 <5bbc4296-4858-d01c-0c76-09d942377ddf@igalia.com>
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220809_110932_813432_B66ADA0D 
X-CRM114-Status: GOOD (  14.86  )
X-Mailman-Approved-At: Mon, 15 Aug 2022 10:10:49 -0700
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Sun, 2022-08-07 at 12:40 -0300, Guilherme G. Piccoli wrote:
> On 19/07/2022 16:53, Guilherme G. Piccoli wrote:
> > Currently the panic notifiers from user mode linux don't follow
> > the convention for most of the other notifiers present in the
> > kernel (indentation, priority setting, numeric return).
> > More important, the priorities could be improved, since it's a
> > special case (userspace), hence we could run the notifiers earlier;
> > user mode linux shouldn't care much with other panic notifiers but
> > the ordering among the mconsole and arch notifier is important,
> > given that the arch one effectively triggers a core dump.
> > 
> > Fix that by running the mconsole notifier as the first panic
> > notifier, followed by the architecture one (that coredumps).
> > 
> > Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> > Cc: Johannes Berg <johannes@sipsolutions.net>
> > Cc: Richard Weinberger <richard@nod.at>
> > Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> > 
> > ---
> > 
> > V2:
> > - Kept the notifier header to avoid implicit usage - thanks
> > Johannes for the suggestion!
> > 
> >  arch/um/drivers/mconsole_kern.c | 7 +++----
> >  arch/um/kernel/um_arch.c        | 8 ++++----
> >  2 files changed, 7 insertions(+), 8 deletions(-)
> > [...]
> 
> Hi Johannes, do you feel this one is good now, after your last review?
> Thanks in advance,
> 

Yeah, no objections, my previous comment was just a minor almost style
issue anyway.

johannes

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
