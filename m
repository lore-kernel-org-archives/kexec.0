Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UFiM4-0000Ir-HM
 for kexec@lists.infradead.org; Wed, 13 Mar 2013 09:52:17 +0000
Date: Wed, 13 Mar 2013 10:52:11 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: failed to compile kexec from git
Message-ID: <20130313095210.GF26746@verge.net.au>
References: <526259845.192944.1363143172053.JavaMail.root@redhat.com>
 <1589213774.196580.1363144097993.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1589213774.196580.1363144097993.JavaMail.root@redhat.com>
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
To: CAI Qian <caiqian@redhat.com>
Cc: kexec <kexec@lists.infradead.org>, Cliff Wickman <cpw@sgi.com>

On Tue, Mar 12, 2013 at 11:08:17PM -0400, CAI Qian wrote:
> If I revert this commit,
> 6df15d1cca55b2cd59c79aed69f004e1b2a6ba36
> kexec x86: drop truncation warning for crash kernel
> 
> Everything is fine again.

Thanks. I have applied the following patch which I believe resolves
the problem. Cliff, could you test this?

commit 51438a32f6a0f09a358742f06196d14e4ad0ccab
Author: Simon Horman <horms@verge.net.au>
Date:   Wed Mar 13 10:48:48 2013 +0100

    Correct build failure in init_linux_parameters()
    
    This fixes a build failure introduced by
    "kexec x86: drop truncation warning for crash kernel".
    
    Reported-by: CAI Qian <caiqian@redhat.com>
    Cc: Cliff Wickman <cpw@sgi.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index b903d43..454fad6 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -508,7 +508,7 @@ void setup_linux_system_parameters(struct kexec_info *info,
 	range = info->memory_range;
 	ranges = info->memory_ranges;
 	if (ranges > E820MAX) {
-		if (!(kexec_flags & KEXEC_ON_CRASH))
+		if (!(info->kexec_flags & KEXEC_ON_CRASH))
 			/*
 			 * this e820 not used for capture kernel, see
 			 * do_bzImage_load()


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
