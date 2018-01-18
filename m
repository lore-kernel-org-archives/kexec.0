Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by casper.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ec8na-00029P-I9
 for kexec@lists.infradead.org; Thu, 18 Jan 2018 11:56:04 +0000
Date: Thu, 18 Jan 2018 12:55:19 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v4] kexec-tools: Perform run-time linking of libxenctrl.so
Message-ID: <20180118115519.GV21705@olila.local.net-space.pl>
References: <1516207141-31590-1-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1516207141-31590-1-git-send-email-eric.devolder@oracle.com>
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
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: andrew.cooper3@citrix.com, horms@verge.net.au, kexec@lists.infradead.org, konrad.wilk@oracle.com, xen-devel@lists.xen.org

On Wed, Jan 17, 2018 at 10:39:01AM -0600, Eric DeVolder wrote:
> When kexec is utilized in a Xen environment, it has an explicit
> run-time dependency on libxenctrl.so. This dependency occurs
> during the configure stage and when building kexec-tools.

[...]

As I saw Simon applied the patch. Great! Sadly I have just
realized that I have missed two things. Please look below.

> The patch creates a wrapper function around xc_interface_open()
> and xc_interface_close() to perform the dlopen() and dlclose().

You say about dlclose() here...

diff --git a/kexec/kexec-xen.h b/kexec/kexec-xen.h
new file mode 100644
index 0000000..ffb8743
--- /dev/null
+++ b/kexec/kexec-xen.h

[...]

> +/* The handle from dlopen(), needed by dlsym(), dlclose() */
> +extern void *xc_dlhandle;

...and here but it is never called. Is it by design or by mistake?
If by design please add a comment saying why into relevant place,
e.g. __xc_interface_close()? If by mistake please fix it.

[...]

> +/* The handle from dlopen(), needed by dlsym(), dlclose() */
> +extern void *xc_dlhandle;

I am still not happy with xc_dlhandle being extern. IMO it should be static.
I have missed that during last review. Sorry about that. I have a feeling
that you can easily fix it.

Define __xc_dlsym() in kexec/kexec-xen.c just before __xc_interface_open() like below:

void *__xc_dlsym(const char *symbol)
{
  return dlsym(xc_dlhandle, symbol);
}

> +/* Wrappers around xc_interface_open/close() to insert dlopen/dlclose() */
> +xc_interface *__xc_interface_open(xentoollog_logger *logger,
> +				  xentoollog_logger *dombuild_logger,
> +				  unsigned open_flags);
> +int __xc_interface_close(xc_interface *xch);
> +
> +/* GCC expression statements for evaluating dlsym() */
> +#define __xc_call(dtype, name, args...) \
> +( \
> +	{ dtype value; \
> +	typedef dtype (*func_t)(xc_interface *, ...); \
> +	func_t func = dlsym(xc_dlhandle, #name); \

And then replace dlsym(xc_dlhandle, #name) with __xc_dlsym(#name)...

> +	value = func(args); \
> +	value; } \
> +)
> +#define __xc_data(dtype, name) \
> +( \
> +	{ dtype *value = (dtype *)dlsym(xc_dlhandle, #name); value; } \

...and here. Additionally, you can use __xc_dlsym() instead of dlsym()
in other places in your patch. Latter is not a must...

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
