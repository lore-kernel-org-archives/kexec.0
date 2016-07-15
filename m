Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bNyp0-0001gX-DT
 for kexec@lists.infradead.org; Fri, 15 Jul 2016 08:50:11 +0000
Date: Fri, 15 Jul 2016 09:49:25 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Message-ID: <20160715084925.GD1041@n2100.armlinux.org.uk>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <5352106.oQ0Ff9gWJA@wuerfel> <20160713094127.GC14522@leverpostej>
 <7352796.seiSnHrYPy@wuerfel>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7352796.seiSnHrYPy@wuerfel>
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>, bhe@redhat.com, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, "Eric W. Biederman" <ebiederm@xmission.com>, bauerman@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>, linux-arm-kernel@lists.infradead.org

On Wed, Jul 13, 2016 at 03:13:42PM +0200, Arnd Bergmann wrote:
> On Wednesday, July 13, 2016 10:41:28 AM CEST Mark Rutland wrote:
> > The big question is whether this is a realistic case on a secure boot
> > system.
> 
> What does x86 do here? I assume changes to the command line are also
> limited.

They aren't.  You can specify /anything/ even with a fully-signed kernel
and initrd, which was one of the things I pointed out in my previous
set of responses.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
