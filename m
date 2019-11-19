Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iX5Ob-00005Z-To
 for kexec@lists.infradead.org; Tue, 19 Nov 2019 15:26:27 +0000
Date: Tue, 19 Nov 2019 10:24:22 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1049422055.13569004.1574177062892.JavaMail.zimbra@redhat.com>
In-Reply-To: <1574169634-10329-1-git-send-email-bhsharma@redhat.com>
References: <1574169634-10329-1-git-send-email-bhsharma@redhat.com>
Subject: Re: [PATCH] crash/arm64: Determine vabits_actual value from
 'TCR_EL1.T1SZ' value in vmcoreinfo
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, bhupesh linux <bhupesh.linux@gmail.com>, kexec@lists.infradead.org, Prabhakar Kushwaha <prabhakar.pkin@gmail.com>, crash-utility@redhat.com


----- Original Message -----
> I have recently sent a kernel patch upstream to add 'TCR_EL1.T1SZ' to
> vmcoreinfo for arm64 (see [0]), instead of VA_BITS_ACTUAL.
> 
> 'crash' can read the 'TCR_EL1.T1SZ' value from vmcoreinfo
> [which indicates the size offset of the memory region addressed by
> TTBR1_EL1] and hence can be used for determining the vabits_actual
> value.

Thanks Bhupesh -- your patch has been queued for crash-7.2.8:

  https://github.com/crash-utility/crash/commit/bfd9a651f9426d86250295ac875d7e33d8de2a97

Dave


> 
> [0].http://lists.infradead.org/pipermail/kexec/2019-November/023962.html
> 
> Cc: Dave Anderson <anderson@redhat.com>
> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
> Cc: crash-utility@redhat.com
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> ---
>  arm64.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arm64.c b/arm64.c
> index af7147d24e20..083491331985 100644
> --- a/arm64.c
> +++ b/arm64.c
> @@ -3856,8 +3856,17 @@ arm64_calc_VA_BITS(void)
>  		} else if (ACTIVE())
>  			error(FATAL, "cannot determine VA_BITS_ACTUAL: please use
>  			/proc/kcore\n");
>  		else {
> -			if ((string = pc->read_vmcoreinfo("NUMBER(VA_BITS_ACTUAL)"))) {
> -				value = atol(string);
> +			if ((string = pc->read_vmcoreinfo("NUMBER(tcr_el1_t1sz)"))) {
> +				/* See ARMv8 ARM for the description of
> +				 * TCR_EL1.T1SZ and how it can be used
> +				 * to calculate the vabits_actual
> +				 * supported by underlying kernel.
> +				 *
> +				 * Basically:
> +				 * vabits_actual = 64 - T1SZ;
> +				 */
> +				value = 64 - strtoll(string, NULL, 0);
> +				fprintf(fp,  "vmcoreinfo : vabits_actual: %ld\n", value);
>  				free(string);
>  				machdep->machspec->VA_BITS_ACTUAL = value;
>  				machdep->machspec->VA_BITS = value;
> --
> 2.7.4
> 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
