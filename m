Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V1Xqr-0002g6-1t
 for kexec@lists.infradead.org; Tue, 23 Jul 2013 08:21:47 +0000
Date: Tue, 23 Jul 2013 17:19:48 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v3] xen: Enforce page size when it could not be
 established by other means
Message-Id: <20130723171948.1df286aa1acf2c72e6027b52@mxc.nes.nec.co.jp>
In-Reply-To: <1374527955-14968-1-git-send-email-daniel.kiper@oracle.com>
References: <1374527955-14968-1-git-send-email-daniel.kiper@oracle.com>
Mime-Version: 1.0
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
To: daniel.kiper@oracle.com
Cc: andrew.cooper3@citrix.com, xen-devel@lists.xensource.com, kexec@lists.infradead.org

On Mon, 22 Jul 2013 23:19:15 +0200
Daniel Kiper <daniel.kiper@oracle.com> wrote:

> Enforce page size when it could not be established by other means.
> 
> v3 - suggestions/fixes:
>    - rearrange code for readability
>      (suggested by Atsushi Kumagai).
> 
> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>

Thanks for all your work !
I'll merge your v3 patchset into makedumpfile-1.5.5.


Atsushi Kumagai

> ---
>  makedumpfile.c |   12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index b42565c..20a547b 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -7324,8 +7324,6 @@ initial_xen(void)
>  #endif
>  	if (!init_xen_crash_info())
>  		return FALSE;
> -	if (!fallback_to_current_page_size())
> -		return FALSE;
>  	/*
>  	 * Get the debug information for analysis from the vmcoreinfo file
>  	 */
> @@ -7370,6 +7368,16 @@ initial_xen(void)
>  		if (!read_vmcoreinfo_from_vmcore(offset, size, TRUE))
>  			return FALSE;
>  	}
> +
> +	if (!info->page_size) {
> +		/*
> +		 * If we cannot get page_size from a vmcoreinfo file,
> +		 * fall back to the current kernel page size.
> +		 */
> +		if (!fallback_to_current_page_size())
> +			return FALSE;
> +	}
> +
>  	if (!get_xen_info())
>  		return FALSE;
>  
> -- 
> 1.7.10.4

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
