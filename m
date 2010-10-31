Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PCMXj-0007RQ-0B
	for kexec@lists.infradead.org; Sun, 31 Oct 2010 01:17:07 +0000
Date: Sun, 31 Oct 2010 10:16:48 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] - make /proc/vmcore accesable on x86_64
Message-ID: <20101031011648.GB4525@verge.net.au>
References: <20101019150630.GA1870@jolsa.brq.redhat.com>
	<20101022085412.GA8267@verge.net.au>
	<20101028121627.GE16206@verge.net.au>
	<20101029075425.GA1978@jolsa.brq.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20101029075425.GA1978@jolsa.brq.redhat.com>
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
To: Jiri Olsa <jolsa@redhat.com>
Cc: kexec@lists.infradead.org

On Fri, Oct 29, 2010 at 09:54:25AM +0200, Jiri Olsa wrote:
> On Thu, Oct 28, 2010 at 09:16:27PM +0900, Simon Horman wrote:
> > On Fri, Oct 22, 2010 at 10:54:12AM +0200, Simon Horman wrote:
> > > On Tue, Oct 19, 2010 at 05:06:30PM +0200, Jiri Olsa wrote:
> 
> SNIP
> 
> > > > My goal is to share data within the host and kexec-ed kernel,
> > > > so I'd like to use the /proc/vmcore for that.. any other
> > > > ideas are welcome :)
> > > 
> > > This approach seems reasonable to me.
> > > I'll push it if a I don't hear any objections
> > > in the near future.
> > 
> > Hi Jiru,
> > 
> > could you please submit this as a formal patch with a signed-off-by line?
>
> sure, it's attached

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
