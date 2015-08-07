Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZNWcq-0002qy-Q9
 for kexec@lists.infradead.org; Fri, 07 Aug 2015 01:39:13 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: [RFC V2 PATCH 0/1] kexec: crash_kexec_post_notifiers boot
 option related fixes
Date: Fri, 7 Aug 2015 01:38:48 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A8445492BE70@GSjpTKYDCembx31.service.hitachi.net>
References: <20150724011615.6834.79628.stgit@softrs>
 <55BF4B1F.9000602@hitachi.com> <877fpcfi2j.fsf@x220.int.ebiederm.org>
 <04EAB7311EE43145B2D3536183D1A84454926993@GSjpTKYDCembx31.service.hitachi.net>
 <87io8tvez5.fsf@x220.int.ebiederm.org>
In-Reply-To: <87io8tvez5.fsf@x220.int.ebiederm.org>
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
To: "'Eric W. Biederman'" <ebiederm@xmission.com>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Baoquan He <bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Daniel Walker <dwalker@fifo99.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

> From: Eric W. Biederman [mailto:ebiederm@xmission.com]
> >> From: Eric W. Biederman [mailto:ebiederm@xmission.com]
> > [...]
> >> A specific hook for a very specific purpose when there is no other way
> >> we can consider.
> >
> > So, is kmsg_dump like feature admissible?
> >
> >> If you don't have something that generalises well into a general purpose
> >> operation that it makes sense for everyone to call you can always use
> >> the world's largest aka you can run code before the new kernel starts
> >> that is loaded with kexec_load.
> >
> > One of our purposes, notifying "I'm dying", would be achieved by purgatory
> > code provided by kexec command as I stated before.  Since the way of the
> > notification will differ from each vendor, I think we need to modify
> > the purgatory codes pluggable.  Also, I think we need some parameter
> > passing mechanism to the purgatory code.  For example, passing the panic
> > message via boot parameter to save it to SEL.  Although I'm not sure
> > we can do that (I've not investigated well yet).  Is that acceptable?
> 
> I think the address of panic message is available in crash notes.  If
> not that is very reasonable to add.

I believed the boot parameter is prepared by the 1st kernel, but
it's wrong.  The boot parameter is completely provieded kexec command.
So, passing the panic message through boot parameter will not
be feasible.  I'm not sure we can easily access to the crash notes
from purgatory, but I think it's a reasonable way to pass panic message.

> Updating the SEL from purgatory after purgatory has validated the
> checksums of the crash handling code is acceptable.
> 
> All that is desired is to run as little code as possible in a kernel
> that is known broken.  Once the checksums have verified things in
> purgatory you should be in good shape, and there is no possibility of
> relying on broken infrastructure because that code simply is not present
> in purgatory.
> 
> We already have a few early_printk style drivers in purgatory and I
> don't the code to update the SEL would be much worse.

For developers, early_printk style feature will be better solution.
For end users, however, it will not be true.  Sometimes they cannot
use a serial port for early_printk because the serial port is used
for other purpose.  Sometimes they cannot place additional machine
which receives messages from the serial port.  So we need some
plugin or enable/disable mechanism for specific purgatory code.

> On the flip side there are enough firmware bugs that I personally would
> not want to rely on firmware code running properly when the machine is
> in a known broken state, so I don't want the SEL update to be
> unconditional.

Yes, I don't also trust BMC firmware.  The most simple I/F to BMC
is KCS (Keyboard Controller Style) I/F which is accessible via
two I/O ports.  If BMC becomes insane, the state machine for the I/F
can go into infinite loop.  However, we can avoid this by introducing
proper timeout.  Of course, I think we should add some enable/disable
mechanism.


Regards,
Kawai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
