Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FD7C32774
	for <kexec@archiver.kernel.org>; Fri, 19 Aug 2022 09:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qpL/3QGI/btnf2UaXCw3GyVXJUNq+KBLtuAY83xGsCA=; b=FPnds9yKQ3RoXb
	xan0U7F6KbS5vJAJTv6AjpL0+r7c/duQyr6cvsN/lcoPT20XSzpgVOfTl/p4LzKbCmNWo7G19or4E
	reWkOkhO07hcdxGA+SNqQp9ZQpvHA5bJ4P26PWv3veZn02sMJOagcBiRDA3uexRr/6ZyYGcKyMwIC
	ryeYNtL3drj5VD823O2QEXCLMukk0As907xYp9NGDkYvkL4+kg/vfRLv9aUjveXQnOfEZUrr5KaEL
	MIx/smyNJGYzEqorsICHnBE3o9Ls+uvhP9BjaYmHehZOzpdxbmgwj29sTsO/Gf45A6j+O5V9XjIgq
	pyJHSWBDMXh6kj9N/AKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOyWr-0058fw-GS; Fri, 19 Aug 2022 09:43:01 +0000
Received: from mail.skyhub.de ([5.9.137.197])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOROB-007XXT-BY
	for kexec@lists.infradead.org; Wed, 17 Aug 2022 22:19:52 +0000
Received: from zn.tnic (p200300ea971b98b0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98b0:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 745D01EC0543;
	Thu, 18 Aug 2022 00:19:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1660774780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=hXb/5tHp6HfhVeqcHs2KXoyJYfDFjl5eR7Mi1mvaxpU=;
	b=aCGSvwvvljvCEaJnuieMUHmxokJbGwx1N2ecJckwLwjciaf8K/4oeits3GagzeiKhsQ1kg
	TqLzx1UbXr7TUqE7uarhxcZ32keEEkXz1XhLT9CXjcbJRiIozt74+WdVTikd9cxazV91O3
	8w4SuDgO8+X3R6DL4CVML0pT4aaXuEk=
Date: Thu, 18 Aug 2022 00:19:36 +0200
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
Message-ID: <Yv1peAdCdn+Qi3xI@zn.tnic>
References: <Yv0mCY04heUXsGiC@zn.tnic>
 <46137c67-25b4-6657-33b7-cffdc7afc0d7@igalia.com>
 <Yv1C0Y25u2IB7PCs@zn.tnic>
 <7f016d7f-a546-a45d-c65c-bc35269b4faa@igalia.com>
 <Yv1XVRmTXHLhOkER@zn.tnic>
 <c0250075-ec87-189f-52c5-e0520325a015@igalia.com>
 <Yv1hn2ayPoyKBAj8@zn.tnic>
 <1ee275b3-97e8-4c2b-be88-d50898d17e23@igalia.com>
 <Yv1lGpisQVFpUOGP@zn.tnic>
 <2f21b91c-4fb0-42f8-0820-a6036405cb29@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2f21b91c-4fb0-42f8-0820-a6036405cb29@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220817_151951_581734_11002D37 
X-CRM114-Status: UNSURE (   7.43  )
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

On Wed, Aug 17, 2022 at 07:09:26PM -0300, Guilherme G. Piccoli wrote:
> Again - a matter of a trade-off, a good compromise must be agreed by all
> parties (kdump maintainers are usually extremely afraid of taking risks
> to not break kdump).

Right, and logging hw errors from a panic notifier feels simply weird.

x86 has its own, special notifier exactly for that and it is independent
from the panic path but it gets run right after the exception raised due
to the hw error is done.

Dunno if ARM has such facilities tho...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
