Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Umh7Z-0000KH-Qq
 for kexec@lists.infradead.org; Wed, 12 Jun 2013 09:13:38 +0000
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Wed, 12 Jun 2013 10:09:20 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id AC6C0219005F
 for <kexec@lists.infradead.org>; Wed, 12 Jun 2013 10:16:28 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5C9CvEZ52887656
 for <kexec@lists.infradead.org>; Wed, 12 Jun 2013 09:12:57 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5C9D7Vn007423
 for <kexec@lists.infradead.org>; Wed, 12 Jun 2013 03:13:07 -0600
Date: Wed, 12 Jun 2013 11:13:03 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 3/5] vmcore: Introduce remap_oldmem_pfn_range()
Message-ID: <20130612111303.3323f24f@holzheu>
In-Reply-To: <CABOkKT05VR3V9rEz1LWnEJSEvkevhBFfQVVX5_DS0Z4rBG9EyA@mail.gmail.com>
References: <1370624161-2298-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1370624161-2298-4-git-send-email-holzheu@linux.vnet.ibm.com>
 <CABOkKT0yk6tytN=aTSdpECQWw_30m5qrZYH-W1msovkeiSeZCA@mail.gmail.com>
 <20130610173739.4d88d4ec@holzheu>
 <CABOkKT05VR3V9rEz1LWnEJSEvkevhBFfQVVX5_DS0Z4rBG9EyA@mail.gmail.com>
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

On Tue, 11 Jun 2013 21:42:15 +0900
HATAYAMA Daisuke <d.hatayama@gmail.com> wrote:

> 2013/6/11 Michael Holzheu <holzheu@linux.vnet.ibm.com>:
> > On Mon, 10 Jun 2013 22:40:24 +0900
> > HATAYAMA Daisuke <d.hatayama@gmail.com> wrote:
> >
> >> 2013/6/8 Michael Holzheu <holzheu@linux.vnet.ibm.com>:
> >> <cut>
> >> > @@ -225,6 +251,56 @@ static ssize_t read_vmcore(struct file *file, char __user *buffer,
> >> >         return acc;
> >> >  }
> >> >
> >> > +static ssize_t read_vmcore(struct file *file, char __user *buffer,
> >> > +                          size_t buflen, loff_t *fpos)
> >> > +{
> >> > +       return __read_vmcore(buffer, buflen, fpos, 1);
> >> > +}
> >> > +
> >> > +/*
> >> > + * The vmcore fault handler uses the page cache and fills data using the
> >> > + * standard __vmcore_read() function.
> >> > + */
> >> > +static int mmap_vmcore_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
> >> > +{
> >> > +       struct address_space *mapping = vma->vm_private_data;
> >> > +       pgoff_t index = vmf->pgoff;
> >> > +       struct page *page;
> >> > +       loff_t src;
> >> > +       char *buf;
> >> > +       int rc;
> >> > +
> >> > +find_page:
> >> > +       page = find_lock_page(mapping, index);
> >> > +       if (page) {
> >> > +               unlock_page(page);
> >> > +               rc = VM_FAULT_MINOR;
> >> > +       } else {
> >> > +               page = page_cache_alloc_cold(mapping);
> >> > +               if (!page)
> >> > +                       return VM_FAULT_OOM;
> >> > +               rc = add_to_page_cache_lru(page, mapping, index, GFP_KERNEL);
> >> > +               if (rc) {
> >> > +                       page_cache_release(page);
> >> > +                       if (rc == -EEXIST)
> >> > +                               goto find_page;
> >> > +                       /* Probably ENOMEM for radix tree node */
> >> > +                       return VM_FAULT_OOM;
> >> > +               }
> >> > +               buf = (void *) (page_to_pfn(page) << PAGE_SHIFT);
> >> > +               src = index << PAGE_CACHE_SHIFT;
> >> > +               __read_vmcore(buf, PAGE_SIZE, &src, 0);
> >> > +               unlock_page(page);
> >> > +               rc = VM_FAULT_MAJOR;
> >> > +       }
> >> > +       vmf->page = page;
> >> > +       return rc;
> >> > +}
> >>
> >> How about reusing find_or_create_page()?
> >
> > The function would then look like the following:
> >
> > static int mmap_vmcore_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
> > {
> >         struct address_space *mapping = vma->vm_private_data;
> >         pgoff_t index = vmf->pgoff;
> >         struct page *page;
> >         loff_t src;
> >         char *buf;
> >
> >         page = find_or_create_page(mapping, index, GFP_KERNEL);
> >         if (!page)
> >                 return VM_FAULT_OOM;
> >         src = index << PAGE_CACHE_SHIFT;
> >         buf = (void *) (page_to_pfn(page) << PAGE_SHIFT);
> >         __read_vmcore(buf, PAGE_SIZE, &src, 0);
> >         unlock_page(page);
> >         vmf->page = page;
> >         return 0;
> > }
> >
> > I agree that this makes the function simpler but we have to copy
> > the page also if it has already been filled, correct?
> >
> 
> You can use for the purpose PG_uptodate flag.

Thanks for that hint! So together with your other comment regarding
error checking for __read_vmcore() the function would look like the
following:

static int mmap_vmcore_fault(struct vm_area_struct *vma, struct'vm_fault *vmf)
{
        struct address_space *mapping = vma->vm_private_data;
        pgoff_t index = vmf->pgoff;
        struct page *page;
        loff_t src;
        char *buf;

        page = find_or_create_page(mapping, index, GFP_KERNEL);
        if (!page)
                return VM_FAULT_OOM;
        if (!PageUptodate(page)) {
                src = index << PAGE_CACHE_SHIFT;
                buf = (void *) (page_to_pfn(page) << PAGE_SHIFT);
                if (__read_vmcore(buf, PAGE_SIZE, &src, 0) < 0) {
                        unlock_page(page);
                        return VM_FAULT_SIGBUS;
                }
                SetPageUptodate(page);
        }
        unlock_page(page);
        vmf->page = page;
        return 0;
}

Perhaps one open issue remains:

Can we remove the page from the page cache if __read_vmcore() fails?

Thanks!
Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
