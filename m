Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-x233.google.com ([2607:f8b0:4001:c06::233])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ebu33-0004iE-Nr
 for kexec@lists.infradead.org; Wed, 17 Jan 2018 20:11:03 +0000
Received: by mail-io0-x233.google.com with SMTP id b198so19567537iof.6
 for <kexec@lists.infradead.org>; Wed, 17 Jan 2018 12:10:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CA+55aFxCuz2K_kE3Huu3Ar32LVmWav__2CPL_=zs2g0devx9-Q@mail.gmail.com>
References: <20171213025256.GA1913@dhcp-128-65.nay.redhat.com>
 <20171213155746.GA29572@yu-chen.sh.intel.com>
 <20171214092429.GA2004@dhcp-128-65.nay.redhat.com>
 <20180104031537.GA1819@dhcp-128-65.nay.redhat.com>
 <20180117072123.GA1866@dhcp-128-65.nay.redhat.com>
 <CA+55aFxCuz2K_kE3Huu3Ar32LVmWav__2CPL_=zs2g0devx9-Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jan 2018 12:10:49 -0800
Message-ID: <CA+55aFziWmqQEYu+7Uwv3nPtbrTNnxPkRg2svRJNG3dtbQkFeA@mail.gmail.com>
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

On Wed, Jan 17, 2018 at 11:42 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  [ .. ]        Some of the errata
> around SME have been about machine check exceptions or something.

That should be "some of the errata around wbinvd". I have no idea if
there have been SME issues.

That said, the really bad old wbinvd bug (which hung the system iirc)
was for some old PPro CPU's. Googling around, the errata I find seem
either irrelevant (eip corruption in 16-bit mode) or fairly mild (odd
behavior wrt parity errors).

So I have this memory of wbinvd having problems, but that memory does
seem to be largely historical. But Dave Young clearly sees *something*
odd going on.

               Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
