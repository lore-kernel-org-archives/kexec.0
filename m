Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xiyzi-0006Cf-Rv
 for kexec@lists.infradead.org; Tue, 28 Oct 2014 05:06:59 +0000
Date: Tue, 28 Oct 2014 13:04:48 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [resend Patch v3 1/2] kaslr: check if kernel location is changed
Message-ID: <20141028050448.GB15783@dhcp-16-105.nay.redhat.com>
References: <543553C7.9010906@zytor.com> <20141008192728.GA26517@redhat.com>
 <20141011031452.GB11560@dhcp-16-116.nay.redhat.com>
 <543907B5.7060001@zytor.com> <20141013125257.GB6466@redhat.com>
 <20141013151955.GA9777@redhat.com> <543BF304.9090708@zytor.com>
 <20141013172242.GB9777@redhat.com>
 <20141014124932.GC5127@redhat.com>
 <20141015033701.GD16068@dhcp-16-116.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141015033701.GD16068@dhcp-16-116.nay.redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: whissi@whissi.de, ak@linux.intel.com, Kees Cook <keescook@chromium.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, mingo@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, tglx@linutronix.de

On 10/15/14 at 11:37am, Baoquan He wrote:
> On 10/14/14 at 08:49am, Vivek Goyal wrote:
> > On Mon, Oct 13, 2014 at 01:22:42PM -0400, Vivek Goyal wrote:
 
> > > Agreed. On x86_64, we should be able to randomize virtual address space
> > > and physical address space independently. And in that case whole of
> > > the physical memory should be available for a possible location for
> > > kernel. (As opposed to a small limit (I guess 1GB) now)
> 
> It can be done to randomize virtual address space and physical address
> space independently. But limited by the 2G of kernel text mapping and
> module mapping virtual address space, virtual address can be randomized
> in (0x1000000, 1G) range. While physical address can be randomized in
> (0x1000000, 4G) according to the identity mapping of normal kernel. Then
> phys_base still stores an relative value, a different offset than before.
> 
> This can be easily implement. One thing is still there's a limit for
> physical addr randomization, only below 4G. So I am wondering if we can
> extend the identify mapping to complete mapping of 48 bit, using 1G page
> frame. This can make physical addr be randomized to anywhere.
> 
> So now there may be 3 options:

Hi hpa,

About kaslr, do you have a suggestion or plan? Should we fix bug based
on current code, or any other solutions?

Thanks
Baoquan


> 
> 1) Fix this bug in current kaslr. Since when randomize the new kernel
> location in choose_kernel_location(), cmdline options has been checked
> strictly, e.g if nokaslr is specified, it's safe to do the kernel
> location randomization. Then in handle_relocations(), we only need to
> check if the kernel location is changed, comparing with kernel loaded
> addr. If changed, kaslr is done, let's do the relocation handling. If
> not changed, no kaslr id done, just skip the relocation handling like
> before.
> 
> 2) randomize the virtual addr space and physical addr space
> independently. But physical addr space must be below 4G.
> 
> 3) extend the identity mapping to 48bit of addr space. Then we can
> randomized the virtual addr space in (0x1000000, 1G) and physical addr
> space in (0x1000000, real physical memory end).
> 
> If option 3 is doable, it's the best. If not, I think bug fix should be
> better.
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
