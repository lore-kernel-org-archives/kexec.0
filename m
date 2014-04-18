Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t3427.houston.hp.com ([15.201.208.55])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WbEun-0003jA-Fe
 for kexec@lists.infradead.org; Fri, 18 Apr 2014 19:57:37 +0000
Date: Fri, 18 Apr 2014 13:57:06 -0600
From: Linn Crosetto <linn@hp.com>
Subject: Re: [PATCH v6 0/9] kexec-tools, x86: E820 memmap pass for kdump
Message-ID: <20140418195706.GA32105@oranje.fc.hp.com>
References: <1397487341-17287-1-git-send-email-chaowang@redhat.com>
 <20140417062420.GB1849@dhcp-17-89.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140417062420.GB1849@dhcp-17-89.nay.redhat.com>
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
Cc: kexec@lists.infradead.org, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, dyoung@redhat.com, trenn@suse.de, vgoyal@redhat.com

On Thu, Apr 17, 2014 at 02:24:20PM +0800, WANG Chao wrote:
> On 04/14/14 at 10:55pm, WANG Chao wrote:
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
> 
> Hi, Linn
> 
> Thanks for testing the patch in the past. Do you have chance to test
> this update? 
> 
> This updated patchset changed too much and I want things to work as it's
> used to be on your prototype machine with large number of memory ranges.
> 
> Thanks in advance!
> WANG Chao

Tested the series on a system with 200+ entries in the map; both kexec and kdump
(with and without --pass-memmap-cmdline). Thanks for the patches.

Tested-by: Linn Crosetto <linn@hp.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
