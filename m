Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38476C32773
	for <kexec@archiver.kernel.org>; Fri, 19 Aug 2022 09:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lhvTG9xoaOXH1VfF4rX+mP0ZtzGmz2Cd16Ve/UGrtBg=; b=mu6ashkxEVyGCa
	0icR8J6i5jGCqE+D0TIqAf+9In0OEK8cpIjJNZ+zS6rOWuPTzwnXi8Qseb7lCBYzj9xda2gQJeXao
	n+ncENsSf6hkYsjz58Cuv6VKgbEUSWMX7U51qPFjMnoaHnBDld406iVGZWrSutl2czsyuMePneBLB
	xsyvCP19RbQOP47JXX0A5NcwG3jzIwcBOTS6Qp+NhuV3eLn9OxcuTCX0yUjJZoM3O3R4g6TEnQyu3
	VQ2UIbz8vIXhL8BNpanpn0XnXmFoavlX+8TOrjeIT8B/QzWDPq/hxnYr8iJfaadZ6LeQOq5z+eKgm
	yUgQdszyf3oUU1W8McrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOyWb-0058Bo-NJ; Fri, 19 Aug 2022 09:42:45 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOMtj-004Pij-Uk
	for kexec@lists.infradead.org; Wed, 17 Aug 2022 17:32:09 +0000
Received: from zn.tnic (p200300ea971b98b0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98b0:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2A7411EC04E4;
	Wed, 17 Aug 2022 19:31:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1660757517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=dUKj+X8ljKS3x0J7PLstLS2kOGr7pWVjrGVNsA+POsw=;
	b=OCrRjecizgJkhIrUuxZqNNRqYD/0fFaYs2TDejeDXW/mmrrYLWtuimSo/AnlefpOtU+AMj
	bsL7N758/zQeINPpMpOiI/ASS6nWSKedONPjIH0T9YfOo5o9ytEmycBmsrGT973RrHO3j/
	FA4Bt5FgbzcF1qKWUonHjI/9nn6LXBk=
Date: Wed, 17 Aug 2022 19:31:53 +0200
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
Message-ID: <Yv0mCY04heUXsGiC@zn.tnic>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-11-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220719195325.402745-11-gpiccoli@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220817_103208_174447_47478F82 
X-CRM114-Status: UNSURE (   9.76  )
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

On Tue, Jul 19, 2022 at 04:53:23PM -0300, Guilherme G. Piccoli wrote:
> The altera_edac panic notifier performs some data collection with
> regards errors detected; such code relies in the regmap layer to
> perform reads/writes, so the code is abstracted and there is some
> risk level to execute that, since the panic path runs in atomic
> context, with interrupts/preemption and secondary CPUs disabled.
> 
> Users want the information collected in this panic notifier though,
> so in order to balance the risk/benefit, let's skip the altera panic
> notifier if kdump is loaded. While at it, remove a useless header
> and encompass a macro inside the sole ifdef block it is used.

How does the fact that kdump is loaded, obviate the need to print
information about the errors?

Are you suggesting that people who have the whole vmcore would be able
to piece together the error information?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
