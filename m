Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bN62r-00075L-Sn
 for kexec@lists.infradead.org; Tue, 12 Jul 2016 22:20:50 +0000
Date: Tue, 12 Jul 2016 23:18:05 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Message-ID: <20160712221804.GV1041@n2100.armlinux.org.uk>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <87furf7ztv.fsf@x220.int.ebiederm.org> <50662781.Utjsnse3nb@hactar>
 <20160712225805.0d27fe5d@hananiah.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160712225805.0d27fe5d@hananiah.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: linux-arm-kernel@lists.infradead.org, bhe@redhat.com, arnd@arndb.de, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, dyoung@redhat.com, vgoyal@redhat.com

On Tue, Jul 12, 2016 at 10:58:05PM +0200, Petr Tesarik wrote:
> I'm not an expert on DTB, so I can't provide an example of code
> execution, but you have already mentioned the /chosen/linux,stdout-path
> property. If an attacker redirects the bootloader to an insecure
> console, they may get access to the system that would otherwise be
> impossible.

I fail to see how kexec connects with the boot loader - the DTB image
that's being talked about is one which is passed from the currently
running kernel to the to-be-kexec'd kernel.  For ARM (and I suspect
also ARM64) that's a direct call chain which doesn't involve any
boot loader or firmware, and certainly none that would involve the
passed DTB image.

However, your point is valid as an attacker can redirect the console
and/or mounted root on the to-be-kexec'd kernel if they can modify
the DTB - and there's a whole host of subtle ways to do that, not
necessarily just modification of the kernel command line.

> In general, tampering with the hardware inventory of a machine opens up
> a security hole, and one must be very cautious which modifications are
> allowed. You're giving this power to an (unsigned, hence untrusted)
> userspace application; Eric argues that only the kernel should have
> this power.

Given that, how does crashdump work in this scenario?

crashdump works by adding an elfcorehdr=address argument to the
crash-booted kernel's command line.  If you can add to the kernel
command line, you can redirect the console and do all sorts of
other stuff like specifying a different filesystem to mount, etc.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
