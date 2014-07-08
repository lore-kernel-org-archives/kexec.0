Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from host81-137-131-225.in-addr.btopenworld.com ([81.137.131.225]
 helo=zimbra.overnetdata.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X4SkV-0003ot-O1
 for kexec@lists.infradead.org; Tue, 08 Jul 2014 10:35:49 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
 by zimbra.overnetdata.com (Postfix) with ESMTP id 19EAF1625A2
 for <kexec@lists.infradead.org>; Tue,  8 Jul 2014 11:34:57 +0100 (BST)
Received: from zimbra.overnetdata.com ([127.0.0.1])
 by localhost (zimbra.overnetdata.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cdarQ7j9T9m6 for <kexec@lists.infradead.org>;
 Tue,  8 Jul 2014 11:34:52 +0100 (BST)
Received: from [192.168.1.27] (unknown [192.168.1.27])
 by zimbra.overnetdata.com (Postfix) with ESMTPSA id 569A21625A1
 for <kexec@lists.infradead.org>; Tue,  8 Jul 2014 11:34:52 +0100 (BST)
Message-ID: <53BBC94B.8060905@overnetdata.com>
Date: Tue, 08 Jul 2014 11:34:51 +0100
From: Anthony Wright <anthony@overnetdata.com>
MIME-Version: 1.0
Subject: Can't load bzImage crashkernel on xen system with 32 bit kernel
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

After successfully modifying kexec-tools to get it to load a crashkernel
on a standard 32 bit linux 3.10.17 kernel, I tried to get it to load the
same crashkernel on the same 32 bit linux kernel running under xen
4.4.0, but get the error "Cannot load <kernel-path>".

I've patched the code to include some diagnostics, and the problem is
caused by add_memmap() reporting that it's been called with overlapping
memory.

It's called twice, the first time it's called with:
	address: 0x00000000
	size:    0x0009f800
	type:    0

This comes from info->backup_src_*

The second time it is passed
	address: 0x00000000
	size:    0x00000000
	type:    0

This is derived from the crash_reserved_mem[] array, which has one
element with the values:
	start: 0x0000000000000000 (16 0's)
	end:   0xffffffffffffffff (16 f's)

The problem isn't caused by the zero size because the maths in
add_memmap, uses size to calculate end which overflows back again, and
(partially) cancels out the error. The problem is caused by the two
memory blocks being based at 0x0, causing the blocks to overlap.

I'm not sure what the correct functionality should be.

Thanks,

Anthony.


-- 
Founder, Overnet Data Ltd
+44-1604-807545
www.overnetdata.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
