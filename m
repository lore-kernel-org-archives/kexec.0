Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCA3C636BD
	for <kexec@archiver.kernel.org>; Fri, 24 Nov 2023 16:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UlDyH8QrskUpjsplcZMMiiNRBtSp3Abj9P1qvSG03Co=; b=dwhEg/K1yHOikR
	JWkeZax0erKDM6H3lQMCRS9mT925JTI1SHGMpqrmXloAAYLUFOSeXbiVDoR89sokDh9IPl6TkLpD1
	bX3mQlVL/D1dYdI/xAUhiNpXfd5QUGm60Nb/WP/cdH8/AuwWBZIc+DAFH49xBg/IDmdNgwnvGgkTb
	8cnUbAJ7FFR1vP/SObBIvso6QT3+nhxxXnbnpLmMas509MGV6RJCs9qriA4LaHg1W180UKCR6/rgj
	WbsxBcfpZP6HXW4I2x42sfNWoIlH/d6DGuwCbx+vOSkMDuPthXFtW9xW3hqJGuwX7QAe2Q0pjRGfq
	NhWa33VS6q040tPc1RqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6ZIT-007iZs-0T;
	Fri, 24 Nov 2023 16:44:53 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r6ZIQ-007iYE-1r;
	Fri, 24 Nov 2023 16:44:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A19F6CE2A69;
	Fri, 24 Nov 2023 16:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D05C433C8;
	Fri, 24 Nov 2023 16:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1700844282;
	bh=Jv88ICKZ110o1np2p9LtMmd50STofDmEsKMRuaqgi7I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qWC7AvJVPIlEnviCx7I6e7oQ953NxvnapmOeKmMXPK+XNf7weDESmBFKIX9Fm6kz9
	 zQtGkUM7zWgxA2VZl4OoLv7T4usgzbJKsX+t+H85rmkSQi61+FBx+orVD4b9CR6d1i
	 AL7IgDp6N89DKQ10Q+OvjgoKPhNwwSCrvTjKpHIU=
Date: Fri, 24 Nov 2023 08:44:41 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: Ignat Korchagin <ignat@cloudflare.com>, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-s390@vger.kernel.org, eric_devolder@yahoo.com, kernel-team
 <kernel-team@cloudflare.com>
Subject: Re: [PATCH 2/3] drivers/base/cpu: crash data showing should depends
 on KEXEC_CORE
Message-Id: <20231124084441.b913fc404fec53d5d0946c55@linux-foundation.org>
In-Reply-To: <ZV80X+lf2iOOTboW@MiWiFi-R3L-srv>
References: <20231123073652.507034-1-bhe@redhat.com>
	<20231123073652.507034-3-bhe@redhat.com>
	<CALrw=nFzy2zq-khLUCXsuf8J5_mka0YPyTosO190OUst2QSjVQ@mail.gmail.com>
	<ZV80X+lf2iOOTboW@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231124_084450_861317_1531BFC4 
X-CRM114-Status: GOOD (  13.36  )
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

On Thu, 23 Nov 2023 19:15:43 +0800 Baoquan He <bhe@redhat.com> wrote:

> > > CONFIG_KEXEC is used to enable kexec_load interface, the
> > > crash_notes/crash_notes_size/crash_hotplug showing depends on
> > > CONFIG_KEXEC is incorrect. It should depend on KEXEC_CORE instead.
> > >
> > > Fix it now.
> > 
> > Can we add Fixes/CC stable, so it gets eventually backported into 6.6?
> 
> Makes sense. Will add it in v2 since I need respin to add the missing
> stuff in patch 1. Thanks.

Please avoid mixing cc:stable patches and this-merge-window fixes in
the same series as next-merge-window material.  Because I'll just have
to separate them out anyway, causing what-I-merged to unnecessarily
differ from what-you-sent.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
