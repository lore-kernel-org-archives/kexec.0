Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W3odI-0008Rp-Hw
 for kexec@lists.infradead.org; Thu, 16 Jan 2014 15:13:25 +0000
Date: Thu, 16 Jan 2014 10:13:02 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Query regarding ELF loader arg style
Message-ID: <20140116151301.GB6156@redhat.com>
References: <20140109153703.GE25897@redhat.com> <87a9eyaumi.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87a9eyaumi.fsf@xmission.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

On Tue, Jan 14, 2014 at 05:42:13PM -0800, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@redhat.com> writes:
> 
> > Hi Eric,
> >
> > I am looking at kexec ELF loader code and wondering what are arg style
> > options.
> >
> > #define ARG_STYLE_ELF   0
> > #define ARG_STYLE_LINUX 1
> > #define ARG_STYLE_NONE  2
> >
> >
> > I have looked at them many a times but frankly never fully understood
> > what do they represent and what's the intention behind them. Can you
> > please elaborate a bit on this.
> 
> There is no standard of what kind of arguments a standalone ELF
> executable will receive from a bootloader.
> 
> Which means that in practice to support different OS's you either need
> to pass nothing or make something up.
> 
> ARG_STYLE_ELF is my own invention and a sad attempt at coming up with an
> OS agnostic standard.
> 
> ARG_STYLE_LINUX is an ELF image receiving the same arguments as the
> linux kernel.  It is a mess but it is reasonably well documented.

Hi Eric,


Even ARG_STYLE_LINUX seems to be making assumptions.

For example, look at init_linux_parameters() in
kexec-tools/kexec/arch/i386/x86-linux-setup.c.

void init_linux_parameters(struct x86_linux_param_header *real_mode)
{
        /* Fill in the values that are usually provided by the kernel. */

        /* Boot block magic */ 
        memcpy(real_mode->header_magic, "HdrS", 4);
        real_mode->protocol_version = 0x0206;
        real_mode->initrd_addr_max = DEFAULT_INITRD_ADDR_MAX;
        real_mode->cmdline_size = COMMAND_LINE_SIZE;
}

- We have no idea what's the max address we can load initrd at. So we make
  assumptions.

- We have no idea what's the maximum command line size kernel suppports. So
  we make assumptions. The other side affect of this is that we can't do
  error handling properly. I can't tell user back that you are passing
  command line which is longer than what kernel can support.

- ELF does not tell anything whether it is self relocating or not. So we
  are forced to load it at a address it has been compiled for (In case of
  kdump). And that address is already occupied by current running kernel
  so it does not work.

For the time being I have written a simple ELF loader along the lines of
kexec-tools. It defaults to ARG_STYLE_LINUX and works only with kexec and
not kexec on panic.

I have also made purgatory a stand alone relocatable object and now
purgatory is doing hash verification.

I am cleaning up the patches and will soon for another round of review
pretty soon.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
