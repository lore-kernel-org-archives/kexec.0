Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bTBWP-00075s-Oc
 for kexec@lists.infradead.org; Fri, 29 Jul 2016 17:24:30 +0000
Date: Fri, 29 Jul 2016 18:23:56 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 1/4] kexec: (bugfix) calc correct end address of
 memory ranges in device tree
Message-ID: <20160729172356.GD1041@n2100.armlinux.org.uk>
References: <cover.1468970114.git.geoff@infradead.org>
 <3562841.ROYbCgkeeq@hactar>
 <20160727232331.GY1041@n2100.armlinux.org.uk>
 <1860371.lT9GInp2C3@hactar>
 <20160729082714.GA1041@n2100.armlinux.org.uk>
 <1469812346.16559.40.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1469812346.16559.40.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Pratyush Anand <panand@redhat.com>, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, Simon Horman <horms@verge.net.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, linux-arm-kernel@lists.infradead.org

On Fri, Jul 29, 2016 at 10:12:26AM -0700, Geoff Levand wrote:
> On Fri, 2016-07-29 at 09:27 +0100, Russell King - ARM Linux wrote:
> 
> > So, these functions are a mess and need fixing.
> 
> Since this change isn't really related to arm64 support, I'll
> drop this patch from my series.

Do you have a case which triggers bugs in this code?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
