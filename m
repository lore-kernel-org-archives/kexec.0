Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TvVvt-0006ST-JD
 for kexec@lists.infradead.org; Wed, 16 Jan 2013 16:33:46 +0000
Message-ID: <50F6D666.5040906@citrix.com>
Date: Wed, 16 Jan 2013 16:33:42 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 0/3] Improve kexec support in Xen hypervisor
References: <1358353746-1899-1-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1358353746-1899-1-git-send-email-david.vrabel@citrix.com>
Content-Type: multipart/mixed; boundary="------------090102050701040100040100"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Eric Biederman <ebiederm@xmission.com>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

--------------090102050701040100040100
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On 16/01/13 16:29, David Vrabel wrote:
> This series of patches improves the kexec hypercall in the Xen
> hypervisor.  It is an incomplete prototype but I posting it early for
> comments on the proposed ABI/API.

And here is a (very) simple test program and a trivial test image I have
used.  This provides an example of how the libxc API can be used.

David

--------------090102050701040100040100
Content-Type: text/x-csrc; name="xen-kexec-test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="xen-kexec-test.c"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <xenctrl.h>
#include <xen/kexec.h>
#include "xc_kexec.h"

extern unsigned long image;
extern unsigned long image_end;

int main(void)
{
    xc_interface *xch;
    unsigned long start, size;
    size_t image_size;
    DECLARE_HYPERCALL_BUFFER(xen_kexec_segment_t, segments);
    DECLARE_HYPERCALL_BUFFER(void, image_buf);
    xen_kexec_load_v2_t load;
    int ret;

    xch = xc_interface_open(NULL, NULL, 0);
    if ( !xch )
    {
        perror("xc_open");
        exit(1);
    }

    ret = xc_kexec_get_range(xch, KEXEC_RANGE_MA_CRASH, 0, &start, &size);
    if ( ret )
    {
        perror("xc_kexec_get_range");
        exit(1);
    }

    printf("Crash region: 0x%08lx-0x%08lx\n", start, start + size);

    image_size = (void *)&image_end - (void *)&image;

    printf("Image %p-%p\n", &image, (void *)&image + image_size);

    image_buf = xc_hypercall_buffer_alloc(xch, image_buf, image_size);
    if ( !image_buf )
    {
        perror("xc_hypercall_buffer_alloc");
        exit(1);
    }
    segments = xc_hypercall_buffer_alloc(xch, segments, sizeof(*segments) * 1);
    if ( !segments )
    {
        perror("xc_hypercall_buffer_alloc");
        exit(1);
    }

    memcpy(image_buf, &image, image_size);

    set_xen_guest_handle(segments[0].buf, image_buf);
    segments[0].size = image_size;
    segments[0].dest_maddr = start;

    load.type = KEXEC_TYPE_DEFAULT;
    load.class = KEXEC_CLASS_32;
    load.nr_segments = 1;
    set_xen_guest_handle(load.segments, segments);
    load.entry_maddr = start;

    ret = xc_kexec_load(xch, &load);
    if ( ret )
    {
        perror("xc_kexec_load");
        exit(1);
    }

    xc_hypercall_buffer_free(xch, image_buf);
    xc_hypercall_buffer_free(xch, segments);

    ret = xc_kexec(xch, KEXEC_TYPE_DEFAULT);
    if ( ret )
    {
        perror("xc_kexec_exec");
        exit(1);
    }

    xc_interface_close(xch);

    return 0;
}

/*
 * Local variables:
 * mode: C
 * c-file-style: "BSD"
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 */

--------------090102050701040100040100
Content-Type: text/plain; name="image.S"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="image.S"

        .text
        .code32
	.globl image
image:
1:      mov     $0x3f8+5, %dx
        inb     %dx, %al
        test    $0x20, %al
        je      1b
        mov     $0x3f8, %dx
        mov     $'I', %al
        outb    %al, %dx
        hlt

        .globl image_end
image_end:

--------------090102050701040100040100
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------090102050701040100040100--

