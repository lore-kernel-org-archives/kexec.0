Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtprelay03.ispgateway.de ([80.67.29.28])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OgZ1X-0001Kf-QE
	for kexec@lists.infradead.org; Wed, 04 Aug 2010 08:08:31 +0000
Date: Wed, 4 Aug 2010 10:08:13 +0200
From: Bernhard Walle <bernhard@bwalle.de>
Subject: Re: [rfc] Merge kexec-tools into the kernel tree
Message-ID: <20100804080813.GA20178@bwalle.de>
References: <20100804070647.GB24064@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100804070647.GB24064@verge.net.au>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Neuling <mikey@neuling.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

* Simon Horman <horms@verge.net.au> [2010-08-04 09:06]:
> 
> Given that there have been a bunch of issues with kexec
> on power that this would resolve. and there is precedence
> for tools in the kernel tree, this sounds entirely reasonable to me.
> So with my kexec-tools maintainer hat on, I would like to start
> a conversation about this.

Well, honestly I don't understand the reason behind it.

If it's about dependencies between the kexec binary and the kernel
version -- there are also dependencies between makedumpfile and crash to
the kernel version. Should we move makedumpfile and crash in the kernel
tree, too (which means that we have a GDB copy in the kernel tree)?


Regards,
Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
