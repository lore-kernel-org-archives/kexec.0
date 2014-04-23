Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wckq5-00035J-2B
 for kexec@lists.infradead.org; Wed, 23 Apr 2014 00:15:01 +0000
Date: Wed, 23 Apr 2014 09:14:33 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v7 0/9] kexec-tools, x86: E820 memmap pass for kdump
Message-ID: <20140423001433.GA5738@verge.net.au>
References: <1398135407-30142-1-git-send-email-chaowang@redhat.com>
 <20140422043751.GD4564@dhcp-17-89.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140422043751.GD4564@dhcp-17-89.nay.redhat.com>
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
To: WANG Chao <chaowang@redhat.com>
Cc: kexec@lists.infradead.org, linn@hp.com, hpa@zytor.com, dyoung@redhat.com, trenn@suse.de, vgoyal@redhat.com

On Tue, Apr 22, 2014 at 12:37:51PM +0800, WANG Chao wrote:
> On 04/22/14 at 10:56am, WANG Chao wrote:
> > Hi, All
> > 
> > This patchset enables passing memory map via E820 map on x86 platform instead
> > of memmap=exactmap. It's a better design and will solve the following problem
> > so far:
> > 
> > - kernel cmdline is limited resource and large machines tend to have many
> >     memory ranges that may excceed kernel cmdline limit size.
> > - kASLR doesn't work with memmap=exactmap, because kASLR happens early than
> >     user defined memmap=exactmap takes effect.
> > 
> > Unfortunately, saved_max_pfn still got its user out there (calgry pci, it looks
> > like the only one). So for backward compatibility, I'm introducing a new option
> > --pass-memmap-cmdline to force kexec-tools to pass memmap=exactmap, the old way.
> > 
> > This patchset contains massive updates from the previous one. I take some
> > suggestions from reviewers. I try to split the changes into smaller pieces and
> > keep the whole change as minimal as I can so it wouldn't be too harsh to review
> > the patch.
> > 
> > Any comment is appreciate!
> > 
> > v7->v6:
> > dyoung/Simon:
> >  - more description for CRASH_MAX_MEMMAP_NR to be 1024
> 
> Hi, Simon
> 
> I've changed 5/9 regarding Dave's comment and yours. Could you please
> pick up this patchset if there's no more problem?

Thanks for all the hard work. I have applied the entire series.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
