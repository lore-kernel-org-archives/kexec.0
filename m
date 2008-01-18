Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JFjeH-0006HY-OP
	for kexec@lists.infradead.org; Fri, 18 Jan 2008 05:20:19 +0000
Date: Fri, 18 Jan 2008 14:20:05 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: Build failure with latest kexec tools git code.
Message-ID: <20080118052003.GA8223@verge.net.au>
References: <47903281.5020508@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47903281.5020508@in.ibm.com>
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
To: "Sachin P. Sant" <sachinp@in.ibm.com>
Cc: kexec@lists.infradead.org

On Fri, Jan 18, 2008 at 10:30:49AM +0530, Sachin P. Sant wrote:
> I came across a build failure with the latest kexec tools git code.
> Not sure if something is wrong with my build setup.
>
> [ kexec-tools-git-stable]$ autoconf
> [ kexec-tools-git-stable]$ ./configure
> checking build system type... i686-pc-linux-gnu
> checking host system type... i686-pc-linux-gnu
> .......
> .......
> config.status: creating Makefile
> config.status: creating include/config.h
> config.status: error: cannot find input file: include/config.h.in
>
> Observed this build failure on i386 as well as ppc64 box.

Hi,

I think that you need to run autoheader to create include/config.h.in.
I will update the documentation accordingly.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
