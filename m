Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1afJEd-0006IE-Rf
 for kexec@lists.infradead.org; Mon, 14 Mar 2016 03:32:00 +0000
Date: Mon, 14 Mar 2016 11:31:31 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH V2] proc-vmcore: wrong data type casting fix
Message-ID: <20160314033131.GA16436@dhcp-128-65.nay.redhat.com>
References: <20160311084248.GA9417@dhcp-128-65.nay.redhat.com>
 <20160314.122539.338096075.d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160314.122539.338096075.d.hatayama@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: bhe@redhat.com, mhuang@redhat.com, kexec@lists.infradead.org, nasa4836@gmail.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, vgoyal@redhat.com

Hi, HATAYAMA

On 03/14/16 at 12:25pm, HATAYAMA Daisuke wrote:
> From: Dave Young <dyoung@redhat.com>
> Subject: [PATCH V2] proc-vmcore: wrong data type casting fix
> Date: Fri, 11 Mar 2016 16:42:48 +0800
> 
> > On i686 PAE enabled machine the contiguous physical area could be large
> > and it can cause trimming down variables in below calculation in
> > read_vmcore() and mmap_vmcore():
> > 
> > 	tsz = min_t(size_t, m->offset + m->size - *fpos, buflen);
> > 
> > Then the real size passed down is not correct any more.
> > Suppose m->offset + m->size - *fpos being truncated to 0, buflen >0 then
> 
> That is, size_t and loff_t are defined as follows on i686:
> 
>     (gdb) ptype size_t
>     type = unsigned int
>     (gdb) ptype loff_t
>     type = long long int
> 
> So casting by size_t means truncating a given value by 4GB.
> 
> Then, if (m->offset + m->size - *fpos) is equal to or larger than 4GB,
> and is aligned with 4GB, the resulted value is 0, and
> 
> > we will get tsz = 0. It is of course not an expected result.
> > 
> > During our tests there are two problems caused by it:
> > 1) read_vmcore will refuse to continue so makedumpfile fails.
> > 2) mmap_vmcore will trigger BUG_ON() in remap_pfn_range().
> >
> 
> we reach these errors.
> 
> If (m->offset + m->size - *fpos) is not aligned with 4GB,
> read_vmcore() or mmap_vmcore() is performed with the truncated
> non-zero value as size (of course, this is also not expected value but
> the execution doesn't result in error). Then, fpos proceeds so that
> (m->offset + m->size - *fpos) is aligned with 4GB in the next loop,
> and we after all reach the errors.
> 
> I think your patch description needs a bit more detail.

I will add your extra comments into the patch description and resend it.

> 
> It seems good to me that the patch itself.

Thank you.

> 
> > Use unsigned long long in min_t instead so that the variables are not
> > truncated.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> > ---
> > v1->v2: spelling fix in patch log
> >  fs/proc/vmcore.c |    7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > --- linux-x86.orig/fs/proc/vmcore.c
> > +++ linux-x86/fs/proc/vmcore.c
> > @@ -231,7 +231,9 @@ static ssize_t __read_vmcore(char *buffe
> >  
> >  	list_for_each_entry(m, &vmcore_list, list) {
> >  		if (*fpos < m->offset + m->size) {
> > -			tsz = min_t(size_t, m->offset + m->size - *fpos, buflen);
> > +			tsz = (size_t)min_t(unsigned long long,
> > +					    m->offset + m->size - *fpos,
> > +					    buflen);
> >  			start = m->paddr + *fpos - m->offset;
> >  			tmp = read_from_oldmem(buffer, tsz, &start, userbuf);
> >  			if (tmp < 0)
> > @@ -461,7 +463,8 @@ static int mmap_vmcore(struct file *file
> >  		if (start < m->offset + m->size) {
> >  			u64 paddr = 0;
> >  
> > -			tsz = min_t(size_t, m->offset + m->size - start, size);
> > +			tsz = (size_t)min_t(unsigned long long,
> > +					    m->offset + m->size - start, size);
> >  			paddr = m->paddr + start - m->offset;
> >  			if (vmcore_remap_oldmem_pfn(vma, vma->vm_start + len,
> >  						    paddr >> PAGE_SHIFT, tsz,
> > 
> --
> Thanks.
> HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
