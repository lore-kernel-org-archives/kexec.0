Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Um4Aa-0005dv-7t
 for kexec@lists.infradead.org; Mon, 10 Jun 2013 15:38:08 +0000
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Mon, 10 Jun 2013 16:33:55 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id BB2182190023
 for <kexec@lists.infradead.org>; Mon, 10 Jun 2013 16:41:00 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5AFbVZr50593960
 for <kexec@lists.infradead.org>; Mon, 10 Jun 2013 15:37:31 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r5AFbfSU008175
 for <kexec@lists.infradead.org>; Mon, 10 Jun 2013 09:37:41 -0600
Date: Mon, 10 Jun 2013 17:37:39 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 3/5] vmcore: Introduce remap_oldmem_pfn_range()
Message-ID: <20130610173739.4d88d4ec@holzheu>
In-Reply-To: <CABOkKT0yk6tytN=aTSdpECQWw_30m5qrZYH-W1msovkeiSeZCA@mail.gmail.com>
References: <1370624161-2298-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1370624161-2298-4-git-send-email-holzheu@linux.vnet.ibm.com>
 <CABOkKT0yk6tytN=aTSdpECQWw_30m5qrZYH-W1msovkeiSeZCA@mail.gmail.com>
Mime-Version: 1.0
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
To: HATAYAMA Daisuke <d.hatayama@gmail.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

On Mon, 10 Jun 2013 22:40:24 +0900
HATAYAMA Daisuke <d.hatayama@gmail.com> wrote:

> 2013/6/8 Michael Holzheu <holzheu@linux.vnet.ibm.com>:
> <cut>
> > @@ -225,6 +251,56 @@ static ssize_t read_vmcore(struct file *file, char __user *buffer,
> >         return acc;
> >  }
> >
> > +static ssize_t read_vmcore(struct file *file, char __user *buffer,
> > +                          size_t buflen, loff_t *fpos)
> > +{
> > +       return __read_vmcore(buffer, buflen, fpos, 1);
> > +}
> > +
> > +/*
> > + * The vmcore fault handler uses the page cache and fills data using the
> > + * standard __vmcore_read() function.
> > + */
> > +static int mmap_vmcore_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
> > +{
> > +       struct address_space *mapping = vma->vm_private_data;
> > +       pgoff_t index = vmf->pgoff;
> > +       struct page *page;
> > +       loff_t src;
> > +       char *buf;
> > +       int rc;
> > +
> > +find_page:
> > +       page = find_lock_page(mapping, index);
> > +       if (page) {
> > +               unlock_page(page);
> > +               rc = VM_FAULT_MINOR;
> > +       } else {
> > +               page = page_cache_alloc_cold(mapping);
> > +               if (!page)
> > +                       return VM_FAULT_OOM;
> > +               rc = add_to_page_cache_lru(page, mapping, index, GFP_KERNEL);
> > +               if (rc) {
> > +                       page_cache_release(page);
> > +                       if (rc == -EEXIST)
> > +                               goto find_page;
> > +                       /* Probably ENOMEM for radix tree node */
> > +                       return VM_FAULT_OOM;
> > +               }
> > +               buf = (void *) (page_to_pfn(page) << PAGE_SHIFT);
> > +               src = index << PAGE_CACHE_SHIFT;
> > +               __read_vmcore(buf, PAGE_SIZE, &src, 0);
> > +               unlock_page(page);
> > +               rc = VM_FAULT_MAJOR;
> > +       }
> > +       vmf->page = page;
> > +       return rc;
> > +}
> 
> How about reusing find_or_create_page()?

The function would then look like the following:

static int mmap_vmcore_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
{
        struct address_space *mapping = vma->vm_private_data;
        pgoff_t index = vmf->pgoff;
        struct page *page;
        loff_t src;
        char *buf;

        page = find_or_create_page(mapping, index, GFP_KERNEL);
        if (!page)
                return VM_FAULT_OOM;
        src = index << PAGE_CACHE_SHIFT;
        buf = (void *) (page_to_pfn(page) << PAGE_SHIFT);
        __read_vmcore(buf, PAGE_SIZE, &src, 0);
        unlock_page(page);
        vmf->page = page;
        return 0;
}

I agree that this makes the function simpler but we have to copy
the page also if it has already been filled, correct?

But since normally only one process uses /proc/vmcore this might be
acceptable.

BTW: I also removed the VM_FAULT_MAJOR/MINOR because I think the fault
handler should return 0 if a page has been found.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
