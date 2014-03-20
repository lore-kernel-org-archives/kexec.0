Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WQek2-0004oX-1I
 for kexec@lists.infradead.org; Thu, 20 Mar 2014 15:18:47 +0000
Date: Thu, 20 Mar 2014 11:18:22 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2] x86, kaslr: Kernel base can be randomized at 0-1G
 offset.
Message-ID: <20140320151822.GA29549@redhat.com>
References: <20140319133331.GB21530@redhat.com>
 <20140320054608.GA25772@dhcp-17-89.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140320054608.GA25772@dhcp-17-89.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: WANG Chao <chaowang@redhat.com>
Cc: dyoung@redhat.com, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, ebiederm@xmission.com

On Thu, Mar 20, 2014 at 01:46:08PM +0800, WANG Chao wrote:
> [CC Simon]
> 
> On 03/19/14 at 09:33am, Vivek Goyal wrote:
> > On Wed, Mar 19, 2014 at 03:05:51PM +0800, WANG Chao wrote:
> > > On 03/17/14 at 08:56am, Vivek Goyal wrote:
> > > > On Fri, Mar 14, 2014 at 04:20:18PM +0800, WANG Chao wrote:
> > > > > With kASLR enabled (CONFIG_RANDOMIZED_BASE=y), kernel virtual address
> > > > > base is PAGE_OFFSET plus a randomized offset from 0 to 1G.
> > > > > 
> > > > > Current kexec-tools gets kernel vaddr and size from /proc/kcore. It
> > > > > assumes kernel vaddr start/end is within the range [0,512M). If kaslr
> > > > > enabled, kernel vaddr start/end will stay at [0+offset, 512M+offset).
> > > 
> > > NACK this patch myself.
> > > 
> > > There are several mistakes I made. I misunderstood some concepts. Then I
> > > realize this kASLR issue is not trivial to fix.
> > > 
> > > I think if kexec-tools needs to get kernel text mapping from kcore in
> > > kALSR case, the max base offset (CONFIG_RANDOMIZE_MAX_BASE_OFFSET) of
> > > the kernel text area must be exposed to userspace some where. We can use
> > > that value to determine which area is for kernel text mapping and which
> > > is for modules text mapping.
> > 
> > How about looking at /proc/kallsyms and look at address of one of the
> > symbols say _text. And search for the ELF header in kcore which contains
> > _text address and that's ELF header representing kernel text mapping.
> 
> Cool. I'd like to go with _stext. _text presents in /proc/kallsyms only
> when CONFIG_KALLSYMS_ALL=y. What do you think?

That's fine. Though looks like _stext will also work only if
CONFIG_KALLSYMS=y.  So that's not a perfect solution either for those
who have built kernel using CONFIG_KALLSYMS=n.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
