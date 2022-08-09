Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18C5C00140
	for <kexec@archiver.kernel.org>; Mon, 15 Aug 2022 17:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nMGffmijuRt2WNOiwdzouicU/lwRg1tvaHQgm7Puhi4=; b=EhiWlym9uIjoBu
	9hkUiyBd+QKX2SFLOUKBYCBltJXGOTnMhjtA5JnqD++svhDjTQyIsZammKqHmxA/Cjko3wgWO5puU
	XZTb5zy7CODJ8OoiTJqxYWL08dvL+a21MANq/dYWTX7ezqS7mwFzgeWUjSTAUGC9sqbb8yYrv980x
	CpxvqZM6vimXXeqRPBBIbT+njSAimY0ZbsTG1fgjRLAv3J4Xd2DbKnmW8Ap1prFuCaoZKwYEtreaB
	A/oBiY3RsRsu6NBYLbZIbWzOYi60D7hBcLa3jG3ns95mki6tvqXTKZbkECZWB0e4vBemt2O6Bg5w1
	7Yv3cBmpbAOdRDU1XKaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNdjt-002APU-DR; Mon, 15 Aug 2022 17:18:57 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLUan-005jxc-C4; Tue, 09 Aug 2022 19:08:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CE9ribd82Wfwyf4qIpdyVQVcb49dja2n3iMdmx/FOf8=;
	t=1660072118; x=1661281718; b=tRt7E/d4RqydLchB9sDSKYvw6sTLn6U38CKetrCIj6Qsr1v
	8XGwiYnMJVO3ZcoZSAJ1QhBRQAqX7z/AfZIHJRyh0LBYRlyZUhhRgZYovkRUv+ZItxu4DAlNIYkDO
	ZB+PYYsPJDYIsscNrU6bIZ6hr3GhQi/iHcsTjZhypEHsCRerv+iFvXj2G7da3zGx9P/9ZhGqEKi3K
	jlTBh7byz0S8PIpgqEC/lvd55/qpY21Wk48c+vkQR8rUjCP1bfnXEvRD9ON5r0X2qYLjR2I/pnxgN
	tUWx+dCA5YDOFLaDtlaNSTPhfDEIfWlPVBji5L3y8nu1EJ0dPFWfEXJm+j5fdi3Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1oLUac-003Ii0-22;
	Tue, 09 Aug 2022 21:08:30 +0200
Message-ID: <f366b3d50aa8b713b0a921e4507bae4779a7cd02.camel@sipsolutions.net>
Subject: Re: [PATCH v2 06/13] um: Improve panic notifiers consistency and
 ordering
From: Johannes Berg <johannes@sipsolutions.net>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, kexec@lists.infradead.org,
  linux-um@lists.infradead.org
Cc: pmladek@suse.com, bhe@redhat.com, akpm@linux-foundation.org, 
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 netdev@vger.kernel.org, x86@kernel.org, kernel-dev@igalia.com,
 kernel@gpiccoli.net,  halves@canonical.com, fabiomirmar@gmail.com,
 alejandro.j.jimenez@oracle.com,  andriy.shevchenko@linux.intel.com,
 arnd@arndb.de, bp@alien8.de, corbet@lwn.net,  d.hatayama@jp.fujitsu.com,
 dave.hansen@linux.intel.com, dyoung@redhat.com,  feng.tang@intel.com,
 gregkh@linuxfoundation.org, mikelley@microsoft.com, 
 hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, 
 keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org,
 mingo@redhat.com,  paulmck@kernel.org, peterz@infradead.org,
 rostedt@goodmis.org,  senozhatsky@chromium.org, stern@rowland.harvard.edu,
 tglx@linutronix.de,  vgoyal@redhat.com, vkuznets@redhat.com,
 will@kernel.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Richard
 Weinberger <richard@nod.at>
Date: Tue, 09 Aug 2022 21:08:28 +0200
In-Reply-To: <15188cf2-a510-2725-0c6e-3c4b264714c5@igalia.com>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
	 <20220719195325.402745-7-gpiccoli@igalia.com>
	 <5bbc4296-4858-d01c-0c76-09d942377ddf@igalia.com>
	 <54cd8c11428db4c419edf2267db00ca10da7a178.camel@sipsolutions.net>
	 <15188cf2-a510-2725-0c6e-3c4b264714c5@igalia.com>
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220809_120841_429936_6DF45629 
X-CRM114-Status: GOOD (  16.55  )
X-Mailman-Approved-At: Mon, 15 Aug 2022 10:10:49 -0700
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

On Tue, 2022-08-09 at 16:03 -0300, Guilherme G. Piccoli wrote:
> On 09/08/2022 15:09, Johannes Berg wrote:
> > [...]
> > > > V2:
> > > > - Kept the notifier header to avoid implicit usage - thanks
> > > > Johannes for the suggestion!
> > > > 
> > > >  arch/um/drivers/mconsole_kern.c | 7 +++----
> > > >  arch/um/kernel/um_arch.c        | 8 ++++----
> > > >  2 files changed, 7 insertions(+), 8 deletions(-)
> > > > [...]
> > > 
> > > Hi Johannes, do you feel this one is good now, after your last review?
> > > Thanks in advance,
> > > 
> > 
> > Yeah, no objections, my previous comment was just a minor almost style
> > issue anyway.
> > 
> > johannes
> 
> Perfect, thank you! Let me take the opportunity to ask you something I'm
> asking all the maintainers involved here - do you prefer taking the
> patch through your tree, or to get it landed with the whole series, at
> once, from some maintainer?
> 
Hm. I don't think we'd really care, but so far I was thinking - since
it's a series - it'd go through some appropriate tree all together. If
you think it should be applied separately, let us know.

johannes

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
