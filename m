Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LOgA1-0001Zz-PZ
	for kexec@lists.infradead.org; Sun, 18 Jan 2009 22:30:33 +0000
Date: Mon, 19 Jan 2009 09:30:24 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Fix missing FILE argument in fprintf()
Message-ID: <20090118223020.GA3043@verge.net.au>
References: <1232114808-22809-1-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1232114808-22809-1-git-send-email-bwalle@suse.de>
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

On Fri, Jan 16, 2009 at 03:06:48PM +0100, Bernhard Walle wrote:
> This fixes the following compiler warning
> 
>     kexec/arch/i386/crashdump-x86.c: In function 'get_crash_memory_ranges':
>     kexec/arch/i386/crashdump-x86.c:144: warning: passing argument 1 of \
>         'fprintf' from incompatible pointer type
>     kexec/arch/i386/crashdump-x86.c:144: warning: passing argument 2 of \
>         'fprintf' makes pointer from integer without a cast
> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>

Thanks Bernhard,

applied.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
