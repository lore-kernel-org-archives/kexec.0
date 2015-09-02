Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZWwTr-0006lv-O2
 for kexec@lists.infradead.org; Wed, 02 Sep 2015 01:04:52 +0000
Date: Wed, 2 Sep 2015 10:04:10 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [Patch v3] Add persistent memory support
Message-ID: <20150902010410.GD30886@verge.net.au>
References: <1439975029-25611-1-git-send-email-bhe@redhat.com>
 <20150819092815.GB6130@localhost.localdomain>
 <20150819104509.GG19950@dhcp-128-28.nay.redhat.com>
 <20150820023812.GA20780@localhost.localdomain>
 <20150820025222.GH19950@dhcp-128-28.nay.redhat.com>
 <20150820074234.GA23537@localhost.localdomain>
 <1440446072.14237.8.camel@hp.com>
 <20150825073719.GB20225@dhcp-129-120.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150825073719.GB20225@dhcp-129-120.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, Toshi Kani <toshi.kani@hp.com>, Baoquan He <bhe@redhat.com>

On Tue, Aug 25, 2015 at 03:37:19PM +0800, Dave Young wrote:

[snip]

> Hmm, after looking into old discussion, I found that the options is there for
> the known issue for calgary iommu. I really doubt there's someone is using it
> but who knows.
> 
> calgary code uses saved_max_pfn which is only calculaed when there's memmap=exactmap
> cmdline params. So before removing the limitation we still need carry the old
> interface.
> 
> Hence, I will not object Bao's changes in his patch any more.

Thanks, on the strength of that comment I have applied this patch.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
