Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kezj4-0002PV-Vf
 for kexec@lists.infradead.org; Tue, 17 Nov 2020 12:04:47 +0000
Received: from mail-ed1-f70.google.com ([209.85.208.70])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <guilherme.piccoli@canonical.com>) id 1kezj2-0003CB-L1
 for kexec@lists.infradead.org; Tue, 17 Nov 2020 12:04:44 +0000
Received: by mail-ed1-f70.google.com with SMTP id f20so9501266edx.23
 for <kexec@lists.infradead.org>; Tue, 17 Nov 2020 04:04:44 -0800 (PST)
MIME-Version: 1.0
References: <20201117001907.GA1342260@bjorn-Precision-5520>
 <87h7poeqqn.fsf@x220.int.ebiederm.org>
In-Reply-To: <87h7poeqqn.fsf@x220.int.ebiederm.org>
From: Guilherme Piccoli <gpiccoli@canonical.com>
Date: Tue, 17 Nov 2020 09:04:07 -0300
Message-ID: <CAHD1Q_zS9Hs8mUsm=q0Ei0kQ+y+wQhkroD+M2eCPKo2xLO6hBw@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
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
To: "Eric W. Biederman" <ebiederm@xmission.com>, Bjorn Helgaas <helgaas@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Guowen Shan <gshan@redhat.com>, "Guilherme G. Piccoli" <kernel@gpiccoli.net>, andi@firstfloor.org, Baoquan He <bhe@redhat.com>, linux-pci@vger.kernel.org, x86@kernel.org, Sinan Kaya <okaya@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Pingfan Liu <kernelfans@gmail.com>, kexec mailing list <kexec@lists.infradead.org>, Dan Streetman <ddstreet@canonical.com>, lukas@wunner.de, Borislav Petkov <bp@alien8.de>, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>, Jay Vosburgh <jay.vosburgh@canonical.com>, Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@redhat.com>, Gavin Guo <gavin.guo@canonical.com>

On Mon, Nov 16, 2020 at 10:07 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
> [...]
> > I think we need to disable MSIs in the crashing kernel before the
> > kexec.  It adds a little more code in the crash_kexec() path, but it
> > seems like a worthwhile tradeoff.
>
> Disabling MSIs in the b0rken kernel is not possible.
>
> Walking the device tree or even a significant subset of it hugely
> decreases the chances that we will run into something that is incorrect
> in the known broken kernel.  I expect the code to do that would double
> or triple the amount of code that must be executed in the known broken
> kernel.  The last time something like that happened (switching from xchg
> to ordinary locks) we had cases that stopped working.  Walking all of
> the pci devices in the system is much more invasive.
>

I think we could try to decouple this problem in 2, if that makes
sense. Bjorn/others can jump in and correct me if I'm wrong. So, the
problem is to walk a PCI topology tree, identify every device and
disable MSI(/INTx maybe) in them, and the big deal with doing that in
the broken kernel before the kexec is that this task is complex due to
the tree walk, mainly. But what if we keep a table (a simple 2-D
array) with the address and data to be written to disable the MSIs,
and before the kexec we could have a parameter enabling a function
that just goes through this array and performs the writes?

The table itself would be constructed by the PCI core (and updated in
the hotplug path), when device discovery is happening. This table
would live in a protected area in memory, with no write/execute
access, this way if the kernel itself tries to corrupt that, we get a
fault (yeah, I know DMAs can corrupt anywhere, but IOMMU could protect
against that). If the parameter "kdump_clear_msi" is passed in the
cmdline of the regular kernel, for example, then the function walks
this simple table and performs the devices' writes before the kexec...

If that's not possible or a bad idea for any reason, I still think the
early_quirks() idea hereby proposed is not something we should
discard, because it'll help a lot of users even with its limitations
(in our case it worked very well).
Also, taking here the opportunity to clarify my understanding about
the limitations of that approach: Bjorn, in our reproducer machine we
had 3 parents in the PCI tree (as per lspci -t), 0000:00, 0000:ff and
0000:80 - are those all under "segment 0" as per your verbiage? In our
case the troublemaker was under 0000:80, and the early_quirks() shut
the device up successfully.

Thanks,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
