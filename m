Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZqcGI-00031h-V7
 for kexec@lists.infradead.org; Mon, 26 Oct 2015 07:32:12 +0000
Date: Mon, 26 Oct 2015 15:31:39 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] Revert "kexec: use mmap instead of read for slurp_file()"
Message-ID: <20151026073139.GB2916@dhcp-128-73.nay.redhat.com>
References: <20151023031000.GA15557@dhcp-129-115.nay.redhat.com>
 <20151023170959.0ab74f20@holzheu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151023170959.0ab74f20@holzheu>
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
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

Hi, Michael

On 10/23/15 at 05:09pm, Michael Holzheu wrote:
> On Fri, 23 Oct 2015 11:10:00 +0800
> Dave Young <dyoung@redhat.com> wrote:
> 
> > This reverts commit 7ab842d8a004f6cd75a9d7b3528e4a70819ce4ef.
> > 
> > using mmap by default in slurp_file cause segment fault while later
> > reallocing dtb_buf during my arm kexec test.
> 
> Sorry, I obviously missed that part.
> 
> How can we fix that:
> 
> - Create a separate function slurp_file_mmap() that is called by s390x?
> - Rework xmalloc/xrealloc to always use mmap() and mremap()?
> - ...

IMHO adding a slurp_file_mmap for s390x use is a better way since the
huge initramfs is not a general case.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
