Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NLtpI-0004gt-8p
	for kexec@lists.infradead.org; Sat, 19 Dec 2009 07:34:12 +0000
Date: Sat, 19 Dec 2009 18:34:06 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: kexec reboot broken with ioatdma?
Message-ID: <20091219073406.GG9764@verge.net.au>
References: <ada3a3a8v1g.fsf@roland-alpha.cisco.com>
	<20091216224912.GC16219@verge.net.au>
	<aday6l27c7w.fsf@roland-alpha.cisco.com>
	<4B296930.9020704@intel.com>
	<adatyvq7bbi.fsf@roland-alpha.cisco.com>
	<1261174241.16958.6.camel@dwillia2-linux.ch.intel.com>
	<adafx773ox9.fsf@roland-alpha.cisco.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <adafx773ox9.fsf@roland-alpha.cisco.com>
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
Cc: Dan Williams <dan.j.williams@intel.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Dec 18, 2009 at 02:20:02PM -0800, Roland Dreier wrote:
> 
>  > Subject: ioat2,3: put channel hardware in known state at init
>  > 
>  > Put the ioat2 and ioat3 state machines in the halted state with all
>  > errors cleared.
> 
> Yes, with this applied I was able to kexec reboot from a kernel with
> ioatdma loaded and have ioatdma work in the new kernel.  So:
> 
> Tested-by: Roland Dreier <rolandd@cisco.com>

This seems fine to me from a kexec point of view

Acked-by: Simon Horman <horms@verge.net.au>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
