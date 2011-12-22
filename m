Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Rdjid-0002Fp-Gw
 for kexec@lists.infradead.org; Thu, 22 Dec 2011 14:34:05 +0000
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Thu, 22 Dec 2011 14:33:57 -0000
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pBMEXeS62367492
 for <kexec@lists.infradead.org>; Thu, 22 Dec 2011 14:33:40 GMT
Received: from d06av05.portsmouth.uk.ibm.com (loopback [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pBMEXeH5018795
 for <kexec@lists.infradead.org>; Thu, 22 Dec 2011 07:33:40 -0700
Message-ID: <1324564420.2720.45.camel@br98xy6r>
Subject: Re: [PATCH] crash: s390x: Auto-detect the correct	MAX_PHYSMEM_BITS
 used in vmcore being analyzed
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Thu, 22 Dec 2011 15:33:40 +0100
In-Reply-To: <6b79bab2-3679-4220-a98f-4e675fdc5226@zmail15.collab.prod.int.phx2.redhat.com>
References: <6b79bab2-3679-4220-a98f-4e675fdc5226@zmail15.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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
To: Dave Anderson <anderson@redhat.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec@lists.infradead.org, V Strivatsa <vatsa@linux.vnet.ibm.com>, Ananth Narayan <ananth@in.ibm.com>, Crash-utility <crash-utility@redhat.com>

Hi Dave,

On Thu, 2011-12-22 at 09:19 -0500, Dave Anderson wrote:
> 
> ----- Original Message -----
> > 
> > Unfortunately Mahesh is currently not online. We still have some time
> > because Martin's kernel patch that introduces the change will go into
> > Linux version 3.3.
> > 
> > So perhaps you make your crash release without this patch.
> > 
> > Michael
> 
> Tell you what -- I'm going to make a hybrid patch, using Mahesh's
> more understandable-yet-longer function, but with your verify_pfn()
> and STRUCT_SIZE_INIT("mem_section") movement, along with a default
> setting of 42 and a non-fatal WARNING message if things fail.
> I'll verify it on RHEL5 and RHEL6.
> 
> If you want to change it later, that will be fine, too.

Ok, I will have a look at your next crash release in the new year.

Thanks!

Michael



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
