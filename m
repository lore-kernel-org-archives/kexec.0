Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K19Eb-0000ZG-Ay
	for kexec@lists.infradead.org; Wed, 28 May 2008 00:09:42 +0000
Date: Wed, 28 May 2008 10:09:34 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Specify the arch on kexec_unload.
Message-ID: <20080528000933.GE6752@verge.net.au>
References: <1211813218-21886-1-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1211813218-21886-1-git-send-email-bwalle@suse.de>
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
Cc: sharyath@in.ibm.com, kexec@lists.infradead.org

On Mon, May 26, 2008 at 04:46:58PM +0200, Bernhard Walle wrote:
> This fixes the problem in kexec-tools that the patch
> http://article.gmane.org/gmane.linux.kernel/685027 tries to fix in kernel.
> 
> The fix in userspace is correct.

Thanks, applied.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
