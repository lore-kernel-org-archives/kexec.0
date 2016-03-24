Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aixOA-0004nO-T4
 for kexec@lists.infradead.org; Thu, 24 Mar 2016 05:00:56 +0000
Date: Thu, 24 Mar 2016 14:00:29 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/3] Pass struct mem_sym into machine_apply_elf_rel()
Message-ID: <20160324050029.GA22690@verge.net.au>
References: <20160226180311.2938d804@kryten>
 <20160323041025.GP46309@thor.bakeyournoodle.com>
 <1458780575.29516.3.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1458780575.29516.3.camel@ellerman.id.au>
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
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Bill Schmidt <wschmidt@us.ibm.com>, kexec@lists.infradead.org, Tony Breeds <tony@bakeyournoodle.com>, Anton Blanchard <anton@samba.org>, Alan Modra <amodra@gmail.com>

On Thu, Mar 24, 2016 at 11:49:35AM +1100, Michael Ellerman wrote:
> On Wed, 2016-03-23 at 15:10 +1100, Tony Breeds wrote:
> 
> > On Fri, Feb 26, 2016 at 06:03:11PM +1100, Anton Blanchard wrote:
> 
> > > On PowerPC64 ABIv2 we need to look at the symbol to determine
> > > if it has a local entry point. Pass struct mem_sym into
> > > machine_apply_elf_rel() so we can.
> > >
> > > Signed-off-by: Anton Blanchard <anton@samba.org>
> >
> > Anton, Alan and Bill clearly know this stuff inside and out but can we get a
> > review from other PPC folks ?
> 
> LGTM.

Thanks, I have applied the entire series.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
