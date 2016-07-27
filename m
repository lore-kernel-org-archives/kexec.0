Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bSYDJ-0006Pr-6D
 for kexec@lists.infradead.org; Wed, 27 Jul 2016 23:26:10 +0000
Date: Thu, 28 Jul 2016 00:23:31 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 1/4] kexec: (bugfix) calc correct end address of
 memory ranges in device tree
Message-ID: <20160727232331.GY1041@n2100.armlinux.org.uk>
References: <cover.1468970114.git.geoff@infradead.org>
 <c4af21ba365767f88a2516719dd0f3b70777b549.1468970114.git.geoff@infradead.org>
 <3562841.ROYbCgkeeq@hactar>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3562841.ROYbCgkeeq@hactar>
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Pratyush Anand <panand@redhat.com>, Geoff Levand <geoff@infradead.org>, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, Simon Horman <horms@verge.net.au>, linux-arm-kernel@lists.infradead.org

On Wed, Jul 27, 2016 at 07:45:13PM -0300, Thiago Jung Bauermann wrote:
> Hello,
> 
> Am Dienstag, 19 Juli 2016, 23:28:13 schrieb Geoff Levand:
> > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > 
> > The end address of "reg" attribute in device tree's memory should be
> > inclusive.
> 
> Actually, there's a bug/inconsistency in kexec-tools right now.
> 
> crashdump-arm.c expect usablemem_rgns.ranges[i].end to be the last byte in 
> the range, but crashdump-powerpc.c, crashdump-ppc64.c and fs2dt.c expect it 
> to be the first byte after the range.

Well, ARM (and the generic code I introduced for mem_ranges) follows
what i386, ia64, mips, s390, and sh all do with struct memory_range
when used for crashdump.

It is extremely bad for a project to have a single structure used
inconsistently like this - even with generic helpers, you can't be
sure that the right helpers are used on the right structures, and
it will lead to off-by-one errors all over the place.  Just don't
pull crap like this, it's asking for trouble - settle on one way
and stick to it.

Given that the majority of architectures treat .end as inclusive, I
think ppc* and fs2dt need to conform to the convention establised by
the other architectures for this structure.

It's also interesting to note that crashdump-powerpc has this:

        /* On powerpc memory ranges in device-tree is denoted as start
         * and size rather than start and end, as is the case with
         * other architectures like i386 . Because of this when loading
         * the memory ranges in crashdump-elf.c the filesz calculation
         * [ end - start + 1 ] goes for a toss.
         *
         * To be in sync with other archs adjust the end value for
         * every crash memory range before calling the generic function
         */

        for (i = 0; i < nr_ranges; i++) {
                end = crash_memory_range[i].end - 1;
                crash_memory_range[i].end = end;
        }

to convert from powerpc end-exclusive to end-inclusive mode -
something that could be killed if it were to conform throughout
to the established convention.  Same goes for ppc64 too:

        /* On ppc64 memory ranges in device-tree is denoted as start
         * and size rather than start and end, as is the case with
         * other architectures like i386 . Because of this when loading
         * the memory ranges in crashdump-elf.c the filesz calculation
         * [ end - start + 1 ] goes for a toss.
         *
         * To be in sync with other archs adjust the end value for
         * every crash memory range before calling the generic function
         */

        for (i = 0; i < nr_ranges; i++) {
                end = crash_memory_range[i].end - 1;
                crash_memory_range[i].end = end;
        }

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
