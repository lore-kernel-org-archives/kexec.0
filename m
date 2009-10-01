Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MtM5R-0000wD-Po
	for kexec@lists.infradead.org; Thu, 01 Oct 2009 13:52:53 +0000
Date: Thu, 1 Oct 2009 23:52:46 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: ARM misdetection
Message-ID: <20091001135245.GE8820@verge.net.au>
References: <d1b08f940910010634m1570a1cfqef90c7742b51f61d@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d1b08f940910010634m1570a1cfqef90c7742b51f61d@mail.gmail.com>
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
To: Andrea Adami <andrea.adami@gmail.com>
Cc: kexec@lists.infradead.org

On Thu, Oct 01, 2009 at 03:34:01PM +0200, Andrea Adami wrote:
> Hello,
> 
> Building kexec-tools_2.0.1 against glibc for armv5te I found out the
> code in kexec/phys_arch.c can lead to arch misdetection.
> The uname's output of my kernel is "armv5tel" and this won't match the
> string "arm".
> 
> I added a patch to the OpenEmbedded buildsystem following the example
> in the old kexec-tools-arm.patch (arch_compat_trampoline).
> 
> http://cgit.openembedded.org/cgit.cgi/openembedded/tree/recipes/kexec/files/fix-arm-arch-detection.patch
> 
> Other than adding some overhead for other archies, it just seems to work.

Extra blank lines and {} aside, this seems like a reasonable approach to me,
Could you submit it to this list with a Signed-off-by line[1]?

[1] http://linux.yyz.us/patch-format.html



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
