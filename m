Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZrwxA-0003Ho-K8
 for kexec@lists.infradead.org; Thu, 29 Oct 2015 23:49:57 +0000
Date: Fri, 30 Oct 2015 08:49:34 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [kexec-tools PATCH 0/3] New option to avoid copying old root
 param from 1st kernel cmdline
Message-ID: <20151029234934.GA26105@verge.net.au>
References: <20151028054134.200833741@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151028054134.200833741@redhat.com>
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
To: dyoung@redhat.com
Cc: jstodola@redhat.com, kexec@lists.infradead.org

On Wed, Oct 28, 2015 at 01:41:34PM +0800, dyoung@redhat.com wrote:
> Hi,
> 
> Here is the update patches for adding a new option --dt-no-old-root.
> Per previously discussion with Simon, we should consider the compatibility 
> issue for changing the old behavior. Thus a new option is necessary
> 
> The 1st patch move the copying code to another function. The other two patches
> are for adding arch dependent option for arm and ppc64.
> 
> Tested kexec load on both arm and ppc64 machines.
> 
> For the latter two patches, some usage lines are over 80 characters, but I just
> keep same with original formats. I prefer to fix it in other patches. If you
> think it really need being fixed in this patchset please let me know, I can
> update them again.

Thanks, I have applied these and included them in kexec-tools 2.0.11-rc1.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
