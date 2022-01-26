From: Baoquan He <bhe@redhat.com>
Date: Wed, 26 Jan 2022 16:03:00 +0800
Subject: [PATCH v3 3/6] crash hp: definitions and prototype changes
In-Reply-To: <8af14bc9-7aab-433b-f741-494b3857226f@oracle.com>
References: <20220110195727.1682-1-eric.devolder@oracle.com>
 <20220110195727.1682-4-eric.devolder@oracle.com>
 <20220119082645.GA6349@MiWiFi-R3L-srv>
 <8af14bc9-7aab-433b-f741-494b3857226f@oracle.com>
Message-ID: <20220126080300.GA6588@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 01/21/22 at 07:48am, Eric DeVolder wrote:
...... 
> > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > > index 0c994ae37729..068f853f1c65 100644
> > > --- a/include/linux/kexec.h
> > > +++ b/include/linux/kexec.h
> > > @@ -221,8 +221,9 @@ struct crash_mem {
> > >   extern int crash_exclude_mem_range(struct crash_mem *mem,
> > >   				   unsigned long long mstart,
> > >   				   unsigned long long mend);
> > > -extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
> > > -				       void **addr, unsigned long *sz);
> > > +extern int crash_prepare_elf64_headers(struct kimage *image,
> > > +					struct crash_mem *mem, int kernel_map,
> > > +					void **addr, unsigned long *sz);
> > >   #endif /* CONFIG_KEXEC_FILE */
> > >   #ifdef CONFIG_KEXEC_ELF
> > > @@ -299,6 +300,13 @@ struct kimage {
> > >   	/* Information for loading purgatory */
> > >   	struct purgatory_info purgatory_info;
> > > +
> > > +#ifdef CONFIG_CRASH_HOTPLUG
> > > +	bool hotplug_event;
> > > +	int offlinecpu;
> > > +	bool elf_index_valid;
> > > +	int elf_index;
> > 
> > Do we really need elf_index_valid? Can we initialize elf_index to , e.g '-1',
> > then check if the value is valid?
> 
> These members become part of struct kimage, and when the kimage is
> allocated, it is automatically zero'd. Wrt/ elf_index, 0 is a valid index,
> and so it needs to be qualified. I initially had used -1, but that required
> code and was fragile as I had to find the right place to do that. Using the
> boolean elf_index_valid, the problems with -1 vanish, and for free! I also
> found when examining the code that reading 'elf_index_valid' was better than
> 'elf_index != -1', more clear.
> 
> Let me know what you think.

OK, I am fine with it. Will see if other people have comment.


