Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQWMF-0006DM-GF
 for kexec@lists.infradead.org; Fri, 01 Nov 2019 12:48:53 +0000
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93233800EBA
 for <kexec@lists.infradead.org>; Fri,  1 Nov 2019 12:48:45 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A15326574
 for <kexec@lists.infradead.org>; Fri,  1 Nov 2019 12:48:45 +0000 (UTC)
Date: Fri, 1 Nov 2019 08:48:45 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1684529127.9771679.1572612525461.JavaMail.zimbra@redhat.com>
In-Reply-To: <20191101014837.lxmqee5jyic7lk4d@two.firstfloor.org>
References: <20191101014837.lxmqee5jyic7lk4d@two.firstfloor.org>
Subject: Re: [Crash-utility] crash and makedumpfile with 5.3 missing memory
 in	dump
MIME-Version: 1.0
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
To: "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>
Cc: kexec@lists.infradead.org



----- Original Message -----
> Hi,
> 
> [I'm not sure if that is a crash or mkdumpfile problem]
> 
> I'm trying to use crash to read a makedumpfile vmcore from 5.3, but I always
> end up with an error when opening the dump.
> 
> I'm using the latest github crash
> 
> crash 7.2.7++
> ...
>  crash: page excluded: kernel virtual address: ffffffff82110370  type:
>  "possible"
>  WARNING: cannot read cpu_possible_map
>  crash: page excluded: kernel virtual address: ffffffff82110360  type:
>  "present"
>  WARNING: cannot read cpu_present_map
>  crash: page excluded: kernel virtual address: ffffffff82110368  type:
>  "online"
>  WARNING: cannot read cpu_online_map
>  crash: page excluded: kernel virtual address: ffffffff82110358  type:
>  "active"
>  WARNING: cannot read cpu_active_map
>  crash: page excluded: kernel virtual address: ffffffff82011544  type:
>  "init_uts_ns"
>  crash: page excluded: kernel virtual address: ffffffff82110360  type:
>  "cpu_present_map"
>  crash: page excluded: kernel virtual address: ffffffff82110360  type:
>  "cpu_present_map"
>  WARNING: ORC unwinder: cannot read lookup_num_blocks
>  crash: seek error: kernel virtual address: ffff88822dffb000  type:
>  "memory section root table"
> 
> The dump is created with the latest makedumpfile release
> 
> makedumpfile: version 1.6.6 (released on 27 Jun 2019)
> 
> It complains that it doesn't support the kernel
> 
> Any ideas?
> 
> -Andi
> 

Yeah, I'm not sure either.  I've tested the github crash on kernels up to 5.4-rc5,
but only running on a live system.  Given that the errors indicate "page excluded",
it looks like makedumpfile 1.6.6 may not cover 5.4 kernels.  The makedumpfile git
log's master branch shows these as the last two commits:

  commit 0a8b504102dbdb952b2e2e3ce15ae706165eba4e
  Author: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
  Date:   Thu Jun 27 08:42:40 2019 -0400

    [v1.6.6] Update version
    
    Update makedumpfile to version 1.6.6.
    
    Signed-off-by: Kazuhito Hagio <k-hagio@ab.jp.nec.com>

  commit 8c21fc7e7c52a2c3e0299e50a8b37becadfa77b4
  Author: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
  Date:   Thu Jun 13 15:32:55 2019 -0400

    [PATCH] Support newer kernels up to v5.1
    
    A new makedumpfile supports newer kernels:
    
      - 4.20, 5.0, 5.1  (x86 FLATMEM)
      - 4.20, 5.0, 5.1  (x86 SPARSEMEM)
      - 4.20, 5.0, 5.1  (x86_64 SPARSEMEM)
    
    Signed-off-by: Kazuhito Hagio <k-hagio@ab.jp.nec.com>

Dave







> --
> Crash-utility mailing list
> Crash-utility@redhat.com
> https://www.redhat.com/mailman/listinfo/crash-utility
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
