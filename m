Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3F5E7D0BC
	for <kexec@archiver.kernel.org>; Fri, 22 Sep 2023 01:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wl/R1XhzJW+m9wonYINeE2HFTeu40i0+IOyTjRDlwQE=; b=C9HM+aivb/VcUV
	uMl1rx3DmhIeQvq6uhT6vaGgG974fskq8luBxwpADApuvjE/xhzUsFFhFirJrJvtJm8Yv+xoluKBt
	34WMiieefVLyOAScq6VCfdUKwZFVJi87jKOWisP9LWsstJGBlEp8n4481119Ng/grLm7EBNicB72c
	hL5J5D5TwJ2As6P68+1Vcn1+yvXsQZ58e4DEOUIJQs7qUMtr6V9oEEOsq141K/ZRDFw2Rbe3wqcly
	ebwKfqwDJJMR4aiAH3r62PH4byEenYIIhi27OzlpODCN8l4TmKpaeQsYHkFxCIL8zCBROYllayYFp
	34E73c633V/6g5VctAIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjV0h-007Ygl-34;
	Fri, 22 Sep 2023 01:31:11 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjU0V-007TDB-2p
	for kexec@lists.infradead.org;
	Fri, 22 Sep 2023 00:26:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id B86ECCE235C;
	Fri, 22 Sep 2023 00:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B58CC433C8;
	Fri, 22 Sep 2023 00:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1695342412;
	bh=kfFmrRzad/TqOSvNuoiBiDpy6r9bqNBbz7/tgMVKhUQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UjGCycgtL1VEO5i1HTKdbjPQnuvU4q6PO640E68jPSQHG3rN8G05h0tNLxjCI8XIo
	 4iVo553ITeqavUDKbB2XEeYuvWGbmHX1iWNm4ariIoLFDi8B6DYiUEPxvV0fUEQLvg
	 YnD8Xn6AcJ0mDL5cLz7bE/4ODJS1/iiuC6AhVpZU=
Date: Thu, 21 Sep 2023 17:26:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com, ebiederm@xmission.com, kexec@lists.infradead.org,
 sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
 boris.ostrovsky@oracle.com
Subject: Re: [PATCH] kexec: change locking mechanism to a mutex
Message-Id: <20230921172650.aeacc5de4f45d13e5671d7b2@linux-foundation.org>
In-Reply-To: <20230921215938.2192-1-eric.devolder@oracle.com>
References: <20230921215938.2192-1-eric.devolder@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_172656_260885_14FC0D92 
X-CRM114-Status: GOOD (  36.67  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, 21 Sep 2023 17:59:38 -0400 Eric DeVolder <eric.devolder@oracle.com> wrote:

> Scaled up testing has revealed that the kexec_trylock()
> implementation leads to failures within the crash hotplug
> infrastructure due to the inability to acquire the lock,
> specifically the message:
> 
>  crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> 
> When hotplug events occur, the crash hotplug infrastructure first
> attempts to obtain the lock via the kexec_trylock(). However, the
> implementation either acquires the lock, or fails and returns; there
> is no waiting on the lock. Here is the comment/explanation from
> kernel/kexec_internal.h:kexec_trylock():
> 
>  * Whatever is used to serialize accesses to the kexec_crash_image needs to be
>  * NMI safe, as __crash_kexec() can happen during nmi_panic(), so here we use a
>  * "simple" atomic variable that is acquired with a cmpxchg().
> 
> While this in theory can happen for either CPU or memory hoptlug,
> this problem is most prone to occur for memory hotplug.
> 
> When memory is hot plugged, the memory is converted into smaller
> 128MiB memblocks (typically). As each memblock is processed, a
> kernel thread and a udev event thread are created. The udev thread
> tries for the lock via the reading of the sysfs node
> /sys/devices/system/memory/crash_hotplug node, and the kernel
> worker thread tries for the lock upon entering the crash hotplug
> infrastructure.
> 
> These threads then compete for the kexec lock.
> 
> For example, a 1GiB DIMM is converted into 8 memblocks, each
> spawning two threads for a total of 16 threads that create a small
> "swarm" all trying to acquire the lock. The larger the DIMM, the
> more the memblocks and the larger the swarm.
> 
> At the root of the problem is the atomic lock behind kexec_trylock();
> it works well for low lock traffic; ie loading/unloading a capture
> kernel, things that happen basically once. But with the introduction
> of crash hotplug, the traffic through the lock increases significantly,
> and more importantly in bursts occurring at roughly the same time. Thus
> there is a need to wait on the lock.
> 
> A possible workaround is to simply retry the lock, say up to N times.
> There is, of course, the problem of determining a value of N that works for
> all implementations, and for all the other call sites of kexec_trylock().
> Not ideal.
> 
> The design decision to use the atomic lock is described in the comment
> from kexec_internal.h, cited above. However, examining the code of
> __crash_kexec():
> 
>         if (kexec_trylock()) {
>                 if (kexec_crash_image) {
>                         ...
>                 }
>                 kexec_unlock();
>         }
> 
> reveals that the use of kexec_trylock() here is actually a "best effort"
> due to the atomic lock.  This atomic lock, prior to crash hotplug,
> would almost always be assured (another kexec syscall could hold the lock
> and prevent this, but that is about it).
> 
> So at the point where the capture kernel would be invoked, if the lock
> is not obtained, then kdump doesn't occur.
> 
> It is possible to instead use a mutex with proper waiting, and utilize
> mutex_trylock() as the "best effort" in __crash_kexec(). The use of a
> mutex then avoids all the lock acquisition problems that were revealed
> by the crash hotplug activity.
> 
> Convert the atomic lock to a mutex.
> 
> ...
>
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -47,7 +47,7 @@
>  #include <crypto/hash.h>
>  #include "kexec_internal.h"
>  
> -atomic_t __kexec_lock = ATOMIC_INIT(0);
> +DEFINE_MUTEX(__kexec_lock);
>  
>  /* Flag to indicate we are going to kexec a new kernel */
>  bool kexec_in_progress = false;
> @@ -1057,7 +1057,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
>  	 * of memory the xchg(&kexec_crash_image) would be
>  	 * sufficient.  But since I reuse the memory...
>  	 */
> -	if (kexec_trylock()) {
> +	if (mutex_trylock(&__kexec_lock)) {
>  		if (kexec_crash_image) {
>  			struct pt_regs fixed_regs;

What's happening here?  If someone else held the lock we silently fail
to run the kexec?  Shouldn't we at least alert the user to what just
happened?



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
