Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WTZHl-0003Cz-Sa
 for kexec@lists.infradead.org; Fri, 28 Mar 2014 16:05:38 +0000
Date: Fri, 28 Mar 2014 12:05:13 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 2/4] x86: Store memory ranges globally used for crash
 kernel to boot into
Message-ID: <20140328160513.GH2089@redhat.com>
References: <1395216241-13983-1-git-send-email-chaowang@redhat.com>
 <20140327223233.GQ13816@redhat.com>
 <20140328052349.GD2944@dhcp-17-89.nay.redhat.com>
 <1442762.HKg1LDRF5G@skinner>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1442762.HKg1LDRF5G@skinner>
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
To: Thomas Renninger <trenn@suse.de>
Cc: kexec@lists.infradead.org, horms@verge.net.au, linn@hp.com, hpa@zytor.com, dyoung@redhat.com, WANG Chao <chaowang@redhat.com>, ebiederm@xmission.com

On Fri, Mar 28, 2014 at 04:44:33PM +0100, Thomas Renninger wrote:

[..]
> > But if you have no problem review it, I can do some
> > clean up within this patch. However I think it's better to be addressed
> > the cleanup in the future, or at least as a separated patch in this
> > series.
> Seeing some cleanups, especially getting rid of the duplicate code to get 
> memory ranges in kdump and kexec case (which I expect still exists?) on top 
> later would be great.

I think let us first get this patch series in. It is important for kaslr
as well as making sure calgary IOMMU works in new kernels. 

And then there can be a patch series on top for cleanup stuff.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
