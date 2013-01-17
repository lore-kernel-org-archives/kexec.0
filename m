Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.eu.citrix.com ([46.33.159.39])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tvoei-0004Ux-1q
 for kexec@lists.infradead.org; Thu, 17 Jan 2013 12:33:16 +0000
Message-ID: <1358425992.13856.54.camel@zakaz.uk.xensource.com>
Subject: Re: [Xen-devel] [PATCH 1/3] kexec: extend hypercall with improved
 load/unload ops
From: Ian Campbell <Ian.Campbell@citrix.com>
Date: Thu, 17 Jan 2013 12:33:12 +0000
In-Reply-To: <1358353746-1899-2-git-send-email-david.vrabel@citrix.com>
References: <1358353746-1899-1-git-send-email-david.vrabel@citrix.com>
 <1358353746-1899-2-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
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
To: David Vrabel <david.vrabel@citrix.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Eric Biederman <ebiederm@xmission.com>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On Wed, 2013-01-16 at 16:29 +0000, David Vrabel wrote:
> 
> +/*
> + * Load a kexec image into memory.
> + *
> + * Each segment of the image must reside in the memory region reserved
> + * for kexec (KEXEC_RANGE_MA_CRASH) and the entry point must be within
> + * the image.
> + *
> + * The caller is responsible for ensuring that multiple images do not
> + * overlap.
> + */
> +#define KEXEC_CMD_kexec_load_v2        4
> +typedef struct xen_kexec_load_v2 {
> +    uint8_t type;  /* One of KEXEC_TYPE_* */
> +    uint8_t class; /* One of KEXEC_CLASS_* */
> +    uint32_t nr_segments;
> +    XEN_GUEST_HANDLE(xen_kexec_segment_t) segments;
> +    uint64_t entry_maddr; /* image entry point machine address. */
> +} xen_kexec_load_v2_t;
> +DEFINE_XEN_GUEST_HANDLE(xen_kexec_load_v2_t); 

Might you want to implement the double buffering scheme which the
existing stuff has? This can avoid windows where there is no complete
crash kernel present while you load a new one.

Ian.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
