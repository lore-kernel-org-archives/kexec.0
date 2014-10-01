Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XZNGH-0001i3-Ri
 for kexec@lists.infradead.org; Wed, 01 Oct 2014 17:00:22 +0000
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Wed, 1 Oct 2014 17:59:58 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id CDDE62190043
 for <kexec@lists.infradead.org>; Wed,  1 Oct 2014 17:59:33 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s91GxtZb59179236
 for <kexec@lists.infradead.org>; Wed, 1 Oct 2014 16:59:55 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s91Gxs1p006138
 for <kexec@lists.infradead.org>; Wed, 1 Oct 2014 10:59:54 -0600
Date: Wed, 1 Oct 2014 18:59:53 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH] makedumpfile: Enable --mem-usage for s390x
Message-ID: <20141001185953.66c6ae9d@holzheu>
In-Reply-To: <20140930090201.GB9989@dhcp-16-116.nay.redhat.com>
References: <1409541340-2719-1-git-send-email-bhe@redhat.com>
 <20140922170247.36774052@holzheu>
 <20140923024058.GC8697@dhcp-16-116.nay.redhat.com>
 <20140924171904.1db5ac90@holzheu>
 <20140925094412.GI8697@dhcp-16-116.nay.redhat.com>
 <20140926101057.14549a12@holzheu>
 <20140926085546.GA30346@dhcp-16-116.nay.redhat.com>
 <20140926133441.5e58303c@holzheu>
 <20140929090432.GA9989@dhcp-16-116.nay.redhat.com>
 <20140929151413.4e9bd1ab@holzheu>
 <20140930090201.GB9989@dhcp-16-116.nay.redhat.com>
Mime-Version: 1.0
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>

On Tue, 30 Sep 2014 17:02:01 +0800
Baoquan He <bhe@redhat.com> wrote:

> On 09/29/14 at 03:14pm, Michael Holzheu wrote:
> > Implement is_vmalloc_addr() using /proc/iommem parsing to enable the new
> > makedumpfile option "--mem-usage".
> > 
> > Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> 
> 
> Hi Michael,
> 
> This idea looks good to me. One question, should it be put in
> arch/s390.c since this is only for s390? Then iomem_for_each_line() need
> be declared in makedumpfile.h .
> 
> If later it's needed by other arch, can be taken out to makedumpfile.c,
> that should be better. Surely this is only my personal concern, if
> Atsushi like to accept it, I am fine too.

Hello Atsushi,

What is your preference regarding this question?

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
