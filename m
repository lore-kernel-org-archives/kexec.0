Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OtcH9-0005hz-Cd
	for kexec@lists.infradead.org; Thu, 09 Sep 2010 08:14:32 +0000
Date: Thu, 9 Sep 2010 17:14:25 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [GIT PULL] Please pull x86 biarch crashdump support and misc devel
Message-ID: <20100909081425.GK19303@verge.net.au>
References: <m1y6bcf2aq.fsf@fess.ebiederm.org>
	<20100909013546.GD5783@verge.net.au>
	<m1bp877kol.fsf@fess.ebiederm.org>
	<20100909024213.GC19303@verge.net.au>
	<m14odzfoe2.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m14odzfoe2.fsf@fess.ebiederm.org>
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
Cc: Kexec Mailing List <kexec@lists.infradead.org>

On Wed, Sep 08, 2010 at 10:59:33PM -0700, Eric W. Biederman wrote:
> Simon Horman <horms@verge.net.au> writes:
> 
> > I'd rather edit the patch to avoid breaking bisection.
> > Is that ok with you?
> 
> No real problem, and my patchset is just intrusive enough someone might
> care and try and bisect a problem.
> 
> In general I wouldn't fix that patch (after I had made it public) and
> would simply send a correcting patch because it can quickly become
> confusing, which patch should go where when.
> 
> Here I don't think there is any danger of confusion so I don't think
> that changing history that has only been on my devel branch is worth
> worrying about.

Agreed. I've made the change and pushed the result.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
