Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bnGNx-0007GN-NV
 for kexec@lists.infradead.org; Fri, 23 Sep 2016 02:38:46 +0000
Date: Fri, 23 Sep 2016 10:38:17 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 0/3] makedumpfile: Add support of mm randomization
Message-ID: <20160923023817.GA3558@dhcp-128-65.nay.redhat.com>
References: <1472460862-29842-1-git-send-email-bhe@redhat.com>
 <20160922084502.GB18585@dhcp-128-65.nay.redhat.com>
 <20160922084848.GA18964@dhcp-128-65.nay.redhat.com>
 <20160922085715.GA378@x1>
 <20160922090335.GA19063@dhcp-128-65.nay.redhat.com>
 <20160922090744.GA14155@x1.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160922090744.GA14155@x1.redhat.com>
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
Cc: ats-kumagai@wm.jp.nec.com, kexec@lists.infradead.org, thgarnie@google.com

On 09/22/16 at 05:07pm, Baoquan He wrote:
> On 09/22/16 at 05:03pm, Dave Young wrote:
> > Hi,
> > 
> > > Did you apply below kexec patch either?
> > > 
> > > kexec/arch/i386: Add support for KASLR memory randomization
> > > 
> > > Please search it in kexec mailing list, Thomas posted it.
> > 
> > Yes, applied.
> 
> message-level 31 could help to find out what's happening in
> makedumpfile.

It works after reapplying them to devel branch.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
