Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMu7j-0006Z8-RV
 for kexec@lists.infradead.org; Fri, 10 Apr 2020 13:55:13 +0000
Date: Fri, 10 Apr 2020 21:54:42 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [GIT PULL 0/9] EFI fixes for v5.7-rc
Message-ID: <20200410135442.GA6772@dhcp-128-65.nay.redhat.com>
References: <20200409130434.6736-1-ardb@kernel.org>
 <20200409190109.GB45598@mit.edu>
 <CAMj1kXGiA3PAybR7r9tatL7WV5iU7B1OQxQok3d-JmRnhX1TnA@mail.gmail.com>
 <20200409201632.GC45598@mit.edu>
 <CAMj1kXFqKGSqm_y+ht4mmmu10TrhSyiTG8V3PxRYGodpZ=xNFQ@mail.gmail.com>
 <20200409235716.GF45598@mit.edu>
 <CAMj1kXH4VtNcJugpG_UR10ewGiOApTiw=C3FsuyAQQyg67Q8Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMj1kXH4VtNcJugpG_UR10ewGiOApTiw=C3FsuyAQQyg67Q8Aw@mail.gmail.com>
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
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi <linux-efi@vger.kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Gary Lin <glin@suse.com>, Sergey Shatunov <me@prok.pw>, Colin Ian King <colin.king@canonical.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, Jiri Slaby <jslaby@suse.cz>, Ingo Molnar <mingo@kernel.org>

Cc kexec list.
On 04/10/20 at 09:08am, Ard Biesheuvel wrote:
> On Fri, 10 Apr 2020 at 01:57, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > On Thu, Apr 09, 2020 at 11:29:06PM +0200, Ard Biesheuvel wrote:
> > > > What happens is that the kexec'ed kernel immediately crashes, at which
> > > > point we drop back into the BIOS, and then it boots the Debain 4.19.0
> > > > distro kernel instead of the kernel to be tested boot.  Since we lose
> > > > the boot command line that was used from the kexec, the gce-xfstests
> > > > image retries the kexec, which fails, and the failing kexec repeats
> > > > until I manually kill the VM.
> > >
> > > Does this help at all?
> > >
> > > diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> > > index 781170d36f50..52f8138243df 100644
> > > --- a/arch/x86/include/asm/efi.h
> > > +++ b/arch/x86/include/asm/efi.h
> > > @@ -180,6 +180,7 @@ extern void __init
> > > efi_uv1_memmap_phys_epilog(pgd_t *save_pgd);
> > >
> > >  struct efi_setup_data {
> > >         u64 fw_vendor;
> > > +       u64 __unused;
> > >         u64 tables;
> > >         u64 smbios;
> > >         u64 reserved[8];
> >
> >
> > Tested-by: Theodore Ts'o <tytso@mit.edu>
> >
> 
> OK, I'll spin a proper patch
> 
> > Yep, that fixed it.  Thanks!!
> >
> > I wonder if this structure definition should be moved something like
> > arch/x86/include/uapi/asm/efi.h so it's more obvious that the
> > structure layout is used externally to the kernel?
> >
> 
> Well, 95% of the data structures used by EFI are based on the UEFI
> spec, so the base assumption is really that we cannot make changes
> like these to begin with. But I'll add a DON'T TOUCH comment here in
> any case.
> 

The runtime cleanup looks a very good one, but I also missed that,
userspace kexec-tools will break with the efi setup_data changes. But
kexec_file_load will just work with the cleanup applied.

Ard, could you add kexec list in cc when you send the fix out?

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
