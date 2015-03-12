Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YW3bW-00006g-6n
 for kexec@lists.infradead.org; Thu, 12 Mar 2015 13:56:51 +0000
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Thu, 12 Mar 2015 13:56:24 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1C033219005F
 for <kexec@lists.infradead.org>; Thu, 12 Mar 2015 13:56:13 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2CDuMhJ8388978
 for <kexec@lists.infradead.org>; Thu, 12 Mar 2015 13:56:22 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2CDuLUj029044
 for <kexec@lists.infradead.org>; Thu, 12 Mar 2015 07:56:21 -0600
Date: Thu, 12 Mar 2015 14:56:16 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/8] Handle mmaped regions in cache [more analysis]
Message-ID: <20150312145616.721b1e37@holzheu>
In-Reply-To: <20150309170858.0e8bf357@holzheu>
References: <cover.1425650592.git.ptesarik@suse.cz>
 <20150309170858.0e8bf357@holzheu>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kexec mailing list <kexec@lists.infradead.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Petr Tesarik <ptesarik@suse.cz>, Jan Willeke <willeke@de.ibm.com>

On Mon, 9 Mar 2015 17:08:58 +0100
Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

> Hello Petr,
> 

[snip]

> As a conclusion, we could think of mapping larger chunks
> also for the fragmented case of -d 31 to reduce the amount
> of mmap/munmap calls.
> 

FYI: I did some more tests and I am no longer sure if the above
conclusion was correct.

A simple "copy" program that reads or maps/unmaps every page
from /proc/vmcore and then writes it to /dev/null is faster
with mmap()/munmap() than with using read():

read:
-----
# time ./copy /dev/null read

real    0m1.072s
user    0m0.010s
sys     0m1.054s

# perf stat -e syscalls:sys_enter_old_mmap,syscalls:sys_enter_munmap,syscalls:sys_enter_read ./copy /dev/null read            
                 8      syscalls:sys_enter_old_mmap                                   
                 1      syscalls:sys_enter_munmap                                   
            458753      syscalls:sys_enter_read                                     
       1.405457536 seconds time elapsed

mmap:
-----
# time ./copy /dev/null mmap

real    0m0.947s
user    0m0.314s
sys     0m0.631s

# perf stat -e syscalls:sys_enter_old_mmap,syscalls:sys_enter_munmap,syscalls:sys_enter_read ./copy /dev/null mmap
            458760      syscalls:sys_enter_old_mmap                                   
            458753      syscalls:sys_enter_munmap                                   
                 1      syscalls:sys_enter_read                                     
       1.175956735 seconds time elapsed

Regards,
Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
