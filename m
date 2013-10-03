Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VRXWa-0003yB-2e
 for kexec@lists.infradead.org; Thu, 03 Oct 2013 01:16:16 +0000
Date: Thu, 3 Oct 2013 10:15:53 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] kexec: Fix off-by-one errors in locate_hole()
Message-ID: <20131003011553.GH13111@verge.net.au>
References: <1380703348-5877-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1380703348-5877-1-git-send-email-geert@linux-m68k.org>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: kexec@lists.infradead.org

On Wed, Oct 02, 2013 at 10:42:27AM +0200, Geert Uytterhoeven wrote:
> When calling locate_hole() with "hole_size" equal to the size of an
> available memory block, it fails to use that memory block.
> 
> "end" and "hole_max" point to the last byte within the range, hence
>   - "size = end - start" is one less than "hole_size",
>   - "hole_base + hole_size" is one more than "hole_max".
> 
> Subtract one from "hole_size" when doing the comparison (adding 1 to "size"
> could overflow in case of one big range covering the whole address space).
> But explicitly check if "hole_size" is zero first, to handle this case
> without causing underflows.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
