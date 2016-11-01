Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c1O1E-0006kO-AY
 for kexec@lists.infradead.org; Tue, 01 Nov 2016 01:37:41 +0000
Date: Tue, 1 Nov 2016 09:37:14 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kexec: Increase the upper limit for RAM segments
Message-ID: <20161101013714.GA20838@x1>
References: <1477005268-26943-1-git-send-email-sgoel@codeaurora.org>
 <cad5f084-b914-f522-eb43-71ed8a45b2a0@infradead.org>
 <43d2add1-15f5-7e62-b8ce-9a8afeff71f3@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <43d2add1-15f5-7e62-b8ce-9a8afeff71f3@codeaurora.org>
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
To: "Goel, Sameer" <sgoel@codeaurora.org>
Cc: Geoff Levand <geoff@infradead.org>, kexec@lists.infradead.org

On 10/31/16 at 01:11pm, Goel, Sameer wrote:
> This change is needed in case when the System Ram listings are retrieved
> from /proc/iomem. On a newer UEFI based Qualcomm system, the number of
> regions listed were close to 34. So, the actual system ram region was not
> covered and the kexec tool failed to load the kernel image.
> 
> So, I have requested an increase in the number of memory regions.
> Thanks,

It would be great to add this to your patch log so that reviewers can
understand it better. Better repost with an updated patch log, copying
these as patch log is good enough.

> Sameer
> 
> On 10/21/2016 11:05 AM, Geoff Levand wrote:
> > Hi Sameer.
> > 
> > On 10/20/2016 04:14 PM, Sameer Goel wrote:
> > > Change the current hardcoded values to 64 from 16.
> > 
> > Please add an explanation of why this change is needed.
> > 
> > -Geoff
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> > 
> 
> -- 
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
