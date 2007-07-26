Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IE5z0-0006m6-1O
	for kexec@lists.infradead.org; Thu, 26 Jul 2007 12:14:35 -0400
Date: Thu, 26 Jul 2007 18:14:31 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch] add kdump_after_notifier
Message-ID: <20070726161431.GA32008@suse.de>
References: <469F55D0.4050203@ah.jp.nec.com> <20070726140702.GA8949@suse.de>
	<20070726153240.GA15969@in.ibm.com>
	<20070726153440.GA19095@suse.de>
	<20070726154415.GB15969@in.ibm.com>
	<20070726154718.GA25561@suse.de>
	<20070726155444.GC15969@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070726155444.GC15969@in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

* Vivek Goyal <vgoyal@in.ibm.com> [2007-07-26 17:54]:
> 
> That's true. Its not mainline. We had similar discussion in the past
> also. I think we should allow only audited code to be run after panic().
> Leaving it open to modules or unaudited code makes this solution
> something like LKCD where whole lot of code used to run after the crash,
> hence was unreliable.
> 
> If KDB goes mainline, then I think it is not a bad idea to call debugger
> first (if it is enabled) and then one can trigger crash dump from inside
> the debugger.

Well, after thinking again about this, I think the best solution would
to call kdump from KDB with a command as it was done by LKCD. The new
sysctl is too specific ...


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
