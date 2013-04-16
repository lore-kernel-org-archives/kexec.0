Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1URzWe-0006Jw-RP
 for kexec@lists.infradead.org; Tue, 16 Apr 2013 06:37:57 +0000
Date: Tue, 16 Apr 2013 15:37:50 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [UPDATED PATCH] kexec/powerpc: Handle buffer overflow in kernel
 command line
Message-ID: <20130416063750.GH27462@verge.net.au>
References: <515AB9BF.5080104@gmail.com>
 <20130402121228.435.27569.stgit@suzukikp.in.ibm.com>
 <516CECFE.6020504@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <516CECFE.6020504@in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Cc: kexec@lists.infradead.org, zhangyanfei.yes@gmail.com

On Tue, Apr 16, 2013 at 11:47:34AM +0530, Suzuki K. Poulose wrote:
> On 04/02/2013 05:43 PM, Suzuki K. Poulose wrote:
> >Zhang,
> >
> >Sorry, it was my mistake. I have updated my patch based on the upstream
> >tree now.
> >
> >---
> >
> >From: Suzuki K. Poulose <suzuki@in.ibm.com>
> >
> >Enforce size check for kernel command line to make sure it
> >doesn't overflow COMMAND_LINE_SIZE.
> >
> >Reported-by: Nathan D. Miller <nathanm2@us.ibm.com>
> >Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
> 
> Simon,
> 
> Could you please apply this one ?

Sorry for the delay, I have applied it now.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
