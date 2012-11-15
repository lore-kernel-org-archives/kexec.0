Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TZ0QR-0002HE-2A
 for kexec@lists.infradead.org; Thu, 15 Nov 2012 14:28:16 +0000
Date: Thu, 15 Nov 2012 09:27:45 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <348117236.32179739.1352989665917.JavaMail.root@redhat.com>
In-Reply-To: <50A4E524.8020702@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
MIME-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, Vivek Goyal <vgoyal@redhat.com>, buendgen@de.ibm.com


----- Original Message -----
> 
> struct key in include/linux/key.h holds "authentication token"/"access
> credential"/"keyring". Suppose these entries should be scrubbed from the
> dumpfile. Then the keyring_name_hash hash table should be scanned and
> for each non-empty list, the entire list should be traversed and
> payload.value (or any other data) in struct key should be cleared.
> 
> Now the EPPIC macro looks like this:
> 
> int
> key()
> {
>     int i;
>     struct list_head *head;
>     struct list_head *next, *prev;
> 
>     head = (struct list_head *)keyring_name_hash;
> 
>     for (i = 0; i < 32; i++)
>     {
>         next = (struct list_head *) head[i].next;
>         prev = (struct list_head *) head[i].prev;
> 
>         if (!next)
>             continue;
> 
>         do
>         {
>             struct key *mykey, *off = 0;
> 
>             mykey = (struct key *)((unsigned long)(next)
>                       - ((unsigned long)&(off->type_data)));
> 
>             memset((char *)mykey->payload.value, 'X', 0x8);
> 
>             next = *(struct list_head **) mykey->type_data.link.next;
>         } while (next != prev);
>     }
>     return 1;
> }
> 
> The data can be cleared by specifying:
> makedumpfile -c -d 31 -x vmlinux --eppic key.c vmcore filtered_vmcore
>
> makedumpfile with the help of eppic will interpret the macro key.c,
> traverses all the hash chains and erases paylod.value of struct key.
> >>>
> >>> - What's the memory footprint of libeppic.a? Looks like this will be
> >>>   linked statically with makedumpfile, and how much is the size bloat of
> >>>   makedumpfile.
> >>
> >> Memory footprint of libeppic.a is around 1MB. Yes, this will be
> >> statically linked to makedumpfile. Users should specify EPPIC=on while
> >> building the makedumpfile and hence linking libeppic.a is optional
> > 
> > How would distributions handle it. Will we continue to build makedumpfile
> > without EPPIC=on. Any increase in initramfs size increase is frowned upon
> > in general.
> 
> We would like distributions to build makedumpfile with EPPIC=on.
> 
> I am not sure, but do you think ~1MB is too much increase to go with?
>
> >>>
> >>> - Is this supposed to work from kdump initramfs or it is supposed to be
> >>>   used on already saved dump (later during post processing).
> >>
> >>
> >> For the time being, it is only during post processing.
> > 
> > Again, how distributions will handle it. If it is being integrated
> > makedumpfile, as opposed to an stand alone utility, that means it
> > makedumpfile needs to link against this library so that somebody can
> > later filter out the symbols. And that means initramfs size bloat
> > too?
> 
> Yes, makedumpfile needs to be linked against eppic library for filtering
> data and this will increase makedumpfile size and initramfs size too.

Just to clarify -- your example indicates that the vmlinux file is required
for this facility to work, correct?
 
> makedumpfile -c -d 31 -x vmlinux --eppic key.c vmcore filtered_vmcore

Clearly distros won't be putting the vmlinux file in the initramfs -- that's
the whole reasoning behind vmcoreinfo.  So the 99% of users that aren't
interested in scrubbing will have to pay the penalty of the larger makedumpfile
binary.

Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
