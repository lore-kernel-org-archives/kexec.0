Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Nz4M9-0001zg-GV
	for kexec@lists.infradead.org; Tue, 06 Apr 2010 08:41:58 +0000
Date: Tue, 6 Apr 2010 18:41:34 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/7] powerpc32: pull in libfdt
Message-ID: <20100406084134.GB22427@verge.net.au>
References: <1270023858-26947-1-git-send-email-sebastian@breakpoint.cc>
	<1270023858-26947-4-git-send-email-sebastian@breakpoint.cc>
	<20100331225819.GC10909@verge.net.au>
	<20100401070559.GA20047@Chamillionaire.breakpoint.cc>
	<20100406061251.GA10387@verge.net.au>
	<20100406075108.GA29206@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100406075108.GA29206@Chamillionaire.breakpoint.cc>
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
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: kexec@lists.infradead.org

On Tue, Apr 06, 2010 at 09:51:08AM +0200, Sebastian Andrzej Siewior wrote:
> * Simon Horman | 2010-04-06 16:12:52 [+1000]:
> 
> >Ok, how about we a) merge your changes as is and b) try and get a patch
> >upstream that we add to kexec-tools later. I understand your reasoning
> >behind not wanting to diverge from libfdt-upstream, but at the same
> >time, I'd like to get this fixed if possible.
> Yeah, this sounds good to me. One of your fixes has allready been
> applied [0]. There is no newer version of libfdt taged at this time.
> Current HEAD of it produces a .so file. Is it okay with you if pull the
> lib in and switch to a library once there is a official one?

Yes, I think that is fine. Do you want me to just take the changes that you
posted last week?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
