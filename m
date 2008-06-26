Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aun.it.uu.se ([130.238.12.36])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBnWQ-0002FS-62
	for kexec@lists.infradead.org; Thu, 26 Jun 2008 09:12:08 +0000
MIME-Version: 1.0
Message-ID: <18531.23894.572847.322265@harpo.it.uu.se>
Date: Thu, 26 Jun 2008 11:11:50 +0200
From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 1/2] Add /sys/firmware/memmap
In-Reply-To: <20080626104524.2d7ed1ab@halley.suse.de>
References: <1214423826-12628-1-git-send-email-bwalle@suse.de>
	<1214423826-12628-2-git-send-email-bwalle@suse.de>
	<20080625224301.GE32344@redhat.com>
	<18531.20387.111875.576837@harpo.it.uu.se>
	<20080626104524.2d7ed1ab@halley.suse.de>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: Mikael Pettersson <mikpe@it.uu.se>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, yhlu.kernel@gmail.com, Vivek Goyal <vgoyal@redhat.com>

Bernhard Walle writes:
 > > It should be configurable. Whether it's done via CONFIG_KEXEC or its own
 > > option I don't care.
 > 
 > Ok, changed:
 > 
 > diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
 > index 1008737..73fcc59 100644
 > --- a/drivers/firmware/Kconfig
 > +++ b/drivers/firmware/Kconfig
 > @@ -28,7 +28,7 @@ config EDD_OFF
 >  
 >  config FIRMWARE_MEMMAP
 >      def_bool y
 > -    depends on X86_64 || X86_32
 > +    depends on (X86_64 || X86_32) && KEXEC
 >  
 >  config EFI_VARS
 >         tristate "EFI Variable Support via sysfs"

Yep, thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
