Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Otbrn-0005F7-U5
	for kexec@lists.infradead.org; Thu, 09 Sep 2010 07:48:21 +0000
Date: Thu, 9 Sep 2010 09:48:13 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86: copy_oldmem_page using cached addressing
Message-ID: <20100909074813.GA8355@elte.hu>
References: <E1OtMLz-0001yp-Ia@eag09.americas.sgi.com>
	<m1eid4gi0g.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1eid4gi0g.fsf@fess.ebiederm.org>
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
Cc: kexec@lists.infradead.org, Cliff Wickman <cpw@sgi.com>, linux-kernel@vger.kernel.org


* Eric W. Biederman <ebiederm@xmission.com> wrote:

> Cliff Wickman <cpw@sgi.com> writes:
> 
> > From: Cliff Wickman <cpw@sgi.com>
> >
> > The copy of /proc/vmcore to a user buffer proceeds much faster
> > if the kernel addresses memory as cached.
> >
> > With this patch we have seen an increase in transfer rate from less than
> > 15MB/s to 80-460MB/s, depending on size of the transfer.  This makes
> > a big difference in time needed to save a system dump.
> >
> > (Does anyone know of a reason why copy_oldmem_page() would need
> >  to use uncached addresses?)
> >
> > Diffed against 2.6.36-rc3
> 
> I believe this code simply predates being able to specify the
> caching attributes at ioremap time.  Being cached in this case
> actually looks more correct, as that is the default for RAM
> and we are talking about RAM.
> 
> Ultimately either there is another cpu running wild with these pages
> mapped with some random set of attributes, and we cannot get the
> permissions right or we have captured all of the cpus and this is the
> only mapping so it doesn't matter.
> 
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Applied, thanks guys. Note, i also added a -stable tag, as kdump is 
typically used with enterprise setups and we want this (low-risk, 
high-impact) improvement to be propagated far back the -stable series.

Thanks,

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
