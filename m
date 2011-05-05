Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mo-p00-ob6.rzone.de ([2a01:238:20a:202:53f0::1])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1QHxlf-0005Pa-95
	for kexec@lists.infradead.org; Thu, 05 May 2011 12:34:56 +0000
Date: Thu, 5 May 2011 14:34:46 +0200
From: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] detect Xen dom0 properly to avoid conflict with
	pv_on_hvm domU
Message-ID: <20110505123446.GA4214@aepfle.de>
References: <20110504163232.GA24669@aepfle.de>
	<20110505122003.GM22010@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110505122003.GM22010@verge.net.au>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

On Thu, May 05, Simon Horman wrote:

> On Wed, May 04, 2011 at 06:32:32PM +0200, Olaf Hering wrote:

> > +static int is_dom0;
> 
> I think you need to explicitly initialise is_dom0 to 0.

Globals are always initialized to zero, its a C language thing.

> Alternatively, is it really such a burden to call access()
> each time xen_present() is called?  (I'm ambivalent with regards to this).

Probably not, its called a dozen times in my testing.

Olaf

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
