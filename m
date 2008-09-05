Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KbUij-0003Og-52
	for kexec@lists.infradead.org; Fri, 05 Sep 2008 06:23:01 +0000
Date: Fri, 5 Sep 2008 16:22:59 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/kexec.h: Bring put/get_unaligned() back from the
	dead.
Message-ID: <20080905062257.GA23955@verge.net.au>
References: <20080905021310.GA20338@linux-sh.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080905021310.GA20338@linux-sh.org>
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
To: Paul Mundt <lethal@linux-sh.org>
Cc: kexec@lists.infradead.org

On Fri, Sep 05, 2008 at 11:13:10AM +0900, Paul Mundt wrote:
> This re-enables the fairly generic put/get_unaligned() routines in
> kexec.h, while tidying up the variable shadowing clash that results
> when using it in places like machine_apply_elf_rel().
> 
> Needed for SH ELF relocations.
> 
> IA64 still does its own put_unaligned64(), which should likely also be
> converted over to using put_unaligned() directly.

Thanks Paul, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
