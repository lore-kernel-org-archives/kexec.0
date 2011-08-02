Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QoKRk-0000lJ-C7
	for kexec@lists.infradead.org; Tue, 02 Aug 2011 19:16:09 +0000
Date: Tue, 2 Aug 2011 15:16:03 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch v2 01/10] kdump: Add KEXEC_CRASH_CONTROL_MEMORY_LIMIT
Message-ID: <20110802191603.GI6399@redhat.com>
References: <20110727125504.491183728@linux.vnet.ibm.com>
	<20110727125807.529303146@linux.vnet.ibm.com>
	<20110801201644.GG3805@redhat.com>
	<1312278664.4881.35.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1312278664.4881.35.camel@br98xy6r>
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

On Tue, Aug 02, 2011 at 11:51:04AM +0200, Michael Holzheu wrote:
> Hello Vivek,
> 
> On Mon, 2011-08-01 at 16:16 -0400, Vivek Goyal wrote:
> > On Wed, Jul 27, 2011 at 02:55:05PM +0200, Michael Holzheu wrote:
> > > From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > > 
> > > On s390 there is a different KEXEC_CONTROL_MEMORY_LIMIT for the normal and
> > > the kdump kexec case. Therefore this patch introduces a new macro
> > > KEXEC_CRASH_CONTROL_MEMORY_LIMIT. This is set to
> > > KEXEC_CONTROL_MEMORY_LIMIT for all architectures that do not define
> > > KEXEC_CRASH_CONTROL_MEMORY_LIMIT.
> > 
> > Hi Michael,
> > 
> > Curious that why limit is different for kexec and kdump cases on s390
> > only.
> 
> The standard kexec relocate_kernel code calls a machine instruction that
> must run below 2 GiB. For kdump we currently do not use the control page
> at all because no segments have to be moved in that case. Perhaps I am
> still missing something here?

On x86, control page is used for transition to purgatory and second kernel
and common code is used. The only step which is skipped in case of kdump
is the page copying part. As code is common for both the cases the limit
is same.

If you are not using control page at all during s390 kdump (because you
are doing all the setup in dump tools, then probably you can specify
a higher limit so control page.) So in this case you are allocating
control page but not using it?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
