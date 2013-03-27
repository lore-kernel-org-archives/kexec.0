Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from 8bytes.org ([2a01:238:4242:f000:64f:6c43:3523:e535]
 helo=mail.8bytes.org)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UKndc-000456-KA
 for kexec@lists.infradead.org; Wed, 27 Mar 2013 10:31:26 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id EAE9412B044
 for <kexec@lists.infradead.org>; Wed, 27 Mar 2013 11:31:22 +0100 (CET)
Date: Wed, 27 Mar 2013 11:31:22 +0100
From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] intel-iommu: Synchronize gcmd value with global command
 register
Message-ID: <20130327103122.GK30540@8bytes.org>
References: <1363829556-2128-1-git-send-email-indou.takao@jp.fujitsu.com>
 <20130326144629.GB2727@8bytes.org>
 <51527D74.9080209@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51527D74.9080209@jp.fujitsu.com>
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
To: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, iommu@lists.linux-foundation.org, dwmw2@infradead.org, linux-kernel@vger.kernel.org

On Wed, Mar 27, 2013 at 02:02:44PM +0900, Takao Indoh wrote:
> The root cause of this problem is mismatch between iommu->gcmd and
> global command register in the case of kdump. At boot time, initial
> value of iommu->gcmd is zero as I wrote above, but actual global command
> register is *not* zero because some bits like IRE/TE/QIE are already set
> in *first* kernel. Therefore this patch synchronize them to fix this
> problem.

Ok, I understand, but I still don't see why this is a problem. There is
no point for the kdump kernel to preserve hardware state from the
previous kernel. So I think the way it is implemented is correct.


	Joerg



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
