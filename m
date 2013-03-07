Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDQr9-0006zE-Sl
 for kexec@lists.infradead.org; Thu, 07 Mar 2013 02:46:57 +0000
Message-ID: <1362624246.8941.104.camel@hastur.hellion.org.uk>
Subject: Re: [Xen-devel] [PATCH 7/8] libxc: add hypercall buffer arrays
From: Ian Campbell <ian.campbell@citrix.com>
Date: Thu, 7 Mar 2013 02:44:06 +0000
In-Reply-To: <1361468894-18655-8-git-send-email-david.vrabel@citrix.com>
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
 <1361468894-18655-8-git-send-email-david.vrabel@citrix.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On Thu, 2013-02-21 at 17:48 +0000, David Vrabel wrote:
> From: David Vrabel <david.vrabel@citrix.com>
> 
> Hypercall buffer arrays are used when a hypercall takes a variable
> length array of buffers.

This looks good to me, I took a quick peek at the 4/4 patch in the kexec
tools series which uses it as well.

Acked-by: Ian Campbell <ian.campbell@citrix.com>

> 
> Signed-off-by: David Vrabel <david.vrabel@citrix.com>
> ---
>  tools/libxc/xc_hcall_buf.c |   73 ++++++++++++++++++++++++++++++++++++++++++++
>  tools/libxc/xenctrl.h      |   27 ++++++++++++++++
>  2 files changed, 100 insertions(+), 0 deletions(-)
> 
> diff --git a/tools/libxc/xc_hcall_buf.c b/tools/libxc/xc_hcall_buf.c
> index ced9abd..3e01f3f 100644
> --- a/tools/libxc/xc_hcall_buf.c
> +++ b/tools/libxc/xc_hcall_buf.c
> @@ -228,6 +228,79 @@ void xc__hypercall_bounce_post(xc_interface *xch, xc_hypercall_buffer_t *b)
>      xc__hypercall_buffer_free(xch, b);
>  }
>  
> +struct xc_hypercall_buffer_array {
> +    unsigned max_bufs;
> +    xc_hypercall_buffer_t *bufs;
> +};
> +
> +xc_hypercall_buffer_array_t *xc_hypercall_buffer_array_create(xc_interface *xch,
> +                                                              unsigned n)
> +{
> +    xc_hypercall_buffer_array_t *array;
> +    xc_hypercall_buffer_t *bufs = NULL;
> +
> +    array = malloc(sizeof(*array));
> +    if ( array == NULL )
> +        goto error;
> +
> +    bufs = calloc(n, sizeof(*bufs));
> +    if ( bufs == NULL )
> +        goto error;
> +
> +    array->max_bufs = n;
> +    array->bufs     = bufs;
> +
> +    return array;
> +
> +error:
> +    free(bufs);
> +    free(array);
> +    return NULL;
> +}
> +
> +void *xc__hypercall_buffer_array_alloc(xc_interface *xch,
> +                                       xc_hypercall_buffer_array_t *array,
> +                                       unsigned index,
> +                                       xc_hypercall_buffer_t *hbuf,
> +                                       size_t size)
> +{
> +    void *buf;
> +
> +    if ( index >= array->max_bufs || array->bufs[index].hbuf )
> +        abort();
> +
> +    buf = xc__hypercall_buffer_alloc(xch, hbuf, size);
> +    if ( buf )
> +        array->bufs[index] = *hbuf;
> +    return buf;
> +}
> +
> +void *xc__hypercall_buffer_array_get(xc_interface *xch,
> +                                     xc_hypercall_buffer_array_t *array,
> +                                     unsigned index,
> +                                     xc_hypercall_buffer_t *hbuf)
> +{
> +    if ( index >= array->max_bufs || array->bufs[index].hbuf == NULL )
> +        abort();
> +
> +    *hbuf = array->bufs[index];
> +    return array->bufs[index].hbuf;
> +}
> +
> +void xc_hypercall_buffer_array_destroy(xc_interface *xc,
> +                                       xc_hypercall_buffer_array_t *array)
> +{
> +    unsigned i;
> +
> +    if ( array == NULL )
> +        return;
> +
> +    for (i = 0; i < array->max_bufs; i++ )
> +        xc__hypercall_buffer_free(xc, &array->bufs[i]);
> +    free(array->bufs);
> +    free(array);
> +}
> +
>  /*
>   * Local variables:
>   * mode: C
> diff --git a/tools/libxc/xenctrl.h b/tools/libxc/xenctrl.h
> index 32122fd..c3b2c28 100644
> --- a/tools/libxc/xenctrl.h
> +++ b/tools/libxc/xenctrl.h
> @@ -317,6 +317,33 @@ void xc__hypercall_buffer_free_pages(xc_interface *xch, xc_hypercall_buffer_t *b
>  #define xc_hypercall_buffer_free_pages(_xch, _name, _nr) xc__hypercall_buffer_free_pages(_xch, HYPERCALL_BUFFER(_name), _nr)
>  
>  /*
> + * Array of hypercall buffers.
> + *
> + * Create an array with xc_hypercall_buffer_array_create() and
> + * populate it by declaring one hypercall buffer in a loop and
> + * allocating the buffer with xc_hypercall_buffer_array_alloc().
> + *
> + * To access a previously allocated buffers, declare a new hypercall
> + * buffer and call xc_hypercall_buffer_array_get().
> + *
> + * Destroy the array with xc_hypercall_buffer_array_destroy() to free
> + * the array and all its alocated hypercall buffers.
> + */
> +struct xc_hypercall_buffer_array;
> +typedef struct xc_hypercall_buffer_array xc_hypercall_buffer_array_t;
> +
> +xc_hypercall_buffer_array_t *xc_hypercall_buffer_array_create(xc_interface *xch, unsigned n);
> +void *xc__hypercall_buffer_array_alloc(xc_interface *xch, xc_hypercall_buffer_array_t *array,
> +                                       unsigned index, xc_hypercall_buffer_t *hbuf, size_t size);
> +#define xc_hypercall_buffer_array_alloc(_xch, _array, _index, _name, _size) \
> +    xc__hypercall_buffer_array_alloc(_xch, _array, _index, HYPERCALL_BUFFER(_name), _size)
> +void *xc__hypercall_buffer_array_get(xc_interface *xch, xc_hypercall_buffer_array_t *array,
> +                                     unsigned index, xc_hypercall_buffer_t *hbuf);
> +#define xc_hypercall_buffer_array_get(_xch, _array, _index, _name, _size) \
> +    xc__hypercall_buffer_array_get(_xch, _array, _index, HYPERCALL_BUFFER(_name))
> +void xc_hypercall_buffer_array_destroy(xc_interface *xc, xc_hypercall_buffer_array_t *array);
> +
> +/*
>   * CPUMAP handling
>   */
>  typedef uint8_t *xc_cpumap_t;



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
