Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UPfyA-0005IJ-TU
 for kexec@lists.infradead.org; Tue, 09 Apr 2013 21:20:47 +0000
Date: Tue, 9 Apr 2013 23:20:36 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH 5/5] kexec/xen: directly load images images into Xen
Message-ID: <20130409212036.GE31533@debian70-amd64.local.net-space.pl>
References: <1365448014-12119-1-git-send-email-david.vrabel@citrix.com>
 <1365448014-12119-6-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1365448014-12119-6-git-send-email-david.vrabel@citrix.com>
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
To: David Vrabel <david.vrabel@citrix.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, xen-devel@lists.xen.org

On Mon, Apr 08, 2013 at 08:06:54PM +0100, David Vrabel wrote:
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

> +int xen_kexec_load(uint64_t entry,
> +		   uint32_t nr_segments, struct kexec_segment *segments,
> +		   uint64_t kexec_flags)
> +{
> +	xc_interface *xch;
> +	xc_hypercall_buffer_array_t *array = NULL;
> +	uint8_t type;
> +	uint8_t arch;
> +	xen_kexec_segment_t *xen_segs;
> +	int s;
> +	int ret = -1;
> +
> +	xch = xc_interface_open(NULL, NULL, 0);
> +	if (!xch)
> +		return -1;
> +
> +	xen_segs = calloc(nr_segments, sizeof(*xen_segs));
> +	if (!xen_segs)
> +		goto out;
> +
> +	array = xc_hypercall_buffer_array_create(xch, nr_segments);
> +	if (array == NULL)
> +		goto out;
> +
> +	for (s = 0; s < nr_segments; s++) {
> +		DECLARE_HYPERCALL_BUFFER(void, seg_buf);
> +
> +		seg_buf = xc_hypercall_buffer_array_alloc(xch, array, s,
> +							  seg_buf, segments[s].bufsz);
> +		if (seg_buf == NULL)
> +			goto out;
> +		memcpy(seg_buf, segments[s].buf, segments[s].bufsz);
> +
> +		set_xen_guest_handle(xen_segs[s].buf, seg_buf);
> +		xen_segs[s].buf_size = segments[s].bufsz;
> +		xen_segs[s].dest_maddr = (uint64_t)segments[s].mem;
> +		xen_segs[s].dest_size = segments[s].memsz;
> +	}
> +
> +	type = kexec_flags & KEXEC_TYPE_CRASH;
> +	arch = (kexec_flags >> 16) & 0xffff;

arch = (kexec_flags & KEXEC_ARCH_MASK) >> 16;

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
