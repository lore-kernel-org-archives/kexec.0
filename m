Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC52C64ED6
	for <kexec@archiver.kernel.org>; Sun, 26 Feb 2023 05:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ND8K0rOK3w+32jtKDzNt6CCEI+7JiAv3nyldErH2fDk=; b=nfDgW5Yszq/jhj
	iF5lUVlYIj9aJDkvCBWdSJZDCs5dUMLDqOhqdmgxvYsbkukN7veffm1CORqXlCvlhUQcys8BD1Mxc
	+rxevRyTXPdrQeV2/LCqAMCPtVSgVwuq8RBYiVrU4I2CmAI0uoum2YkoA2w22+8tOmITav2n6k11I
	m+q/K8WKpCZIbpe/7oL+lEhev1ADxlf26hNo6h23MYqivv3zwhZZTdJi8hvhEk4Uspj86NzZtlBPp
	uR5RUiLl0U5FYHUseGH/OoV/A8BbskV+nSaRba2BzLeRkUJ0p6fCf90atALsyBcbheRxxKS5O8AY7
	vmDBqMft1mFbWqUt/DYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pW9qJ-006qva-Th; Sun, 26 Feb 2023 05:45:03 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pW9qC-006qv6-VV
	for kexec@lists.infradead.org; Sun, 26 Feb 2023 05:44:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2719460BCA;
	Sun, 26 Feb 2023 05:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F039C433EF;
	Sun, 26 Feb 2023 05:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1677390295;
	bh=tdqNtzVVQiNAGo+d23F6Rjsew/mx9y+fMs7cnvra67Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bUJc72SJrw994D6SiFP/QwiH3zQiYfy1kslI+lGU7nvqzpKabCVnBbw9BA24jKb5o
	 hpOl8KPp5GQVHbH5DWOWbG4VFm3uSaIlaRtbOnK3efzwU+nOjqzy7RNLXUb9o26qj4
	 /wKMLNhcNv3WK7Rn4ylq7oawj9mzKoW6XZgeHMIU=
Date: Sat, 25 Feb 2023 21:44:54 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: bhe@redhat.com, pmladek@suse.com, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, dyoung@redhat.com, d.hatayama@jp.fujitsu.com,
 feng.tang@intel.com, hidehiro.kawai.ez@hitachi.com, keescook@chromium.org,
 mikelley@microsoft.com, vgoyal@redhat.com, kernel-dev@igalia.com,
 kernel@gpiccoli.net, stable@vger.kernel.org
Subject: Re: [PATCH v4] panic: Fixes the panic_print NMI backtrace setting
Message-Id: <20230225214454.5eb25ff8a937a99d357c44ad@linux-foundation.org>
In-Reply-To: <20230210203510.1734835-1-gpiccoli@igalia.com>
References: <20230210203510.1734835-1-gpiccoli@igalia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230225_214457_087391_9F47392D 
X-CRM114-Status: GOOD (  21.91  )
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

On Fri, 10 Feb 2023 17:35:10 -0300 "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:

> Commit 8d470a45d1a6 ("panic: add option to dump all CPUs backtraces in panic_print")
> introduced a setting for the "panic_print" kernel parameter to allow
> users to request a NMI backtrace on panic. Problem is that the panic_print
> handling happens after the secondary CPUs are already disabled, hence
> this option ended-up being kind of a no-op - kernel skips the NMI trace
> in idling CPUs, which is the case of offline CPUs.
> 
> Fix it by checking the NMI backtrace bit in the panic_print prior to
> the CPU disabling function.
> 
> ...
> 
> Notice that while at it, I got rid of the "crash_kexec_post_notifiers"
> local copy in panic(). This was introduced by commit b26e27ddfd2a
> ("kexec: use core_param for crash_kexec_post_notifiers boot option"),
> but it is not clear from comments or commit message why this local copy
> is required.
> 
> My understanding is that it's a mechanism to prevent some concurrency,
> in case some other CPU modify this variable while panic() is running.
> I find it very unlikely, hence I removed it - but if people consider
> this copy needed, I can respin this patch and keep it, even providing a
> comment about that, in order to be explict about its need.

Only two sites change crash_kexec_post_notifiers, in
arch/powerpc/kernel/fadump.c and drivers/hv/hv_common.c.  Yes, it's
very unlikely that this will be altered while panic() is running and
the consequences will be slight anyway.

But formally, we shouldn't do this, especially in a -stable
backportable patch.  So please, let's have the minimal bugfix for now
and we can look at removing that local at a later time?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
