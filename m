Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82F8C6FD1F
	for <kexec@archiver.kernel.org>; Tue, 14 Mar 2023 20:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xi+yEnsWz6ebG4O8srumGOkslZlBxk5oPpOTlCVVhGo=; b=OWUeWHVCMvZA1p
	p5eDyXmFgJiSmXKhaOD5dR5Hv7Kp4XcVlLNso+lSafpENw/ip4pTgM2iUuM7yGserCQZ1RnwCbn6K
	cii0/eW/49Aw7u/TqVaWG0LqntaC9sMCsjUkTjBTMu6boZUnrj8wrLBYxSH95l+3kpyYG07a+5ggK
	2eLw1m0hlczaeaLb53CV6kUwX70yU1DQwUrctG0OnxLNhCr0m48T8BNEx6StNLCxNSqxusBhG+92p
	oFFH39t6sCPgnZ9p8Lqz3w5mz5IVAjaKksIE8wTPFQ3lhFxkMVlYvAzY6skxbP2l2n8bok9gsBQil
	rzAocMayCqowEcBpaaxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcBbC-00BWrB-0h;
	Tue, 14 Mar 2023 20:50:22 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcBb9-00BWqS-1a
	for kexec@lists.infradead.org;
	Tue, 14 Mar 2023 20:50:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id D0564B81AB7;
	Tue, 14 Mar 2023 20:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08555C433D2;
	Tue, 14 Mar 2023 20:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1678827016;
	bh=JHk46x/emWmmAKUThmzmIVufAq99SXDmf5ZDhxE/9mc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0SIVS/u6wVyRyw6Lwatl8bMnv26kL+zMtvY6e14V6EvXSQk7C0y2qB0gcuxBhphed
	 VPyZNC2dsAGHcvN+a2apHUp9E8LF6PxLD8qwnInNr9tLbSso0NA9EmOf8tdx73NZoe
	 2111uNsRw+jbzo8J2VmIcJ1Pbtp197xVJDm3DFp8=
Date: Tue, 14 Mar 2023 13:50:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, bhe@redhat.com,
 pmladek@suse.com, xiyou.wangcong@gmail.com, dmitry.osipenko@collabora.com,
 rafael.j.wysocki@intel.com, bigeasy@linutronix.de,
 valentin.schneider@arm.com, kernel-dev@igalia.com, kernel@gpiccoli.net,
 Arjan van de Ven <arjan@linux.intel.com>, Michael Kelley
 <mikelley@microsoft.com>, Steven Rostedt <rostedt@goodmis.org>, Xiaoming Ni
 <nixiaoming@huawei.com>
Subject: Re: [PATCH v4] notifiers: Add tracepoints to the notifiers
 infrastructure
Message-Id: <20230314135015.789369cd9f71b39a5b7eb291@linux-foundation.org>
In-Reply-To: <20230314200058.1326909-1-gpiccoli@igalia.com>
References: <20230314200058.1326909-1-gpiccoli@igalia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230314_135019_722914_3B2FB3E1 
X-CRM114-Status: UNSURE (   8.65  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, 14 Mar 2023 17:00:58 -0300 "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:

>  include/trace/events/notifiers.h | 69 ++++++++++++++++++++++++++++++++
>  kernel/notifier.c                |  6 +++

Perhaps the filenames should match, which means "notifier.h".

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
