Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b6JRF-0006Cx-V5
 for kexec@lists.infradead.org; Fri, 27 May 2016 15:12:39 +0000
Date: Fri, 27 May 2016 16:12:08 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH kexec-tools 12/32] kexec: add helper to exlude a region
 from a set of memory ranges
Message-ID: <20160527151208.GO19428@n2100.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXSv-0004i3-Gi@e0050434b2927.dyn.arm.linux.org.uk>
 <CAHB_Guo_ozXhAnkGk_NrdBME2fSYDoKTHwu3kLBvsrmbwxOdww@mail.gmail.com>
 <20160526085638.GF19428@n2100.arm.linux.org.uk>
 <CAHB_GuoRuQwhe-bXKAzmjOn=3=7KQ7LtT2JTooO1kjx+V3VgpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHB_GuoRuQwhe-bXKAzmjOn=3=7KQ7LtT2JTooO1kjx+V3VgpQ@mail.gmail.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Fri, May 27, 2016 at 08:37:41PM +0530, Pratyush Anand wrote:
> On Thu, May 26, 2016 at 2:26 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > -                               new = ranges->ranges + ranges->size++;
> > -                               new->start = range->end + 1;
> > -                               new->end = r->end;
> > +                               ret = mem_regions_add(ranges, range->end + 1,
> > +                                                     r->end, 0);
> 
> 3rd argument should be (r->end - range->end)

Yes indeed, thanks for pointing that out.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
