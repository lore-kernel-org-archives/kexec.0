Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QgH9U-0006gR-0X
	for kexec@lists.infradead.org; Mon, 11 Jul 2011 14:08:00 +0000
Date: Mon, 11 Jul 2011 10:07:54 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch 0/9] kdump: Patch series for s390 support
Message-ID: <20110711140754.GD30674@redhat.com>
References: <20110704170922.976299676@linux.vnet.ibm.com>
	<20110705202615.GJ24348@redhat.com>
	<1309944287.3937.39.camel@br98xy6r>
	<20110707193321.GE28850@redhat.com>
	<1310133738.3508.245.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1310133738.3508.245.camel@br98xy6r>
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
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

On Fri, Jul 08, 2011 at 04:02:18PM +0200, Michael Holzheu wrote:
> Hello Vivek,
> 
> I attached a document where the s390 port is described in more detail.
> Perhaps this helps you to understand what want and what we are doing. If
> not - just delete it :-)
> 

Michael,

Thanks for the documentation. I have gone through it quickly and there
are some parts I am still missing.

On x86, after the kernel crash we jump to purgatory code which does the
checksum verification of all the loaded segments and if everything is
fine, it jumps to kdump kernel's entry point and second kernel boots.

On s390, looks like after purgatory, control is going to some other
piece of code (which does IPL?), and that code decides whether to
start kdump kernel or launch stand alone kernel as backup plan?

If yes, is that code whic does the IPL, also loaded in crashkernel memory
as part of kdump kernel? If not, how does kexec-tools come to know
where to jump after doing checksum on loaded kernel?

Thanks
Vivek


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
