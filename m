Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SEkr3-0008GW-MN
 for kexec@lists.infradead.org; Mon, 02 Apr 2012 17:15:46 +0000
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Mon, 2 Apr 2012 18:15:35 +0100
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q32HFXIm2924690
 for <kexec@lists.infradead.org>; Mon, 2 Apr 2012 18:15:33 +0100
Received: from d06av03.portsmouth.uk.ibm.com (localhost.localdomain
 [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q32HFXsW011204
 for <kexec@lists.infradead.org>; Mon, 2 Apr 2012 11:15:33 -0600
Message-ID: <1333386933.9539.8.camel@br98xy6r>
Subject: Re: makedumpfile memory usage grows with system memory size
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Mon, 02 Apr 2012 19:15:33 +0200
In-Reply-To: <20120329170918.4223e816.oomichi@mxs.nes.nec.co.jp>
References: <20120328212204.GI18218@redhat.com>
 <20120329170918.4223e816.oomichi@mxs.nes.nec.co.jp>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Don Zickus <dzickus@redhat.com>, kexec@lists.infradead.org

Hello Ken'ichi,

On Thu, 2012-03-29 at 17:09 +0900, Ken'ichi Ohmichi wrote:
> On Wed, 28 Mar 2012 17:22:04 -0400
> makedumpfile uses the system memory of 2nd-kernel for a bitmap if RHEL.
> The bitmap represents each page of 1st-kernel is excluded or not.
> So the bitmap size depends on 1st-kernel's system memory.

Does this mean that makedumpfile's memory demand linearly grows with 1
bit per page of 1-st kernel's memory?

Is that the exact factor, if /tmp is in memory? Or is there any other
memory allocation that is not constant regarding the 1-st kernel memory
size?

Michael




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
