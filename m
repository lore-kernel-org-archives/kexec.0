Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZtQCO-00081e-La
 for kexec@lists.infradead.org; Tue, 03 Nov 2015 01:15:45 +0000
Date: Tue, 3 Nov 2015 09:15:11 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] Revert "kexec: use mmap instead of read for slurp_file()"
Message-ID: <20151103011511.GA30841@dhcp-128-100.nay.redhat.com>
References: <20151023031000.GA15557@dhcp-129-115.nay.redhat.com>
 <1446509499.23374.2.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1446509499.23374.2.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Michael Holzheu <holzheu@linux.vnet.ibm.com>

Hi, Geoff

On 11/02/15 at 04:11pm, Geoff Levand wrote:
> Hi,
> 
> On Fri, 2015-10-23 at 11:10 +0800, Dave Young wrote:
> > This reverts commit 7ab842d8a004f6cd75a9d7b3528e4a70819ce4ef.
> > 
> > using mmap by default in slurp_file cause segment fault while later
> > reallocing dtb_buf during my arm kexec test.
> 
> Could you say more about the cause of the segfault?  Where is the dtb
> reallocated?

See kexec-zImage-arm.c:
slurp_file --> setup_dtb_prop --> xrealloc

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
