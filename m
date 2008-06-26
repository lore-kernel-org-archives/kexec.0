Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aun.it.uu.se ([130.238.12.36])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBn4H-0000YJ-CF
	for kexec@lists.infradead.org; Thu, 26 Jun 2008 08:43:01 +0000
MIME-Version: 1.0
Message-ID: <18531.20387.111875.576837@harpo.it.uu.se>
Date: Thu, 26 Jun 2008 10:13:23 +0200
From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 1/2] Add /sys/firmware/memmap
In-Reply-To: <20080625224301.GE32344@redhat.com>
References: <1214423826-12628-1-git-send-email-bwalle@suse.de>
	<1214423826-12628-2-git-send-email-bwalle@suse.de>
	<20080625224301.GE32344@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Bernhard Walle <bwalle@suse.de>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, yhlu.kernel@gmail.com

Vivek Goyal writes:
 > On Wed, Jun 25, 2008 at 09:57:05PM +0200, Bernhard Walle wrote:
 > > This patch adds /sys/firmware/memmap interface that represents the BIOS
 > > (or Firmware) provided memory map. The tree looks like:
 > > 
 > >     /sys/firmware/memmap/0/start   (hex number)
 > >                            end     (hex number)
 > >                            type    (string)
 > >     ...                 /1/start
 > >                            end
 > >                            type
 > > 
 > > With the following shell snippet one can print the memory map in the same form
 > > the kernel prints itself when booting on x86 (the E820 map).
 > > 
 > >   --------- 8< --------------------------
 > >     #!/bin/sh
 > >     cd /sys/firmware/memmap
 > >     for dir in * ; do
 > >         start=$(cat $dir/start)
 > >         end=$(cat $dir/end)
 > >         type=$(cat $dir/type)
 > >         printf "%016x-%016x (%s)\n" $start $[ $end +1] "$type"
 > >     done
 > >   --------- >8 --------------------------
 > > 
 > > That patch only provides the needed interface:
 > > 
 > >  1. The sysfs interface.
 > >  2. The structure and enumeration definition.
 > >  3. The function firmware_map_add() and firmware_map_add_early()
 > >     that should be called from architecture code (E820/EFI, for
 > >     example) to add the contents to the interface.
 > > 
 > > If the kernel is compiled without CONFIG_FIRMWARE_MEMMAP, the interface does
 > > nothing without cluttering the architecture-specific code with #ifdef's.
 > > 
 > 
 > Hi Bernhard,
 > 
 > Thanks for the patch. Couple of thoughts.
 > 
 > Do we really need another CONFIG option (CONFIG_FIRMWARE_MEMMAP)? To,
 > me this does not seem to be a big chunk of code

It should be configurable. Whether it's done via CONFIG_KEXEC or its own
option I don't care.

 > at the same time I am
 > assuming that most of the people will use it (because of kexec). So
 > probably, it might not make lot of sense to put additional CONFIG option.

I question that assumption. Even if (and that's a big if) "most"
people use kexec (I don't), Linux is not about forcing unwanted
stuff down peoples' throats, we allow knowledgeable users to tune
their kernels.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
