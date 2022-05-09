From: Baoquan He <bhe@redhat.com>
Date: Mon, 9 May 2022 13:26:59 +0800
Subject: [PATCH v8 1/7] x86/crash: fix minor typo/bug in debug message
In-Reply-To: <72764a3c-8b8c-8652-945e-9b15f31cda15@linux.ibm.com>
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-2-eric.devolder@oracle.com>
 <72764a3c-8b8c-8652-945e-9b15f31cda15@linux.ibm.com>
Message-ID: <YnimI5cZWXKeNSHY@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 05/09/22 at 10:46am, Sourabh Jain wrote:
> 
> On 06/05/22 00:15, Eric DeVolder wrote:
> > The pr_debug() intends to display the memsz member, but the
> > parameter is actually the bufsz member (which is already
> > displayed). Correct this to display memsz value.
> > 
> > Signed-off-by: Eric DeVolder<eric.devolder@oracle.com>
> > Reviewed-by: David Hildenbrand<david@redhat.com>
> > Acked-by: Baoquan He<bhe@redhat.com>
> > ---
> >   arch/x86/kernel/crash.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> > index e8326a8d1c5d..9730c88530fc 100644
> > --- a/arch/x86/kernel/crash.c
> > +++ b/arch/x86/kernel/crash.c
> > @@ -407,7 +407,7 @@ int crash_load_segments(struct kimage *image)
> >   	}
> >   	image->elf_load_addr = kbuf.mem;
> >   	pr_debug("Loaded ELF headers at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> > -		 image->elf_load_addr, kbuf.bufsz, kbuf.bufsz);
> > +		 image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
> > 
> I think we can push this patch separately.

Boris has taken this into tip/x86/kdump.


