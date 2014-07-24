Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XACJr-0007oL-4R
 for kexec@lists.infradead.org; Thu, 24 Jul 2014 06:15:59 +0000
Date: Thu, 24 Jul 2014 14:15:30 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH] kexec/ppc64: disabling exception handling when building
 the purgatory
Message-ID: <20140724061530.GD31683@dhcp-17-37.nay.redhat.com>
References: <20140722104255.GF13924@dhcp-17-37.nay.redhat.com>
 <20140722162228.12506.28076.stgit@nimbus>
 <20140723000224.GD21367@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140723000224.GD21367@verge.net.au>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>, kexec@lists.infradead.org

On 07/23/14 at 09:02am, Simon Horman wrote:
> On Tue, Jul 22, 2014 at 06:22:28PM +0200, Laurent Dufour wrote:
> > Some Linux distributions would like to turn on the GCC exception handling
> > by default. As this option introduces symbols in the built code that are
> > defined in a separate shared library, this is not a good idea to have such
> > an option activated when building the purgatory.
> > 
> > This patch forces the exception handling to be turned off when building the
> > purgatory on ppc64 BE and LE.
> > 
> > Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> 
> Thanks, applied.

FWIW, this patch works for me. Thanks for the fix.

Thanks
WANG Chao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
