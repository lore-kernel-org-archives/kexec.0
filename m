Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OgYUx-0007ze-JC
	for kexec@lists.infradead.org; Wed, 04 Aug 2010 07:34:51 +0000
Subject: Re: [rfc] Merge kexec-tools into the kernel tree
References: <20100804070647.GB24064@verge.net.au>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 04 Aug 2010 00:34:29 -0700
In-Reply-To: <20100804070647.GB24064@verge.net.au> (Simon Horman's message of
	"Wed\, 4 Aug 2010 16\:06\:48 +0900")
Message-ID: <m17hk6de62.fsf@fess.ebiederm.org>
MIME-Version: 1.0
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Neuling <mikey@neuling.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Simon Horman <horms@verge.net.au> writes:

> Hi,
>
> After all the excitement of relocating kexec-tools from
> one location on kernel.org to another last week it was
> suggested to me by Michael Neuling that the merging
> kexec-tools into the kernel tree would be a good idea.
>
> Given that there have been a bunch of issues with kexec
> on power that this would resolve. and there is precedence
> for tools in the kernel tree, this sounds entirely reasonable to me.
> So with my kexec-tools maintainer hat on, I would like to start
> a conversation about this.

What are the issues with kexec on power?  Did someone fail to maintain
ABI compatibility?

The interface isn't even supposed to be linux specific, so I can't
imagine what would motivate moving this into the kernel tree.

I'm afraid that someone has a good answer for why their lives would be
simpler if /sbin/kexec was in the kernel tree and I will be absolutely
horrified and about someones stupidity when I hear that answer.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
