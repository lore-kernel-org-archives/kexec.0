Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Un3Im-0005tY-91
 for kexec@lists.infradead.org; Thu, 13 Jun 2013 08:54:41 +0000
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Thu, 13 Jun 2013 09:49:22 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 171DB219005F
 for <kexec@lists.infradead.org>; Thu, 13 Jun 2013 09:57:37 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5D8s4X642205392
 for <kexec@lists.infradead.org>; Thu, 13 Jun 2013 08:54:04 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r5D8sDBX024956
 for <kexec@lists.infradead.org>; Thu, 13 Jun 2013 02:54:14 -0600
Date: Thu, 13 Jun 2013 10:54:11 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 3/5] vmcore: Introduce remap_oldmem_pfn_range()
Message-ID: <20130613105411.5ddeccfd@holzheu>
In-Reply-To: <51B92140.9050407@jp.fujitsu.com>
References: <1370624161-2298-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1370624161-2298-4-git-send-email-holzheu@linux.vnet.ibm.com>
 <CABOkKT0yk6tytN=aTSdpECQWw_30m5qrZYH-W1msovkeiSeZCA@mail.gmail.com>
 <20130610173739.4d88d4ec@holzheu>
 <CABOkKT05VR3V9rEz1LWnEJSEvkevhBFfQVVX5_DS0Z4rBG9EyA@mail.gmail.com>
 <20130612111303.3323f24f@holzheu> <51B92140.9050407@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Jan Willeke <willeke@de.ibm.com>, HATAYAMA Daisuke <d.hatayama@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, 13 Jun 2013 10:32:48 +0900
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> > Perhaps one open issue remains:
> >
> > Can we remove the page from the page cache if __read_vmcore() fails?
> >  
> 
> Yes, use page_cache_release() after unlocking the page like:
> 
>                     if (__read_vmcore(buf, PAGE_SIZE, &src, 0) < 0) {
>                             unlock_page(page);
> +                          page_cache_release(page);
>                             return VM_FAULT_SIGBUS;
>                     }
> 
> BTW, you now keep file->f_mapping in vma->vm_private_data, but the vma already has the file object in its vma->vm_file member. You can get the mapping by vma->vm_file->f_mapping without necessity of vma->vm_private_data.

Hello Hatayama,

Here the new function:

static int mmap_vmcore_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
{
        struct address_space *mapping = vma->vm_file->f_mapping;
        pgoff_t index = vmf->pgoff;
        struct page *page;
        loff_t src;
        char *buf;
        int rc;

        page = find_or_create_page(mapping, index, GFP_KERNEL);
        if (!page)
                return VM_FAULT_OOM;
        if (!PageUptodate(page)) {
                src = index << PAGE_CACHE_SHIFT;
                buf = (void *) (page_to_pfn(page) << PAGE_SHIFT);
                rc = __read_vmcore(buf, PAGE_SIZE, &src, 0);
                if (rc < 0) {
                        unlock_page(page);
                        page_cache_release(page);
                        return (rc == -ENOMEM) ? VM_FAULT_OOM : VM_FAULT_SIGBUS;
                }
                SetPageUptodate(page);
        }
        unlock_page(page);
        vmf->page = page;
        return 0;
}

Thanks for all the constructive feedback!

Best Regards,
Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
