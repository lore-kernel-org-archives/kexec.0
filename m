Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WcSTM-0004FO-19
 for kexec@lists.infradead.org; Tue, 22 Apr 2014 04:38:21 +0000
Date: Tue, 22 Apr 2014 12:37:51 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH v7 0/9] kexec-tools, x86: E820 memmap pass for kdump
Message-ID: <20140422043751.GD4564@dhcp-17-89.nay.redhat.com>
References: <1398135407-30142-1-git-send-email-chaowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1398135407-30142-1-git-send-email-chaowang@redhat.com>
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
To: horms@verge.net.au, dyoung@redhat.com, linn@hp.com, vgoyal@redhat.com, hpa@zytor.com, trenn@suse.de
Cc: kexec@lists.infradead.org

On 04/22/14 at 10:56am, WANG Chao wrote:
> Hi, All
> 
> This patchset enables passing memory map via E820 map on x86 platform instead
> of memmap=exactmap. It's a better design and will solve the following problem
> so far:
> 
> - kernel cmdline is limited resource and large machines tend to have many
>     memory ranges that may excceed kernel cmdline limit size.
> - kASLR doesn't work with memmap=exactmap, because kASLR happens early than
>     user defined memmap=exactmap takes effect.
> 
> Unfortunately, saved_max_pfn still got its user out there (calgry pci, it looks
> like the only one). So for backward compatibility, I'm introducing a new option
> --pass-memmap-cmdline to force kexec-tools to pass memmap=exactmap, the old way.
> 
> This patchset contains massive updates from the previous one. I take some
> suggestions from reviewers. I try to split the changes into smaller pieces and
> keep the whole change as minimal as I can so it wouldn't be too harsh to review
> the patch.
> 
> Any comment is appreciate!
> 
> v7->v6:
> dyoung/Simon:
>  - more description for CRASH_MAX_MEMMAP_NR to be 1024

Hi, Simon

I've changed 5/9 regarding Dave's comment and yours. Could you please
pick up this patchset if there's no more problem?

Thanks
WANG Chao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
