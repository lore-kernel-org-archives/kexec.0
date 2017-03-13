Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1cnLo8-0003M7-5a
 for kexec@lists.infradead.org; Mon, 13 Mar 2017 08:58:26 +0000
Date: Mon, 13 Mar 2017 09:57:59 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] build_mem_phdrs(): check if p_paddr is invalid
Message-ID: <20170313085759.GB22378@verge.net.au>
References: <e45f4027aa72ea9009ae03f471894d62ccc135bb.1488346530.git.panand@redhat.com>
 <20170301071317.GA3534@dhcp-128-65.nay.redhat.com>
 <c1f408fe-2283-0b37-a035-9080a31e91e2@redhat.com>
 <20170313064529.GB11197@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170313064529.GB11197@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Pratyush Anand <panand@redhat.com>, kexec@lists.infradead.org, bhe@redhat.com

On Mon, Mar 13, 2017 at 02:45:29PM +0800, Dave Young wrote:
> On 03/07/17 at 06:53am, Pratyush Anand wrote:
> > Hi Simon,
> > 
> > On Wednesday 01 March 2017 12:43 PM, Dave Young wrote:
> > > On 03/01/17 at 11:19am, Pratyush Anand wrote:
> > > > Currently, all the p_paddr of PT_LOAD headers are assigned to 0, which
> > > > is not correct and could be misleading, since 0 is a valid physical
> > > > address.
> > > > 
> > > > Upstream kernel commit "464920104bf7 /proc/kcore: update physical
> > > > address for kcore ram and text" fixed it and now invalid PT_LOAD is
> > > > assigned as -1.
> > > > 
> > > > kexec/arch/i386/crashdump-x86.c:get_kernel_vaddr_and_size() uses kcore
> > > > interface and so calls build_mem_phdrs() for kcore PT_LOAD headers.
> > > > 
> > > > This patch fixes build_mem_phdrs() to check if p_paddr is invalid.
> > 
> > Any comment on this?
> 
> Simon, ping, explain a bit about the background based on the patch log:
> 
> Although it is a kernel regression, the original p_addr = 0 assumption is
> wrong, it should be fixed in kernel instead of keep it to avoid
> kexec-tools breakage.
> 
> Since latest kernel already has the fix merged, kexec-tools will fail to
> load crash kernel now. 
> 
> Any opinion about this patch?

Sorry for letting this slip through the cracks.

The patch looks good to me and I have applied it.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
