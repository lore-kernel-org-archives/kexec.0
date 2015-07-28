Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZJwXq-0003Xn-2B
 for kexec@lists.infradead.org; Tue, 28 Jul 2015 04:31:15 +0000
Date: Tue, 28 Jul 2015 13:30:19 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: Remove the unnecessary conditional judgement to
 simplify the code logic
Message-ID: <20150728043019.GC25714@verge.net.au>
References: <1433571252-11874-1-git-send-email-mhuang@redhat.com>
 <20150727134453.GA16064@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150727134453.GA16064@redhat.com>
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
Cc: Minfei Huang <mhuang@redhat.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, Minfei Huang <mnfhuang@gmail.com>, ebiederm@xmission.com

On Mon, Jul 27, 2015 at 09:44:53AM -0400, Vivek Goyal wrote:
> On Sat, Jun 06, 2015 at 02:14:12PM +0800, Minfei Huang wrote:
> > From: Minfei Huang <mnfhuang@gmail.com>
> > 
> > Transforming PFN(Page Frame Number) to struct page is never failure, so
> > we can simplify the code logic to do the image->control_page assignment
> > directly in the loop, and remove the unnecessary conditional judgement.
> > 
> > Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
> 
> Looks good to me.
> 
> Acked-by: Vivek Goyal <vgoyal@redhat.com>

FWIW, this probably needs to be reposted to Andrew Morton with appropriate
Acks and CCs in order to proceed into his tree and then Linus's.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
