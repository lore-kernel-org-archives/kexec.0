Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RuuHz-000094-OL
 for kexec@lists.infradead.org; Tue, 07 Feb 2012 23:17:32 +0000
Date: Tue, 7 Feb 2012 17:19:24 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] x86, kdump: No need to disable ioapic in crash path
Message-ID: <20120207221924.GH6346@redhat.com>
References: <1328206323-25580-1-git-send-email-dzickus@redhat.com>
 <m1r4ycsts1.fsf@fess.ebiederm.org>
 <20120207215741.GD5650@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120207215741.GD5650@redhat.com>
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
To: Don Zickus <dzickus@redhat.com>
Cc: x86@kernel.org, kexec-list <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, LKML <linux-kernel@vger.kernel.org>

On Tue, Feb 07, 2012 at 04:57:41PM -0500, Don Zickus wrote:
> On Thu, Feb 02, 2012 at 03:24:46PM -0800, Eric W. Biederman wrote:
> > > Eric, brought up a point that because the boot code was restructured we may
> > > not need to disable the io apic any more in the crash path.  The original
> > > concern that led to the development of disable_IO_APIC, was that the TSC
> > > calibration on boot up relied on the PIT timer for reference.  Access
> > > to the PIT required 8259 interrupts to be working.  This wouldn't work
> > > if the ioapic needed to be configured.  So on panic path, the ioapic was
> > > reconfigured to use virtual wire mode to allow the 8259 to passthrough.
> > 
> > A small clarification originally it was the jiffies calibration that
> > would fail if we could cause the PIT to generate interrupts through the
> > 8259.  The boot would then hang at calibrating jiffies.
> 
> Ok.  Thanks!

So now what has changed? Do we setup LAPIC and IOAPIC early enough to
receive PIT interrupts in regular mode (non-virtual wire mode) or
something else?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
