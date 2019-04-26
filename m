Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJxWA-0001Zg-G8
 for kexec@lists.infradead.org; Fri, 26 Apr 2019 09:51:43 +0000
Date: Fri, 26 Apr 2019 17:51:34 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [RFC PATCH] kexec, x86/boot: map systab region in identity
 mapping before accessing it
Message-ID: <20190426095134.GP3584@localhost.localdomain>
References: <20190419101733.GA10324@zn.tnic>
 <20190419105014.GE11060@MiWiFi-R3L-srv>
 <20190419112801.GB10324@zn.tnic> <20190419113621.GD10324@zn.tnic>
 <20190422143346.GD3584@localhost.localdomain>
 <20190422151723.GD21457@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190422151723.GD21457@zn.tnic>
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
Cc: "x86@kernel.org" <x86@kernel.org>, Kairui Song <kasong@redhat.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Thomas Gleixner <tglx@linutronix.de>, dyoung@redhat.com

On 04/22/19 at 05:17pm, Borislav Petkov wrote:
> + hpa
> 
> On Mon, Apr 22, 2019 at 10:33:46PM +0800, Baoquan He wrote:
> > On 04/19/19 at 01:36pm, Borislav Petkov wrote:
> > > On Fri, Apr 19, 2019 at 01:28:01PM +0200, Borislav Petkov wrote:
> > > > Read again what I said: "should all be passed through boot_params".
> > > > Which means, boot_params should be extended with a field of a flag to
> > > > say: "this is a kexec'ed kernel".
> > > 
> > > And by that I mean similar to the XLF_EFI_KEXEC mechanism. The first
> > > kernel or kexec(1) should prepare the info needed by the kexec'ed
> > > kernel.
> > 
> > We have set the loader type to '0x0D << 4' for kexec specifically, in both
> > kexec_load and kexec_file_load. We can check this to identify if it's
> > kexec-ed kernel or not.
> > 
> > Update patch with it?
> > 
> > static void *bzImage64_load(struct kimage *image, char *kernel,
> >                             unsigned long kernel_len, char *initrd,
> >                             unsigned long initrd_len, char *cmdline,
> >                             unsigned long cmdline_len)
> > {
> > 
> > 	...
> > 	/* bootloader info. Do we need a separate ID for kexec kernel loader? */
> >         params->hdr.type_of_loader = 0x0D << 4;
> 
> That's already documented in Documentation/x86/boot.txt
> 
> Field name:     type_of_loader
> Type:           write (obligatory)
> Offset/size:    0x210/1
> Protocol:       2.00+
> 
> 	...
> 
>         D  kexec-tools
> 
> And yes, the question in the code is still valid: do we need a separate ID.
> 
> I'd say no and we'll simply call 0xD all kernels loaded using a
> kexec-type syscall.

Yes, agree. Time has proved we don't need a separate ID, just 0x0D is
fine for both kexec/kdump. We can clear it away now.

I can make a patch to add a bit into xloadflags, to indicate that this
is kexec-ed kernel. It can help to differentiate kexec-ed kernel from
kdump kernel. As we know, kdump kernel is recognized with /proc/vmcore
existence. While during kernel initialization stage, or /proc/vmcore is
not validated in some cases, the adding bit may help.

Thoughts?

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
