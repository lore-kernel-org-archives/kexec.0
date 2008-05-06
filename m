Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga05.intel.com ([192.55.52.89] helo=fmsmga101.fm.intel.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JtNK0-0000nI-IE
	for kexec@lists.infradead.org; Tue, 06 May 2008 13:35:09 +0000
Date: Tue, 6 May 2008 06:31:08 -0700
From: "Lombard, David N" <dnlombar@ichips.intel.com>
Subject: Re: [PATCH] Cross compile?
Message-ID: <20080506133108.GB29182@nlxdcldnl2.cl.intel.com>
References: <20080505205328.GA29182@nlxdcldnl2.cl.intel.com>
	<200805060742.45737.jk@ozlabs.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200805060742.45737.jk@ozlabs.org>
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
To: Jeremy Kerr <jk@ozlabs.org>
Cc: "Lombard, David N" <dnlombar@plxs0284.pdx.intel.com>, kexec@lists.infradead.org

On Tue, May 06, 2008 at 07:42:45AM +1000, Jeremy Kerr wrote:
> David,
> 
> > In util/Makefile, the bin-to-hex utility was being built with the
> > cross-compiler, not the host compiler.  This patch fixes that.
> 
> We set the CC to BUILD_CC for the bin-to-hex target so it should use the 
> host compiler currently.
> 
> What are your BUILD_CC, BUILD_CFLAGS and LDFLAGS?

Well, note the patch *does* uses those values--it's just the assignment
doesn't work.

-- 
David N. Lombard, Intel, Irvine, CA
I do not speak for Intel Corporation; all comments are strictly my own.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
