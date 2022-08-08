Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753F6C00140
	for <kexec@archiver.kernel.org>; Mon, 15 Aug 2022 17:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tx1ULiWbSbAeb83CJ4V3F2YpnDKP1fMlg7PM7vR8Q/M=; b=w7C17FYAbyTJpx
	EGRi5xgNgbFGqn7d9c7UVIr+8JokmltYO1NQhZu6RMR15TWIbQkJYYv9qaAr9IoL1U7IrW1QSYR5x
	aqBFA60V389mr3DtqT9JyqmWetXan8KarYBW88lA/KxOS0HxWJSDfB59vjCwkljG11IBbRo4+anuy
	y9bN1w8zwYh+KgYlwqT3XOIfGT26T6cVCzTTGznr3ZTbpq81BzEMRXzmCBe9fs+g/Rd8ZulOtkKL+
	uzuR93kqO13vKmrLcqqpLbD/qfMwbZCakaPlAHRxyHxbSe2t7V2O7TLniZTngK83eruEeSTrin3ZG
	hy7JUj7EQJBObaf5ir8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNdiZ-0029eI-Ou; Mon, 15 Aug 2022 17:17:35 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oL4eV-00Egdl-Ll
	for kexec@lists.infradead.org; Mon, 08 Aug 2022 15:26:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DC07560FF6;
	Mon,  8 Aug 2022 15:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E23C433D6;
	Mon,  8 Aug 2022 15:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1659972406;
	bh=QVa4BfBV7lo527XdkUKxpdBKV3SSO4B9ggVsxDseAa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DB4SmNrxCqdztrrLn4+ufvycDeBeLRrfL0+xLwT4ASz/nm5dHRteRaEbBRNIa3kQM
	 4dj1wxE+Ic9ZqgyLgZEGS72UCULcniMnRaVa+vMdUqQOz1O42TqhrCzEEDiokhgFQb
	 +ktK7QnRL5Kci/32aGkLmp+ApYcrBtlehxhq98u8=
Date: Mon, 8 Aug 2022 17:26:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Evan Green <evgreen@chromium.org>, linux-efi@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, bhe@redhat.com,
	Petr Mladek <pmladek@suse.com>, kexec@lists.infradead.org,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	x86@kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
	halves@canonical.com, fabiomirmar@gmail.com,
	alejandro.j.jimenez@oracle.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Jonathan Corbet <corbet@lwn.net>, d.hatayama@jp.fujitsu.com,
	dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com,
	mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com,
	jgross@suse.com, john.ogness@linutronix.de,
	Kees Cook <keescook@chromium.org>, luto@kernel.org,
	mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org,
	peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Thomas Gleixner <tglx@linutronix.de>, vgoyal@redhat.com,
	vkuznets@redhat.com, Will Deacon <will@kernel.org>,
	David Gow <davidgow@google.com>,
	Julius Werner <jwerner@chromium.org>
Subject: Re: [PATCH v2 03/13] firmware: google: Test spinlock on panic path
 to avoid lockups
Message-ID: <YvErMyM8FNjeDeiW@kroah.com>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-4-gpiccoli@igalia.com>
 <CAE=gft71vH+P3iAFXC0bLu0M2x2V4uJGWc82Xa+246ECuUdT-w@mail.gmail.com>
 <019ae735-3d69-cb4e-c003-b83cc8cd76f8@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <019ae735-3d69-cb4e-c003-b83cc8cd76f8@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220808_082647_808403_4E00240F 
X-CRM114-Status: GOOD (  24.18  )
X-Mailman-Approved-At: Mon, 15 Aug 2022 10:10:47 -0700
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

On Mon, Aug 08, 2022 at 12:14:30PM -0300, Guilherme G. Piccoli wrote:
> On 08/08/2022 02:07, Evan Green wrote:
> > On Tue, Jul 19, 2022 at 12:55 PM Guilherme G. Piccoli
> > <gpiccoli@igalia.com> wrote:
> >>
> >> Currently the gsmi driver registers a panic notifier as well as
> >> reboot and die notifiers. The callbacks registered are called in
> >> atomic and very limited context - for instance, panic disables
> >> preemption and local IRQs, also all secondary CPUs (not executing
> >> the panic path) are shutdown.
> >>
> >> With that said, taking a spinlock in this scenario is a dangerous
> >> invitation for lockup scenarios. So, fix that by checking if the
> >> spinlock is free to acquire in the panic notifier callback - if not,
> >> bail-out and avoid a potential hang.
> >>
> >> Fixes: 74c5b31c6618 ("driver: Google EFI SMI")
> >> Cc: Ard Biesheuvel <ardb@kernel.org>
> >> Cc: David Gow <davidgow@google.com>
> >> Cc: Evan Green <evgreen@chromium.org>
> >> Cc: Julius Werner <jwerner@chromium.org>
> >> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> > 
> > Reviewed-by: Evan Green <evgreen@chromium.org>
> 
> Thanks a bunch Evan!
> 
> Ard / Greg, do you think you could get this patch through your -next (or
> -fixes) trees? Not sure which tree is the most common for picking GSMI
> stuff.

Picking out an individual patch from a series with as many responses and
threads like this one is quite difficult.

Just resend this as a stand-alone patch if you want it applied
stand-alone as our tools want to apply a whole patch series at once.

> I'm trying to get these fixes merged individually in their trees to not
> stall the whole series and increase the burden of re-submitting.

The burden is on the submitter, not the maintainer as we have more
submitters than reviewers/maintainers.

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
