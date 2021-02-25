Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lF4oP-0004qZ-Fm
 for kexec@lists.infradead.org; Thu, 25 Feb 2021 00:47:26 +0000
Date: Wed, 24 Feb 2021 16:47:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [RFC PATCH 4/4] i40e: don't open i40iw client for kdump
Message-ID: <20210224164720.2228c580@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210225002101.hvbpq7f6zbvylqy4@Rk>
References: <20210222070701.16416-1-coxu@redhat.com>
 <20210222070701.16416-5-coxu@redhat.com>
 <20210223122207.08835e0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210224114141.ziywca4dvn5fs6js@Rk>
 <20210224084841.50620776@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210225002101.hvbpq7f6zbvylqy4@Rk>
MIME-Version: 1.0
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
To: Coiby Xu <coxu@redhat.com>
Cc: netdev@vger.kernel.org, kexec@lists.infradead.org, Jesse Brandeburg <jesse.brandeburg@intel.com>, open list <linux-kernel@vger.kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org, "David S. Miller" <davem@davemloft.net>

On Thu, 25 Feb 2021 08:21:01 +0800 Coiby Xu wrote:
> On Wed, Feb 24, 2021 at 08:48:41AM -0800, Jakub Kicinski wrote:
> >On Wed, 24 Feb 2021 19:41:41 +0800 Coiby Xu wrote:  
> >> I'm not sure if I understand you correctly. Do you mean we shouldn't
> >> disable i40iw for kdump?  
> >
> >Forgive my ignorance - are the kdump kernels separate builds?
> 
> AFAIK we don't build a kernel exclusively for kdump. 
> 
> >If they are it'd be better to leave the choice of enabling RDMA
> >to the user - through appropriate Kconfig options.
> 
> i40iw is usually built as a loadable module. So if we want to leave the
> choce of enabling RDMA to the user, we could exclude this driver when
> building the initramfs for kdump, for example, dracut provides the 
> omit_drivers option for this purpose. 
> 
> On the other hand, the users expect "crashkernel=auto" to work out of
> the box. So i40iw defeats this purpose. 
> 
> I'll discuss with my Red Hat team and the Intel team about whether RDMA
> is needed for kdump. Thanks for bringing up this issue!

Great, talking to experts here at FB it seems that building a cut-down
kernel for kdump is easier than chasing all the drivers to react to
is_kdump_kernel(). But if you guys need it and Intel is fine with 
the change I won't complain.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
