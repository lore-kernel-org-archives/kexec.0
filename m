Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fhqpi-0007kf-0q
 for kexec@lists.infradead.org; Tue, 24 Jul 2018 06:30:08 +0000
Date: Tue, 24 Jul 2018 08:29:50 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: kexec support for plan9 on x86
Message-ID: <20180724062950.abqla2wqqny53ad7@verge.net.au>
References: <1AD2A76B46A10571107915DE89919D3B@felloff.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1AD2A76B46A10571107915DE89919D3B@felloff.net>
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
To: cinap_lenrek@felloff.net
Cc: kexec@lists.infradead.org

On Sat, Jul 21, 2018 at 06:46:42PM +0200, cinap_lenrek@felloff.net wrote:
> implemented support in kexec-tools to boot plan9 kernel last night
> (see attachment).
> 
> this is very basic support. it loads the kernel and provides it
> a memory map (from info->memory_range) in its config area and also
> has a optional parameter to pass additional plan9.ini configuration.
> 
> but i have a couple of questions:
> 
> who's in charge?

I am the maintainer of kexec-tools.

> is here interest in supporting other OS than linux such as plan9
> in the official kexec-tools? or should i write my own plan9 loader
> for linux using the kexec_load() syscall directly?

I think that if there is a good amount of code re-use and there
is an intention to keep the plan9 code maintained then it
is reasonable to include support in the current kexec-tools tree.

> on uefi systems, the address of the RSDT is passed to the kernel
> in the config area as theres no known region to search for it.
> this is done in 9front by the bootloader (as we do not want to
> call back into crappy uefi code from our kernel once virtual
> memory and interrups are set up). but i'v not seen any of the
> kexec modules implement such a thing. so where do i get that
> information from? how does linux locate the acpi tables?
> 
> on a uefi systems, theres no cga text mode. when linear
> framebuffer was already set up. we pass this information in
> the config area (done by efi loader using the GOP). but i havnt
> seen any kexec module to implement passing the framebuffer
> configuration to the new kernel. so where do i get that
> that information in linux? this is also needed for proper
> multiboot support.

Its been a long time since I worked on kexec in that depth -
it was on ia64. Perhaps others on the list have some more recent
experience that can help guide you.

> the 9front kernel supports multiboot specification, but your
> multiboot loader expects all multiboot images to be ELF files.
> as well. what are you THINKING? :-)

I'm not sure that I was involved in the project when that
design decision was made. But in general I would say that its
entirely reasonable to make enhancements so long as we can
be sure that existing boot-cases don't break.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
