Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WAwIg-0008PQ-Ce
 for kexec@lists.infradead.org; Wed, 05 Feb 2014 06:49:35 +0000
Date: Wed, 5 Feb 2014 15:49:06 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: More frequent kexec-tools releases
Message-ID: <20140205064906.GB29499@verge.net.au>
References: <20140128184042.GA7098@redhat.com>
 <52E85B26.2080203@cn.fujitsu.com>
 <20140129142311.GA15077@redhat.com>
 <20140131052304.GC25099@verge.net.au>
 <20140131143047.GA10594@redhat.com>
 <20140204083151.GE30621@verge.net.au>
 <20140204124148.GH17028@verge.net.au>
 <52F18FFA.5060103@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52F18FFA.5060103@cn.fujitsu.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, Dave Young <dyoung@redhat.com>, WANG Chao <chaowang@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Wed, Feb 05, 2014 at 09:12:26AM +0800, Zhang Yanfei wrote:
> On 02/04/2014 08:41 PM, Simon Horman wrote:
> > On Tue, Feb 04, 2014 at 05:31:51PM +0900, Simon Horman wrote:
> >> On Fri, Jan 31, 2014 at 09:30:47AM -0500, Vivek Goyal wrote:
> >>> On Fri, Jan 31, 2014 at 02:23:04PM +0900, Simon Horman wrote:
> >>>
> >>> [..]
> >>>>> Simon what do you think? A kexec-tools release every 4 months or every
> >>>>> 6 months. Does it make sense to you? 
> >>>>
> >>>> Perhaps we could aim for every second kernel release and see how that goes?
> >>>
> >>> Sounds Good. Kernel releases are roughly 3 months apart. So that would
> >>> mean a kexec-tools release roughly around 6 months. This sounds like
> >>> a good start.
> >>>
> >>> So 3.13 was release recently. And last kexec-tools release was in march
> >>> 2013. May be it is a good idea to do one release now and then next one
> >>> can be after release of kernel 3.15, 3.17 and so on.
> >>
> >> Yes, I think so too.
> > 
> > Would any of you object to me doing this with the current state of the
> > tree as of fe2c38cc0fc32573 ("Avoid buffer overflow on strncat usage").
> > 
> 
> NO objection.

Done :)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
