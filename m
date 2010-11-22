Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
References: <1290161310-22808-1-git-send-email-per.xx.fransson@stericsson.com>
	<20101122072420.GC14080@gw.healthdatacare.com>
	<AANLkTikJiXFG_kGV4=wTKOzViy-h9VtGRHKVBuh76fE2@mail.gmail.com>
	<20101122104740.GA30744@n2100.arm.linux.org.uk>
	<20101122112759.GA31227@n2100.arm.linux.org.uk>
	<9d90879f08b3141aa5ce4a0887018de9@mail.gmail.com>
	<20101122142101.GL31227@n2100.arm.linux.org.uk>
MIME-Version: 1.0
In-Reply-To: <20101122142101.GL31227@n2100.arm.linux.org.uk>
Date: Mon, 22 Nov 2010 22:55:46 +0530
Message-ID: <bdbc2959fe609090afc0fb6d656e36de@mail.gmail.com>
Subject: RE: [PATCH] Add call to non-crashing cores through IPI
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Per Fransson <per.fransson.ml@gmail.com>, Mika Westerberg <mika.westerberg@iki.fi>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Monday, November 22, 2010 7:51 PM
> To: Santosh Shilimkar
> Cc: Per Fransson; Mika Westerberg; kexec@lists.infradead.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH] Add call to non-crashing cores through IPI
>
> On Mon, Nov 22, 2010 at 06:37:09PM +0530, Santosh Shilimkar wrote:
> > > ARM: smp: make smp_send_stop() wait for secondary CPUs to stop
> > >
> > > Wait up to one second for secondary CPUs to respond to a request to
> > > stop.  This avoids the sender CPU continuing and possibly destroying
> > > state before the recipients have had a chance to respond to the
stop.
> > > However, if the recipients have crashed, we won't hang the sender
> > > CPU indefinitely.
> > >
> > Just tried this patch thinking it might fix the reboot issue
> > reported earlier. But it doesn't help.
>
> I was hoping that it might change the behaviour slightly, but if not
> the patch can't do any harm.
>
> The reboot stuff works fine on Versatile Express with Cortex A9, so
> I suspect your problem might be specific to OMAP.
Interesting.
I thought it's a common issue. Will have a look at it more
closely

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
