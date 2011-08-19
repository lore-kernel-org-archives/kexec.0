Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QuOzx-0007Nq-St
	for kexec@lists.infradead.org; Fri, 19 Aug 2011 13:20:35 +0000
Date: Fri, 19 Aug 2011 09:20:19 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch 0/3] kdump: Add external kdump entry point for s390
	stand-alone dump tools
Message-ID: <20110819132019.GA18656@redhat.com>
References: <20110729123944.562622201@linux.vnet.ibm.com>
	<20110819011431.GB20747@verge.net.au>
	<1313758400.3858.12.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1313758400.3858.12.camel@br98xy6r>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, Simon Horman <horms@verge.net.au>, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

On Fri, Aug 19, 2011 at 02:53:20PM +0200, Michael Holzheu wrote:

[...]
> > although I am a little unclear about the status of the kernel side of
> > things. Please let me know if you would like me to merge the kexec-tools
> > patches now or wait a bit (for an updated version?).
> 
> I think that we are almost done with the discussion. I will send you my
> current kexec-tools patches and would be glad, if you could integrate
> them now.

I guess kexec-tools integration will make more sense once kernel patches
show up atleast in one maintainer's subtree.

Also in kernel patches, atleast we need to resolve the issue of arch
specific kmap(), kunmap() calls so that we don't have to make
kimage_load_crash_segment() arch specific.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
