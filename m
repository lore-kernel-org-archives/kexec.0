Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aOlwa-0007F6-2t
 for kexec@lists.infradead.org; Thu, 28 Jan 2016 12:45:03 +0000
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Thu, 28 Jan 2016 12:44:37 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 229C31B0806B
 for <kexec@lists.infradead.org>; Thu, 28 Jan 2016 12:44:43 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0SCiZOk11010496
 for <kexec@lists.infradead.org>; Thu, 28 Jan 2016 12:44:35 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0SCiY0i010462
 for <kexec@lists.infradead.org>; Thu, 28 Jan 2016 05:44:34 -0700
Date: Thu, 28 Jan 2016 13:44:32 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec: unmap reserved pages for each error-return way
Message-ID: <20160128134432.7f25bf77@holzheu>
In-Reply-To: <56AA0208.7050508@redhat.com>
References: <1453895311-11087-1-git-send-email-dsafonov@virtuozzo.com>
 <20160127111546.2212f191f5f313b613f6b60b@linux-foundation.org>
 <20160128113217.79d37ff5@holzheu> <56AA0208.7050508@redhat.com>
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

On Thu, 28 Jan 2016 19:56:56 +0800
Xunlei Pang <xpang@redhat.com> wrote:

> On 2016/01/28 at 18:32, Michael Holzheu wrote:
> > On Wed, 27 Jan 2016 11:15:46 -0800
> > Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> >> On Wed, 27 Jan 2016 14:48:31 +0300 Dmitry Safonov <dsafonov@virtuozzo.com> wrote:
> >>
> >>> For allocation of kimage failure or kexec_prepare or load segments
> >>> errors there is no need to keep crashkernel memory mapped.
> >>> It will affect only s390 as map/unmap hook defined only for it.
> >>> As on unmap s390 also changes os_info structure let's check return code
> >>> and add info only on success.
> >>>
> >> This conflicts (both mechanically and somewhat conceptually) with
> >> Xunlei Pang's "kexec: Introduce a protection mechanism for the
> >> crashkernel reserved memory" and "kexec: provide
> >> arch_kexec_protect(unprotect)_crashkres()".
> >>
> >> http://ozlabs.org/~akpm/mmots/broken-out/kexec-introduce-a-protection-mechanism-for-the-crashkernel-reserved-memory.patch
> >> http://ozlabs.org/~akpm/mmots/broken-out/kexec-introduce-a-protection-mechanism-for-the-crashkernel-reserved-memory-v4.patch
> >>
> >> and
> >>
> >> http://ozlabs.org/~akpm/mmots/broken-out/kexec-provide-arch_kexec_protectunprotect_crashkres.patch
> >> http://ozlabs.org/~akpm/mmots/broken-out/kexec-provide-arch_kexec_protectunprotect_crashkres-v4.patch
> > Hmm, It looks to me that arch_kexec_(un)protect_crashkres() has exactly
> > the same semantics as crash_(un)map_reserved_pages().
> >
> > On s390 we don't have the crashkernel memory mapped and therefore need
> > crash_map_reserved_pages() before loading something into crashkernel
> > memory.
> 
> I don't know s390, just curious, if s390 doesn't have crash kernel memory mapped,
> what's the purpose of the commit(558df7209e)  for s390 as the reserved crash memory
> with no kernel mapping already means the protection is on?

When we reserve crashkernel memory on s390 ("crashkernel=" kernel parameter),
we create a memory hole without page tables.

Commit (558df7209e) was necessary to load a kernel/ramdisk into
the memory hole with the kexec() system call.

We create a temporary mapping with crash_map_reserved_pages(), then
copy the kernel/ramdisk and finally remove the mapping again
via crash_unmap_reserved_pages().

We did that all in order to protect the preloaded kernel and ramdisk.

I forgot the details why commit(558df7209e) wasn't necessary before.
AFAIK it became necessary because of some kdump (mmap?) rework.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
