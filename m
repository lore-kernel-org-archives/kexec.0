Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VgoMA-00055h-Be
 for kexec@lists.infradead.org; Thu, 14 Nov 2013 04:16:39 +0000
Date: Thu, 14 Nov 2013 13:16:09 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH RESEND] arm: add command line option for the total image
 size
Message-ID: <20131114041609.GC22870@verge.net.au>
References: <1384355795-20796-1-git-send-email-zonque@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1384355795-20796-1-git-send-email-zonque@gmail.com>
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
To: Daniel Mack <zonque@gmail.com>
Cc: linux@arm.linux.org.uk, kexec@lists.infradead.org, neumann@teufel.de

On Wed, Nov 13, 2013 at 04:16:35PM +0100, Daniel Mack wrote:
> Currently, kexec on arm assumes that it's safe to place binary images
> such as atags, dtb or initrd at an estimated offset after the load
> address. That estimated offset is set to 4 times the size of the
> compressed image, hence assuming a minimum compression ratio of 1:4.
> 
> While that assumption matches what the in-kernel compressors are able to
> achive, it doesn't take into account the .bss section the kernel image
> carries, and which can grow to arbitrary sizes while not accounting to
> the compressed image size.
> 
> After decompression, and before the execution of the compressed kernel,
> the .bss area is initialized to zeros, trampeling over the binary images
> in case they happen to live in that piece of memory.
> 
> Unfortunately, determining the full image size is not easiliy possible
> at runtime, as it would include doing all possible ways of
> decompression and then walk the ELF sections by hand.
> 
> For now, allow users to override the static offset with a new, arm
> specific command line argument. Users are supposed to set this, and
> determine a sane value by using 'arm-linux-size vmlinux'.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
