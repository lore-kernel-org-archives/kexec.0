Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hlyoy-00022y-IK
	for kexec@lists.infradead.org; Wed, 09 May 2007 22:56:02 -0400
Date: Thu, 10 May 2007 11:55:56 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [patch 2/2] kexec rename dprintf to dbgprintf
Message-ID: <20070510025553.GD30920@verge.net.au>
References: <20070507235727.631477448@am.sony.com>>
	<463FBE27.4060402@am.sony.com> <20070508061204.GD8170@verge.net.au>
	<46423FCB.4080200@am.sony.com>
	<20070510021414.GB30920@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070510021414.GB30920@verge.net.au>
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
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: kexec@lists.infradead.org

On Thu, May 10, 2007 at 11:14:16AM +0900, Simon Horman wrote:
> On Wed, May 09, 2007 at 02:40:27PM -0700, Geoff Levand wrote:
> > The recently introduce kexec debug routine dprintf clashes with an existing
> > libc symbol.  Rename dprintf to dbgprintf.
> 
> Ok, ignore my previous email :-)
> 
> This seems good to me. I'll test it out in my tree.

Applied.

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
