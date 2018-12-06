Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.hallyn.com ([178.63.66.53])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV2lz-0001IV-7b
 for kexec@lists.infradead.org; Thu, 06 Dec 2018 23:09:36 +0000
Date: Thu, 6 Dec 2018 17:09:16 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH 7/7] ima: Support platform keyring for kernel appraisal
Message-ID: <20181206230916.GA10203@mail.hallyn.com>
References: <20181125151500.8298-1-nayna@linux.ibm.com>
 <20181125151500.8298-8-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181125151500.8298-8-nayna@linux.ibm.com>
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
To: Nayna Jain <nayna@linux.ibm.com>
Cc: linux-efi@vger.kernel.org, mpe@ellerman.id.au, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, zohar@linux.ibm.com, dhowells@redhat.com, seth.forshee@canonical.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, ebiederm@xmission.com, jforbes@redhat.com, linux-integrity@vger.kernel.org, vgoyal@redhat.com

On Sun, Nov 25, 2018 at 08:45:00PM +0530, Nayna Jain wrote:
> On secure boot enabled systems, the bootloader verifies the kernel
> image and possibly the initramfs signatures based on a set of keys. A
> soft reboot(kexec) of the system, with the same kernel image and
> initramfs, requires access to the original keys to verify the
> signatures.
> 
> This patch allows IMA-appraisal access to those original keys, now
> loaded on the platform keyring, needed for verifying the kernel image
> and initramfs signatures.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

The overall set seems sensible to me, and I see no errors here,

Acked-by: Serge Hallyn <serge@hallyn.com>

I do think that replacing the 'rc' with xattr_len in the previous line might
help future readers save a few cycles.

> ---
>  security/integrity/ima/ima_appraise.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index deec1804a00a..9c13585e7d3e 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -294,7 +294,16 @@ int ima_appraise_measurement(enum ima_hooks func,
>  					     iint->ima_hash->length);
>  		if (rc == -EOPNOTSUPP) {
>  			status = INTEGRITY_UNKNOWN;
> -		} else if (rc) {
> +			break;
> +		}
> +		if (rc && func == KEXEC_KERNEL_CHECK)
> +			rc = integrity_digsig_verify(
> +					INTEGRITY_KEYRING_PLATFORM,
> +					(const char *)xattr_value,
> +					xattr_len,
> +					iint->ima_hash->digest,
> +					iint->ima_hash->length);
> +		if (rc) {
>  			cause = "invalid-signature";
>  			status = INTEGRITY_FAIL;
>  		} else {
> -- 
> 2.13.6
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
