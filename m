Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp08.uk.ibm.com ([195.75.94.104])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zpdz8-0002Eg-6l
 for kexec@lists.infradead.org; Fri, 23 Oct 2015 15:10:27 +0000
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 23 Oct 2015 16:10:02 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id E02FF17D8056
 for <kexec@lists.infradead.org>; Fri, 23 Oct 2015 16:10:10 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9NFA0uX62455864
 for <kexec@lists.infradead.org>; Fri, 23 Oct 2015 15:10:00 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9NFA0dn005119
 for <kexec@lists.infradead.org>; Fri, 23 Oct 2015 09:10:00 -0600
Date: Fri, 23 Oct 2015 17:09:59 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH] Revert "kexec: use mmap instead of read for slurp_file()"
Message-ID: <20151023170959.0ab74f20@holzheu>
In-Reply-To: <20151023031000.GA15557@dhcp-129-115.nay.redhat.com>
References: <20151023031000.GA15557@dhcp-129-115.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On Fri, 23 Oct 2015 11:10:00 +0800
Dave Young <dyoung@redhat.com> wrote:

> This reverts commit 7ab842d8a004f6cd75a9d7b3528e4a70819ce4ef.
> 
> using mmap by default in slurp_file cause segment fault while later
> reallocing dtb_buf during my arm kexec test.

Sorry, I obviously missed that part.

How can we fix that:

- Create a separate function slurp_file_mmap() that is called by s390x?
- Rework xmalloc/xrealloc to always use mmap() and mremap()?
- ...

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
