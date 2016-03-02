Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aax0z-0001Tb-HH
 for kexec@lists.infradead.org; Wed, 02 Mar 2016 02:59:53 +0000
Date: Wed, 2 Mar 2016 11:03:20 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH V2 1/2] kexec: Make a pair of map/unmap reserved pages in
 error path
Message-ID: <20160302030320.GB20240@dhcp-128-25.nay.redhat.com>
References: <1456819349-8650-1-git-send-email-mnfhuang@gmail.com>
 <1456819349-8650-2-git-send-email-mnfhuang@gmail.com>
 <20160301135658.341928989a18949d97998abd@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160301135658.341928989a18949d97998abd@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, Minfei Huang <mnfhuang@gmail.com>, ebiederm@xmission.com

On 03/01/16 at 01:56pm, Andrew Morton wrote:
> On Tue,  1 Mar 2016 16:02:28 +0800 Minfei Huang <mnfhuang@gmail.com> wrote:
> 
> > For some arch, kexec shall map the reserved pages, then use them, when
> > we try to start the kdump service.
> 
> Which architectures are these, by the way?

Hi.

This patch only affects s390. The others doesn't implement the interface
of crash_unmap_reserved_pages and crash_map_reserved_pages.

> 
> > kexec may return directly, without unmaping the reserved pages, if it
> > fails during starting service. To fix it, we make a pair of map/unmap
> > reserved pages both in generic path and error path.
> 
> I'm having trouble understanding the urgency of this patch.  Do you
> think it is needed in 4.5?  -stable?  If so, why?

IMHO, it is fine in next release as it isn't a urgent patch. Kernel can
work well without any risk, although the reseverd pages are not unmaped
before returning in error path.

Thanks
Minfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
