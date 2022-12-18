Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6935C4332F
	for <kexec@archiver.kernel.org>; Sun, 18 Dec 2022 00:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s7Wgc0VzQW4/iEFcXaB3Bh1/8Ua+gZ9OLp/PImAH96o=; b=PC1UWBluDDkBRy
	5d8Jev/Rx/AhiEGRRWV7MZupJI39SH3VHA6mhB4ePpdIbOfldkjJ5woPMhQtPdRtsoVQakFs/Ptqj
	nwMshH+xL9wer6/3Sw/vC1JjtDAU49qivscb0jQ8ki2adoErMSBAd6M79nh03pFZmM9lVQpyItdCO
	8Ii4qXyxyoUAdJm+t40/+4UqIGuWba9PnFcugNkbPrL+bfzk2xGkFwTtbECnnJ42+mHYtd2GIvd/2
	ETg8QSgQmpmvRMPjayWCKxABG0Cd7bTVrlUmhS76yC/gd2vhfOfKdH/MBsMQ+atgpuhLrEOz4duyc
	E7MPT2qtcNHbm30cjIig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6hbY-00E5Sj-5T; Sun, 18 Dec 2022 00:32:36 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6hbV-00E5RR-Lh
	for kexec@lists.infradead.org; Sun, 18 Dec 2022 00:32:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id D6F22B80066;
	Sun, 18 Dec 2022 00:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA59CC433D2;
	Sun, 18 Dec 2022 00:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1671323549;
	bh=9avVX4rWz+0DFaSot1tqCO7Hml3sUh4OLO3CAj/xkIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X2imIY7DDEIdZC0adiZPHv6q3BfQboikn8a6nfwMJkpn8pPjOjfwVuDwm53UtmzEB
	 hDeGIH7dn4tKZPkDWLkMWwUJXsvfdzZRnVO7JUBS37WzEfH2RLjymeBHHU2xNK/P5n
	 taZqDw2atwi2lPJ5B7vr1XabtAH1BkboTKSLn60M=
Date: Sat, 17 Dec 2022 16:32:28 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jianglei Nie
 <niejianglei2021@163.com>, Baoquan He <bhe@redhat.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Chen Lifu <chenlifu@huawei.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>, Li Chen
 <lchen@ambarella.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul
 Mackerras <paulus@samba.org>, Petr Mladek <pmladek@suse.com>, Russell King
 <linux@armlinux.org.uk>, ye xingchen <ye.xingchen@zte.com.cn>, Zeal Robot
 <zealci@zte.com.cn>, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH AUTOSEL 6.1 13/22] proc/vmcore: fix potential memory
 leak in vmcore_init()
Message-Id: <20221217163228.9308c293458ceb680a6ffed8@linux-foundation.org>
In-Reply-To: <20221217152727.98061-13-sashal@kernel.org>
References: <20221217152727.98061-1-sashal@kernel.org>
	<20221217152727.98061-13-sashal@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221217_163233_894908_E87C22D0 
X-CRM114-Status: GOOD (  15.47  )
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

On Sat, 17 Dec 2022 10:27:14 -0500 Sasha Levin <sashal@kernel.org> wrote:

> From: Jianglei Nie <niejianglei2021@163.com>
> 
> [ Upstream commit 12b9d301ff73122aebd78548fa4c04ca69ed78fe ]
> 
> Patch series "Some minor cleanup patches resent".
> 
> The first three patches trivial clean up patches.
>
> And for the patch "kexec: replace crash_mem_range with range", I got a
> ibm-p9wr ppc64le system to test, it works well.
> 
> This patch (of 4):
> 
> elfcorehdr_alloc() allocates a memory chunk for elfcorehdr_addr with
> kzalloc().  If is_vmcore_usable() returns false, elfcorehdr_addr is a
> predefined value.  If parse_crash_elf_headers() gets some error and
> returns a negetive value, the elfcorehdr_addr should be released with
> elfcorehdr_free().

This is exceedingly minor - a single memory leak per boot, under very
rare circumstances.


With every patch I merge I consider -stable.  Often I'll discuss the
desirability of a backport with the author and with reviewers.  Every
single patch.  And then some damn script comes along and overrides that
quite careful decision.  argh.

Can we please do something like

	if (akpm && !cc:stable)
		dont_backport()

And even go further - if your script thinks it might be something we
should backport and if it didn't have cc:stable then contact the
author, reviewers and committers and ask them to reconsider before we
go and backport it.  This approach will have the advantage of training
people to consider the backport more consistently.


I'd (still) like to have a new patch tag like Not-For-Stable: or
cc:not-stable or something to tell your scripts "yes, we thought about
it and we decided no".

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
