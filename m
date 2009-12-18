Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NLlEv-0004Ze-0d
	for kexec@lists.infradead.org; Fri, 18 Dec 2009 22:24:05 +0000
Subject: Re: kexec reboot broken with ioatdma?
From: Dan Williams <dan.j.williams@intel.com>
In-Reply-To: <adafx773ox9.fsf@roland-alpha.cisco.com>
References: <ada3a3a8v1g.fsf@roland-alpha.cisco.com>
	<20091216224912.GC16219@verge.net.au>
	<aday6l27c7w.fsf@roland-alpha.cisco.com> <4B296930.9020704@intel.com>
	<adatyvq7bbi.fsf@roland-alpha.cisco.com>
	<1261174241.16958.6.camel@dwillia2-linux.ch.intel.com>
	<adafx773ox9.fsf@roland-alpha.cisco.com>
Date: Fri, 18 Dec 2009 15:23:20 -0700
Message-Id: <1261175000.16958.8.camel@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
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
To: Roland Dreier <rdreier@cisco.com>
Cc: Simon Horman <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, 2009-12-18 at 15:20 -0700, Roland Dreier wrote:
> > Subject: ioat2,3: put channel hardware in known state at init
>  > 
>  > Put the ioat2 and ioat3 state machines in the halted state with all
>  > errors cleared.
> 
> Yes, with this applied I was able to kexec reboot from a kernel with
> ioatdma loaded and have ioatdma work in the new kernel.  So:
> 
> Tested-by: Roland Dreier <rolandd@cisco.com>

What was that, all of 8 minutes to turn that test around! :-) Nice.

Thanks,
Dan



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
