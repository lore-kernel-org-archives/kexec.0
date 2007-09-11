Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IV9Qi-0004n3-F8
	for kexec@lists.infradead.org; Tue, 11 Sep 2007 13:21:44 -0400
Date: Tue, 11 Sep 2007 19:21:37 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch 1/5] Extended crashkernel command line
Message-ID: <20070911172137.GF20907@suse.de>
References: <20070909083914.065380136@strauss.suse.de>
	<20070909083914.488571169@strauss.suse.de>
	<20070911131445.GA17460@suse.de>
	<20070911153209.GA5054@nlxdcldnl2.cl.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070911153209.GA5054@nlxdcldnl2.cl.intel.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

* Lombard, David N <dnlombar@ichips.intel.com> [2007-09-11 17:32]:
> 
> lilo:
>   append=<string>
> 
>     Appends the options specified to the parameter line passed to
>     the kernel. 

Given that lilo appends the user-specified command line, I think it's
the best to honor the last value. It has also been the previous
behaviour (execpt IA64).

Having a different behaviour if the last or the first value is honored
on different architectures is not what we want, IMO.


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
