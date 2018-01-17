Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-x22f.google.com ([2607:f8b0:4001:c0b::22f])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ebtbQ-0003Zy-EH
 for kexec@lists.infradead.org; Wed, 17 Jan 2018 19:42:30 +0000
Received: by mail-it0-x22f.google.com with SMTP id b5so10603756itc.3
 for <kexec@lists.infradead.org>; Wed, 17 Jan 2018 11:42:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180117072123.GA1866@dhcp-128-65.nay.redhat.com>
References: <20171213025256.GA1913@dhcp-128-65.nay.redhat.com>
 <20171213155746.GA29572@yu-chen.sh.intel.com>
 <20171214092429.GA2004@dhcp-128-65.nay.redhat.com>
 <20180104031537.GA1819@dhcp-128-65.nay.redhat.com>
 <20180117072123.GA1866@dhcp-128-65.nay.redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jan 2018 11:42:15 -0800
Message-ID: <CA+55aFxCuz2K_kE3Huu3Ar32LVmWav__2CPL_=zs2g0devx9-Q@mail.gmail.com>
Subject: Re: kexec reboot fails with extra wbinvd introduced for AME SME
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
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Tony Luck <tony.luck@intel.com>, Yu Chen <yu.c.chen@intel.com>, Baoquan He <bhe@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, Ingo Molnar <mingo@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>, ebiederm@redhat.com, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>

On Tue, Jan 16, 2018 at 11:22 PM, Dave Young <dyoung@redhat.com> wrote:
>
> For the kexec reboot hang, if I remove the wbinvd in stop_this_cpu()
> then kexec works fine. like this:

Honestly, I think we should apply that patch regardless.

Using 'wbinvd' should not be some "just because of random reasons".
There are CPU's with errata on wbinvd, and the thing in general is
slow and nasty.

Doing the wbinvd in a loop sounds even stranger.

If we're only doing it because of some SME issue, why isn't it
dependent on SME? And why is it inside that loop at all?

Anyway, does it work for you if you just do the wbinvd() once, outside
the loop? Admittedly the loop shouldn't actually loop (hlt with
interrupts disabled), but who the hell knows.. Some of the errata
around SME have been about machine check exceptions or something.

See commit a68e5c94f7d3 ("x86, hotplug: Move WBINVD back outside the
play_dead loop") for another example where wbinvd was inside a loop
and apparently caused some odd issues.

              Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
