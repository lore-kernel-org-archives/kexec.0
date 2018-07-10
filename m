Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fcnC2-0007R1-1E
 for kexec@lists.infradead.org; Tue, 10 Jul 2018 07:36:16 +0000
Received: by mail-pl0-x241.google.com with SMTP id 6-v6so7235251plb.0
 for <kexec@lists.infradead.org>; Tue, 10 Jul 2018 00:36:03 -0700 (PDT)
Date: Tue, 10 Jul 2018 16:37:22 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v10 08/14] arm64: kexec_file: load initrd and device-tree
Message-ID: <20180710073719.GW28220@linaro.org>
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
 <20180623022058.10935-9-takahiro.akashi@linaro.org>
 <1e401f4e-6176-990d-476c-31ae3f28f26c@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1e401f4e-6176-990d-476c-31ae3f28f26c@arm.com>
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
To: James Morse <james.morse@arm.com>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com

James,

On Tue, Jul 03, 2018 at 05:32:09PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 23/06/18 03:20, AKASHI Takahiro wrote:
> > load_other_segments() is expected to allocate and place all the necessary
> > memory segments other than kernel, including initrd and device-tree
> > blob (and elf core header for crash).
> > While most of the code was borrowed from kexec-tools' counterpart,
> > users may not be allowed to specify dtb explicitly, instead, the dtb
> > presented by the original boot loader is reused.
> > 
> > arch_kimage_kernel_post_load_cleanup() is responsible for freeing arm64-
> > specific data allocated in load_other_segments().
> 
> 
> > diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> > index c38a8048ed00..7115c4f915dc 100644
> > --- a/arch/arm64/kernel/machine_kexec_file.c
> > +++ b/arch/arm64/kernel/machine_kexec_file.c
> 
> > +static int setup_dtb(struct kimage *image,
> > +		unsigned long initrd_load_addr, unsigned long initrd_len,
> > +		char *cmdline, unsigned long cmdline_len,
> > +		char **dtb_buf, size_t *dtb_buf_len)
> > +{
> > +	char *buf = NULL;
> > +	size_t buf_size;
> > +	int nodeoffset;
> > +	u64 value;
> > +	int ret;
> > +
> > +	/* duplicate dt blob */
> > +	buf_size = fdt_totalsize(initial_boot_params);
> > +
> > +	if (initrd_load_addr) {
> > +		buf_size += fdt_prop_len("linux,initrd-start", sizeof(u64));
> > +		buf_size += fdt_prop_len("linux,initrd-end", sizeof(u64));
> > +	}
> > +
> > +	if (cmdline)
> > +		buf_size += fdt_prop_len("bootargs", cmdline_len + 1);
> 
> (a comment here about the possibility of an embedded NULL may avoid surprises later)
> 
> 
> > +	buf = vmalloc(buf_size);
> > +	if (!buf) {
> > +		ret = -ENOMEM;
> > +		goto out_err;
> > +	}
> > +
> > +	ret = fdt_open_into(initial_boot_params, buf, buf_size);
> > +	if (ret)
> > +		goto out_err;
> > +
> > +	nodeoffset = fdt_path_offset(buf, "/chosen");
> > +	if (nodeoffset < 0)
> > +		goto out_err;
> 
> This doesn't update 'ret', so we return the 0/success from above...

OK. Will fix it.

> 
> > +
> > +	/* add bootargs */
> > +	if (cmdline) {
> > +		ret = fdt_setprop(buf, nodeoffset, "bootargs",
> > +						cmdline, cmdline_len + 1);
> > +		if (ret)
> > +			goto out_err;
> > +	}
> 
> So (cmdline_len == 0) from user-space means keep the old cmdline. Sounds
> sensible. Is this documented anywhere?

Very good catch, James.
To be a bit surprise, --append (and --cmdline) option belongs to arch-
specific options in terms of implementation. Apparently, a standard man page
of kexec(8) say little about it, in particular, for device-tree-based system.

As far as arm64 is concerned, the fact is a bit complicated.
User space kexec accepts --append as well as --reuse-cmdline, and
along with yet another --dtb option, a resulting command line for new
kernel (or bootargs in new dtb) would look to be:

	--append=A | --reuse-cmdline |     --dtb
		   |                 |   n    |    y(bootargs=B)

	    n            n               S(*1)      B(*2)
	    n            y               S          S(*3)
	    y            n               A          A
	    y            y              S+A        S+A(*4)

      where S: the cmdline parameters of the running system
		 (equal to bootargs in system's dtb)

You are talking about case(1) above.

Given that we can have an explicit option, --reuse-cmdline, the cmdline
in (1) should be NULL. Meanwhile, we specify --dtb here, which means
that we want to re-use system's dtb, implying that we also want to
reuse a cmdline parameter. (This can be arguable, though)

So I would say that we have both reasons to go for and go against.

# Likewise,
# I wonder why the cmdnline would not be B or A+B, respectively,
in case of (3) and (4). But it's a different issue.

> powerpc does the opposite, it deletes the bootargs in this case. Are we happy
> making his a per-arch thing?

My compromise solution is:
a.to maintain compatibility with powerpc at system call level, that is,
  replacing bootargs in new dtb if user explicitly specifies cmdline
  argument, otherwise nullifying bootargs,
b.yet maintain compatibility with arm64's kexec behavior at command line
  interface level. If neither --append nor --dtb is not specified,
  user space kexec will reuse the system's command line whether or not
  --reuse-cmdline is used.

(Do you follow me?)

So kexec and kexec_file on arm64 will still behave in exactly the same way,
but differently from ppc at command level for now.
The point is that, if we might want or need to change this behavior
(at any time in the future), we would only have to modify user space kexec.
Kernel semantics will never break.

(b) requires additional small modification on kexec-tools, but kexec_file
support is yet to be upstreamed anyway.

> 
> > +	/* add initrd-* */
> > +	if (initrd_load_addr) {
> > +		value = cpu_to_fdt64(initrd_load_addr);
> > +		ret = fdt_setprop_u64(buf, nodeoffset, "linux,initrd-start",
> > +							value);
> > +		if (ret)
> > +			goto out_err;
> > +
> > +		value = cpu_to_fdt64(initrd_load_addr + initrd_len);
> > +		ret = fdt_setprop_u64(buf, nodeoffset, "linux,initrd-end",
> > +							value);
> > +		if (ret)
> > +			goto out_err;
> > +	}
> 
> Won't this do the same with the initrd? Re-use the old values if no new one was
> provided? I can't find anything that deletes the property by the time we come to
> kexec, and the old physical addresses may have been re-used by who-knows-what.
> 
> (powerpc has some code to: /* If there's no new initrd, delete the old initrd's
> info. */)

Yeah, I think that deleting properties would be a right way to go.
Will fix.

Thanks,
-Takahiro AKASHI

> 
> 
> Thanks,
> 
> James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
