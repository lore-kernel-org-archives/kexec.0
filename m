Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iMuMT-0003aF-Uy
 for kexec@lists.infradead.org; Tue, 22 Oct 2019 13:38:11 +0000
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 166AB107AD33
 for <kexec@lists.infradead.org>; Tue, 22 Oct 2019 13:38:04 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F54E4221
 for <kexec@lists.infradead.org>; Tue, 22 Oct 2019 13:38:04 +0000 (UTC)
Received: from zmail24.collab.prod.int.phx2.redhat.com
 (zmail24.collab.prod.int.phx2.redhat.com [10.5.83.30])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 061734EE50
 for <kexec@lists.infradead.org>; Tue, 22 Oct 2019 13:38:04 +0000 (UTC)
Date: Tue, 22 Oct 2019 09:38:03 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1711321633.7795678.1571751483859.JavaMail.zimbra@redhat.com>
In-Reply-To: <mailman.5359.1571746554.2486.kexec@lists.infradead.org>
References: <mailman.5359.1571746554.2486.kexec@lists.infradead.org>
Subject: Re: [PATCH 1/3 v4] x86/kdump: always reserve the low 1MiB when the
 crashkernel option is specified
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
To: kexec@lists.infradead.org



----- Original Message -----

> > 
> > [root linux]$ crash vmlinux
> > /var/crash/127.0.0.1-2019-09-19-08\:31\:27/vmcore
> > WARNING: kernel relocated [240MB]: patching 97110 gdb minimal_symbol values
> > 
> >       KERNEL: /var/crash/127.0.0.1-2019-09-19-08:31:27/vmlinux
> >     DUMPFILE: /var/crash/127.0.0.1-2019-09-19-08:31:27/vmcore  [PARTIAL DUMP]
> >         CPUS: 128
> >         DATE: Thu Sep 19 08:31:18 2019
> >       UPTIME: 00:01:21
> > LOAD AVERAGE: 0.16, 0.07, 0.02
> >        TASKS: 1343
> >     NODENAME: amd-ethanol
> >      RELEASE: 5.3.0-rc7+
> >      VERSION: #4 SMP Thu Sep 19 08:14:00 EDT 2019
> >      MACHINE: x86_64  (2195 Mhz)
> >       MEMORY: 127.9 GB
> >        PANIC: "Kernel panic - not syncing: sysrq triggered crash"
> >          PID: 9789
> >      COMMAND: "bash"
> >         TASK: "ffff89711894ae80  [THREAD_INFO: ffff89711894ae80]"
> >          CPU: 83
> >        STATE: TASK_RUNNING (PANIC)
> > 
> > crash> kmem -s|grep -i invalid
> > kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099f0c5a4
> > kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099f0c5a4
> > crash>
> 
> I fail to see what that's trying to tell me? You have invalid pointers?

Correct, because the pointer values are encrypted.  The command is walking through the
singly-linked list of free objects in a slab from the dma-kmalloc-512 slab cache.  The
slab memory had been allocated from low memory, and because of the  problem at hand,
it was was copied to the vmcore in its encrypted state.

Dave 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
