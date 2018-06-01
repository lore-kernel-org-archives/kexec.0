Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fOoe8-0007mo-S1
 for kexec@lists.infradead.org; Fri, 01 Jun 2018 18:19:30 +0000
Date: Fri, 1 Jun 2018 20:19:13 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v4 4/8] firmware: add call to LSM hook before firmware
 sysfs fallback
Message-ID: <20180601181913.GN4511@wotan.suse.de>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1527616920-5415-5-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1527616920-5415-5-git-send-email-zohar@linux.vnet.ibm.com>
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, "Luis R . Rodriguez" <mcgrof@kernel.org>, Eric Biederman <ebiederm@xmission.com>, linux-integrity@vger.kernel.org, Andres Rodriguez <andresx7@gmail.com>

On Tue, May 29, 2018 at 02:01:56PM -0400, Mimi Zohar wrote:
> Add an LSM hook prior to allowing firmware sysfs fallback loading.

Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>

> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Luis R. Rodriguez <mcgrof@suse.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> 
> Changelog v4:
> - call new LSM security_kernel_arg hook
> 
> Changelog v2:
> - call security_kernel_read_blob()
> - rename the READING_FIRMWARE_FALLBACK kernel_read_file_id enumeration to
> READING_FIRMWARE_FALLBACK_SYSFS.
> ---
>  drivers/base/firmware_loader/fallback.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> index 358354148dec..2443bda81631 100644
> --- a/drivers/base/firmware_loader/fallback.c
> +++ b/drivers/base/firmware_loader/fallback.c
> @@ -651,6 +651,8 @@ static bool fw_force_sysfs_fallback(unsigned int opt_flags)
>  
>  static bool fw_run_sysfs_fallback(unsigned int opt_flags)
>  {
> +	int ret;
> +
>  	if (fw_fallback_config.ignore_sysfs_fallback) {
>  		pr_info_once("Ignoring firmware sysfs fallback due to sysctl knob\n");
>  		return false;
> @@ -659,6 +661,11 @@ static bool fw_run_sysfs_fallback(unsigned int opt_flags)
>  	if ((opt_flags & FW_OPT_NOFALLBACK))
>  		return false;
>  
> +	/* Also permit LSMs and IMA to fail firmware sysfs fallback */
> +	ret = security_kernel_load_data(LOADING_FIRMWARE);
> +	if (ret < 0)
> +		return ret;
> +
>  	return fw_force_sysfs_fallback(opt_flags);
>  }
>  
> -- 
> 2.7.5
> 
> 

-- 
Do not panic

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
