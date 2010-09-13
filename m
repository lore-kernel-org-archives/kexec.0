Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Ov8xI-0008Ax-NQ
	for kexec@lists.infradead.org; Mon, 13 Sep 2010 13:20:25 +0000
Date: Mon, 13 Sep 2010 22:20:14 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] Revert "powerpc new toolchains fix (crt.S)"
Message-ID: <20100913132014.GB3193@verge.net.au>
References: <20100907151025.5784.98190.stgit@muvarov>
	<20100909081656.GL19303@verge.net.au>
	<AANLkTi=qvs8dDL8oSvczgoMB_K1ymrV7OrJr=Lzug0dW@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTi=qvs8dDL8oSvczgoMB_K1ymrV7OrJr=Lzug0dW@mail.gmail.com>
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
To: Maxim Uvarov <muvarov@gmail.com>
Cc: kexec@lists.infradead.org

On Mon, Sep 13, 2010 at 04:11:06PM +0400, Maxim Uvarov wrote:
> 2010/9/9 Simon Horman <horms@verge.net.au>:
> > On Tue, Sep 07, 2010 at 07:10:25PM +0400, Maxim Uvarov wrote:
> >> This reverts commit 45e8f29639d9f97b74389e5bd28c7a5cccbf3e2a.
> >> purgatory/arch/ppc/crt.S and purgatory/arch/ppc/misc.S are the same
> >> files.
> >
> > Thanks, applied both patches.
> >
> 
> Thanks, we had some misunderstanding there and committed 3 patches
> instead of one.

Sorry about that.

> But now crt.S is out of the tree and it is ok. Powerpc code is
> compilable without any specific
> options.

:-)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
