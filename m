Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ebzIe-000736-4I
 for kexec@lists.infradead.org; Thu, 18 Jan 2018 01:47:29 +0000
Date: Thu, 18 Jan 2018 09:47:05 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: kexec reboot fails with extra wbinvd introduced for AME SME
Message-ID: <20180118014705.GA1812@dhcp-128-65.nay.redhat.com>
References: <20171213025256.GA1913@dhcp-128-65.nay.redhat.com>
 <20171213155746.GA29572@yu-chen.sh.intel.com>
 <20171214092429.GA2004@dhcp-128-65.nay.redhat.com>
 <20180104031537.GA1819@dhcp-128-65.nay.redhat.com>
 <20180117072123.GA1866@dhcp-128-65.nay.redhat.com>
 <CA+55aFxCuz2K_kE3Huu3Ar32LVmWav__2CPL_=zs2g0devx9-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+55aFxCuz2K_kE3Huu3Ar32LVmWav__2CPL_=zs2g0devx9-Q@mail.gmail.com>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Tony Luck <tony.luck@intel.com>, Yu Chen <yu.c.chen@intel.com>, Baoquan He <bhe@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, Ingo Molnar <mingo@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>, ebiederm@redhat.com, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>

On 01/17/18 at 11:42am, Linus Torvalds wrote:
> On Tue, Jan 16, 2018 at 11:22 PM, Dave Young <dyoung@redhat.com> wrote:
> >
> > For the kexec reboot hang, if I remove the wbinvd in stop_this_cpu()
> > then kexec works fine. like this:
> 
> Honestly, I think we should apply that patch regardless.
> 
> Using 'wbinvd' should not be some "just because of random reasons".
> There are CPU's with errata on wbinvd, and the thing in general is
> slow and nasty.
> 
> Doing the wbinvd in a loop sounds even stranger.
> 
> If we're only doing it because of some SME issue, why isn't it
> dependent on SME? And why is it inside that loop at all?
> 
> Anyway, does it work for you if you just do the wbinvd() once, outside
> the loop? Admittedly the loop shouldn't actually loop (hlt with
> interrupts disabled), but who the hell knows.. Some of the errata
> around SME have been about machine check exceptions or something.

It does not work with just once wbinvd(), and it only works with
removing the wbinvd() for me.  Tom's new post works for me as well
since my cpu is an Intel i5-4200U.

> 
> See commit a68e5c94f7d3 ("x86, hotplug: Move WBINVD back outside the
> play_dead loop") for another example where wbinvd was inside a loop
> and apparently caused some odd issues.
> 
>               Linus

Thanks for the help! Finally I get my laptop kexec & kdump works again
after solving these issues.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
