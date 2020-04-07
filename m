Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 7 Apr 2020 11:01:00 +0100
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: Trying to kexec on Allwinner A80
Message-ID: <20200407100100.GJ25745@shell.armlinux.org.uk>
References: <20200406082720.GA31279@Red>
 <20200406091600.GF25745@shell.armlinux.org.uk>
 <20200406092540.GB31279@Red>
 <20200406093729.GG25745@shell.armlinux.org.uk>
 <20200406201053.GA10931@Red>
 <20200407073117.GH25745@shell.armlinux.org.uk>
 <20200407080144.GA20773@Red>
 <20200407081257.GI25745@shell.armlinux.org.uk>
 <20200407093253.GA4630@Red>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200407093253.GA4630@Red>
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
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mripard@kernel.org, wens@csie.org, ebiederm@xmission.com, linux-arm-kernel@lists.infradead.org

On Tue, Apr 07, 2020 at 11:32:53AM +0200, Corentin Labbe wrote:
> On Tue, Apr 07, 2020 at 09:12:57AM +0100, Russell King - ARM Linux admin wrote:
> > That was not reflected in the command lines given to kexec that you
> > quoted previously, so I'm now wondering if you're giving me the full
> > information.
> > 
> > In any case, based on the information you've supplied thus far, I have
> > no further suggetsions to make.
> > 
> 
> Sorry I have added --debug after my initial mail.
> But I am surprised that no debug output like "MEMORY RANGES" is done (like I got in my first try).
> I have started to patch kexec-tools to check it, and debug is enabled.
> Furthermore, I got in locate_hole:237 memory_ranges=0.
> So the memory region in struct kexec_info is not initialized (and so cannot be printed)

The memory region information is initialised by get_memory_ranges()
in kexec/arch/arm/kexec-arm.c, which reads /proc/iomem.

That is called from my_load(), which checks that info.memory_ranges
is non-zero.  If it's zero, it errors out with "Could not get memory
layout".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
