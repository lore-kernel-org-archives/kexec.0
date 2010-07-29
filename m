Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OeLEs-0006ED-13
	for kexec@lists.infradead.org; Thu, 29 Jul 2010 05:01:04 +0000
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [patch] MAINTAINERS: kexec-tools has moved
In-reply-to: <20100729041641.GA32220@verge.net.au>
References: <20100729041641.GA32220@verge.net.au>
Date: Thu, 29 Jul 2010 15:00:56 +1000
Message-ID: <24707.1280379656@neuling.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>



In message <20100729041641.GA32220@verge.net.au> you wrote:
> Kexec tools has been moved to http://kernel.org/pub/linux/utils/kernel/kexec/
> as user-space code shouldn't be in /pub/linux/kernel
> 
> Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> Index: linux-2.6/MAINTAINERS
> ===================================================================
> --- linux-2.6.orig/MAINTAINERS	2010-07-29 13:10:04.000000000 +0900
> +++ linux-2.6/MAINTAINERS	2010-07-29 13:11:40.000000000 +0900
> @@ -3334,7 +3334,7 @@ F:	drivers/s390/kvm/
>  
>  KEXEC
>  M:	Eric Biederman <ebiederm@xmission.com>

I think it's time to change or at least add you as a maintainer, Simon
:-)

Mikey

> -W:	http://ftp.kernel.org/pub/linux/kernel/people/horms/kexec-tools/
> +W:	http://kernel.org/pub/linux/utils/kernel/kexec/
>  L:	kexec@lists.infradead.org
>  S:	Maintained
>  F:	include/linux/kexec.h
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
