Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UmwPx-00057e-Ro
 for kexec@lists.infradead.org; Thu, 13 Jun 2013 01:33:39 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 5B27F3EE0AE
 for <kexec@lists.infradead.org>; Thu, 13 Jun 2013 10:33:08 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 4985245DE51
 for <kexec@lists.infradead.org>; Thu, 13 Jun 2013 10:33:08 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 2D71A45DE4D
 for <kexec@lists.infradead.org>; Thu, 13 Jun 2013 10:33:08 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 1808F1DB803B
 for <kexec@lists.infradead.org>; Thu, 13 Jun 2013 10:33:08 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id BDB951DB8040
 for <kexec@lists.infradead.org>; Thu, 13 Jun 2013 10:33:07 +0900 (JST)
Message-ID: <51B92140.9050407@jp.fujitsu.com>
Date: Thu, 13 Jun 2013 10:32:48 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v5 3/5] vmcore: Introduce remap_oldmem_pfn_range()
References: <1370624161-2298-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1370624161-2298-4-git-send-email-holzheu@linux.vnet.ibm.com>
 <CABOkKT0yk6tytN=aTSdpECQWw_30m5qrZYH-W1msovkeiSeZCA@mail.gmail.com>
 <20130610173739.4d88d4ec@holzheu>
 <CABOkKT05VR3V9rEz1LWnEJSEvkevhBFfQVVX5_DS0Z4rBG9EyA@mail.gmail.com>
 <20130612111303.3323f24f@holzheu>
In-Reply-To: <20130612111303.3323f24f@holzheu>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Jan Willeke <willeke@de.ibm.com>, HATAYAMA Daisuke <d.hatayama@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

(2013/06/12 18:13), Michael Holzheu wrote:
> On Tue, 11 Jun 2013 21:42:15 +0900
> HATAYAMA Daisuke <d.hatayama@gmail.com> wrote:
>
>> 2013/6/11 Michael Holzheu <holzheu@linux.vnet.ibm.com>:
>>> On Mon, 10 Jun 2013 22:40:24 +0900
>>> HATAYAMA Daisuke <d.hatayama@gmail.com> wrote:
>>>
>>>> 2013/6/8 Michael Holzheu <holzheu@linux.vnet.ibm.com>:
<cut>
> static int mmap_vmcore_fault(struct vm_area_struct *vma, struct'vm_fault *vmf)
> {
>          struct address_space *mapping = vma->vm_private_data;
>          pgoff_t index = vmf->pgoff;
>          struct page *page;
>          loff_t src;
>          char *buf;
>
>          page = find_or_create_page(mapping, index, GFP_KERNEL);
>          if (!page)
>                  return VM_FAULT_OOM;
>          if (!PageUptodate(page)) {
>                  src = index << PAGE_CACHE_SHIFT;
>                  buf = (void *) (page_to_pfn(page) << PAGE_SHIFT);
>                  if (__read_vmcore(buf, PAGE_SIZE, &src, 0) < 0) {
>                          unlock_page(page);
>                          return VM_FAULT_SIGBUS;
>                  }
>                  SetPageUptodate(page);
>          }
>          unlock_page(page);
>          vmf->page = page;
>          return 0;
> }
>
> Perhaps one open issue remains:
>
> Can we remove the page from the page cache if __read_vmcore() fails?
>

Yes, use page_cache_release() after unlocking the page like:

                    if (__read_vmcore(buf, PAGE_SIZE, &src, 0) < 0) {
                            unlock_page(page);
+                          page_cache_release(page);
                            return VM_FAULT_SIGBUS;
                    }

BTW, you now keep file->f_mapping in vma->vm_private_data, but the vma already has the file object in its vma->vm_file member. You can get the mapping by vma->vm_file->f_mapping without necessity of vma->vm_private_data.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
