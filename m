Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp06.uk.ibm.com ([195.75.94.102])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aOn9F-0002EN-5L
 for kexec@lists.infradead.org; Thu, 28 Jan 2016 14:02:12 +0000
Received: from localhost
 by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Thu, 28 Jan 2016 14:01:45 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id C3ADE2190068
 for <kexec@lists.infradead.org>; Thu, 28 Jan 2016 14:01:19 +0000 (GMT)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0SE1W7N9372006
 for <kexec@lists.infradead.org>; Thu, 28 Jan 2016 14:01:32 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0SE1UGv001107
 for <kexec@lists.infradead.org>; Thu, 28 Jan 2016 07:01:31 -0700
Date: Thu, 28 Jan 2016 15:01:28 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec: unmap reserved pages for each error-return way
Message-ID: <20160128150128.564bfcdd@holzheu>
In-Reply-To: <56AA13D6.20808@redhat.com>
References: <1453895311-11087-1-git-send-email-dsafonov@virtuozzo.com>
 <20160127111546.2212f191f5f313b613f6b60b@linux-foundation.org>
 <20160128113217.79d37ff5@holzheu> <56AA0208.7050508@redhat.com>
 <20160128134432.7f25bf77@holzheu> <56AA13D6.20808@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: xlpang@redhat.com
Cc: linux-s390@vger.kernel.org, Dmitry Safonov <dsafonov@virtuozzo.com>, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, 0x7f454c46@gmail.com, xpang@redhat.com, schwidefsky@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>, dyoung@redhat.com, kexec@lists.infradead.org

On Thu, 28 Jan 2016 21:12:54 +0800
Xunlei Pang <xpang@redhat.com> wrote:

> On 2016/01/28 at 20:44, Michael Holzheu wrote:
> > On Thu, 28 Jan 2016 19:56:56 +0800
> > Xunlei Pang <xpang@redhat.com> wrote:
> >
> >> On 2016/01/28 at 18:32, Michael Holzheu wrote:
> >>> On Wed, 27 Jan 2016 11:15:46 -0800
> >>> Andrew Morton <akpm@linux-foundation.org> wrote:
> >>>
> >>>> On Wed, 27 Jan 2016 14:48:31 +0300 Dmitry Safonov <dsafonov@virtuozzo.com> wrote:
> >>>>
> >>>>> For allocation of kimage failure or kexec_prepare or load segments
> >>>>> errors there is no need to keep crashkernel memory mapped.
> >>>>> It will affect only s390 as map/unmap hook defined only for it.
> >>>>> As on unmap s390 also changes os_info structure let's check return code
> >>>>> and add info only on success.
> >>>>>
> >>>> This conflicts (both mechanically and somewhat conceptually) with
> >>>> Xunlei Pang's "kexec: Introduce a protection mechanism for the
> >>>> crashkernel reserved memory" and "kexec: provide
> >>>> arch_kexec_protect(unprotect)_crashkres()".
> >>>>
> >>>> http://ozlabs.org/~akpm/mmots/broken-out/kexec-introduce-a-protection-mechanism-for-the-crashkernel-reserved-memory.patch
> >>>> http://ozlabs.org/~akpm/mmots/broken-out/kexec-introduce-a-protection-mechanism-for-the-crashkernel-reserved-memory-v4.patch
> >>>>
> >>>> and
> >>>>
> >>>> http://ozlabs.org/~akpm/mmots/broken-out/kexec-provide-arch_kexec_protectunprotect_crashkres.patch
> >>>> http://ozlabs.org/~akpm/mmots/broken-out/kexec-provide-arch_kexec_protectunprotect_crashkres-v4.patch
> >>> Hmm, It looks to me that arch_kexec_(un)protect_crashkres() has exactly
> >>> the same semantics as crash_(un)map_reserved_pages().
> >>>
> >>> On s390 we don't have the crashkernel memory mapped and therefore need
> >>> crash_map_reserved_pages() before loading something into crashkernel
> >>> memory.
> >> I don't know s390, just curious, if s390 doesn't have crash kernel memory mapped,
> >> what's the purpose of the commit(558df7209e)  for s390 as the reserved crash memory
> >> with no kernel mapping already means the protection is on?
> > When we reserve crashkernel memory on s390 ("crashkernel=" kernel parameter),
> > we create a memory hole without page tables.
> >
> > Commit (558df7209e) was necessary to load a kernel/ramdisk into
> > the memory hole with the kexec() system call.
> >
> > We create a temporary mapping with crash_map_reserved_pages(), then
> > copy the kernel/ramdisk and finally remove the mapping again
> > via crash_unmap_reserved_pages().
> 
> Thanks for the explanation.
> So, on s390 the physical memory address has the same value as its kernel virtual address,
> and kmap() actually returns the value of the physical address of the page, right?

Correct. On s390 kmap() always return the physical address of the page.

We have an 1:1 mapping for all the physical memory. For this area
virtual=real. In addition to that we have the vmalloc area above
the 1:1 mapping where some of the memory is mapped a second time.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
