Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RPsBC-0005KG-FX
 for kexec@lists.infradead.org; Mon, 14 Nov 2011 08:46:15 +0000
Date: Mon, 14 Nov 2011 17:46:10 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/3] kexec-tools: powerpc: Fix 64bit optimize for size
 (gcc -Os) build
Message-ID: <20111114084610.GB8750@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111114185433.0297c2c8@kryten> <20111114185622.79fe0a18@kryten>
 <20111114185329.19ddc2b4@kryten>
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
To: Anton Blanchard <anton@samba.org>
Cc: Michael Neuling <mikey@neuling.org>, kexec@lists.infradead.org, Milton Miller <miltonm@bga.com>, Matt Evans <matt@ozlabs.org>, amodra@gmail.com

On Mon, Nov 14, 2011 at 06:53:29PM +1100, Anton Blanchard wrote:
> 
> commit 46b2d0b8a719 (kexec/powerpc fix optimization for size (gcc -Os)
> build) added out of line GPR save/restore handlers for 32bit -Os
> builds. This patch adds the handlers for 64bit builds.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

On Mon, Nov 14, 2011 at 06:56:22PM +1100, Anton Blanchard wrote:
> 
> Some cleanup of the relocation code:
> 
> - Whitespace changes
> - Use braces to add clarity to nested for/if loop.
> - Order ADDR16 relocations
> - No need for to return from a void function.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

On Mon, Nov 14, 2011 at 06:54:33PM +1100, Anton Blanchard wrote:
> 
> Add all the TOC16 relocations. These were hit when building kexec
> with a recent toolchain.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>


Thanks Anton,

I have applied all three patches.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
