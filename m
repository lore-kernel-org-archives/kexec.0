Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1S1n3L-0004Be-Rk
 for kexec@lists.infradead.org; Sun, 26 Feb 2012 22:58:53 +0000
Date: Sun, 26 Feb 2012 22:58:42 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] kexec: crash: don't save swapper_pg_dir for !CONFIG_MMU
 configurations
Message-ID: <20120226225842.GA23028@mudshark.cambridge.arm.com>
References: <1330094447-11900-1-git-send-email-will.deacon@arm.com>
 <20120225023748.GE21429@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120225023748.GE21429@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Sat, Feb 25, 2012 at 02:37:49AM +0000, Simon Horman wrote:
> On Fri, Feb 24, 2012 at 02:40:47PM +0000, Will Deacon wrote:
> > nommu platforms don't have very interesting swapper_pg_dir pointers and
> > usually just #define them to NULL, meaning that we can't include them in
> > the vmcoreinfo on the kexec crash path.
> > 
> > This patch only saves the swapper_pg_dir if we have an MMU.
> 
> Hi Will,

Hi Simon,

> might this cover cases where swapper_pg_dir is interesting?

The only case where it's interesting is when you have CONFIG_MMU enabled -
otherwise it's always NULL. If it's #defined as NULL, the current code will
fail at build time so simply omitting it from the dump seems like the best
bet to me (the alternative being to add a NULL entry explicitly, but I don't
see what the gains us).

Cheers,

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
