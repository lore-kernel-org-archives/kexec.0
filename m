Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WY1pv-0005hU-Mk
 for kexec@lists.infradead.org; Wed, 09 Apr 2014 23:23:20 +0000
Date: Thu, 10 Apr 2014 08:22:54 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/ppc: cleanup crash regions creation
Message-ID: <20140409232254.GE2187@verge.net.au>
References: <1394178033-501-1-git-send-email-nyushchenko@dev.rtsoft.ru>
 <532C1B71.2080406@dev.rtsoft.ru>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <532C1B71.2080406@dev.rtsoft.ru>
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
To: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
Cc: yadviga@dev.rtsoft.ru, lugovskoy@dev.rtsoft.ru, kexec@lists.infradead.org

On Fri, Mar 21, 2014 at 02:58:57PM +0400, Nikita Yushchenko wrote:
> > Move filling crash_memory_range table entries into a separate routine,
> > which saves quite a few lines of code.
> > 
> > In this routine, if range spawns over lowmem-highmem border, split range
> > into two. This is needed to get proper virtual address for lowmem part.
> > Similar thing is already done for x86. Credits to Yadviga Grigorieva
> > <yadviga@dev.rtsoft.ru> for tracking down this issue for ppc.
> > 
> > Also this patch makes excluding crash kernel region a bit shorter, and
> > removes unused variable to get rid of compiler warning.
> > 
> > Signed-off-by: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
> > ---
> >  kexec/arch/ppc/crashdump-powerpc.c |  108 +++++++++++++++++-------------------
> >  1 files changed, 51 insertions(+), 57 deletions(-)
> 
> Hi
> 
> Any followup on this?
> 
> Without this patch, vmcore files extracted with kdump is not very useful with gdb:

Apologies for the delay, I have applied this patch.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
