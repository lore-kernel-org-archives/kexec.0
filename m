Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TQLWD-0000Wo-Kt
 for kexec@lists.infradead.org; Mon, 22 Oct 2012 17:10:28 +0000
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Mon, 22 Oct 2012 18:10:20 +0100
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9MHAAQN20971588
 for <kexec@lists.infradead.org>; Mon, 22 Oct 2012 17:10:10 GMT
Received: from d06av10.portsmouth.uk.ibm.com (loopback [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9MGPXHl013759
 for <kexec@lists.infradead.org>; Mon, 22 Oct 2012 12:25:34 -0400
Date: Mon, 22 Oct 2012 19:10:15 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 0/2] x86, apic: Disable BSP if boot cpu is AP
Message-ID: <20121022191015.2989b7a0@holzheu>
In-Reply-To: <20121019151753.GF27052@redhat.com>
References: <20121017141234.GD31663@redhat.com>
 <20121018.120805.464238435.d.hatayama@jp.fujitsu.com>
 <20121018141449.GB18147@redhat.com>
 <20121019.122054.476812873.d.hatayama@jp.fujitsu.com>
 <20121019151753.GF27052@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: len.brown@intel.com, fenghua.yu@intel.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, mingo@elte.hu

On Fri, 19 Oct 2012 11:17:53 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

[..]

> On Fri, Oct 19, 2012 at 12:20:54PM +0900, HATAYAMA Daisuke wrote:
> I am skeptical that this approach is going to fly in practice. Dumping
> huge images, processing and transferring these is not very practical.
> So I would rather narrow down the problem on a running system and take
> filtered dump of appropriate component where I suspect the problem is.
> 
> [..]
> > > capability was the primary reason that s390 also wants to support
> > > kdump otherwise there firmware dumping mechanism was working just
> > > fine.
> > > 
> > 
> > I don't know s390 firmware dumping mechanism at all, but is it
> > possble for s390 to filter crash dump even on firmware dumping
> > mechanism?
> 
> AFAIK, s390 dump mechanism could not filter dump and tha's the reason
> they wanted to support kdump and /proc/vmcore so that makedumpfile 
> could filter it. I am CCing Michael Holzheu, who did the s390 kdump
> work. He can tell it better.

Correct. The other s390 dump mechanisms (stand-alone and hypervisor
dump) are not able to do filtering and therefore the handling of large
dumps has been a problem for us.

This was one of the main reasons to implement kdump on s390.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
