Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from astoria.ccjclearline.com ([64.235.106.9])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6k3G-0008IE-HX
 for kexec@lists.infradead.org; Wed, 29 Aug 2012 15:19:31 +0000
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com
 ([174.115.5.73]:57494 helo=crashcourse.ca)
 by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
 (Exim 4.77) (envelope-from <rpjday@crashcourse.ca>)
 id 1T6k37-0002uF-8l
 for kexec@lists.infradead.org; Wed, 29 Aug 2012 11:19:21 -0400
Date: Wed, 29 Aug 2012 11:19:21 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: "make headers_check" identifies unusable userspace code
Message-ID: <alpine.DEB.2.02.1208291117030.23657@oneiric>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec mailing list <kexec@lists.infradead.org>


$ make headers_check
...
/home/rpjday/k/git/usr/include/linux/kexec.h:49: userspace cannot
reference function or variable defined in the kernel
...

  sure enough, here's that part of the exported kexec.h header file:

#ifndef __KERNEL__
/*
 * This structure is used to hold the arguments that are used when
 * loading  kernel binaries.
 */
struct kexec_segment {
        const void *buf;
        size_t bufsz;
        const void *mem;
        size_t memsz;
};

/* Load a new kernel image as described by the kexec_segment array
 * consisting of passed number of segments at the entry-point address.
 * The flags allow different useage types.
 */
extern int kexec_load(void *, size_t, struct kexec_segment *,
                unsigned long int);
#endif /* __KERNEL__ */

  seems pretty clear that there's no point exporting the declaration
of kexec_load() to user space, correct?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
