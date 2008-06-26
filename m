Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KBqoY-0003ha-L4
	for kexec@lists.infradead.org; Thu, 26 Jun 2008 12:43:02 +0000
Date: Thu, 26 Jun 2008 08:42:04 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 1/2] Add /sys/firmware/memmap
Message-ID: <20080626124204.GB3878@redhat.com>
References: <1214423826-12628-1-git-send-email-bwalle@suse.de>
	<1214423826-12628-2-git-send-email-bwalle@suse.de>
	<20080625224301.GE32344@redhat.com>
	<18531.20387.111875.576837@harpo.it.uu.se>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <18531.20387.111875.576837@harpo.it.uu.se>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Bernhard Walle <bwalle@suse.de>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, yhlu.kernel@gmail.com

On Thu, Jun 26, 2008 at 10:13:23AM +0200, Mikael Pettersson wrote:
> Vivek Goyal writes:
>  > On Wed, Jun 25, 2008 at 09:57:05PM +0200, Bernhard Walle wrote:
>  > > This patch adds /sys/firmware/memmap interface that represents the BIOS
>  > > (or Firmware) provided memory map. The tree looks like:
>  > > 
>  > >     /sys/firmware/memmap/0/start   (hex number)
>  > >                            end     (hex number)
>  > >                            type    (string)
>  > >     ...                 /1/start
>  > >                            end
>  > >                            type
>  > > 
>  > > With the following shell snippet one can print the memory map in the same form
>  > > the kernel prints itself when booting on x86 (the E820 map).
>  > > 
>  > >   --------- 8< --------------------------
>  > >     #!/bin/sh
>  > >     cd /sys/firmware/memmap
>  > >     for dir in * ; do
>  > >         start=$(cat $dir/start)
>  > >         end=$(cat $dir/end)
>  > >         type=$(cat $dir/type)
>  > >         printf "%016x-%016x (%s)\n" $start $[ $end +1] "$type"
>  > >     done
>  > >   --------- >8 --------------------------
>  > > 
>  > > That patch only provides the needed interface:
>  > > 
>  > >  1. The sysfs interface.
>  > >  2. The structure and enumeration definition.
>  > >  3. The function firmware_map_add() and firmware_map_add_early()
>  > >     that should be called from architecture code (E820/EFI, for
>  > >     example) to add the contents to the interface.
>  > > 
>  > > If the kernel is compiled without CONFIG_FIRMWARE_MEMMAP, the interface does
>  > > nothing without cluttering the architecture-specific code with #ifdef's.
>  > > 
>  > 
>  > Hi Bernhard,
>  > 
>  > Thanks for the patch. Couple of thoughts.
>  > 
>  > Do we really need another CONFIG option (CONFIG_FIRMWARE_MEMMAP)? To,
>  > me this does not seem to be a big chunk of code
> 
> It should be configurable. Whether it's done via CONFIG_KEXEC or its own
> option I don't care.
> 

That's fine. I am just curious how does one decide whether a particular
functionality should have a separate CONFIG option or not.

I thought if a functionality is sufficiently big/significant (in terms of code
and in terms of memory allocation etc), then it is a good idea to put it
under a CONFIG option, in case people want to compile it out. 

Just that looking at the patch, personally, I don't think that it makes
lot of sense to create a separate CONFIG option for this patch. 

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
