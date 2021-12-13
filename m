Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwheH-008dip-QY
 for kexec@lists.infradead.org; Mon, 13 Dec 2021 09:29:35 +0000
Date: Mon, 13 Dec 2021 17:29:15 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 3/3] vmcore: Convert read_from_oldmem() to take an iov_iter
Message-ID: <20211213092915.GC29905@MiWiFi-R3L-srv>
References: <20211213000636.2932569-1-willy@infradead.org>
 <20211213000636.2932569-4-willy@infradead.org>
 <20211213080257.GC20986@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211213080257.GC20986@lst.de>
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
To: Christoph Hellwig <hch@lst.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org, Amit Daniel Kachhap <amit.kachhap@arm.com>, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org

On 12/13/21 at 09:02am, Christoph Hellwig wrote:
> >  
> >  ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
> >  {
> > -	return read_from_oldmem(buf, count, ppos, 0,
> > +	struct kvec kvec = { .iov_base = buf, .iov_len = count };
> > +	struct iov_iter iter;
> > +
> > +	iov_iter_kvec(&iter, READ, &kvec, 1, count);
> > +
> > +	return read_from_oldmem(&iter, count, ppos,
> >  				cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT));
> >  }
> 
> elfcorehdr_read should probably also take an iov_iter while we're at it.
> 
> I also don't quite understand why we even need the arch overrides for it,
> but that would require some digging into the history of this interface.
> 

Below patchset removing sec_active() from generic code added this arch
override on x86_64. Before that, s390 and arm64 have had arch overrides. 
And arm64 says "elfcorehdr_read() is simple as the region is always mapped."
in commit e62aaeac42 "arm64: kdump: provide /proc/vmcore file".

[v3,0/6] Remove x86-specific code from generic headers
https://patchwork.kernel.org/project/linux-fsdevel/cover/20190718032858.28744-1-bauerman@linux.ibm.com/

5cbdaeefb655 s390/mm: Remove sev_active() function
ae7eb82a92fa fs/core/vmcore: Move sev_active() reference to x86 arch code
284e21fab2cf x86, s390/mm: Move sme_active() and sme_me_mask to x86-specific header
e740815a97e2 dma-mapping: Remove dma_check_mask()
47e5d8f9ed34 swiotlb: Remove call to sme_active()
0c9c1d563975 x86, s390: Move ARCH_HAS_MEM_ENCRYPT definition to arch/Kconfig



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
