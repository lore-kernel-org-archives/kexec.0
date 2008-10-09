Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ko414-0000JY-Mx
	for kexec@lists.infradead.org; Thu, 09 Oct 2008 22:29:55 +0000
Date: Fri, 10 Oct 2008 09:29:53 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Use return value of count_dyn_reconf_memory_ranges()
Message-ID: <20081009222951.GE20255@verge.net.au>
References: <1223571685-14110-1-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1223571685-14110-1-git-send-email-bwalle@suse.de>
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
Cc: kexec@lists.infradead.org

On Thu, Oct 09, 2008 at 07:01:25PM +0200, Bernhard Walle wrote:
> This patch fixes the build error
> 
>     kexec/arch/ppc64/kexec-ppc64.c:140: \
>         warning: control reaches end of non-void function
> 
> The patch returns 0 on success, and checks when the function is called
> for a non-zero value.

Thanks Bernhard, applied.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
