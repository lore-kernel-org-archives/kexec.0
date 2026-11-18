Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC38606A320
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=A+ACSlKe;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=iGfSqlI4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5Uv1kv8Fyhvm9H5I85dSa/PbCA5mggh9KfNOAnb9QWM=; b=A+ACSlKeAzYAKP6L9s2jz+TczS
	WHnlH9jPM1Qod1h9OZw+wysloO2jKLIywTeV0QxAxpyyng22dCyEDlYUGmswS85al3zk0+J20vu+/
	Hb6OnRmN6aI3xRyWMadO7AHIfyJLsn/Eor9mbQkKgi52IqdU7OPCVOaxrt60zyMOfshb4aw8kDZvG
	WXU+Lo/0UEKU8e/IytjO34hf5oOL8yDAZgtu0/NwA7BNLWVNgZMdsmzMGSm/Q13HXTfA42i3oVaxN
	esCoS0viqNxz7BQYlfzyEwpHxTEXyDpnVxwU3RiZSntyd8A2es4KU3cKcqZazjG5rTRSQtOlX583J
	ag9fnAUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTgmX-000000097vB-446J;
	Wed, 18 Nov 2026 14:37:05 +0000
Received: from smtprelay0013.hostedemail.com ([216.40.44.13] helo=relay.hostedemail.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTgmT-000000097ub-2wT2
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 14:37:04 +0000
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 88883120785;
	Wed, 18 Nov 2026 14:36:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 472A92000E;
	Wed, 18 Nov 2026 14:36:46 +0000 (UTC)
Date: Wed, 18 Nov 2026 09:36:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Baoquan He <baoquan.he@linux.dev>
Subject: Re: [PATCH v4 3/4] x86/vmware: Add the vmware_record_panic_msg
 sysctl
Message-ID: <20261118093644.10644df9@gandalf.local.home>
In-Reply-To: <av1IuMZ2W0SXWcNn@MiWiFi-R3L-srv>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
	<4c5de34b10f579368b890eaa9333a2755886bad3.1794980455.git.zack.rusin@broadcom.com>
	<sashiko-outbox-220212@kernel.org>
	<av1IuMZ2W0SXWcNn@MiWiFi-R3L-srv>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 472A92000E
X-Rspamd-Server: rspamout08
X-Stat-Signature: nsnhqchs79u4e17w4yf3cscerw5q6qjw
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=4.0.1
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19ZBBweeRonAcIW3Sj8e1zyecfJ8umsG9A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=5Uv1kv8Fyhvm9H5I85dSa/PbCA5mggh9KfNOAnb9QWM=; b=iGfSqlI4S5Jo9GiY8tlcxhyjxCE0unaS0t24fuxlAGdpNjHwyDHZj+ARmOszbO/EKCO1t2Ugca5wEWxdj+vnHq9p0zClr1EqkpIXcw0AKRzDFnMXQXE7hjS1KzJqqCKlsrgb3ii+t4Nx6MEhcyOUhiDAegNBAC6zR6uHfwR5QaI=
X-HE-Tag: 1795012606-378161
X-HE-Meta: U2FsdGVkX19ahj7+sR8308Zi2QXrJe1XafgKhfctr/grJYjwlB9Y8ZEh/wCDLdA3ilqVbgcd9/psAC2D02fnr5NUfybeZ8dc2HRYcO/cre8NmsHiAH7z4QB2+ChzEVX6QXqA8HfV1e1a0kC83FEElkujKiAX8EP0rmw1Qg87CIqmP4+nRaJOlE0C+GcOa6xa0zLDxZ+bzRw3rN2idlYOeuy5fAv88aSpKGahWNzLysA5buZCVrgVlj9rFtLgQarpJXo29VVm+Jp7Aruj752oLohZgu25tt6ki2pKen4lvDNRGDC+kc25u30CI0RfQ0Cbkale1qu0klm6mwdUMDphGbgdaUT81kCrCO0IFbQ5G+k0R5R+Lmk0oA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_063702_075111_4D56CE14 
X-CRM114-Status: GOOD (  17.61  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Young <ruirui.yang@linux.dev>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Zack Rusin <zack.rusin@broadcom.com>, Jonathan Corbet <corbet@lwn.net>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Eugenio Perez <eperezma@redhat.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Thomas Gleixner <tglx@kernel.org>, Petr Mladek <pmladek@suse.com>, Bradley Morgan <brads@mainlining.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, sashiko-reviews@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, Ian Forbes <ian.forbes@broadcom.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Pratyush Yadav <pratyush@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 14:42:00 +0800
Baoquan He <baoquan.he@linux.dev> wrote:

> On 11/18/26 at 06:14am, sashiko-bot@kernel.org wrote:
> > > Allow administrators to disable host log transfer on ordinary guests or
> > > opt in on encrypted guests. Expose the boolean recording policy through
> > > kernel.vmware_record_panic_msg using proc_dobool(), as Joel suggested.
> > > Zero disables recording, nonzero integers enable it, and reads return
> > > 0 or 1.
> > > 
> > > Register the sysctl only after the logger is ready. A registration failure
> > > leaves the internal default in force. Document that the log is sent
> > > before kdump, and that disable_panic_notifiers_platform_list also skips
> > > it.
> > > 
> > > Link: https://lore.kernel.org/r/4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw7f3zjbz7c@srfabx6lsusj
> > > Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>  
> > 
> > Sashiko has reviewed this patch and found no issues.  
> 
> It might be better to turn off this message if not issues found, just
> like what LKP bot has been doing.

I believe that's an option per mailing list. I personally like it because
to me it does add value. It tells me it was able to apply it and it didn't
find anything wrong with it. This way I know sashiko didn't ignore it.

But I understand others may not find that useful.

-- Steve

