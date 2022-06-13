Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EA4C433EF
	for <kexec@archiver.kernel.org>; Mon, 13 Jun 2022 22:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=koM+EiqKZw97rHcqWPnyL1f3bxwG6Ja98KNZNL1VIQY=; b=FJzvL/3w57WXNz
	VyXdO8hCKTo5O07laX4ql+0Zl422zC8s1Rta/6HDLtJqrZfrjjyusoJBU+/mjn1aNYkLJ3SaOC1w4
	Ow9lGmRGudxSYJW816oGvI6O/svkpQPpYfB5B8sBwXfH4VS9znGeGP1t3A+hzuOJvpbHW9gUeHiBn
	GrCdmq8UrOYigQ2P1w9/CzS8rPhpzUdnFyRIe/WpyPcKWdCbsZ+oA+zUBtSi9lE32LCfOZCBpOJpp
	SvpUdXaNIOoAvP4K28IHu5IwSnBTzPeNX+IYgFVlwHBQxLIEY4SP/27A/tC+EoDS7qoorkVmLAU3O
	clRIydfKOgXDMbtg6oJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0sKK-0064Oe-Ke; Mon, 13 Jun 2022 22:14:28 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0sKH-0064Ne-Og
	for kexec@lists.infradead.org; Mon, 13 Jun 2022 22:14:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 307FD614BF;
	Mon, 13 Jun 2022 22:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C7CC34114;
	Mon, 13 Jun 2022 22:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1655158463;
	bh=eD273+X+BzkXpDaLR2HObkBXeSp56Ex7Sjo+sd7QsqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qeHwFwq8QhV6jatQoViVN070e1CQc33l8WBYFHHVDnoEmiPdN59AyOi+Fbjb0+ACj
	 fvwMLeAP0DaeW2CUVwXG3gK8tX9SEUH3uRQcJOQIXbP+WLsoXw0H7WIIILt1q/aNY6
	 UJBjIUmr9+vvW8dePY20LfTuRKDqaYCsp6fAQrLY=
Date: Mon, 13 Jun 2022 15:14:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, Nick Desaulniers <ndesaulniers@google.com>, Dave
 Young <dyoung@redhat.com>, Kees Cook <keescook@chromium.org>, Jiri Olsa
 <jolsa@kernel.org>, Stephen Boyd <swboyd@chromium.org>, Bixuan Cui
 <cuibixuan@huawei.com>, David Vernet <void@manifault.com>, Vivek Goyal
 <vgoyal@redhat.com>, Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH 0/2] Expose kallsyms data in vmcoreinfo note
Message-Id: <20220613151422.e2173f14909b9149fec8e0a6@linux-foundation.org>
In-Reply-To: <87edzsrzqn.fsf@oracle.com>
References: <20220517000508.777145-1-stephen.s.brennan@oracle.com>
	<20220613142609.3e4be0f2f45671341450232d@linux-foundation.org>
	<87edzsrzqn.fsf@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_151425_886735_D4DE7753 
X-CRM114-Status: GOOD (  15.99  )
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

On Mon, 13 Jun 2022 14:59:44 -0700 Stephen Brennan <stephen.s.brennan@oracle.com> wrote:

> >> Related discussion around the BTF side of this:
> >> https://lore.kernel.org/bpf/586a6288-704a-f7a7-b256-e18a675927df@oracle.com/T/#u
> >> 
> >> Some work-in-progress branches using this feature:
> >> https://github.com/brenns10/dwarves/tree/remove_percpu_restriction_1
> >> https://github.com/brenns10/drgn/tree/kallsyms_plus_btf
> >
> > What's the story on using gdb with this?
> 
> There is no story with GDB as of yet. I was already familiar with the
> code of drgn when I started down this path, so that's what I used. Drgn
> happens to have a very extensible type system which made it quite simple
> to do. I'd love to see support for doing this with GDB, and might look
> into the feasibility of it, but it's not on my roadmap right now.

Naive question - could some standalone tool take this kallsyms-based
info, combine it with a core image and create a minimally-dwarfified
file which any debugger can munch on?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
