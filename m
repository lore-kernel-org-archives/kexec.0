Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5596CC00140
	for <kexec@archiver.kernel.org>; Mon, 15 Aug 2022 17:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T/6aIiK+V4dZZo5lfX5FdqOoBRs63mGjZNwRdKU/Ozg=; b=TpS6et3DtEGKvL
	S+bMqXrxCAy+hQuIAtIXzdtNdLHnZwXb2Atl4JgmuCyxyE9TGtUR0FWN3MQJ3a7hdp7TUeMfQmmXb
	woKUJhpca12dgyHTj3Q23qCR1taHCcVjRbZyORyytQta4IPXt2EeVOLCA5X3AmuP0HqQw2WhxmzHK
	PkMwwx5vuSBhsZXCMl+hRjbg3CBpk6/x0LhaNgzGu//qfbJ+HCmgeOP2QDuDilnR2iBJkCtde8t3z
	RUJeYLHt0zlQrxMCIvrG5+HSpn5MGu8HW7ct0wEMY13AVV7tzYGzxzBR0cAjTaAbUJqoGjYiUYKpk
	CcMeCCibo5unIuxCpapw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNdhW-0028t6-1F; Mon, 15 Aug 2022 17:16:30 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKiOU-00FN83-2x; Sun, 07 Aug 2022 15:40:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EeHU4GZXVj90knDikrlAT10biCMpyNXIYZ492gpol+s=; b=jTZwpdmqF3XqT8+jXcqJ6GDFfR
	PxnNT9XP3iA6r1cpYT4naEjxoD1tQX74wR8OAHAzp4CWvIkUUkXUzYyPpkKOsRZgMPMZuj+5p9GP5
	Uw+94dj89kf/Asj9KY/mmNEWmmuztrKLfjkVD+LCYmsivYiVInFYT5MGBGMuBVpvYugBCTdchUYEQ
	ImktElUtqotBACvuRTFHL+/dDdRHwC/8jiRfWah9yozq3liIWlUuEtoQZJ/VY7HdyfEnnTxbzO83/
	LCdttDLGKkVuGz+YQ5BtaCwEcn0V66rebK0UlFyTqj14kGGsiwbRWjWNC8o/7n2KQbG/yLybOl0Fs
	uxYlg8sw==;
Received: from [187.56.70.103] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oKiOP-0011og-UI; Sun, 07 Aug 2022 17:40:42 +0200
Message-ID: <5bbc4296-4858-d01c-0c76-09d942377ddf@igalia.com>
Date: Sun, 7 Aug 2022 12:40:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 06/13] um: Improve panic notifiers consistency and
 ordering
Content-Language: en-US
To: kexec@lists.infradead.org, linux-um@lists.infradead.org,
 Johannes Berg <johannes@sipsolutions.net>
Cc: pmladek@suse.com, bhe@redhat.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, x86@kernel.org, kernel-dev@igalia.com,
 kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com,
 alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com,
 arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com,
 dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com,
 gregkh@linuxfoundation.org, mikelley@microsoft.com,
 hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de,
 keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org,
 mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org,
 rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu,
 tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Richard Weinberger <richard@nod.at>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-7-gpiccoli@igalia.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220719195325.402745-7-gpiccoli@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220807_084046_200789_4690BDD3 
X-CRM114-Status: GOOD (  11.04  )
X-Mailman-Approved-At: Mon, 15 Aug 2022 10:10:48 -0700
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

On 19/07/2022 16:53, Guilherme G. Piccoli wrote:
> Currently the panic notifiers from user mode linux don't follow
> the convention for most of the other notifiers present in the
> kernel (indentation, priority setting, numeric return).
> More important, the priorities could be improved, since it's a
> special case (userspace), hence we could run the notifiers earlier;
> user mode linux shouldn't care much with other panic notifiers but
> the ordering among the mconsole and arch notifier is important,
> given that the arch one effectively triggers a core dump.
> 
> Fix that by running the mconsole notifier as the first panic
> notifier, followed by the architecture one (that coredumps).
> 
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Richard Weinberger <richard@nod.at>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> V2:
> - Kept the notifier header to avoid implicit usage - thanks
> Johannes for the suggestion!
> 
>  arch/um/drivers/mconsole_kern.c | 7 +++----
>  arch/um/kernel/um_arch.c        | 8 ++++----
>  2 files changed, 7 insertions(+), 8 deletions(-)
> [...]

Hi Johannes, do you feel this one is good now, after your last review?
Thanks in advance,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
