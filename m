Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDvby-0003Iy-MD
 for kexec@lists.infradead.org; Fri, 08 Mar 2013 11:37:21 +0000
Date: Fri, 8 Mar 2013 12:37:08 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH 4/8] kexec: add infrastructure for handling kexec images
Message-ID: <20130308113708.GF10740@debian70-amd64.local.net-space.pl>
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
 <1361468894-18655-5-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1361468894-18655-5-git-send-email-david.vrabel@citrix.com>
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

On Thu, Feb 21, 2013 at 05:48:10PM +0000, David Vrabel wrote:
> From: David Vrabel <david.vrabel@citrix.com>
>
> Add the code needed to handle and load kexec images into Xen memory or
> into the crash region.  This is needed for the new KEXEC_CMD_load and
> KEXEC_CMD_unload hypercall sub-ops.
>
> Much of this code is derived from the Linux kernel.
>
> Signed-off-by: David Vrabel <david.vrabel@citrix.com>

[...]

> diff --git a/xen/common/kimage.c b/xen/common/kimage.c

[...]

> +static int kimage_load_segment(struct kexec_image *image, xen_kexec_segment_t *segment)
> +{
> +    int result = -ENOMEM;

Somewhere should be a check that arhitecture of loaded image
is compatible with arhitecture on which we currently running.

> +    switch ( image->type )
> +    {
> +    case KEXEC_TYPE_DEFAULT:
> +        result = kimage_load_normal_segment(image, segment);
> +        break;
> +    case KEXEC_TYPE_CRASH:
> +        result = kimage_load_crash_segment(image, segment);
> +        break;
> +    }
> +
> +    return result;
> +}

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
