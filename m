From: Baoquan He <bhe@redhat.com>
Date: Thu, 27 Jan 2022 15:51:32 +0800
Subject: [PATCH v3 6/6] crash hp: Add x86 crash hotplug support
In-Reply-To: <cf834659-3d8c-7ab5-ccd4-c877b0b9a2f0@oracle.com>
References: <20220110195727.1682-1-eric.devolder@oracle.com>
 <20220110195727.1682-7-eric.devolder@oracle.com>
 <20220119102323.GB6349@MiWiFi-R3L-srv>
 <280485c9-4612-892c-0e3e-9e8b09e60cf9@oracle.com>
 <20220126091243.GB6588@MiWiFi-R3L-srv>
 <cf834659-3d8c-7ab5-ccd4-c877b0b9a2f0@oracle.com>
Message-ID: <20220127075132.GB13508@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 01/26/22 at 11:32am, Eric DeVolder wrote:
..snip.... 
> > > > > +void arch_crash_hotplug_handler(struct kimage *image,
> > > > > +	unsigned int hp_action, unsigned long a, unsigned long b)
> > > > > +{
> > > > > +	/*
> > > > > +	 * To accurately reflect hot un/plug changes, the elfcorehdr (which
> > > > > +	 * is passed to the crash kernel via the elfcorehdr= parameter)
> > > > > +	 * must be updated with the new list of CPUs and memories. The new
> > > > > +	 * elfcorehdr is prepared in a kernel buffer, and if no errors,
> > > > > +	 * then it is written on top of the existing/old elfcorehdr.
> > > > > +	 *
> > > > > +	 * Due to the change to the elfcorehdr, purgatory must explicitly
> > > > > +	 * exclude the elfcorehdr from the list of segments it checks.
> > > > > +	 */
> > > > 
> > > > Please move this code comment to above function as kernel-doc if you
> > > > this it benefits the entire function. Otherwise should move them above
> > > > the code block they are explaining. For this place, I think moving them
> > > > to above arch_crash_hotplug_handler() is better.
> > > 
> > > ok, I will do that!
> > > 
> > > > 
> > > > > +	struct kexec_segment *ksegment;
> > > > > +	unsigned char *ptr = NULL;
> > > > > +	unsigned long elfsz = 0;
> > > > > +	void *elfbuf = NULL;
> > > > > +	unsigned long mem, memsz;
> > > > > +	unsigned int n;
> > > > > +
> > > > > +	/*
> > > > > +	 * When the struct kimage is alloced, it is wiped to zero, so
> > > > > +	 * the elf_index_valid defaults to false. It is set on the
> > > > > +	 * kexec_file_load path, or here for kexec_load.
> > > > > +	 */
> > > > 
> > > > I think this kexec loading part should be taken out and post after this
> > > > whole patchset being accepted. At least, it's worth to put them in a
> > > > separate patch.
> > > 
> > > This little bit of code that identifies the incoming elfcorehdr is all that
> > > is needed to support kexec_load (and the userspace changes of course). I'm
> > > happy to split as a separate patch, but I would think that be maintaining it
> > > with this series, then when it is accepted, both the kexec_load and
> > > kexec_file_load paths would be supported? Your call.
> > 
> > Hmm, at first, let's split it out from this patch since it's an
> > independent action to kdump. I would suggest we don't carry it in this
> > series. After this series is done, you can post another patchset
> > including this part as kernel patch, and also the code change in
> > kexec_tools as user space patch.
> > 
> > ......
> > 
> 
> OK, I'll remove the bit of code that supports kexec_load, so it can be introduced
> later coincident with the changes to kexec-tools.
> 
> In a previous message you mentioned making changes to the order of the patches,
> was this it, or is there more to come?

Yeah, replied to cover letter, please check it there.


