Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RdJ6C-0007c9-BU
 for kexec@lists.infradead.org; Wed, 21 Dec 2011 10:08:37 +0000
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 21 Dec 2011 10:03:49 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pBLA8TOP5079160
 for <kexec@lists.infradead.org>; Wed, 21 Dec 2011 21:08:29 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pBLA8Spn012860
 for <kexec@lists.infradead.org>; Wed, 21 Dec 2011 21:08:29 +1100
Message-ID: <4EF1B019.3030201@linux.vnet.ibm.com>
Date: Wed, 21 Dec 2011 15:38:25 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: s390x: Auto-detect the correct
 MAX_PHYSMEM_BITSused in vmcore being analyzed.
References: <20111220101459.26622.49407.stgit@mars.in.ibm.com>
 <20111221151141tachibana@mail.jp.nec.com>
In-Reply-To: <20111221151141tachibana@mail.jp.nec.com>
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
To: tachibana@mxm.nes.nec.co.jp
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, Ananth Narayan <ananth@in.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>

On 12/21/2011 11:41 AM, tachibana@mxm.nes.nec.co.jp wrote:
> Hi Mahesh,
> 
> Thank you for the patch.
> I will review it.
> However I have never dumped 1 terabyte or more data using makedumpfile.
> Has anyone ever dumped it successfully?
> 

I have seen makedumpfile successfully compressing vmcore generated on
system with 1TB memory.

Thanks,
-Mahesh.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
