Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KnhDh-00038l-8L
	for kexec@lists.infradead.org; Wed, 08 Oct 2008 22:09:25 +0000
Date: Thu, 9 Oct 2008 09:09:23 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [patch] ia64: Order of operations bug in PT_LOAD segment reader
Message-ID: <20081008220922.GI16178@verge.net.au>
References: <20081008064940.GA11893@verge.net.au>
	<jeljwza5a6.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <jeljwza5a6.fsf@sykes.suse.de>
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
To: Andreas Schwab <schwab@suse.de>
Cc: kexec@lists.infradead.org, Bernhard Walle <bwalle@suse.de>, "Luck,
	Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Jay Lan <jlan@sgi.com>

On Wed, Oct 08, 2008 at 09:56:49AM +0200, Andreas Schwab wrote:
> Simon Horman <horms@verge.net.au> writes:
> 
> > The bug comes about because the break statment was never executed because
> > the if clause would bever be true because the if clause will never be true
> > because &  has higher precedence than !=.
>                  ^^^^^^
>                  lower

Thanks.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
