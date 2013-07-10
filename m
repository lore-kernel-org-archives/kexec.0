Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from www84.your-server.de ([213.133.104.84])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UwrC9-0007Gh-J0
 for kexec@lists.infradead.org; Wed, 10 Jul 2013 10:00:21 +0000
Message-ID: <1373450412.1016.3.camel@wall-e>
Subject: Re: BUG: 32 Bit Kernel kexec hangs on P2020
From: Stefani Seibold <stefani@seibold.net>
Date: Wed, 10 Jul 2013 12:00:12 +0200
In-Reply-To: <51DD1FC7.6080203@windriver.com>
References: <1373445543.348.5.camel@wall-e> <51DD1FC7.6080203@windriver.com>
Mime-Version: 1.0
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
To: "tiejun.chen" <tiejun.chen@windriver.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, kexec@lists.infradead.org

Am Mittwoch, den 10.07.2013, 16:48 +0800 schrieb tiejun.chen:
> On 07/10/2013 04:39 PM, Stefani Seibold wrote:
> > Hi,
> >
> > i have tried to kexec a 32 bit kernel on a Freescale P2020 dual core CPU
> > (e500v2, revison 5.1 - pvr 8021 1051), but Kexec will hang after the
> > "Bye!".
> >
> > The host and the kexec kernel are the same, based on the current kernel
> > version 3.10.
> >
> > I have tried it with kexec-tools 2.0.4.git released 30 June 2013.
> >
> > Invoking kexec with
> >
> > kexec --command-line "1 maxcpus=1 noirqdistrib reset_devices $(cat /proc/cmdline)" -t elf-ppc --dtb=rs2020.dtb \
> > --reuse-node="/cpus/PowerPC,P2020@0/timebase-frequency" \
> > --reuse-node="/cpus/PowerPC,P2020@0/bus-frequency" \
> > --reuse-node="/cpus/PowerPC,P2020@0/clock-frequency" \
> > --reuse-node="/cpus/PowerPC,P2020@0/next-level-cache" \
> > --reuse-node="/cpus/PowerPC,P2020@1/timebase-frequency" \
> > --reuse-node="/cpus/PowerPC,P2020@1/bus-frequency" \
> > --reuse-node="/cpus/PowerPC,P2020@1/clock-frequency" \
> > --reuse-node="/cpus/PowerPC,P2020@1/next-level-cache" \
> > --reuse-node="/cpus/PowerPC,P2020@1/cpu-release-addr" \
> > --reuse-node="/cpus/PowerPC,P2020@1/enable-method" \
> > --reuse-node="/soc@ffe00000/bus-frequency" \
> > --reuse-node="/soc@ffe00000/serial@4500/clock-frequency" \
> > --reuse-node="/soc@ffe00000/ethernet@24000/local-mac-address" \
> > -d -l -x vmlinux
> > kexec -e
> 
> Could you try again with one simple command like,
> 
> kexec -l vmlinux --append="`cat /proc/cmdline`";kexec -e
> 

Great, this works.

I did more test and the issue for the fail is the passing of the device
tree. But the device tree is exact the same as the previous used one.

Is passing a new device tree not allowed?

Stefani



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
