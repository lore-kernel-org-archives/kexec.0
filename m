Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1OC7Kv-0000ug-B8
	for kexec@lists.infradead.org; Wed, 12 May 2010 08:30:37 +0000
Date: Wed, 12 May 2010 17:30:33 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] Fix kexec on powerpc32
Message-ID: <20100512083032.GD18808@verge.net.au>
References: <20100511174749.19309.44615.stgit@muvarov>
	<4BEA2375.7040802@nerdbynature.de>
	<AANLkTimSATEKI4TdO6zNWSRzl2on4OL5D2GGBlVsndMs@mail.gmail.com>
	<4BEA589A.1080009@ozlabs.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4BEA589A.1080009@ozlabs.org>
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
Cc: Maxim Uvarov <muvarov@gmail.com>, kexec@lists.infradead.org

On Wed, May 12, 2010 at 05:28:26PM +1000, Matt Evans wrote:
> Maxim Uvarov wrote:
> >
> > This -Werror came from mips. kexec/arch/mips/Makefile. It is already
> > removed in the git. We already saw this problem.
> 
> BTW, I just did a clone of the kexec git tree repository and the -Werror is 
> still in kexec/arch/mips/Makefile.  Simon's patch of May 4th 
> ("[PATCH] build: Don't modify CFLAGS in kexec/arch/mips/Makefile") doesn't
> seem to be in there [yet].

I'll investigate why.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
