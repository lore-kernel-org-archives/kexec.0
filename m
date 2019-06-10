Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-f196.google.com ([209.85.166.196])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1haHOJ-0000Ye-QE
 for kexec@lists.infradead.org; Mon, 10 Jun 2019 10:19:05 +0000
Received: by mail-it1-f196.google.com with SMTP id j194so5402347ite.0
 for <kexec@lists.infradead.org>; Mon, 10 Jun 2019 03:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190610073617.19767-1-kasong@redhat.com>
 <20190610095150.GA5488@zn.tnic>
In-Reply-To: <20190610095150.GA5488@zn.tnic>
From: Kairui Song <kasong@redhat.com>
Date: Mon, 10 Jun 2019 18:18:50 +0800
Message-ID: <CACPcB9f-sussXaOuOau6=CD85pS2KhcsknpJDQH_aEkwvLfvVA@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: Add ACPI NVS region to the ident map
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
To: Borislav Petkov <bp@alien8.de>
Cc: the arch/x86 maintainers <x86@kernel.org>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, Chao Fan <fanc.fnst@cn.fujitsu.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dirk van der Merwe <dirk.vandermerwe@netronome.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>

On Mon, Jun 10, 2019 at 5:52 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Jun 10, 2019 at 03:36:17PM +0800, Kairui Song wrote:
> > With the recent addition of RSDP parsing in decompression stage, kexec
> > kernel now needs ACPI tables to be covered by the identity mapping.
> > And in commit 6bbeb276b71f ("x86/kexec: Add the EFI system tables and
> > ACPI tables to the ident map"), ACPI tables memory region was added to
> > the ident map.
> >
> > But on some machines, there is only ACPI NVS memory region, and the ACPI
> > tables is located in the NVS region instead. In such case second kernel
>
> *are* located - plural.
>
> > will still fail when trying to access ACPI tables.
> >
> > So, to fix the problem, add NVS memory region in the ident map as well.
> >
> > Fixes: 6bbeb276b71f ("x86/kexec: Add the EFI system tables and ACPI tables to the ident map")
> > Suggested-by: Junichi Nomura <j-nomura@ce.jp.nec.com>
> > Signed-off-by: Kairui Song <kasong@redhat.com>
> > ---
> >
> > Tested with my laptop and VM, on top of current tip:x86/boot.
>
> You tested this in a VM and not on the *actual* machine with the NVS
> region?
>
> This is a joke, right?
>

Hi Boris, unfortunately I don't have a real machine which only have
the NVS region.
I did fake the memmap to emulate such problem but can't really promise
this will fix the real case.
So just declare it won't break anything that is already working. And
I'm asking Junichi to have a try as he reported this issue on the
machines he has.

-- 
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
