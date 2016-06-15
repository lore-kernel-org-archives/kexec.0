Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 15 Jun 2016 10:43:03 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: kexec failures with DEBUG_RODATA
Message-ID: <20160615024303.GA7720@x1.redhat.com>
References: <20160614175920.GD1041@n2100.armlinux.org.uk>
 <CAGXu5j+5j32HO0rQtF2hcqMUBaa8cyxgLT4JvaZ6LL2WPj_zjw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGXu5j+5j32HO0rQtF2hcqMUBaa8cyxgLT4JvaZ6LL2WPj_zjw@mail.gmail.com>
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
To: Kees Cook <keescook@google.com>
Cc: Pratyush Anand <panand@redhat.com>, Simon Horman <horms@verge.net.au>, Kexec Mailing List <kexec@lists.infradead.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 06/14/16 at 11:05am, Kees Cook wrote:
> On Tue, Jun 14, 2016 at 10:59 AM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > Since the kernel now has CONFIG_DEBUG_RODATA by default, this means
> > that these kinds of ratio-based assumptions are even more invalid
> > than they have been.
> >
> > Right now, a zImage doesn't advertise the size of its uncompressed
> > image, but I think with things like CONFIG_DEBUG_RODATA, we can no
> > longer make assumptions like we have done in the past, and we need
> > the zImage to provide this information so that the boot environment
> > can be setup sanely by boot loaders/kexec rather than relying on
> > broken heuristics like this.
> >
> > Thoughts?
> 
> I'm much less familiar with the ARM decompression stub, but is there a
> boot image header (like x86 has)? If not, perhaps we can invent one,
> and it can carry all the details needed for a bootloader to do the
> right things.

Yes, x86 stores addr and size of initrd into boot header. When
decompressing kernel it will choose a safe starting position before the
loaded place according to the max evaluation of decompressing algorithm.

ARM only use a rough 4 times evaluation, sounds too hasty. Simplest way
is to increase times to 8 for now. The final way should be as Kees
suggested.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
