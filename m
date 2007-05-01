Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HilJm-0006b6-7u
	for kexec@lists.infradead.org; Tue, 01 May 2007 01:54:32 -0400
Date: Tue, 1 May 2007 14:54:24 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec ppc64: cleanup get_devtree_details
Message-ID: <20070501055422.GA20102@verge.net.au>
References: <10869.1177991234@neuling.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <10869.1177991234@neuling.org>
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
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org

On Tue, May 01, 2007 at 01:47:14PM +1000, Michael Neuling wrote:
> Cleanup error paths in get_devtree_details.  Also convert fstat from a
> pointer to avoid malloc.

Thanks, applied.

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
