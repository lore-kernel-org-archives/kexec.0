Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OtaAi-0003Qr-EV
	for kexec@lists.infradead.org; Thu, 09 Sep 2010 05:59:47 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <m1y6bcf2aq.fsf@fess.ebiederm.org>
	<20100909013546.GD5783@verge.net.au>
	<m1bp877kol.fsf@fess.ebiederm.org>
	<20100909024213.GC19303@verge.net.au>
Date: Wed, 08 Sep 2010 22:59:33 -0700
In-Reply-To: <20100909024213.GC19303@verge.net.au> (Simon Horman's message of
	"Thu, 9 Sep 2010 11:42:13 +0900")
Message-ID: <m14odzfoe2.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [GIT PULL] Please pull x86 biarch crashdump support and misc devel
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
Cc: Kexec Mailing List <kexec@lists.infradead.org>

Simon Horman <horms@verge.net.au> writes:

> I'd rather edit the patch to avoid breaking bisection.
> Is that ok with you?

No real problem, and my patchset is just intrusive enough someone might
care and try and bisect a problem.

In general I wouldn't fix that patch (after I had made it public) and
would simply send a correcting patch because it can quickly become
confusing, which patch should go where when.

Here I don't think there is any danger of confusion so I don't think
that changing history that has only been on my devel branch is worth
worrying about.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
