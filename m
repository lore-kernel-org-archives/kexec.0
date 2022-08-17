Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCA8C32773
	for <kexec@archiver.kernel.org>; Fri, 19 Aug 2022 09:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a/lGY1zm5yVmeZP2jgozlzZlStF2tpamH+kWqzu/awY=; b=koXVhefc/ODl9q
	KgI/2Fd5bah9mYK0/gZXRX6K8jFX048HPfA02T4ERCON23Kd8R0VBKlZkfjhgLg13plFloLYzDQjS
	qGcAOtD4LuSKojz0rk4HM32rZCN4ro7aNL6EdvCyBAJun9LcyZD26E1nwSZEI5qSAclqkYtRk9dDm
	FCDuwm5HK+fTEOqUk+A/hsUpTdp7/UdKsmWWhUFeLl/hcccVWMkuN6RSSWgbNJB/5ISgkrK4YQPuy
	J9oTYdCvzgvRlSBIhoPLg8o4t1KQ4CxocrnRiiiU3u1154nlX09ge4hU22D5x/3qN8ziX4oypoS9w
	YjWD/UomXZycE7ni+4Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOyWk-0058ZH-KB; Fri, 19 Aug 2022 09:42:54 +0000
Received: from mail.skyhub.de ([5.9.137.197])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOQrh-007Aje-1Q
	for kexec@lists.infradead.org; Wed, 17 Aug 2022 21:46:18 +0000
Received: from zn.tnic (p200300ea971b98b0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98b0:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E56E1EC058B;
	Wed, 17 Aug 2022 23:46:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1660772771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=t2fxF578BtmxUg3x9OTOyiD8pEVJYcWl0c4xff75WMw=;
	b=byLAhfAupeoCRhGwdiBwltXwycmk2gglMeDJEyPXcAFAsOEG7lmhxD53xgKvgwt1y3marN
	JrFD35s9cj8KbZbzZN08JqQIJDT8ZkYjZI0xmrwP+D4bntN/E2LHya8pVEi5sVO1L1FE2s
	9M58lEddvYzGD2l0SFRY2wwbHYjeYFY=
Date: Wed, 17 Aug 2022 23:46:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: pmladek@suse.com, Dinh Nguyen <dinguyen@kernel.org>,
	Tony Luck <tony.luck@intel.com>, akpm@linux-foundation.org,
	bhe@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, x86@kernel.org, kernel-dev@igalia.com,
	kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com,
	alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com,
	arnd@arndb.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com,
	dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com,
	gregkh@linuxfoundation.org, mikelley@microsoft.com,
	hidehiro.kawai.ez@hitachi.com, jgross@suse.com,
	john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org,
	mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org,
	peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
	stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com,
	vkuznets@redhat.com, will@kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH v2 10/13] EDAC/altera: Skip the panic notifier if kdump
 is loaded
Message-ID: <Yv1hn2ayPoyKBAj8@zn.tnic>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-11-gpiccoli@igalia.com>
 <Yv0mCY04heUXsGiC@zn.tnic>
 <46137c67-25b4-6657-33b7-cffdc7afc0d7@igalia.com>
 <Yv1C0Y25u2IB7PCs@zn.tnic>
 <7f016d7f-a546-a45d-c65c-bc35269b4faa@igalia.com>
 <Yv1XVRmTXHLhOkER@zn.tnic>
 <c0250075-ec87-189f-52c5-e0520325a015@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c0250075-ec87-189f-52c5-e0520325a015@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220817_144617_291505_BB21EDDA 
X-CRM114-Status: UNSURE (   7.89  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Fri, 19 Aug 2022 02:42:41 -0700
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

On Wed, Aug 17, 2022 at 06:39:07PM -0300, Guilherme G. Piccoli wrote:
> Sorry for the confusion, let me try to be a bit more clear:

I think you're missing the point. Lemme try again:

You *absolutely* must log those errors because they're important. It
doesn't matter if this is done in a panic notifier and you're changing
that whole shebang or through some other magic.

If you do, then this driver needs to *still* *log* those fatal errors -
regardless through a panic notifier or some novel contraption it wants
to use.

So if you want to change the panic notifiers, you *must* make sure those
errors still do get logged.

Better?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
