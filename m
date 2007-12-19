Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga05.intel.com ([192.55.52.89] helo=fmsmga101.fm.intel.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1J4zqb-0005QI-7T
	for kexec@lists.infradead.org; Wed, 19 Dec 2007 14:24:39 +0000
Date: Wed, 19 Dec 2007 06:38:22 -0800
From: "Lombard, David N" <dnlombar@ichips.intel.com>
Subject: Re: [PATCH 0/8] kexec build system updates, to allow cross-kexec()ing
Message-ID: <20071219143822.GA17705@nlxdcldnl2.cl.intel.com>
References: <1197967675.854275.930419561848.0.gpush@pokey>
	<20071218232558.GA14092@redhat.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071218232558.GA14092@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, Jeremy Kerr <jk@ozlabs.org>

On Tue, Dec 18, 2007 at 06:25:58PM -0500, Vivek Goyal wrote:
> On Tue, Dec 18, 2007 at 05:47:55PM +0900, Jeremy Kerr wrote:
> 
> > This allows us to kexec a powerpc64 kernel from a powerpc userspace.
> > x86{,_64} users might find this handy too, but I don't have hardware
> > to test.
> 
> I think x86 it already happens. I think I can launch 64bit kernel from
> a 32bit kexec.

You certainly can...

-- 
David N. Lombard, Intel, Irvine, CA
I do not speak for Intel Corporation; all comments are strictly my own.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
