Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QEy1R-0008Oo-BI
	for kexec@lists.infradead.org; Wed, 27 Apr 2011 06:14:53 +0000
Date: Wed, 27 Apr 2011 15:14:44 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [Patch] kexec: fix a compiler warning on ppc64
Message-ID: <20110427061444.GD14497@verge.net.au>
References: <1303876403-10538-1-git-send-email-amwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1303876403-10538-1-git-send-email-amwang@redhat.com>
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
To: Amerigo Wang <amwang@redhat.com>
Cc: kexec@lists.infradead.org

On Wed, Apr 27, 2011 at 11:53:23AM +0800, Amerigo Wang wrote:
> I got the following warning when I compiled kexec-tools on ppc64,
> 
> In file included from kexec/arch/ppc64/kexec-ppc64.c:32:
> kexec/arch/ppc64/../../kexec-syscall.h:118:1: warning: "KEXEC_ARCH_NATIVE" redefined
> kexec/arch/ppc64/../../kexec-syscall.h:115:1: warning: this is the location of the previous definition
> 
> This is due to that ppc64 defines bot __powerpc64__ and __powerpc__,
> this patch fixes that warning.
> 
> Signed-off-by: WANG Cong <amwang@redhat.com>
> Cc: Simon Horman <horms@verge.net.au>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
