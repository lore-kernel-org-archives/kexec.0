Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kemNg-0004vU-3l
 for kexec@lists.infradead.org; Mon, 16 Nov 2020 21:49:48 +0000
Received: from mail-ed1-f71.google.com ([209.85.208.71])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <guilherme.piccoli@canonical.com>) id 1kemNd-0006NW-6G
 for kexec@lists.infradead.org; Mon, 16 Nov 2020 21:49:45 +0000
Received: by mail-ed1-f71.google.com with SMTP id f20so8633550edx.23
 for <kexec@lists.infradead.org>; Mon, 16 Nov 2020 13:49:45 -0800 (PST)
MIME-Version: 1.0
References: <20201114212215.GA1194074@bjorn-Precision-5520>
 <87v9e6n2b2.fsf@x220.int.ebiederm.org> <87sg9almmg.fsf@x220.int.ebiederm.org>
 <874klqac40.fsf@nanos.tec.linutronix.de>
 <87lff2ic0h.fsf@x220.int.ebiederm.org>
 <c8238524-4197-c22d-7bae-df61133fcbfe@canonical.com>
 <87a6vhht71.fsf@x220.int.ebiederm.org>
In-Reply-To: <87a6vhht71.fsf@x220.int.ebiederm.org>
From: Guilherme Piccoli <gpiccoli@canonical.com>
Date: Mon, 16 Nov 2020 18:49:08 -0300
Message-ID: <CAHD1Q_zk6Z841E1yAH-GKpDXQ=32YPb-R4Exo7UcNHnTY3bdqQ@mail.gmail.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Guowen Shan <gshan@redhat.com>, linux-pci@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>, andi@firstfloor.org, "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>, x86@kernel.org, Sinan Kaya <okaya@kernel.org>, Ingo Molnar <mingo@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>, Jay Vosburgh <jay.vosburgh@canonical.com>, Dave Young <dyoung@redhat.com>, Gavin Guo <gavin.guo@canonical.com>, Borislav Petkov <bp@alien8.de>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, kexec mailing list <kexec@lists.infradead.org>, "Guilherme G. Piccoli" <kernel@gpiccoli.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Dan Streetman <ddstreet@canonical.com>, lukas@wunner.de, Vivek Goyal <vgoyal@redhat.com>

On Mon, Nov 16, 2020 at 6:45 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> The way to do that would be to collect the set of pci devices when the
> kexec on panic kernel is loaded, not during crash_kexec.  If someone
> performs a device hotplug they would need to reload the kexec on panic
> kernel.
>
> I am not necessarily endorsing that just pointing out how it can be
> done.
>
> Eric

Thanks Eric, I agree! I think if we use something like PKRAM (a more
dynamic approach) we could have the PCI hotplug path updating the data
to-be-passed to the crash kernel, so the crash kernel doesn't even
need to be loaded again.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
