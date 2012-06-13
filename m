Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SecSr-0003Nq-SV
 for kexec@lists.infradead.org; Wed, 13 Jun 2012 01:33:42 +0000
Date: Wed, 13 Jun 2012 10:33:36 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Load bzImages smaller than 32 KiB
Message-ID: <20120613013336.GJ16686@verge.net.au>
References: <20120601155931.GB17616@zzz> <20120604231459.GO28747@verge.net.au>
 <20120605234605.GA28884@zzz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120605234605.GA28884@zzz>
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
To: Eric Biggers <ebiggers3@gmail.com>
Cc: kexec@lists.infradead.org

On Tue, Jun 05, 2012 at 07:46:07PM -0400, Eric Biggers wrote:
> Allow bzImages smaller than 32KiB to be kexec'ed.
> 
> The current code will fail to load a bzImage smaller than 32768 bytes (sizeof
> struct x86_linux_header), but the 'memdisk' program that comes with syslinux is
> only about 26 KiB.  This patch changes the minimum size to 1024 bytes (2
> sectors), which appears to be the limit that syslinux enforces.
> 
> Removed the "tail" field of struct x86_linux_header because it doesn't seem to
> actually be used (is there a reason for it?).
> 
> Also, note that bzImage_probe() was incorrectly using `sizeof (header)', even
> though header is a pointer.
> 
> Signed-off-by: Eric Biggers <ebiggers3@gmail.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
