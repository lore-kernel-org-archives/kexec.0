Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1afISF-0008At-1M
 for kexec@lists.infradead.org; Mon, 14 Mar 2016 02:41:59 +0000
Date: Mon, 14 Mar 2016 10:41:31 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH V2] proc-vmcore: wrong data type casting fix
Message-ID: <20160314023854.GC2522@x1.redhat.com>
References: <20160311084248.GA9417@dhcp-128-65.nay.redhat.com>
 <20160311122711.f738d878070641f113dfd348@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160311122711.f738d878070641f113dfd348@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mhuang@redhat.com, kexec@lists.infradead.org, nasa4836@gmail.com, linux-kernel@vger.kernel.org, d.hatayama@jp.fujitsu.com, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

On 03/11/16 at 12:27pm, Andrew Morton wrote:
> On Fri, 11 Mar 2016 16:42:48 +0800 Dave Young <dyoung@redhat.com> wrote:
> 
> > On i686 PAE enabled machine the contiguous physical area could be large
> > and it can cause trimming down variables in below calculation in
> > read_vmcore() and mmap_vmcore():
> > 
> > 	tsz = min_t(size_t, m->offset + m->size - *fpos, buflen);
> > 
> > Then the real size passed down is not correct any more.
> > Suppose m->offset + m->size - *fpos being truncated to 0, buflen >0 then
> > we will get tsz = 0. It is of course not an expected result.
> 
> I don't really understand this.
> 
> vmcore.offset if loff_t which is 64-bit
> vmcore.size is long long
> *fpos is loff_t
> 
> so the expression should all be done with 64-bit arithmetic anyway.
> 
> Maybe buflen (size_t) has the wrong type, but the result of the other
> expression should be in-range by the time we come to doing the
> comparison.

Hi Andrew,

these vmcore-s relates to "System RAM" area in 1st kernel. E.g on my
machine with 8G physical RAM, I got:

[bhe@x1 ~]$ grep "System RAM" /proc/iomem 
00001000-0009cfff : System RAM
00100000-0fffffff : System RAM
1000b000-be0b2fff : System RAM
100000000-22dffffff : System RAM

For vmcore_list handling in mmap_vmcore() we have below formula:

tsz = min_t(size_t, m->offset + m->size - start, size);

In 2nd kernel, there could be 4 vmcore(s) to cover them for dumping
their content. For 4th area, 100000000-22dffffff, its vmcore could have
value like vmcore.offset=0x100000000, vmcore.size=0x12dffffff. 'start' 
here is dynamically changed, it should begin from vmcore->offset.
While 'size' is decided in makedumpfile which is user space utility, its
value is 0x400000, this is hardcoded.

So here makedumpfile will do mmap() and dump coutinuously until the
whole area is finished. Each time it will compare 'size', namely passed
in size, with the length of left area.

For formula in read_vmcore() as Dave mentioned:

tsz = min_t(size_t, m->offset + m->size - *fpos, buflen);

I didnt' add debug printing code. From makedumpfile code it reads one
page at one time. So here the buflen should be 4K.

So here their own type is OK, but the type set in min_t is bad.

Thanks
Baoquan

> 
> > During our tests there are two problems caused by it:
> > 1) read_vmcore will refuse to continue so makedumpfile fails.
> > 2) mmap_vmcore will trigger BUG_ON() in remap_pfn_range().
> > 
> > Use unsigned long long in min_t instead so that the variables are not
> > truncated.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> 
> I think we'll need a cc:stable here.
> 
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
> 
> This is rather a mess.  Can we please try to fix this bug by choosing
> appropriate types rather than all the typecasting?
> 
> 
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
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
