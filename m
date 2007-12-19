Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1J4s2i-0000oT-LB
	for kexec@lists.infradead.org; Wed, 19 Dec 2007 06:04:39 +0000
Date: Wed, 19 Dec 2007 15:04:26 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/8] kexec build system updates, to allow cross-kexec()ing
Message-ID: <20071219060425.GD12773@verge.net.au>
References: <1197967675.854275.930419561848.0.gpush@pokey>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1197967675.854275.930419561848.0.gpush@pokey>
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
To: Jeremy Kerr <jk@ozlabs.org>
Cc: kexec@lists.infradead.org

On Tue, Dec 18, 2007 at 05:47:55PM +0900, Jeremy Kerr wrote:
> Hi all,
> 
> This series of patches is aimed at simplifying the kexec build system,
> mainly in order to make cross-compilation much easier.
> 
> As well as cross-compiling, this makes it possible to separate the
> 'host' architecture (ie, the arch of the kexec binary built), and the
> 'target' architecture (ie, the arch of the kernel that we're kexecing).
> We can specify these with the standard --host and --target arguments
> to configure.
> 
> This allows us to kexec a powerpc64 kernel from a powerpc userspace.
> x86{,_64} users might find this handy too, but I don't have hardware
> to test.
> 
> Any comments are most welcome - if you're able to test on your
> arch, that would be great too.

Thanks Jeremy,

I've run these patches through the build for all supported architectures
and they seem clean to me. So I have gone ahead and applied them. If
anyone notices any breakage please let Jeremy and/or myself know.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
