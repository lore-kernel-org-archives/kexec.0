From: Luis Chamberlain <mcgrof@kernel.org>
Date: Tue, 25 Jan 2022 11:50:40 -0800
Subject: [PATCH v4 1/6] s390/kexec_file: Don't opencode appended
 signature check.
In-Reply-To: <940cd6a0e88793060cdf5ddb7880c03564b38bdd.1641822505.git.msuchanek@suse.de>
References: <cover.1641822505.git.msuchanek@suse.de>
 <940cd6a0e88793060cdf5ddb7880c03564b38bdd.1641822505.git.msuchanek@suse.de>
Message-ID: <YfBUkIlvQc0U0ylo@bombadil.infradead.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon, Jan 10, 2022 at 02:49:53PM +0100, Michal Suchanek wrote:
> Module verification already implements appeded signature check.
> 
> Reuse it for kexec_file.
> 
> The kexec_file implementation uses EKEYREJECTED error in some cases when
> there is no key and the common implementation uses ENOPKG or EBADMSG
> instead.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> ---
> v3: Philipp Rudo <prudo@redhat.com>: Update the commit with note about
> change of return value
> ---
>  arch/s390/kernel/machine_kexec_file.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
> index 8f43575a4dd3..c944d71316c7 100644
> --- a/arch/s390/kernel/machine_kexec_file.c
> +++ b/arch/s390/kernel/machine_kexec_file.c
> @@ -31,6 +31,7 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
>  	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
>  	struct module_signature *ms;
>  	unsigned long sig_len;
> +	int ret;
>  
>  	/* Skip signature verification when not secure IPLed. */
>  	if (!ipl_secure_flag)
> @@ -45,25 +46,12 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
>  	kernel_len -= marker_len;
>  
>  	ms = (void *)kernel + kernel_len - sizeof(*ms);
> -	kernel_len -= sizeof(*ms);
> +	ret = mod_check_sig(ms, kernel_len, "kexec");
> +	if (ret)
> +		return ret;
>  
>  	sig_len = be32_to_cpu(ms->sig_len);
> -	if (sig_len >= kernel_len)
> -		return -EKEYREJECTED;

There is a small minor fix here, where by using mod_check_sig() now
decreased the kernel_len by the sizeof(*ms). It is minor though.

> -	kernel_len -= sig_len;
> -
> -	if (ms->id_type != PKEY_ID_PKCS7)
> -		return -EKEYREJECTED;

More importantly is the return value used here changes but given the
Ack by Heiko I suspect this if fine and does not break old userspace,
the only change here is the possible error value returned by the
kexec_file_load() system call.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

   Luis

