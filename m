Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UFNOR-00080Z-Fo
 for kexec@lists.infradead.org; Tue, 12 Mar 2013 11:29:20 +0000
Date: Tue, 12 Mar 2013 12:29:10 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH 4/4] kexec/xen: directly load images images into Xen
Message-ID: <20130312112910.GC13567@debian70-amd64.local.net-space.pl>
References: <1361469460-18771-1-git-send-email-david.vrabel@citrix.com>
 <1361469460-18771-5-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1361469460-18771-5-git-send-email-david.vrabel@citrix.com>
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
To: David Vrabel <david.vrabel@citrix.com>
Cc: kexec@lists.infradead.org, xen-devel@lists.xen.org

On Thu, Feb 21, 2013 at 05:57:40PM +0000, David Vrabel wrote:
> From: David Vrabel <david.vrabel@citrix.com>
>
> Xen 4.3 has an improvided kexec hypercall ABI that allows images to be
> loaded and executed without any kernel involvement.  Use the API
> provided by libxc to load images when running in a Xen guest.
>
> Support for loading images via the kexec_load syscall in non-upstream
> ("classic") Xen kernels is no longer supported.
>
> Signed-off-by: David Vrabel <david.vrabel@citrix.com>

[...]

> diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c

[...]

> +	type = kexec_flags & KEXEC_TYPE_CRASH;
> +	arch = (kexec_flags >> 16) & 0xffff;

arch = (kexec_flags & KEXEC_ARCH_MASK) >> 16;

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
