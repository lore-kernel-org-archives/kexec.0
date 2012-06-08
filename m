Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Sd0Ly-0004ap-Jh
 for kexec@lists.infradead.org; Fri, 08 Jun 2012 14:39:56 +0000
Date: Fri, 8 Jun 2012 10:39:49 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] ppc/ppc64: Compile purgatory code with gcc option
 -msoft-float
Message-ID: <20120608143949.GC29471@redhat.com>
References: <20120608134315.GA29791@redhat.com>
 <20120608134801.GZ24904@tucnak.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120608134801.GZ24904@tucnak.redhat.com>
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
To: Jakub Jelinek <jakub@redhat.com>
Cc: Lingzhu Xiang <lxiang@redhat.com>, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, "Suzuki K. Poulose" <suzuki@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jeremy Kerr <jk@ozlabs.org>

On Fri, Jun 08, 2012 at 03:48:01PM +0200, Jakub Jelinek wrote:
> On Fri, Jun 08, 2012 at 09:43:15AM -0400, Vivek Goyal wrote:
> > Recently we faced an issue on power7 machine where kernel hanged in purgatory.
> > Some investigation revealed that gcc is generating hardware FPU instructions.
> > I have been told we can't use it at this point of time and as kernel is
> > compiled with -msoft-float for ppc/ppc64, so should be purgatory (as it runs
> > inside kernel context).
> > 
> > Thanks to Jakub Jelinek and Lingzhu Xiang for debugging and coming up with
> > a fix for this issue.
> 
> IMNSHO as a follow-up all other architectures should be changed to
> compile kernel code with the right kernel CFLAGS (e.g. -mcmodel=kernel
> -mno-sse -mno-mmx should be used probably on x86_64, etc.).

Sure. These changes can be done in separate patches.

BTW, What does -mcmodel do and why should we use -mcmodel? purgatory, is a
separate binary which we reloate at turn time based on physical memory
location. IOW, why should we make any assumptions about running location
of purgatory and pass -mcmodel flag.

Eric, would have have any objections to making use of above gcc flags
for purgatory?

> 
> Furthermore, is there still a reason to compile sha256.c with -O0?  If
> there was a compiler bug? on ia64 6 years ago, with which gcc version
> it was, has the problem been reported and resolved?  Compiling code like
> hash computation unconditionally everywhere at -O0 must IMHO pessimize
> things unnecessarily.

git blame points to following commit for forcing -O0 on sha256. CCing
Jermey, if we can give some details why -O2 was a problem on IA6 and
if problem is still there if he has objections if we swtich back to -O2.

commit adf85cbc1756e56c1f52f56235a3c08b3c5b8e05
Author: Jeremy Kerr <jk@ozlabs.org>
Date:   Thu Dec 13 16:18:53 2007 +0900

    Build system simplification/standardisation
    
Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
