Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aMTVi-0002e8-1K
 for kexec@lists.infradead.org; Fri, 22 Jan 2016 04:39:48 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [RFC PATCH 0/4] purgatory: Add basic support for IPMI command
 execution
Date: Fri, 22 Jan 2016 04:39:18 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454AA932B@GSjpTKYDCembx31.service.hitachi.net>
References: <20160120103734.4234.64015.stgit@softrs> <56A0FB5E.5080606@acm.org>
In-Reply-To: <56A0FB5E.5080606@acm.org>
Content-Language: ja-JP
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
To: "'minyard@acm.org'" <minyard@acm.org>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello,

Thanks for your comments.

> I understand what you are trying to accomplish here, but I'm not sure of
> the wisdom of this approach.  I'll give some more information and the
> kexec maintainers can decide, I suppose.
> 
> The KCS interface given here probably covers ~70% of the systems out there
> right now.

I decided to use KCS I/F because I believe it covers relatively high
rate of servers and it is the only system interface which one of our
targets supports for.

>  Other systems have:
>    * KCS interfaces at a different port or in a different place like
> memory, PCI,
>      and with different register sizes and spacing.

At least, I'm going to add an option to change the base I/O port.
I'm not sure about other cases because I don't know how supporting
them raises the cover rate and I don't have hardware to test.

>    * Other standard interfaces.  SMIC (probably not relevant), BT
> (faster, it does
>      block transfers) and SSIF (which is IPMI over I2C).
>    * Those other standard interfaces can be in different places, just
> like KCS.
>      Hundreds of I2C interfaces exist.
>    * Non-standard interfaces.  Power systems have their own IPMI interfaces,
>      for instance.  Some systems have IPMI over serial ports, though
> hopefully
>      that has pretty much gone away.
> 
> I'd guess that over half of the IPMI SI driver is discovering and
> handling all the
> various interface types, locations from all the sources it can come from.
> 
> As time goes on that 70% number is decreasing in favour of other faster
> and more convenient interfaces.  I expect that SSIF will become much more
> popular over time because it has block transfer capability and all the
> hardware
> is already there on systems.

Thanks for this information.  I'll check out the BMC implementation
of other servers, then I'll decide whether I should support SSIF, too.

> This is no different, of course, than any other common hardware
> interface out
> there.  USB, ATA, etc.  But it makes it hard to cover all the
> possibilities in something
> like purgatory.

Such kind of device sometimes become a cause of dump failure
due to wrong DMA or interrupts.  So we shouldn't use them.
Also, I think it is not suitable for purgatory to implement
their drivers.

Other possible options are to use serial device and NVRAM (like
the pstore driver).  However, serial port is not always available
for this purpose (actually this is our case), and NVRAM is not
always equipped.  Furthermore, we'd like to start/stop
the BMC's watchdog timer before starting the 2nd kernel.  This
can be done only by IPMI.

> I know how valuable this information can be.  It has saved my butt on
> occasions,
> which is why I go through the inconvenience of handling it in the IPMI
> driver.
> But it seems to me that the failure rate of doing this in the crashing
> kernel should
> be pretty low.  Not zero of course.  But I have no idea what it is.

At first, I tried to use crash_kexec_post_notifiers to call
the callback of IPMI driver before jumping to the 2nd kernel.
But the feature has a couple of bugs and I tried to fix them:

https://lkml.org/lkml/2015/7/10/316
https://lkml.org/lkml/2015/7/23/864

However, no one supports this bugfix and the discussion didn't
make a progress because calling notifiers before kdump is not
reliable.  So, I suggested to use the purgatory.

Regards,

--
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
