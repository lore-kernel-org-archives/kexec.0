Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KJwJa-0003nH-HJ
	for kexec@lists.infradead.org; Fri, 18 Jul 2008 20:12:30 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20080718150410.GB26261@hack.voiplan.pt>
Date: Fri, 18 Jul 2008 13:07:58 -0700
In-Reply-To: <20080718150410.GB26261@hack.voiplan.pt> (WANG Cong's message of
	"Fri, 18 Jul 2008 16:04:10 +0100")
Message-ID: <m1sku7j6qp.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [Patch] kexec: remove redundant if-else
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
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>

WANG Cong <xiyou.wangcong@gmail.com> writes:

> These if-else's can be removed.

Why?  That appears to be pointless code style thrashing.

Converting code with a single return into code with multiple returns.
Which arguably makes it harder to prove properties about.

Further if you want to use the style you suggest a label name like err
is better than the name out.

But in this case where we have multiple results I don't like the proposed
change in style at all.  Especially with no rational.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
