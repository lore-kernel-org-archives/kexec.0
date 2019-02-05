Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr1ez-00085U-MR
 for kexec@lists.infradead.org; Tue, 05 Feb 2019 14:25:15 +0000
Date: Tue, 5 Feb 2019 15:25:10 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] arm64: wipe old initrd addresses when patching the DTB
Message-ID: <20190205142510.65in5bqmyzsacsbq@verge.net.au>
References: <20190201155028.43562-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190201155028.43562-1-jean-philippe.brucker@arm.com>
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
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: kexec@lists.infradead.org

On Fri, Feb 01, 2019 at 03:50:28PM +0000, Jean-Philippe Brucker wrote:
> When copying the DTB from the current kernel, if the user didn't pass an
> initrd on the command-line, make sure that the new DTB doesn't contain
> initrd properties with stale addresses. Otherwise the next kernel will
> try to unpack the initramfs from a location that contains junk, since
> the initial initrd is long gone:
> 
> [   49.370026] Initramfs unpacking failed: junk in compressed archive
> 
> This issue used to be hidden by a successful recovery, but since commit
> ff1522bb7d98 ("initramfs: cleanup incomplete rootfs") in Linux, the
> kernel removes the default /root mountpoint after failing to load an
> initramfs, and cannot mount the rootfs passed on the command-line
> anymore.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
