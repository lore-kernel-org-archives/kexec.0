Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from 8bytes.org ([85.214.48.195] helo=mail.8bytes.org)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UO4TO-000138-4N
 for kexec@lists.infradead.org; Fri, 05 Apr 2013 11:06:23 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id 269CE12B05A
 for <kexec@lists.infradead.org>; Fri,  5 Apr 2013 13:06:17 +0200 (CEST)
Date: Fri, 5 Apr 2013 13:06:16 +0200
From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] intel-iommu: Synchronize gcmd value with global command
 register
Message-ID: <20130405110616.GB6858@8bytes.org>
References: <1363829556-2128-1-git-send-email-indou.takao@jp.fujitsu.com>
 <20130326144629.GB2727@8bytes.org>
 <51527D74.9080209@jp.fujitsu.com>
 <20130327103122.GK30540@8bytes.org> <51591EEE.60401@jp.fujitsu.com>
 <20130402140546.GA15687@8bytes.org>
 <515BD638.8070307@jp.fujitsu.com>
 <1364977479.28127.15.camel@i7.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1364977479.28127.15.camel@i7.infradead.org>
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
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, iommu@lists.linux-foundation.org, Takao Indoh <indou.takao@jp.fujitsu.com>, linux-kernel@vger.kernel.org

On Wed, Apr 03, 2013 at 09:24:39AM +0100, David Woodhouse wrote:
> On Wed, 2013-04-03 at 16:11 +0900, Takao Indoh wrote:
> > Yeah, you are right. I forgot such a case.
> 
> If you disable translation and there's some device still doing DMA, it's
> going to scribble over random areas of memory. You really want to have
> translation enabled and all the page tables *cleared*, during kexec. I
> think it's fair to insist that the secondary kernel should use the IOMMU
> if the first one did.

Do we really need to insist on that? The IOMMU initialization on x86
happens after the kernel scanned and enumerated the PCI bus. While doing
this the kernel (at least it should) disables all devices it finds. So
when the IOMMU init code runs we should be safe from any in-flight DMA
and can either disable translation or re-initialize it for the kdump
kernel. Until then translation needs to stay enabled of course, so that
the old page-tables are still used and in-flight DMA doesn't corrupt
any data.


	Joerg



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
