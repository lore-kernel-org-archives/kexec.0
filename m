Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914BBC7618B
	for <kexec@archiver.kernel.org>; Tue, 14 Mar 2023 21:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S1lPOj/mR4yHvS6I3hoRnVRgUBZNB1vz8VnuBUUdkl8=; b=yn57mWDoQ3p/xp
	vob9InWJ8bIjyzAaW2fmQBr53XR4wDBohkDHwXRPJIPfrjdXYsfeDBK1T2+02gp1kZ7VVkJcTdL1X
	Hcz54A5PTLmoKzo1X1PaQR9EvuSAjW80aMDEIRMvwwXVNTphF5+j42BSGkR3LkAO+PEdAVB4tgdLQ
	GLmcMpqf2l5XUOvopG+8S/84plVfjsDk7qkopQF306AzA/VCROLBErJ3Rn/O1Yv6jREohEVbqwbLz
	uZzfakaIohwyHgW2mN+cX73bZYNhBzZPqZ3Iv67Bm4fRA7uet0rzOgUFO9krEIQBuu0KAml7ZS5Jr
	5pta9FSutmA1PEkk5ePw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcC2l-00BZG0-2q;
	Tue, 14 Mar 2023 21:18:51 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcC2j-00BZFA-0q
	for kexec@lists.infradead.org;
	Tue, 14 Mar 2023 21:18:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7CCF4619BF;
	Tue, 14 Mar 2023 21:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E532C433D2;
	Tue, 14 Mar 2023 21:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1678828727;
	bh=LxklN4FdggZ4PulSDJ3lafIgCXNs3zWjIbGe+ZmUX2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bxCOYrQLt9cdqJKXZ507AIB54dVw5gYB33dtxIViCwY8tL8sYmLVP4WBNsAEvDOl3
	 xeOk9cCKBufrcCTZiOtdJTPOsWbJwbkNJz4/GNpDNCST8j+u7z/Mia5K04+0uIFmcN
	 7fmKq+sP4ry5soN2nJ1ThSoGBHqKWfwkkozeNzRQ=
Date: Tue, 14 Mar 2023 14:18:46 -0700
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
Message-Id: <20230314141846.d801ae3dafb6fd2faa7206ac@linux-foundation.org>
In-Reply-To: <2d1ad49c-d38e-ef06-8737-766ab0566251@igalia.com>
References: <20230314200058.1326909-1-gpiccoli@igalia.com>
	<20230314135015.789369cd9f71b39a5b7eb291@linux-foundation.org>
	<2d1ad49c-d38e-ef06-8737-766ab0566251@igalia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230314_141849_353399_20DFCF08 
X-CRM114-Status: GOOD (  14.44  )
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

On Tue, 14 Mar 2023 18:08:37 -0300 "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:

> On 14/03/2023 17:50, Andrew Morton wrote:
> > On Tue, 14 Mar 2023 17:00:58 -0300 "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:
> > 
> >>  include/trace/events/notifiers.h | 69 ++++++++++++++++++++++++++++++++
> >>  kernel/notifier.c                |  6 +++
> > 
> > Perhaps the filenames should match, which means "notifier.h".
> 
> Hi Andrew, thanks!
> 
> Do you want me to re-submit? I see some emails of the patch getting
> added to "mm-nonmm-unstable" (and also a checkpatch fixes you added on
> top of that). Lemme know how should I proceed.

I changed it, thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
