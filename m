Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B13C433EF
	for <kexec@archiver.kernel.org>; Wed, 22 Jun 2022 05:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uKXcyRgOZHxRhNVmUYFJSqu83qnU/NWX/Bz3UAkPrYs=; b=tPxjgcI96qakBw
	q1c6NuF0N8QovwFK5nt6O2j2ioko+DQTJHoIWRvHQHXkcvLB7LemYCWWRyZif8RBR/VRkbcsXrc5K
	3QY5vKbQN/8psyXKF7dL0Vz2I9aHUUmZlDHzm+X5q3RaV/20T0xAwhy8lRDKaE0x5H77Xs/8z0U+S
	okNPj5EusceMBc7p56fKCt9We9XHO6Hi/6pb7s84EIbjgZ9b8NPqzPOTwq5F66rLQIUP/v1j4Fuee
	WjCFi40n2ddrm9xf42+sRIcEudfEKrthOPLG4WCoV3UQBKCG6hDS8ba0T88eyzqNeINNvfC0dkNPi
	AY2Gg0nr80eFrJDmKOWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3tDc-008eFH-M5; Wed, 22 Jun 2022 05:48:00 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1UAe-00EyxK-Da; Wed, 15 Jun 2022 14:39:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=75kgVCcqOPOLeu4JBiLLFab/dM4uNZ1dcLuvpDx9ZCg=; b=QKJkD59ykV7yiOyz/dtWW2y9vx
	hndlFBRcaZsnBnrqZoup91OkoTyawJySwoVhlpL7dLf1AhSC2FT/c1b4wWjKQQz3Ts/zk9OO98kFv
	+FC9l5GCJhBfrKE6kZA+D8NGU0EPzmXivPQuJSxTabgMFPBoq60T1jrKka72ogzWgFlDhGdSM9nPh
	kdjC7+L/1mmMVS/0lHPYAqTJBRL/pruzfhR3AXDHwTQN0WJWsKaG8l/fi8PkDOVPumbtXx3qSg2rS
	NUVNxFl3FBtUihYMEXUFbZYAP0aeGi7k0B0/nMXwVUG0DmoNEeofCrPrumTBifLWluIAqDy0snXDE
	ptf+tVOQ==;
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1UAa-0017cW-IG; Wed, 15 Jun 2022 14:38:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=75kgVCcqOPOLeu4JBiLLFab/dM4uNZ1dcLuvpDx9ZCg=; b=kAIWl67VuUe8cBDkmFOZTh4b+J
	Uy6PgE2+CwIEzhFEfsXCTAadcMkk5TefuTIBHvgzxNrjmUz+/r/f3fMBR5i8mMC7UweLMh9MkeJoD
	97gkOJRUGibA77qDy9s4vL7NkQkS1Sv+TX4WpruLFHmbGvImVgE9LeYadgdIraA8AGxMlB+PxaWy/
	1adKvJuvvpCbTsZosCqi5SMDlMupfKEgEY7JpKMS8HhvbF7gyowCTheRqW0YX0S9D05qpW9G1fKLt
	DJUWQ6k8Tz/HxaHb6kuJRSWnDBXrsJA/DQco3hh/lFSm8XLWvSeNFNfH2bKr+ugXM0hH/Gw2zl2s+
	laFslj7w==;
Received: from 179.red-81-39-194.dynamicip.rima-tde.net ([81.39.194.179] helo=[192.168.15.167])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1o1U8m-002LYs-SW; Wed, 15 Jun 2022 16:37:04 +0200
Message-ID: <362f6520-8209-1721-823c-11928338f57d@igalia.com>
Date: Wed, 15 Jun 2022 11:36:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 24/30] panic: Refactor the panic path
Content-Language: en-US
To: Petr Mladek <pmladek@suse.com>
Cc: bhe@redhat.com, d.hatayama@jp.fujitsu.com,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Mark Rutland <mark.rutland@arm.com>, mikelley@microsoft.com,
 vkuznets@redhat.com, akpm@linux-foundation.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
 netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 rcu@vger.kernel.org, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, x86@kernel.org, kernel-dev@igalia.com,
 kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com,
 alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com,
 arnd@arndb.de, bp@alien8.de, corbet@lwn.net, dave.hansen@linux.intel.com,
 dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org,
 hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de,
 keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org,
 mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org,
 rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu,
 tglx@linutronix.de, vgoyal@redhat.com, will@kernel.org
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-25-gpiccoli@igalia.com>
 <87fskzuh11.fsf@email.froward.int.ebiederm.org>
 <0d084eed-4781-c815-29c7-ac62c498e216@igalia.com> <Yqic0R8/UFqTbbMD@alley>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <Yqic0R8/UFqTbbMD@alley>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_153856_647908_86CE0600 
X-CRM114-Status: UNSURE (   5.50  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Tue, 21 Jun 2022 22:47:55 -0700
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

Perfect Petr, thanks for your feedback!

I'll be out for some weeks, but after that what I'm doing is to split
the series in 2 parts:

(a) The general fixes, which should be reviewed by subsystem maintainers
and even merged individually by them.

(b) The proper panic refactor, which includes the notifiers list split,
etc. I'll think about what I consider the best solution for the
crash_dump required ones, and will try to split in very simple patches
to make it easier to review.

Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
