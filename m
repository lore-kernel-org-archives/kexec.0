Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1md8Q3-00469i-9N
 for kexec@lists.infradead.org; Wed, 20 Oct 2021 10:02:00 +0000
Date: Wed, 20 Oct 2021 12:01:51 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: multiboot2: Correct BASIC_MEMINFO memory
 units
Message-ID: <20211020100151.GA19898@vergenet.net>
References: <20210924170327.6775-1-dinhngoc.tu@irit.fr>
 <20211005081832.GA23961@vergenet.net>
 <001601d7b9c9$4c8be2c0$e5a3a840$@irit.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <001601d7b9c9$4c8be2c0$e5a3a840$@irit.fr>
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
To: dinhngoc.tu@irit.fr
Cc: kexec@lists.infradead.org

On Tue, Oct 05, 2021 at 11:13:45AM +0200, dinhngoc.tu@irit.fr wrote:
> > Thanks,
> > 
> > I'm curious to know how the current code could have worked.
> > Do we have some testing to verify this change?
> 
> Hi,
> 
> The current code is not actually used very often when loading Xen (which is
> one of the few things that actually support Multiboot2), as Xen uses the
> EBDA instead of the MB2 memory information on the MB2 boot path.
> However this blows up on EFI systems without CSM (as EBDA is no longer
> available).
> 
> I tested the loading of KVM->Xen and Xen->Xen with this patch and a patched
> version of Xen that trusts the MB2 information, on a laptop and a server.
> 
> The Multiboot2 documentation at
> https://www.gnu.org/software/grub/manual/multiboot2/multiboot.html#Basic-mem
> ory-information also supports the change.

Thanks, and sorry for the delay.

Applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
