Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aOVZX-0001Wt-Ij
 for kexec@lists.infradead.org; Wed, 27 Jan 2016 19:16:08 +0000
Date: Wed, 27 Jan 2016 11:15:46 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kexec: unmap reserved pages for each error-return way
Message-Id: <20160127111546.2212f191f5f313b613f6b60b@linux-foundation.org>
In-Reply-To: <1453895311-11087-1-git-send-email-dsafonov@virtuozzo.com>
References: <1453895311-11087-1-git-send-email-dsafonov@virtuozzo.com>
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
To: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, 0x7f454c46@gmail.com, schwidefsky@de.ibm.com, holzheu@linux.vnet.ibm.com, dyoung@redhat.com, Xunlei Pang <xlpang@redhat.com>

On Wed, 27 Jan 2016 14:48:31 +0300 Dmitry Safonov <dsafonov@virtuozzo.com> wrote:

> For allocation of kimage failure or kexec_prepare or load segments
> errors there is no need to keep crashkernel memory mapped.
> It will affect only s390 as map/unmap hook defined only for it.
> As on unmap s390 also changes os_info structure let's check return code
> and add info only on success.
> 

This conflicts (both mechanically and somewhat conceptually) with
Xunlei Pang's "kexec: Introduce a protection mechanism for the
crashkernel reserved memory" and "kexec: provide
arch_kexec_protect(unprotect)_crashkres()".

http://ozlabs.org/~akpm/mmots/broken-out/kexec-introduce-a-protection-mechanism-for-the-crashkernel-reserved-memory.patch
http://ozlabs.org/~akpm/mmots/broken-out/kexec-introduce-a-protection-mechanism-for-the-crashkernel-reserved-memory-v4.patch

and

http://ozlabs.org/~akpm/mmots/broken-out/kexec-provide-arch_kexec_protectunprotect_crashkres.patch
http://ozlabs.org/~akpm/mmots/broken-out/kexec-provide-arch_kexec_protectunprotect_crashkres-v4.patch

so can we please sort all that out?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
