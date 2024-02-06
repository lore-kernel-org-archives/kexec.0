Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A636CC48297
	for <kexec@archiver.kernel.org>; Tue,  6 Feb 2024 14:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sA3uGjETPpXB26uSnh5JBcnnbAE9Oi+G20Gho8HPfaA=; b=vntn9mDwlS1I7m
	+cGgejDEi+mXYe1XHK04ZvgA3qSVsjnhuu2MuBibOiTSlImUIV+IPYEuXAM74/gUMSUXsJlaz6UUN
	qWfW/lH8kRUOz25L53gDIkSzaqSS9rJ0dkNiwZKVZqeButk/hopvSeVfaZ9o2EB4LKi/lpzty2+j2
	iY04d1a6jxqQQbAbQYvhDMzHzUcREOcCf4xEtUM3WCLga+1UNmBG/jV34PWz4NOguF/32tUC1eXxu
	5mvFcpFRf1lGznQdJvYr6qNQj4i8jSemridIoRWo/QJtaCGGuB9l8DzRhsRAx/7OhvMbrsYsd/62Q
	m1e4G6m4GKkS7ct7+lTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXMck-00000007tzE-3rie;
	Tue, 06 Feb 2024 14:40:34 +0000
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXMci-00000007txu-0EBw
	for kexec@lists.infradead.org;
	Tue, 06 Feb 2024 14:40:33 +0000
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rXMcd-0003xc-Ql; Tue, 06 Feb 2024 15:40:27 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rXMcY-004qRv-6e; Tue, 06 Feb 2024 15:40:22 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rXMcY-00EFqp-0E;
	Tue, 06 Feb 2024 15:40:22 +0100
Date: Tue, 6 Feb 2024 15:40:22 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Alexander Graf <graf@amazon.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	arnd@arndb.de, pbonzini@redhat.com, madvenka@linux.microsoft.com,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 00/17] kexec: Allow preservation of ftrace buffers
Message-ID: <ZcJE1qQy29lR42-G@pengutronix.de>
References: <20240117144704.602-1-graf@amazon.com>
 <ZcHrIJ7lxpbkm5sc@pengutronix.de>
 <c7157097-4727-4360-80a0-20e7d8015e13@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c7157097-4727-4360-80a0-20e7d8015e13@amazon.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240206_064032_104992_AD56B8E6 
X-CRM114-Status: GOOD (  49.96  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, Feb 06, 2024 at 02:43:15PM +0100, Alexander Graf wrote:
> Hey Oleksij!
> 
> On 06.02.24 09:17, Oleksij Rempel wrote:
> > Hi Alexander,
> > 
> > Nice work!
> > 
> > On Wed, Jan 17, 2024 at 02:46:47PM +0000, Alexander Graf wrote:
> > > Make sure to fill ftrace with contents that you want to observe after
> > > kexec.  Then, before you invoke file based "kexec -l", activate KHO:
> > > 
> > >    # echo 1 > /sys/kernel/kho/active
> > >    # kexec -l Image --initrd=initrd -s
> > >    # kexec -e
> > > 
> > > The new kernel will boot up and contain the previous kernel's trace
> > > buffers in /sys/kernel/debug/tracing/trace.
> > Assuming:
> > - we wont to start tracing as early as possible, before rootfs
> >    or initrd would be able to configure it.
> > - traces are stored on a different device, not RAM. For example NVMEM.
> > - Location of NVMEM is different for different board types, but
> >    bootloader is able to give the right configuration to the kernel.
> 
> 
> Let me try to really understand what you're tracing here. Are we talking
> about exposing boot loader traces into Linux [1]? In that case, I think a
> mechanism like [2] is what you're looking for.
> 
> Or do you want to transfer genuine Linux ftrace traces? In that case, why
> would you want to store them outside of RAM?

The high level object of what i need is to find how embedded systems in
fields do break. Since this devices should be always on, there are
different situations where system may reboot. For example, voltage
related issues, temperature, scheduled system updates, HW or SW errors.

To get better understand on what is going on, information should be
collected. But there are some limitations:
- voltage drops can be recorder only with prepared HW:
  https://www.spinics.net/lists/devicetree/msg644030.html

- In case of voltage drops RAM or block devices can't be used. Instead,
  some variant of NVMEM should be used. In my case, NVMEM has 8 bits of
  storage :) So, only one entry of the "trace" is compressed to this storage.
  https://lore.kernel.org/all/20240124122204.730370-1-o.rempel@pengutronix.de
  The reset reason information is provide by kernel and used by firmware
  and kernel on next reboot

The implementation is not a big deal. The problematic part is the way
how the system should get information about existence of recorder and
where the recorder should stored things, for example NVMEM cell.

In my initial implementation I used devicetree to configure the software
based recorder and linked it with NVMEM cell. But it is against the DT
purpose to describe only HW and it makes this recorder unusable for
not DT basd systems.

Krzysztof is suggesting to configure it from initrd. This has own
limitations as well:
 - record can't be used before initrd.
 - we have multiple configuration point of board specific information - 
   firmware (bootloader) and initrd.
 - initrd take place and reduce boot time for device which do not needed
   it before.

Other variants like kernel command-line and/or module parameters seems
to be not acceptable depending maintainer. So, I'm still seeking
proper, acceptable, portable way to hand over not HW specific
information to the kernel.

> > What would be the best, acceptable for mainline, way to provide this
> > kind of configuration? At least part of this information do not
> > describes devices or device states, this would not fit in to devicetree
> > universe. Amount of possible information would not fit in to bootconfig
> > too.
> 
> 
> We have precedence for configuration in device tree: You can use device tree
> to describe partitions on a NAND device, you can use it to specify MAC
> address overrides of devices attached to USB, etc etc. At the end of the day
> when people say they don't want configuration in device tree, what they mean
> is that device tree should be a hand over data structure from firmware to
> kernel, not from OS integrator to kernel :). If your firmware is the place
> that knows about offsets and you need to pass those offsets, IMHO DT is a
> good fit.

Yes, the layout of the NVMEM can be described in the DT. How can I tell
the system that this NVMEM cell should be used by some recorder or
tracer? Before sysfs is available any how. @Krzysztof ?

> > Other more or less overlapping use case I have in mind is a netbootable
> > embedded system with a requirement to boot as fast as possible. Since
> > bootloader already established a link and got all needed ip
> > configuration, it would be able to hand over etherent controller and ip
> > configuration states. Wille be the KHO the way to go for this use case?
> 
> 
> That's an interesting one too. I would lean towards "try with normal device
> tree first" here as well. It's again a very clear case of "firmware wants to
> tell OS about things it knows, but the OS doesn't know" to me. That means
> device tree should be fine to describe it.

I can imagine description of PHY and MAC state. But IP configuration
state of the firmware seems to be out of DT scope?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
