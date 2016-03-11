Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aeHol-0008MW-1k
 for kexec@lists.infradead.org; Fri, 11 Mar 2016 07:49:03 +0000
Date: Fri, 11 Mar 2016 15:48:27 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 2/2] [PATCH 2/2] proc-vmcore: wrong data type casting fix
Message-ID: <20160311074827.GA8337@dhcp-128-65.nay.redhat.com>
References: <20160311062953.623220113@redhat.com>
 <20160311071935.GA28205@dhcp-128-25.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160311071935.GA28205@dhcp-128-25.nay.redhat.com>
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
To: Minfei Huang <mhuang@redhat.com>
Cc: bhe@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, d.hatayama@jp.fujitsu.com, akpm@linux-foundation.org, vgoyal@redhat.com

Hi, Minfei

On 03/11/16 at 03:19pm, Minfei Huang wrote:
> On 03/11/16 at 02:21pm, dyoung@redhat.com wrote:
> > @@ -231,7 +231,8 @@ static ssize_t __read_vmcore(char *buffe
> >  
> >  	list_for_each_entry(m, &vmcore_list, list) {
> >  		if (*fpos < m->offset + m->size) {
> > -			tsz = min_t(size_t, m->offset + m->size - *fpos, buflen);
> > +			tsz = (size_t)min_lt(m->offset + m->size - *fpos,
> > +					    buflen);
> >  			start = m->paddr + *fpos - m->offset;
> >  			tmp = read_from_oldmem(buffer, tsz, &start, userbuf);
> >  			if (tmp < 0)
> > @@ -461,7 +462,7 @@ static int mmap_vmcore(struct file *file
> >  		if (start < m->offset + m->size) {
> >  			u64 paddr = 0;
> >  
> > -			tsz = min_t(size_t, m->offset + m->size - start, size);
> > +			tsz = (size_t)min_lt(m->offset + m->size - start, size);
> >  			paddr = m->paddr + start - m->offset;
> >  			if (vmcore_remap_oldmem_pfn(vma, vma->vm_start + len,
> >  						    paddr >> PAGE_SHIFT, tsz,
> 
> Hi, Dave.
> 
> Seems the previous parameter is unsigned long long, and the later one is
> size_t. The size of both these types doesn't change in running time, why
> not use min_t(unsigned long long, a, b) instead?

Just want a common macro so it can benefit other users so that we can simply
use it without knowning type details and avoid such similar bugs also.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
