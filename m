Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R47cD-0007R3-Ll
	for kexec@lists.infradead.org; Thu, 15 Sep 2011 08:48:14 +0000
Received: from d06nrmr1806.portsmouth.uk.ibm.com
	(d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p8F8m5D3024463
	for <kexec@lists.infradead.org>; Thu, 15 Sep 2011 08:48:05 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p8F8m5Ps2592934
	for <kexec@lists.infradead.org>; Thu, 15 Sep 2011 09:48:05 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p8F8m4tn030276
	for <kexec@lists.infradead.org>; Thu, 15 Sep 2011 02:48:04 -0600
Subject: Re: [patch v2 2/2] s390: Add architecture code for unmapping
	crashkernel memory
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110914182902.GA32658@redhat.com>
References: <20110913132635.063397500@linux.vnet.ibm.com>
	<20110913132654.157278466@linux.vnet.ibm.com>
	<20110913145218.659f9e21.akpm@google.com>
	<1315990708.3367.14.camel@br98xy6r> <20110914182902.GA32658@redhat.com>
Date: Thu, 15 Sep 2011 10:48:03 +0200
Message-ID: <1316076483.3526.4.camel@br98xy6r>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Andrew Morton <akpm@google.com>, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, schwidefsky@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org

Hello Vivek, Andrew,

On Wed, 2011-09-14 at 14:29 -0400, Vivek Goyal wrote:
> On Wed, Sep 14, 2011 at 10:58:28AM +0200, Michael Holzheu wrote:
> > > Why not make this unconditional, for all architectures which support
> > > hugepages?  ie:
> > > 
> > > #ifdef HPAGE_SIZE
> > > #define KEXEC_CRASH_MEM_ALIGN HPAGE_SIZE
> > > #else
> > > #define KEXEC_CRASH_MEM_ALIGN PAGE_SIZE
> > > #endif
> > 
> > > in include/linux/kexec.h?
> > > 
> > > IOW, what are the compromises here?
> > 
> > If we would do it that way, crashkernel memory on architectures that
> > support large pages but do not support unmapping of crashkernel memory
> > would always be aligned to HPAGE_SIZE. But only PAGE_SIZE alignment
> > would be necessary in that case.
> > 
> > If that is acceptable I have no problem to define that unconditional for
> > all architectures. Vivek what do you think?
> 
> As PAGE_SIZE alignment is sufficient for rest of the architecture, I 
> am fine with keeping it in arch dependent files.

Ok fine. So I will resend the two patches including Andrew's
resource_size() fix and keep KEXEC_CRASH_MEM_ALIGN definition
architecture dependent.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
