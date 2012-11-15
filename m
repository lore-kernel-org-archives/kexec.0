Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TZ1h0-0000Iy-UV
 for kexec@lists.infradead.org; Thu, 15 Nov 2012 15:49:28 +0000
Date: Thu, 15 Nov 2012 10:49:14 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
Message-ID: <20121115154914.GE2529@redhat.com>
References: <20121108133554.28410.99763.stgit@aravinda>
 <20121114145445.GC20215@redhat.com>
 <50A3CFAD.6090008@linux.vnet.ibm.com>
 <20121114175304.GK20215@redhat.com>
 <50A4E524.8020702@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50A4E524.8020702@linux.vnet.ibm.com>
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
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, Dave Anderson <anderson@redhat.com>, buendgen@de.ibm.com

On Thu, Nov 15, 2012 at 06:20:44PM +0530, Aravinda Prasad wrote:

[..]
> > Can you give some details about how does it work and what's the
> > correlation with makedumpfile.
> 
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

Ok, are these the only places where key is. Can a copy of it exist in
some other buffers? We don't clear these.

Also, if key is the only issue, why not just write this logic in
makedumpfile and provide another option, --clear-kernel-keys.

Why to introduce such generic scheme.

[..]
> >>> - What's the memory footprint of libeppic.a? Looks like this will be
> >>>   linked statically with makedumpfile, and how much is the size bloat of
> >>>   makedumpfile.
> >>
> >>
> >> Memory footprint of libeppic.a is around 1MB. Yes, this will be
> >> statically linked to makedumpfile. Users should specify EPPIC=on while
> >> building the makedumpfile and hence linking libeppic.a is optional

1MB bloat is significant given the fact that we reserve only 128MB for
kdump kernel. Hence we need to review the benefits of this bloat very
carefully.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
