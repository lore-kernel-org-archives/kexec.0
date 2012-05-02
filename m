Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SPfOv-0003LN-Lp
 for kexec@lists.infradead.org; Wed, 02 May 2012 19:39:51 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1330546129-4812-1-git-send-email-dzickus@redhat.com>
 <20120315202652.GA13930@redhat.com>
 <5C4C569E8A4B9B42A84A977CF070A35B2E31C6F859@USINDEVS01.corp.hds.com>
 <20120430205354.GA32472@redhat.com>
 <5C4C569E8A4B9B42A84A977CF070A35B2E4D461583@USINDEVS01.corp.hds.com>
Date: Wed, 02 May 2012 12:39:06 -0700
In-Reply-To: <5C4C569E8A4B9B42A84A977CF070A35B2E4D461583@USINDEVS01.corp.hds.com>
 (Seiji Aguchi's message of "Wed, 2 May 2012 15:10:34 -0400")
Message-ID: <87vckemkyt.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH] x86, kdump: No need to disable ioapic in crash path
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
To: Seiji Aguchi <seiji.aguchi@hds.com>
Cc: Don Zickus <dzickus@redhat.com>, "x86@kernel.org" <x86@kernel.org>, kexec-list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@redhat.com>

Seiji Aguchi <seiji.aguchi@hds.com> writes:

>> Perhaps calling setup_IO_APIC before setup_local_APIC would be a better fix?
>
> I checked Intel develper's manual and there is no restriction about the order of enabling IO_APIC/local_APIC.
> So, it may work.
>
> But, I don't understand why we have to change the stable boot-up code.

Because the boot-up code is buggy.  We need to get a better handle on
how it is buggy but apparently an interrupt coming in at the wrong
moment while booting with interrupts on the interrupt flag on the cpus
disalbed puts us in a state where we fail to boot.

We should be able to boot with apics enabled, and we almost can
emperically there are a few bugs.

The kdump path is particularly good at finding bugs.

> If kdump disables both local_apic and IO_APIC in proper way in 1st kernel,  2nd kernel works without any change.

We can not guarnatee disabling the local apics in the first kernel.

Ultimately the less we do in the first kernel the more reliable kdump is
going to be.  Disabling the apics has been a long standing bug work
around.

At worst we may have been a smidge premature in using assuming the
kernel can boot with the apics enabled but it I would hope we can
track down and fix the boot up code.

Probably what we want to do is not to disable the I/O apics but
to program the I/O apics before we enable the local apic so that
we have control of the in-comming interrupts.  But I haven't
looked at this in nearly enough detail to even guess what needs
to happen.

Eric



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
