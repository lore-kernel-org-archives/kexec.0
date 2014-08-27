Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XMdqW-0000XG-IG
 for kexec@lists.infradead.org; Wed, 27 Aug 2014 14:05:09 +0000
Date: Wed, 27 Aug 2014 23:04:45 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH V2] kexec: Provide an option to use new kexec system call
Message-ID: <20140827140445.GA24547@verge.net.au>
References: <20140818152232.GA7525@redhat.com>
 <20140826143034.GD9081@redhat.com>
 <20140827075936.GA5936@verge.net.au>
 <20140827130438.GA6744@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140827130438.GA6744@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, WANG Chao <chaowang@redhat.com>

On Wed, Aug 27, 2014 at 09:04:39AM -0400, Vivek Goyal wrote:
> On Wed, Aug 27, 2014 at 04:59:37PM +0900, Simon Horman wrote:
> > On Tue, Aug 26, 2014 at 10:30:34AM -0400, Vivek Goyal wrote:
> > > On Mon, Aug 18, 2014 at 11:22:32AM -0400, Vivek Goyal wrote:
> > > > Hi,
> > > > 
> > > > This is v2 of the patch. Since v1, I moved syscall implemented check littler
> > > > earlier in the function as per the feedback.
> > > > 
> > > > Now a new kexec syscall (kexec_file_load()) has been merged in upstream
> > > > kernel. This system call takes file descriptors of kernel and initramfs
> > > > as input (as opposed to list of segments to be loaded). This new system
> > > > call allows for signature verification of the kernel being loaded.
> > > > 
> > > > One use of signature verification of kernel is secureboot systems where
> > > > we want to allow kexec into a kernel only if it is validly signed by
> > > > a key system trusts.
> > > > 
> > > > This patch provides and option --kexec-file-syscall (-s), to force use of
> > > > new system call for kexec. Default is to continue to use old syscall.
> > > > 
> > > > Currently only bzImage64 on x86_64 can be loaded using this system call.
> > > > As kernel adds support for more arches and for more image types, kexec-tools
> > > > can be modified accordingly.
> > > > 
> > > 
> > > Hi Simon,
> > > 
> > > Do you have any concerns with this patch? If not, can you please consider
> > > it for merge.
> > 
> > Thanks, applied.
> 
> Thanks Simon. Have you pushed it out yet. git pull does not show anything.

It seems not. I have done so now.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
