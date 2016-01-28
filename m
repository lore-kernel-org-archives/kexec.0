Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aOjse-0000s7-0E
 for kexec@lists.infradead.org; Thu, 28 Jan 2016 10:32:50 +0000
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Thu, 28 Jan 2016 10:32:23 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7313F17D8059
 for <kexec@lists.infradead.org>; Thu, 28 Jan 2016 10:32:28 +0000 (GMT)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0SAWJNb1442118
 for <kexec@lists.infradead.org>; Thu, 28 Jan 2016 10:32:19 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0SAWIOi005142
 for <kexec@lists.infradead.org>; Thu, 28 Jan 2016 05:32:19 -0500
Date: Thu, 28 Jan 2016 11:32:17 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec: unmap reserved pages for each error-return way
Message-ID: <20160128113217.79d37ff5@holzheu>
In-Reply-To: <20160127111546.2212f191f5f313b613f6b60b@linux-foundation.org>
References: <1453895311-11087-1-git-send-email-dsafonov@virtuozzo.com>
 <20160127111546.2212f191f5f313b613f6b60b@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-s390@vger.kernel.org, Dmitry Safonov <dsafonov@virtuozzo.com>, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, 0x7f454c46@gmail.com, schwidefsky@de.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, Xunlei Pang <xlpang@redhat.com>

On Wed, 27 Jan 2016 11:15:46 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 27 Jan 2016 14:48:31 +0300 Dmitry Safonov <dsafonov@virtuozzo.com> wrote:
> 
> > For allocation of kimage failure or kexec_prepare or load segments
> > errors there is no need to keep crashkernel memory mapped.
> > It will affect only s390 as map/unmap hook defined only for it.
> > As on unmap s390 also changes os_info structure let's check return code
> > and add info only on success.
> > 
> 
> This conflicts (both mechanically and somewhat conceptually) with
> Xunlei Pang's "kexec: Introduce a protection mechanism for the
> crashkernel reserved memory" and "kexec: provide
> arch_kexec_protect(unprotect)_crashkres()".
> 
> http://ozlabs.org/~akpm/mmots/broken-out/kexec-introduce-a-protection-mechanism-for-the-crashkernel-reserved-memory.patch
> http://ozlabs.org/~akpm/mmots/broken-out/kexec-introduce-a-protection-mechanism-for-the-crashkernel-reserved-memory-v4.patch
> 
> and
> 
> http://ozlabs.org/~akpm/mmots/broken-out/kexec-provide-arch_kexec_protectunprotect_crashkres.patch
> http://ozlabs.org/~akpm/mmots/broken-out/kexec-provide-arch_kexec_protectunprotect_crashkres-v4.patch

Hmm, It looks to me that arch_kexec_(un)protect_crashkres() has exactly
the same semantics as crash_(un)map_reserved_pages().

On s390 we don't have the crashkernel memory mapped and therefore need
crash_map_reserved_pages() before loading something into crashkernel
memory.

Perhaps I missed something?
Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
