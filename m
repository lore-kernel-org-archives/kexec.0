Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cCj6v-0004wm-Pf
 for kexec@lists.infradead.org; Fri, 02 Dec 2016 08:22:26 +0000
Date: Fri, 2 Dec 2016 09:21:58 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH V2] purgatory: Change default sha256 optimization to -O2
Message-ID: <20161202082158.GC32351@verge.net.au>
References: <32a52ca4-8741-e0e6-92c1-6b9583fa479b@infradead.org>
 <e64cbdf7-36f9-c97e-a243-e66350b55661@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e64cbdf7-36f9-c97e-a243-e66350b55661@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Pratyush Anand <panand@redhat.com>, kexec@lists.infradead.org

On Thu, Dec 01, 2016 at 11:09:37AM -0800, Geoff Levand wrote:
> Change the default purgatory sha256 code optimization from -O0 to -O2, and add a
> new arch specific makefile variable $(ARCH)_PURGATORY_SHA256_CFLAGS which can
> over ride this default.  Set ia64_PURGATORY_SHA256_CFLAGS to -O0 to retain the
> previous optimization level for ia64.
> 
> The purgatory sha256 code needs the be built with -O0 for the  ia64
> architecture.  Currently this code is built with -O0 for all architectures,
> which slows down the calculations for architectures which could otherwise
> use -O2.
> 
> On arm64, it takes around 20 second to verify SHA in purgatory when
> vmlinuz image is around 13MB and initramfs is around 30M with -O2
> enabled. Otherwise, it takes more than 2 minutes.
> 
> Cc: Pratyush Anand <panand@redhat.com>
> Signed-off-by: Geoff Levand <geoff@infradead.org>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
