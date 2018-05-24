Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fLkiY-0003nK-Kc
 for kexec@lists.infradead.org; Thu, 24 May 2018 07:31:24 +0000
Date: Thu, 24 May 2018 15:31:05 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kdump: add default crashkernel reserve kernel config
 options
Message-ID: <20180524073105.GF24627@MiWiFi-R3L-srv>
References: <20180521025337.GA4627@dhcp-128-65.nay.redhat.com>
 <20180521120215.117d963a7619eb0d1f54bced@linux-foundation.org>
 <20180523070641.GA1689@dhcp-128-65.nay.redhat.com>
 <877enucqr0.fsf@xmission.com>
 <20180523222236.5a96732e@ezekiel.suse.cz>
 <20180524014905.GB2031@dhcp-128-65.nay.redhat.com>
 <20180524085708.31aa311d@ezekiel.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180524085708.31aa311d@ezekiel.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: dzickus@redhat.com, Neil Horman <nhorman@redhat.com>, Tony Luck <tony.luck@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Hari Bathini <hbathini@linux.vnet.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Cong Wang <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On 05/24/18 at 08:57am, Petr Tesarik wrote:
> On Thu, 24 May 2018 09:49:05 +0800
> Dave Young <dyoung@redhat.com> wrote:
> 
> > Hi Petr,
> > 
> > On 05/23/18 at 10:22pm, Petr Tesarik wrote:
> >[...]
> > > In short, if one size fits none, what good is it to hardcode that "one
> > > size" into the kernel image?  
> > 
> > I agreed with all the things that we can not know the exact memory
> > requirement for 100% use cases.  But that does not means this is useless
> > it is still useful for common use cases of no special and memory hog
> > requirements as I mentioned in another reply it can simplify the kdump
> > deployment for those people who do not need the special setup.
> 
> I still tend to disagree. This "common-case" reservation depends on
> things that are defined by user space. It surely does not make it
> easier to build a distribution kernel. Today, I get bug reports that
> the number calculated and added to the boot loader configuration by the
> installer is inaccurate. If I put a fixed number into a kernel config
> option, I will start getting bugs that this number is incorrect (for
> some systems).
> 
> > For example, if this is a workstation I just want to break into a shell
> > to collect some panic info, then I just need a very minimal initrd, then
> > the Kconfig will work just fine.
> 
> What is "a very minimal initrd"? Last time I had to make a significant
> adjustment to the estimation for openSUSE, this was caused by growing
> user-space requirements (systemd in this case, but I don't want to
> start flamewars on that topic, please).
> 
> Anyway, if you want to improve the "common case", then look how IBM
> tries to solve it for firmware-assisted dump (fadump) on powerpc:
> 
> https://patchwork.ozlabs.org/patch/905026/
> 
> The main idea is:
> 
> > Instead of setting aside a significant chunk of memory nobody can use,
> > [...] reserve a significant chunk of memory that the kernel is prevented
> > from using [...], but applications are free to use it.
> 
> That works great, because user space pages are filtered out in the
> common case, so they can be used freely by the panic kernel.

This seems a good idea, just makedumpfile need be adjusted since it allows
user to decide if dump user space data or not. 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
