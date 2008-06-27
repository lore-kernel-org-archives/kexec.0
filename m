Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KCBwG-0002an-SW
	for kexec@lists.infradead.org; Fri, 27 Jun 2008 11:16:25 +0000
Date: Fri, 27 Jun 2008 13:17:01 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Fix vmcoreinfo generation on 32bit hosts for 64bit kernels
Message-ID: <20080627131701.5ab66b5a@halley.suse.de>
In-Reply-To: <48645B6C.1070608@mxs.nes.nec.co.jp>
References: <20080626124731.GA24365@suse.de>
	<48645B6C.1070608@mxs.nes.nec.co.jp>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec-ml <kexec@lists.infradead.org>

Hi Ken'ichi,

* Ken'ichi Ohmichi [2008-06-27 12:15]:
> Bernhard Walle wrote:
> > This bug fixes the generation of vmcoreinfo files on 32bit hosts for ELF64
> > files, i.e. 64bit kernels. The concrete problem was PPC64 which is built in a
> > 32bit environment at SUSE.
> 
> I have one question.
> I guess that the fundamental problem is that makedumpfile cannot
> use vmcoreinfo which is contained in /proc/vmcore on ppc64, right ?
> If yes, could you please test my attached patch for fixing it.
> 
> I created the kernel patch for adding the symbol "node_data" to
> ppc64's vmcoreinfo, but I cannot tested it because I don't have
> any ppc64 machine.

No, not directly. We still ship the makedumpfile.config. Yes, we plan
to switch to /proc/vmcore vmcoreinfo for next release (SLES 11).

I'll test your patch on PPC and give feedback!

But I think the patch is also valid since makedumpfile.config file is
still supported and should work.


Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
