Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eEUtm-0008Sm-4s
 for kexec@lists.infradead.org; Tue, 14 Nov 2017 06:40:44 +0000
Date: Tue, 14 Nov 2017 14:39:55 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v6 4/5] crash: export paddr_vmcoreinfo_note()
Message-ID: <20171114063955.GA4668@dhcp-128-65.nay.redhat.com>
References: <20171113192958.22953-1-marcandre.lureau@redhat.com>
 <20171113192958.22953-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171113192958.22953-5-marcandre.lureau@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: Tony Luck <tony.luck@intel.com>, Baoquan He <bhe@redhat.com>, mst@redhat.com, somlo@cmu.edu, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Hari Bathini <hbathini@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On 11/13/17 at 08:29pm, Marc-Andr=E9 Lureau wrote:
> The following patch is going to use the symbol from the fw_cfg module,
> to call the function and write the note location details in the
> vmcoreinfo entry, so qemu can produce dumps with the vmcoreinfo note.
> =

> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Baoquan He <bhe@redhat.com>
> CC: Dave Young <dyoung@redhat.com>
> CC: Dave Young <dyoung@redhat.com>
> CC: Hari Bathini <hbathini@linux.vnet.ibm.com>
> CC: Tony Luck <tony.luck@intel.com>
> CC: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> Acked-by: Gabriel Somlo <somlo@cmu.edu>
> ---
>  kernel/crash_core.c | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 6db80fc0810b..47541c891810 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -375,6 +375,7 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
>  {
>  	return __pa(vmcoreinfo_note);
>  }
> +EXPORT_SYMBOL(paddr_vmcoreinfo_note);
>  =

>  static int __init crash_save_vmcoreinfo_init(void)
>  {
> -- =

> 2.15.0.125.g8f49766d64
> =


Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
