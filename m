Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WYRmi-00036d-U4
 for kexec@lists.infradead.org; Fri, 11 Apr 2014 03:05:45 +0000
Date: Fri, 11 Apr 2014 11:05:19 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH v5 00/10] kexec-tools, x86: E820 memmap pass for kdump
Message-ID: <20140411030519.GF2944@dhcp-17-89.nay.redhat.com>
References: <1397121186-9353-1-git-send-email-chaowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397121186-9353-1-git-send-email-chaowang@redhat.com>
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
To: horms@verge.net.au, vgoyal@redhat.com, ebiederm@xmission.com, hpa@zytor.com, trenn@suse.de, dyoung@redhat.com, linn@hp.com
Cc: kexec@lists.infradead.org

On 04/10/14 at 05:12pm, WANG Chao wrote:
> Hi, all
> 
> (Sorry for this late update. I was occupied with something else)
> 
> This patchset enables passing memory map via E820 map on x86 platform instead
> of memmap=exactmap. It's a better design and will solve the following problem
> so far:
> 
> - kernel cmdline is limited resource and large machines tend to have many
>   memory ranges that may excceed kernel cmdline limit size.
> - kASLR doesn't work with memmap=exactmap, because kASLR happens early than
>   user defined memmap=exactmap takes effect.
> 
> Unfortunately, saved_max_pfn still got its user out there (calgry pci, it looks
> like the only one). So for backward compatibility, I'm introducing a new option
> --pass-memmap-cmdline to force kexec-tools to pass memmap=exactmap, the old way.
> 
> This patchset contains massive updates from the previous one. I take some
> suggestions from reviewers. I try to split the changes into smaller pieces and
> keep the whole change as minimal as I can so it wouldn't be too harsh to review
> the patch.

I messed up this patchset and ended up with some duplicated patches :(

Please ignore this patchset and take a look at the other series I just
sent out with "RESEND" suject prefix.

Thanks
WANG Chao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
