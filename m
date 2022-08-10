Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AA0C00140
	for <kexec@archiver.kernel.org>; Mon, 15 Aug 2022 17:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2QVtpTBP37BSkjBs3Z+7LN29ChDPDZzORr8lCIMQ1Ww=; b=GCeFXhOXDO+4v/
	LhSCJcZoOERxG6W7F5FRJsgOLjjvYwZNmRPPs1cvd4SW9BzPz594CXULZHGJk6XsMC5cZGI8gxnU0
	l8BA/Xgurbcm/QHSxwRglgQD25GL2TqTmamzxFNX2/hOVj8gxpSG3Z3e55GjK0dvuWvufW8PLYui+
	XgXimc9fe03U/xAcgvtcwgxVqRjP8tNPvi1fEHg1Z3Gqvvp2L4Wr9Y3Mq+PuNFz+7sFUfOI6tBlnm
	1+A5LYBhXDiuUnR0MFy+S42wixhZZCEAmQD+o/bOM2ttnz6A/j6Vgmi9q2j6lA4St2rA+tgCSI4BI
	9RqXGsbssxSE/nY0V8SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNdkV-002Amh-F0; Mon, 15 Aug 2022 17:19:35 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLlEM-00BrwY-3A
	for kexec@lists.infradead.org; Wed, 10 Aug 2022 12:54:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9229261375;
	Wed, 10 Aug 2022 12:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F2DC433D6;
	Wed, 10 Aug 2022 12:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1660136077;
	bh=uPLuF+DDW04LT9gSOZbFu31bMHZHY7AuwxnDEymETPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UNkY0zZ/dvbVjljh7EO1ErSs2YeEMilfLO5c7AcIqM6C1wcyaDC45s2CAW4+v+5bm
	 aSZTtEljP0xweM/nDWXYsXgAGq/7xNaMyvKwesvewAHqmg1qJ58a7fWwmZ2C2n+tlo
	 KD8eRKVStYwt20VObVfv4seCARLA42wybbg5rK9E=
Date: Wed, 10 Aug 2022 14:54:34 +0200
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
Message-ID: <YvOqimNnybaCDDBm@kroah.com>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-4-gpiccoli@igalia.com>
 <CAE=gft71vH+P3iAFXC0bLu0M2x2V4uJGWc82Xa+246ECuUdT-w@mail.gmail.com>
 <019ae735-3d69-cb4e-c003-b83cc8cd76f8@igalia.com>
 <YvErMyM8FNjeDeiW@kroah.com>
 <55a074a0-ca3a-8afc-4336-e40cff757394@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55a074a0-ca3a-8afc-4336-e40cff757394@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_055438_212802_9A85C721 
X-CRM114-Status: GOOD (  13.32  )
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

On Mon, Aug 08, 2022 at 12:37:46PM -0300, Guilherme G. Piccoli wrote:
> Let me clarify / ask something: this series, for example, is composed as
> a bunch of patches "centered" around the same idea, panic notifiers
> improvements/fixes. But its patches belong to completely different
> subsystems, like EFI/misc, architectures (alpha, parisc, arm), core
> kernel code, etc.
> 
> What is the best way of getting this merged?
> (a) Re-send individual patches with the respective Review/ACK tags to
> the proper subsystem, or;

Yes.

> (b) Wait until the whole series is ACKed/Reviewed, and a single
> maintainer (like you or Andrew, for example) would pick the whole series
> and apply at once, even if it spans across multiple parts of the kernel?

No, only do this after a kernel release cycle happens and there are
straggler patches that did not get picked up by the relevant subsystem
maintainers.

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
