Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD38D606A325
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 07:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yTnABqYw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=onWjqs9i
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pC6bu7iSXyV8W9whBUiuoNGv5YhTizVhbT+HSAZuHzc=; b=yTnABqYwHgWk5tZuIAGz6XbuZT
	hK4IMbpCmqiqZUGHy4dRoysqXTv4eLck1dMNfpOrMcHg+XlDxOhwAVCVyvLt02LPmpVpCnSv8rtLb
	HCEhsVMq2AOr8Tb1JOQi4Asp3uoxAk9A4zQY153SaM5+evhsdjeYu9bloV53r1diFEBAXgaOE3K8q
	u40PWmCCliS/QiYVF9WCBhBK9rDngebQLWyY1/q+MnGtNMzOq4IOg2anz7wQHbdhMO+moKgy+0fLe
	SKmCx8B1kflGCCbSLaDwy104+wbBNXY7UxVqMgusbKK86PHiLVIQxjG6yzRObSl/E0ILknt7GBeja
	G3EEJwCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTZgE-00000007xdz-21mR;
	Wed, 18 Nov 2026 07:02:06 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTZgD-00000007xdA-2dRq
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 07:02:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B445561CCE;
	Wed, 18 Nov 2026 07:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249391F000C4;
	Wed, 18 Nov 2026 07:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794985323;
	bh=pC6bu7iSXyV8W9whBUiuoNGv5YhTizVhbT+HSAZuHzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=onWjqs9iJE3AO0poYc6hGpoTohnUGtCzhLcUFlojn8PVCZr2vg99c3Fj1fhmP1+FJ
	 vzPtPTP+a8et5gVCC13vLaRdyEkNvtMZn+VzWjtGGssl9YrrjxakWM3ZkCqRfGoDOj
	 He5c8nVj9LUwgAn9BJRQMe7t+28pI3PpaTgwiJYs=
Date: Tue, 17 Nov 2026 23:02:01 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <baoquan.he@linux.dev>
Subject: Re: [PATCH v4 3/4] x86/vmware: Add the vmware_record_panic_msg
 sysctl
Message-Id: <20261117230201.921ec5bddf49cd459ddb8428@linux-foundation.org>
In-Reply-To: <av1IuMZ2W0SXWcNn@MiWiFi-R3L-srv>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
	<4c5de34b10f579368b890eaa9333a2755886bad3.1794980455.git.zack.rusin@broadcom.com>
	<sashiko-outbox-220212@kernel.org>
	<av1IuMZ2W0SXWcNn@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Young <ruirui.yang@linux.dev>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Zack Rusin <zack.rusin@broadcom.com>, Jonathan Corbet <corbet@lwn.net>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, sashiko@lists.linux.dev, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Eugenio Perez <eperezma@redhat.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Thomas Gleixner <tglx@kernel.org>, Petr Mladek <pmladek@suse.com>, Bradley Morgan <brads@mainlining.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, sashiko-reviews@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, Ian Forbes <ian.forbes@broadcom.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, "Michael S. Tsirkin" <mst@redhat.com>, Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 14:42:00 +0800 Baoquan He <baoquan.he@linux.dev> wrote:

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

(+sashiko@lists.linux.dev)

Yes please.

These emails do have a little bit of value: they tell you that Sashiko
was able to apply the patch and to review it.  I guess.  Or something.


Me:

:0 D:
* ^From:[ 	]*sashiko-bot@kernel\.org[ 	]*$
* B ?? ^Sashiko has reviewed this patch and found no issues\.$
/home/akpm/.nsmail-zip/Trash

hp2:/home/akpm> grep "From:.*sashiko-bot" .nsmail-zip/Trash | wc -l
1140
hp2:/home/akpm> 


