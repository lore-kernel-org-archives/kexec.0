From: Petr Tesarik <ptesarik@suse.cz>
Date: Wed, 16 Mar 2022 12:56:03 +0100
Subject: [PATCH] kexec-tools: print error if kexec_file_load fails
In-Reply-To: <20220316103305.174842-1-hbathini@linux.ibm.com>
References: <20220316103305.174842-1-hbathini@linux.ibm.com>
Message-ID: <53ecedd5-df24-7a32-7fa0-2a4cf50619c3@suse.cz>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Hari,

Dne 16. 03. 22 v 11:33 Hari Bathini napsal(a):
> Commit 4f77da634035 ("kexec-tools: Fix kexec_file_load(2) error
> handling") introduced EFALLBACK for scenarios where fallbacking back
> to kexec_load syscall is likely to work and dropped printing error
> message for these scenarios. But printing error message for other
> failure scenarios was inadvertently dropped. Restore printing error
> message for such cases.

Indeed, my commit removed the error messages on failure.

> 
> Fixes: 4f77da634035 ("kexec-tools: Fix kexec_file_load(2) error handling")
> Cc: Petr Tesarik <ptesarik@suse.com>
> Reported-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
> Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Petr T

> ---
>   kexec/kexec.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index 7e4787b..865de61 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -1339,6 +1339,7 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
>   		case EMSGSIZE:
>   			/* Reject by default. */
>   		default:
> +			fprintf(stderr, "kexec_file_load failed: %s\n", strerror(errno));
>   			ret = EFAILED;
>   			break;
>   
-------------- next part --------------
A non-text attachment was scrubbed...
Name: OpenPGP_0xAA503BC9AE0F47A7.asc
Type: application/pgp-keys
Size: 18487 bytes
Desc: OpenPGP public key
URL: <http://lists.infradead.org/pipermail/kexec/attachments/20220316/06bb02e3/attachment-0001.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: OpenPGP_signature
Type: application/pgp-signature
Size: 495 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/kexec/attachments/20220316/06bb02e3/attachment-0001.sig>
