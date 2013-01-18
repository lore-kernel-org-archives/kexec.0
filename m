Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mo6-p00-ob.rzone.de ([2a01:238:20a:202:5300::1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TwExZ-0001wG-R8
 for kexec@lists.infradead.org; Fri, 18 Jan 2013 16:38:30 +0000
Received: from probook.site
 (dslb-088-065-094-075.pools.arcor-ip.net [88.65.94.75])
 by smtp.strato.de (joses mo12) (RZmta 31.13 DYNA|AUTH)
 with (DHE-RSA-AES256-SHA encrypted) ESMTPA id N072a7p0IFI52X
 for <kexec@lists.infradead.org>; Fri, 18 Jan 2013 17:38:17 +0100 (CET)
Date: Fri, 18 Jan 2013 17:38:10 +0100
From: Olaf Hering <olaf@aepfle.de>
Subject: getting memory footprint of new kernel
Message-ID: <20130118163809.GA23530@aepfle.de>
MIME-Version: 1.0
Content-Disposition: inline
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


I'm working on kexec support for a ballooned Xen PVonHVM guest.

One of the issues is that the new kernel must run in populated memory,
otherwise it will access ballooned pages and crash.

The kexec syscall passes several physical memory ranges in
kexec_segment->{mem,memsz}. Thats enough info to populate the purgatory
code and early startup code of the new kernel. 

But it lacks the memory range of the new kernel. From my understanding
the entry point is know by kexec(1), it is
kexec/arch/i386/kexec-bzImage.c:do_bzImage_load():kernel32_load_addr
The memory size howver is not known, and I dont see a way to retreive
this information from a bzImage. I think it should be all in the ELF
data of the compressed vmlinux.bin, but this compressed content is not
accessible. 

So what would be a good way to know or estimate the memory size of the
new kernel, and pass the start and size to the balloon driver so that it
can populate the range? I see there are already a few kexec related
sysfs files in kernel/ksysfs.c. What about something like
kexec_newkernel_phys and kexec_newkernel_memsz?

Olaf

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
