Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga06.intel.com ([134.134.136.21] helo=orsmga101.jf.intel.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1OCYgi-0000zf-4g
	for kexec@lists.infradead.org; Thu, 13 May 2010 13:42:57 +0000
Date: Thu, 13 May 2010 06:42:49 -0700
From: "David N. Lombard" <dnlombar@ichips.intel.com>
Subject: Re: [RFC PATCH] kexec-tools: Fix option/argument parsing
Message-ID: <20100513134249.GB8160@nlxcldnl2.cl.intel.com>
References: <4BEBB4E8.6080000@ozlabs.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4BEBB4E8.6080000@ozlabs.org>
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
To: Matt Evans <matt@ozlabs.org>
Cc: Michael Neuling <mikey@neuling.org>, "horms@verge.net.au" <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Thu, May 13, 2010 at 01:14:32AM -0700, Matt Evans wrote:
> Hi,
> 
> 
> In playing with kexec-tools I've noticed various problems with the argument
> passing, meaning one has to be careful to use certain forms of arguments
> and present them in a certain order.
> 
> The arguments end up being parsed three times, each getting more specific
> than the last.  main() looks for general args, arch_process_options() looks
> for options common to all loaders for the arch, and then finally many
> file_type load() methods check for options specific to that filetype.
> 
> As GNU getopt works, it re-orders the argv[] pushing any args it doesn't
> recognise to the end.  This includes arguments to valid options which
> are simply not recognised the first time around.

This is a long standing problem; I found it years ago.  My patch saved a copy
of the original argc and then passed that original version to each phase instead
of the mangled vector.

I hope your suggestion is accepted or prompts a solution, as the problem can
be quite vexing...

-- 
David N. Lombard, Intel, Irvine, CA
I do not speak for Intel Corporation; all comments are strictly my own.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
