Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KYAXd-0000Jm-0B
	for kexec@lists.infradead.org; Wed, 27 Aug 2008 02:13:49 +0000
Date: Wed, 27 Aug 2008 12:13:47 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] [PATCH] Move $(LIBS) on the end
Message-ID: <20080827021345.GH19066@verge.net.au>
References: <669d49e549978c2cd9bb.1219738609@halley.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <669d49e549978c2cd9bb.1219738609@halley.suse.de>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org, yhlu.kernel@gmail.com

On Tue, Aug 26, 2008 at 10:16:49AM +0200, Bernhard Walle wrote:
> 1 file changed, 1 insertion(+), 2 deletions(-)
> kexec/Makefile |    3 +--
> 
> 
> To make static compilation work with
> 
>     LDFLAGS=-static ./configure
>     make
> 
> we have to move $(LIBS) on the end of the compiler line. Static compilation has
> been requested by "Yinghai Lu" <yhlu.kernel@gmail.com>. Although I don't see the
> practical benefit in most cases, I don't think we should not support it. Since
> kexec does not use name resolution functions of libc, it's valid to use static
> linking.
> 
> Tested on x86_64-suse-linux.
> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>

Thanks. I agree that static is entirely sensible for kexec-tools.

Applied


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
