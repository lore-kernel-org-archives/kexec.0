Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4188C32774
	for <kexec@archiver.kernel.org>; Fri, 19 Aug 2022 09:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qCGaSundw0fvOq4Sw0tFjaiUjsjAoBjZlwnEJMF4PYA=; b=yGsvw4YSguB+Gj
	XiYElbaV+Thp6mkIVOiiCzPMBPgi8tSCN8Ql8SsR90bExZ9yG005UrsFP0EmE2GzQTQ4WE4WZrjmu
	V4gTzK/BkMCJ6GyAGGXxjN/BjUa54cvlfHW8T3wxeb2HmnSVlNanfWF5V74QcA+WEIGZfceURQmlV
	3KFlNJy+v1kEbqhBQhAhkUhCKES04YNIYxEt0X6a7mg0kx0M/JVab29tt/STR4sM9K6wuhgY/wAwO
	o7a7T2ytIOHtQw4thqefdswKvxnV+eIUgs6q2+4t+VoMw4gIUvivZJxZ6Do8Gp7J02IEtC6/UWyw4
	Da02UTdZ1zpxpRcTedtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOyWf-0058Mn-2W; Fri, 19 Aug 2022 09:42:49 +0000
Received: from mail.skyhub.de ([5.9.137.197])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOOoX-005mcE-E5
	for kexec@lists.infradead.org; Wed, 17 Aug 2022 19:34:56 +0000
Received: from zn.tnic (p200300ea971b98b0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98b0:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4CFEB1EC0230;
	Wed, 17 Aug 2022 21:34:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1660764882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=1Rh8+/Ir/HWVaSZXutajiwYFkwurpOA/MHY+NMaBjxs=;
	b=Jd1PX9kZRcNSw8+wGtMkcTz1uxwQoiFDMeJcOBbCsfgsS/ppmOJVaFWhACWZBRC8SWFuXf
	dDheftx78DZKMY27r4f2TuqDeOVN1yTvEzhMKxM+xZJ7a3wUIkdjs3yXleorPHPenOphKo
	aWCyAr6mU/8LtCODdObw+jqfRCppjys=
Date: Wed, 17 Aug 2022 21:34:41 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, pmladek@suse.com,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	x86@kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
	halves@canonical.com, fabiomirmar@gmail.com,
	alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com,
	arnd@arndb.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com,
	dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com,
	gregkh@linuxfoundation.org, mikelley@microsoft.com,
	hidehiro.kawai.ez@hitachi.com, jgross@suse.com,
	john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org,
	mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org,
	peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
	stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com,
	vkuznets@redhat.com, will@kernel.org, linux-edac@vger.kernel.org,
	Dinh Nguyen <dinguyen@kernel.org>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v2 10/13] EDAC/altera: Skip the panic notifier if kdump
 is loaded
Message-ID: <Yv1C0Y25u2IB7PCs@zn.tnic>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-11-gpiccoli@igalia.com>
 <Yv0mCY04heUXsGiC@zn.tnic>
 <46137c67-25b4-6657-33b7-cffdc7afc0d7@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46137c67-25b4-6657-33b7-cffdc7afc0d7@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220817_123453_675024_5C312B67 
X-CRM114-Status: GOOD (  12.18  )
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

On Wed, Aug 17, 2022 at 03:45:30PM -0300, Guilherme G. Piccoli wrote:
> But happens that in the refactor we are proposing [0], some notifiers
> should run before the kdump. We are basically putting some ordering in
> the way notifiers are executed, while documenting this properly and with
> the goal of not increasing the failure risk for kdump.

What is "the failure risk for kdump"?

Some of the notifiers which run before kdump might fail and thus prevent
the machine from kdumping?

> This patch is useful so we can bring the altera EDAC notifier to run
> earlier while not increasing the risk on kdump - this operation is a bit
> "delicate" to happen in the panic scenario. The origin of this patch was
> a discussion with Tony/Peter [1], guess we can call it a "compromise
> solution".

My question stands: if kdump is loaded and the s10_edac_dberr_handler()
does not read the the fatal errors and they don't get shown in dmesg
before the machine panics, how do you intend to show that information to
the user?

Because fatal errors are something you absolutely wanna show, at least,
in dmesg!

I don't think you can "read" the errors from vmcore - they need to be
read from the hw registers before the machine dies.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
