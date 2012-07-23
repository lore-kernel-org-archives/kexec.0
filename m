Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1StRkD-0007ra-Pf
 for kexec@lists.infradead.org; Mon, 23 Jul 2012 23:08:54 +0000
Date: Tue, 24 Jul 2012 08:08:48 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] vmcore-dmesg: Do not write beyond end of allocated buffer
Message-ID: <20120723230848.GJ2966@verge.net.au>
References: <20120717152300.GB11031@redhat.com>
 <20120717224031.GB22241@verge.net.au>
 <20120718133351.GB21746@redhat.com>
 <20120723143511.GA32118@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120723143511.GA32118@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On Mon, Jul 23, 2012 at 10:35:12AM -0400, Vivek Goyal wrote:
> On Wed, Jul 18, 2012 at 09:33:51AM -0400, Vivek Goyal wrote:
> 
> [..]
> > > > +	char temp_buf[1024];
> > > > +	bool last_line = false;
> > > 
> > > Is there a chance of over-running temp_buf?
> > > 
> > > I would be more comfortable if there was a check below to
> > > ensure that len can never be greater than sizeof(temp_buf).
> > 
> > Hi Simon,
> > 
> > Agreed. Making sure temp_buf does not overflow is a good idea. Here is
> > the udpated patch.
> > 
> 
> Hi Simon,
> 
> Do you have any more concerns with this patch. If not, can you please
> apply it.

Sorry, I missed the updated patch somehow.
I'll apply it ASAP.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
