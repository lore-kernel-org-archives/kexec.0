From: joeyli <jlee@suse.com>
Date: Wed, 6 Apr 2022 23:41:16 +0800
Subject: [PATCH 1/4] Fix arm64 kexec forbidding kernels signed with keys
 in the secondary keyring to boot
In-Reply-To: <83b3583f35c50c609739a8d857d14e8410293373.1644953683.git.msuchanek@suse.de>
References: <cover.1644953683.git.msuchanek@suse.de>
 <83b3583f35c50c609739a8d857d14e8410293373.1644953683.git.msuchanek@suse.de>
Message-ID: <20220406154056.GL11641@linux-l9pv.suse>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Tue, Feb 15, 2022 at 08:39:38PM +0100, Michal Suchanek wrote:
> commit d3bfe84129f6 ("certs: Add a secondary system keyring that can be added to dynamically")
> split of .system_keyring into .builtin_trusted_keys and
> .secondary_trusted_keys broke kexec, thereby preventing kernels signed by
> keys which are now in the secondary keyring from being kexec'd.
> 
> Fix this by passing VERIFY_USE_SECONDARY_KEYRING to
> verify_pefile_signature().
> 
> Cherry-picked from
> commit ea93102f3224 ("Fix kexec forbidding kernels signed with keys in the secondary keyring to boot")
> 
> Fixes: 732b7b93d849 ("arm64: kexec_file: add kernel signature verification support")
> Cc: kexec at lists.infradead.org
> Cc: keyrings at vger.kernel.org
> Cc: linux-security-module at vger.kernel.org
> Cc: stable at kernel.org
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>

> ---
>  arch/arm64/kernel/kexec_image.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> index 9ec34690e255..1fbf2ee7c005 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -133,7 +133,8 @@ static void *image_load(struct kimage *image,
>  #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
>  static int image_verify_sig(const char *kernel, unsigned long kernel_len)
>  {
> -	return verify_pefile_signature(kernel, kernel_len, NULL,
> +	return verify_pefile_signature(kernel, kernel_len,
> +				       VERIFY_USE_SECONDARY_KEYRING,
>  				       VERIFYING_KEXEC_PE_SIGNATURE);
>  }
>  #endif
> -- 
> 2.31.1


