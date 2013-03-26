Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from 8bytes.org ([85.214.48.195] helo=mail.8bytes.org)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UKV94-0006vI-84
 for kexec@lists.infradead.org; Tue, 26 Mar 2013 14:46:39 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id 806C912AFA3
 for <kexec@lists.infradead.org>; Tue, 26 Mar 2013 15:46:31 +0100 (CET)
Date: Tue, 26 Mar 2013 15:46:30 +0100
From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] intel-iommu: Synchronize gcmd value with global command
 register
Message-ID: <20130326144629.GB2727@8bytes.org>
References: <1363829556-2128-1-git-send-email-indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1363829556-2128-1-git-send-email-indou.takao@jp.fujitsu.com>
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

On Thu, Mar 21, 2013 at 10:32:36AM +0900, Takao Indoh wrote:
> In this function, clearing IRE bit in iommu->gcmd and writing it to
> global command register. But initial value of iommu->gcmd is zero, so
> this writel means clearing all bits in global command register.

Seems weird. Why is the value of gcmd zero in your case? The usage of
this register is well encapsulated by the different parts of the VT-d
driver. There are other places which enable/disable translation and qpi
the same way it is done with interrupt remapping. So it looks to me that
it is unlikely that gcmd is really zero in your case.

Can you explain that more and also describe what the actual misbehavior
is you are trying to fix here?

Thanks,

	Joerg



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
