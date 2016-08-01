Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bU58S-0007bQ-SF
 for kexec@lists.infradead.org; Mon, 01 Aug 2016 04:47:30 +0000
Received: by mail-pf0-x22a.google.com with SMTP id x72so51176718pfd.2
 for <kexec@lists.infradead.org>; Sun, 31 Jul 2016 21:47:08 -0700 (PDT)
Date: Mon, 1 Aug 2016 13:52:41 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v1 1/4] kexec: (bugfix) calc correct end address of
 memory ranges in device tree
Message-ID: <20160801045240.GD7995@linaro.org>
References: <cover.1468970114.git.geoff@infradead.org>
 <3562841.ROYbCgkeeq@hactar>
 <20160727232331.GY1041@n2100.armlinux.org.uk>
 <1860371.lT9GInp2C3@hactar>
 <20160729082714.GA1041@n2100.armlinux.org.uk>
 <1469812346.16559.40.camel@infradead.org>
 <20160729172356.GD1041@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160729172356.GD1041@n2100.armlinux.org.uk>
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
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Pratyush Anand <panand@redhat.com>, Geoff Levand <geoff@infradead.org>, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, linux-arm-kernel@lists.infradead.org

On Fri, Jul 29, 2016 at 06:23:56PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 29, 2016 at 10:12:26AM -0700, Geoff Levand wrote:
> > On Fri, 2016-07-29 at 09:27 +0100, Russell King - ARM Linux wrote:
> > 
> > > So, these functions are a mess and need fixing.
> > 
> > Since this change isn't really related to arm64 support, I'll
> > drop this patch from my series.
> 
> Do you have a case which triggers bugs in this code?

Actually, this patch was necessary when my kdump used "usable-memory"
properties in "memory" nodes, as on ppc64, to limit the usable memory
regions that can be used by crash dump kernel.
Since then, I've moved to the approach of using "mem=" kernel parameter,
then introducing a new property, "linux,usable-memory-range," under /chosen
and now we don't need this patch any more.

So, we can drop it but I still believe that it is buggy.

Thanks,
-Takahiro AKASHI

> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
