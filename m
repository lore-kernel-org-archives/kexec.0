Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from one.firstfloor.org ([213.235.205.2])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OgfWs-0003oT-L4
	for kexec@lists.infradead.org; Wed, 04 Aug 2010 15:05:15 +0000
From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [rfc] Merge kexec-tools into the kernel tree
References: <20100804070647.GB24064@verge.net.au>
	<m17hk6de62.fsf@fess.ebiederm.org>
Date: Wed, 04 Aug 2010 17:05:08 +0200
In-Reply-To: <m17hk6de62.fsf@fess.ebiederm.org> (Eric W. Biederman's message
	of "Wed, 04 Aug 2010 00:34:29 -0700")
Message-ID: <87bp9ie7vf.fsf@basil.nowhere.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Neuling <mikey@neuling.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:
>
> I'm afraid that someone has a good answer for why their lives would be
> simpler if /sbin/kexec was in the kernel tree and I will be absolutely
> horrified and about someones stupidity when I hear that answer.

Same here. In fact I guess it would be counter productive: it would
discourage a stable API between the kernel and the user tool.
We're seeing this problem with other user tools which are in 
the kernel tree.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
