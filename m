Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aDZ1R-0007cp-Hg
 for kexec@lists.infradead.org; Mon, 28 Dec 2015 14:43:42 +0000
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Tue, 29 Dec 2015 00:43:17 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A4CE72CE8050
 for <kexec@lists.infradead.org>; Tue, 29 Dec 2015 01:43:15 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBSEh74946923876
 for <kexec@lists.infradead.org>; Tue, 29 Dec 2015 01:43:15 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBSEghn3010024
 for <kexec@lists.infradead.org>; Tue, 29 Dec 2015 01:42:43 +1100
Message-ID: <1451313742.3289.239.camel@linux.vnet.ibm.com>
Subject: Re: [Linux-ima-devel] [PATCH v2 4/7] ima: measure and appraise
 kexec image and initramfs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Mon, 28 Dec 2015 09:42:22 -0500
In-Reply-To: <20151228142910.GA16243@localhost>
References: <1450914903-5793-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1450914903-5793-5-git-send-email-zohar@linux.vnet.ibm.com>
 <20151225053356.GA3398@dhcp-128-65.nay.redhat.com>
 <1451054749.3289.131.camel@linux.vnet.ibm.com>
 <20151228020829.GB2980@dhcp-128-65.nay.redhat.com>
 <1451307075.3289.224.camel@linux.vnet.ibm.com>
 <20151228142910.GA16243@localhost>
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
To: Petko Manolov <petkan@mip-labs.com>
Cc: David Woodhouse <dwmw2@infradead.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Mon, 2015-12-28 at 16:29 +0200, Petko Manolov wrote:
> On 15-12-28 07:51:15, Mimi Zohar wrote:
> > On Mon, 2015-12-28 at 10:08 +0800, Dave Young wrote:
> > > On 12/25/15 at 09:45am, Mimi Zohar wrote:
> > > > IMA calculates the file hash, in this case, based on the buffer
> > > > contents.   The hash is calculated once and used for both measurement
> > > > and appraisal.  If the file integrity appraisal fails (eg. hash
> > > > comparison or signature failure), IMA prevents the kexec files from
> > > > being used.
> > > > 
> > > 
> > > Ok, thanks for the explanatioin. But I have another question, why do we
> > > need a special hook for KEXEC? Shouldn't all files use same way to do the
> > > measurement and appraisal?
> > 
> > "By all files" are you referring to all files read by the kernel or all
> > files opened, executed or mmapped by the system?
> > 
> > Currently IMA allocates a page sized buffer, reads a file a page chunk
> > at a time calculating the file hash as it does so, and then frees the
> > buffer before returning to the caller.  This method of calculating the
> 
> I kind of wonder isn't it possible to optimize the file read?  If the file is 
> relatively small (a few megabytes, for example) it will fit into any modern 
> system's memory.  At least those that cares to run IMA, i mean.
> 
> Fetching file page by page is a slow process even though the BIO subsystem reads 
> larger chunks off the real storage devices.  Has anyone done a benchmark test?

Dmitry recently added asynchronous hash (ahash) support, which allows HW
crypto acceleration, for calculating the file hash.

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
