Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YG2EX-0004j7-9x
 for kexec@lists.infradead.org; Tue, 27 Jan 2015 09:14:54 +0000
Date: Tue, 27 Jan 2015 10:14:28 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [RFD] efi assisted kdump
Message-ID: <20150127101428.75a736bb@hananiah.suse.cz>
In-Reply-To: <20150127062141.GC2506@darkstar.redhat.com>
References: <20150124132637.GB2139@darkstar.redhat.com>
 <20150124170344.3b06a23e@hananiah.suse.cz>
 <20150127062141.GC2506@darkstar.redhat.com>
MIME-Version: 1.0
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org

On Tue, 27 Jan 2015 14:21:41 +0800
Dave Young <dyoung@redhat.com> wrote:

> Hi, Petr
> 
> On 01/24/15 at 05:03pm, Petr Tesarik wrote:
> > On Sat, 24 Jan 2015 21:26:37 +0800
> > Dave Young <dyoung@redhat.com> wrote:
> > 
> > > Hi,
> > > 
> > > Kdump has several limitations currently such as kdump kernel reboot will bypass
> > > device shutdown path so device drivers should reset during initialization.
> > > 
> > >[...]
> > > 
> > > ppc64 has a feature "firmware assisted kdump", see below documentation:
> > > Documentation/powerpc/firmware-assisted-dump.txt
> > 
> > Hi Dave,
> > 
> > while I'm no expert on either UEFI or IBM POWER, I'd like to warn you
> > that fadump (firmware-assisted dump) on PPC is not quite optimal in its
> > current form. One of the things that have always irritated me are
> > excessive RAM requirements.
> > 
> > The problem is that there is only one reboot in fadump - after saving
> > the dump, the secondary kernel discards the saved area and continues
> > booting as usual. However, many kernel structuers must be already
> > allocated at that point, e.g. the memmap array(s), but they are sized
> > by the total RAM, not the limited amount available to the 2nd kernel.
> 
> Thanks for the comment.
> 
> I'm not sure I understand the RAM requirements you mentioned. I think you
> are worrying about freeing oldmem to be used by 2nd kernel.
> 
> But we do not need to do same as power we can just reboot another time
> as long as vmcore is saved. The main advantage is the capture kernel can
> boot with all devices being reset. 

Yes, that's true. If you're fine with rebooting the machine twice (once
for the dump-taking and once for bringing up the normal system), then
there's no concern. The IBM folks apparently wanted to save some
downtime associated with going through the boot-up sequence. In fact,
you could kexec back into the normal system instead of rebooting, if
kexec can be used.

All I wanted to say is that fadump has its own issues, and we'd better
not repeat them with UEFI-based dumps. ;-)

Petr Tesarik

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
