Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OsQVa-0006EZ-WE
	for kexec@lists.infradead.org; Mon, 06 Sep 2010 01:28:31 +0000
Date: Mon, 6 Sep 2010 10:28:26 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] mips/crashdump put cmdline after the latest segment
Message-ID: <20100906012825.GK7491@verge.net.au>
References: <20100903130632.2859.83145.stgit@muvarov>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100903130632.2859.83145.stgit@muvarov>
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

On Fri, Sep 03, 2010 at 05:06:32PM +0400, Maxim Uvarov wrote:
> From: Maxim Uvarov <muvarov@gmail.com>
> 
> Move cmdline from just after .bss segment to the just after
> the latest segment to avoid segments overlap while loading
> crashdump kernel. (new mips vmlinux has additional segments
> after .bss).
> Signed-off-by: Maxim Uvarov <muvarov@gmail.com>

Thanks, applied

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
