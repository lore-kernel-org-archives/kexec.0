Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZX3yT-00021q-0a
 for kexec@lists.infradead.org; Wed, 02 Sep 2015 09:04:58 +0000
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Wed, 2 Sep 2015 10:04:23 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 83D2317D837F
 for <kexec@lists.infradead.org>; Wed,  2 Sep 2015 09:50:23 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t828mfWv43843830
 for <kexec@lists.infradead.org>; Wed, 2 Sep 2015 08:48:41 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t828meDO032084
 for <kexec@lists.infradead.org>; Wed, 2 Sep 2015 02:48:41 -0600
Date: Wed, 2 Sep 2015 10:48:39 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] kexec: use mmap instead of read for slurp_file()
Message-ID: <20150902104839.17674456@holzheu>
In-Reply-To: <20150902010721.GE30886@verge.net.au>
References: <1439914643-26484-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <20150902010721.GE30886@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: stefan.roscher@de.ibm.com, kexec@lists.infradead.org

On Wed, 2 Sep 2015 10:07:21 +0900
Simon Horman <horms@verge.net.au> wrote:
[snip]
> > The slurp_fd() function allocates memory and uses the read() system call.
> > This results in double memory consumption for image and initrd:
> > 
> >  1) Memory allocated in user space by the kexec tool
> >  2) Memory allocated in kernel by the kexec() system call
> > 
> > Therefore use mmap() for non-character devices to reduce the memory
> > consumption of the kexec tool.
> 
> I'm not opposed to this change but I also don't see a strong motivation for
> it.  I would imagine that the memory saving is not that large. And that the
> memory consumption disappears when the presumably short-lived kexec process
> exits.

Correct it will disappear.

The reason for the the patch is that we have the following scanario:

1) Boot a 4 GB Linux system
2) Read kernel and 1,5 GB ramdisk from external source into local tmpfs (ram)
3) kexec the kernel and ramdisk

So without the mmap patch for the kexec runtime we need:

1,5 GB (tmpfs) + 1,5 GB (kexec malloc) + 1,5 GB (kernel memory) = 4,5 GB

If we use mmap we only need 3 GB memory.

Regards,
Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
