Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.arm.linux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1as4hl-0000TR-15
 for kexec@lists.infradead.org; Mon, 18 Apr 2016 08:38:50 +0000
Date: Mon, 18 Apr 2016 09:36:01 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/3] kexec: arrange for paddr_vmcoreinfo_note() to return
 phys_addr_t
Message-ID: <20160418083601.GY19428@n2100.arm.linux.org.uk>
References: <20160414195938.GV19428@n2100.arm.linux.org.uk>
 <E1aqnQy-0001U9-SR@rmk-PC.arm.linux.org.uk>
 <20160418053820.GC3602@x1.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160418053820.GC3602@x1.redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org

On Mon, Apr 18, 2016 at 01:38:20PM +0800, Baoquan He wrote:
> On 04/14/16 at 09:00pm, Russell King wrote:
> > On PAE systems (eg, ARM LPAE) the vmcore note may be located above
> > 4GB physical on 32-bit architectures, so we need a wider type than
> > "unsigned long" here.  Arrange for paddr_vmcoreinfo_note() to return
> > a phys_addr_t, thereby allowing it to be located above 4GB.
> 
> At first glance, it sounds great. But I can't imagine a scenario where
> on pae system kernel can be located above 4G. As far as I know i386 and
> its pae can't do this because the current linux VM implementation can't
> allow that. I am not familiar with arm system. So please correct me if
> I was wrong.

You are wrong.  That's precisely why this patch exists.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
