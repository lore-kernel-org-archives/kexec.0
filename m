Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZPnOi-0008Ld-1Y
 for kexec@lists.infradead.org; Thu, 13 Aug 2015 07:58:00 +0000
Date: Thu, 13 Aug 2015 16:57:32 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [REPOST PATCH] kexec: Remove the unnecessary conditional
 judgement to simplify the code logic
Message-ID: <20150813075730.GA4325@verge.net.au>
References: <1438058802-6462-1-git-send-email-mnfhuang@gmail.com>
 <20150813005525.GB7852@verge.net.au>
 <20150813055345.GC26247@dhcp-128-28.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150813055345.GC26247@dhcp-128-28.nay.redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Minfei Huang <mnfhuang@gmail.com>, akpm@linux-foundation.org, vgoyal@redhat.com, ebiederm@xmission.com

On Thu, Aug 13, 2015 at 01:53:45PM +0800, Baoquan He wrote:
> On 08/13/15 at 09:55am, Simon Horman wrote:
> > On Tue, Jul 28, 2015 at 12:46:42PM +0800, Minfei Huang wrote:
> > > Transforming PFN(Page Frame Number) to struct page is never failure, so
> > > we can simplify the code logic to do the image->control_page assignment
> > > directly in the loop, and remove the unnecessary conditional judgement.
> > > 
> > > Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
> > > Acked-by: Dave Young <dyoung@redhat.com>
> > > Acked-by: Vivek Goyal <vgoyal@redhat.com>
> > 
> > Andrew, could you consider picking this up.
> > It seems to have been sufficiently reviewed, acked, etc...
> 
> I saw this has been in linux-next tree.

Excellent, sorry for the noise.

> commit b90b6ef0f152ef42fe66ce5c9ccf2783ea84fa69
> Author: Minfei Huang <mnfhuang@gmail.com>
> Date:   Thu Jul 30 09:56:18 2015 +1000
> 
>     kexec: remove unnecessary test in kimage_alloc_crash_control_pages()
> 
> Thanks
> Baoquan
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
