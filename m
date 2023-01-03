Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F1BC3DA7D
	for <kexec@archiver.kernel.org>; Tue,  3 Jan 2023 09:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QXNvxt+NCBS+lYzcOWLvhT7hKEagoW3RooIbZ/74uXA=; b=AZxaFBEfVZagPJ
	xPADs2OPrntWNxHMx3KPUKZHPW04xLWagGB/5qe2iBpdRTw/XwFkDCZNiYZOsjeClhIpm+DHgshk0
	KRsD+B0fyaAUIpTNxWxzkPg+ZWDQbPxh7MeLz8vrXbG+wekt5QWTiqJKsItsTmyjHBc20OtD4Wgvi
	fPbeoe5fgV2sgVTsOGS5z4ikHATC4nLJZb8k6KF9SAGEQ2YkRduMs/hniBm3JnO4acwwvgChitUwS
	qYCyLKQEfdvlsZMUtPgK9+EtNbFPwFWwFJf1qH+QqgeYdIxKkqJl4dpERmH4sNI50L9RomDaHZ3Zw
	uLfka9VLwUUQzm71vDzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCdts-000Wfs-OZ; Tue, 03 Jan 2023 09:48:04 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCdnq-000VJh-MJ
	for kexec@lists.infradead.org; Tue, 03 Jan 2023 09:41:58 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 176253824A;
	Tue,  3 Jan 2023 09:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1672738902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=INe1fRfDJG3P7PcSGiSjhLagJ0XMpmhGUZjZv1725PQ=;
	b=DyhqLbWcmkJ8E4l+8lrj+YTGgJHJxZ+gwmkvvc7cJqIc481jWHw6QFzlER7icrSxINhysN
	WGF+kmr/GGDDMCBofEIbnTIdii8KNbAN4EgH39qeb22mI1Px3/Gl5FqQbvrYLdt9/NENk0
	gxkaPnS1zbKplJ3LZMFimW73X75tWM0=
Received: from suse.cz (unknown [10.100.201.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 9DA752C141;
	Tue,  3 Jan 2023 09:41:41 +0000 (UTC)
Date: Tue, 3 Jan 2023 10:41:39 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] docs: gdbmacros: print newest record
Message-ID: <Y7P4UwjRQG8Tov1D@alley>
References: <20221229134339.197627-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221229134339.197627-1-john.ogness@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_014151_495691_9EE1F194 
X-CRM114-Status: GOOD (  10.97  )
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

On Thu 2022-12-29 14:49:39, John Ogness wrote:
> @head_id points to the newest record, but the printing loop
> exits when it increments to this value (before printing).
> 
> Exit the printing loop after the newest record has been printed.
> 
> The python-based function in scripts/gdb/linux/dmesg.py already
> does this correctly.
> 
> Fixes: e60768311af8 ("scripts/gdb: update for lockless printk ringbuffer")
> Cc: stable@vger.kernel.org
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Great catch!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
