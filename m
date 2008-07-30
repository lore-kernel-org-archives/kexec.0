Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KOIZj-0007SJ-7Y
	for kexec@lists.infradead.org; Wed, 30 Jul 2008 20:47:11 +0000
Date: Wed, 30 Jul 2008 22:47:07 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH 2/2] firmware/memmap: Move kobject initialisation before
	kobject_add()
Message-ID: <20080730224707.6b0791b2@kopernikus.site>
In-Reply-To: <20080730134011.24d10dfe.akpm@linux-foundation.org>
References: <1217448752-13859-1-git-send-email-bwalle@suse.de>
	<1217448752-13859-3-git-send-email-bwalle@suse.de>
	<20080730221424.0d997fb0@kopernikus.site>
	<20080730134011.24d10dfe.akpm@linux-foundation.org>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

* Andrew Morton <akpm@linux-foundation.org> [2008-07-30 13:40]:
>
> If you think that "firmware/memmap: Move kobject initialisation before
> kobject_add()" 

Yes, that's what I meant.

> should still be applied then I'd disagree. Adding a
> GFP_KERNEL allocation into kobject_init() was a fairly significant
> backward step.  It's _good_ that kobject_init() can be called this
> early.  Let us strive to retain that robustness.

Ok, since you have more experience with kobject, I'm fine with not
applying that one.

[I saw you merged the first (coding style) patch.]


Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
