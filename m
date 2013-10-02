Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VRLAI-00069F-03
 for kexec@lists.infradead.org; Wed, 02 Oct 2013 12:04:26 +0000
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Wed, 2 Oct 2013 13:04:02 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id A00D51B08070
 for <kexec@lists.infradead.org>; Wed,  2 Oct 2013 13:04:01 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r92C3lVg40697976
 for <kexec@lists.infradead.org>; Wed, 2 Oct 2013 12:03:47 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r92C3wwu014871
 for <kexec@lists.infradead.org>; Wed, 2 Oct 2013 06:03:59 -0600
Date: Wed, 2 Oct 2013 14:03:56 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: mmap for /proc/vmcore broken since 3.12-rc1
Message-ID: <20131002140356.63706540@holzheu>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Jan Willeke <willeke@de.ibm.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "David S. Miller" <davem@davemloft.net>, Vivek Goyal <vgoyal@redhat.com>

Hello Alexey,

Looks like the following commit broke mmap for /proc/vmcore:

commit c4fe24485729fc2cbff324c111e67a1cc2f9adea
Author: Alexey Dobriyan <adobriyan@gmail.com>
Date:   Tue Aug 20 22:17:24 2013 +0300

    sparc: fix PCI device proc file mmap(2)

Because /proc/vmcore (fs/proc/vmcore.c) does not implement the
get_unmapped_area() fops function mmap now always returns EIO.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
