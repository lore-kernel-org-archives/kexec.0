Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v11 10/15] arm64: kexec_file: allow for loading
 Image-format kernel
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
 <20180711074203.3019-11-takahiro.akashi@linaro.org>
From: James Morse <james.morse@arm.com>
Message-ID: <bfbb8d3f-6d7b-3ebb-d805-15b89c55aaeb@arm.com>
Date: Wed, 18 Jul 2018 17:47:50 +0100
MIME-Version: 1.0
In-Reply-To: <20180711074203.3019-11-takahiro.akashi@linaro.org>
Content-Language: en-US
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com

Hi Akashi,

On 11/07/18 08:41, AKASHI Takahiro wrote:
> This patch provides kexec_file_ops for "Image"-format kernel. In this
> implementation, a binary is always loaded with a fixed offset identified
> in text_offset field of its header.
> 
> Regarding signature verification for trusted boot, this patch doesn't
> contains CONFIG_KEXEC_VERIFY_SIG support, which is to be added later
> in this series, but file-attribute-based verification is still a viable
> option by enabling IMA security subsystem.
> 
> You can sign(label) a to-be-kexec'ed kernel image on target file system
> with:
>     $ evmctl ima_sign --key /path/to/private_key.pem Image
> 
> On live system, you must have IMA enforced with, at least, the following
> security policy:
>     "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig"
> 
> See more details about IMA here:
>     https://sourceforge.net/p/linux-ima/wiki/Home/

This looks useful to set a keys/signature/policy for a kernel that wasn't built
to enforce signatures at compile time, so its a good thing to have from a
single-image perspective.

I haven't managed to get IMA working to test this, but its all done by the kexec
core code, so I don't think we're missing anything.


> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> new file mode 100644
> index 000000000000..a47cf9bc699e
> --- /dev/null
> +++ b/arch/arm64/kernel/kexec_image.c

> +static int image_probe(const char *kernel_buf, unsigned long kernel_len)
> +{
> +	const struct arm64_image_header *h;
> +
> +	h = (const struct arm64_image_header *)(kernel_buf);
> +
> +	if (!h || (kernel_len < sizeof(*h)) ||

> +			!memcmp(&h->magic, ARM64_MAGIC, sizeof(ARM64_MAGIC)))

Doesn't memcmp() return 0 if the memory regions are the same?
This would always match the correct magic, rejecting the image.

That's not whats happening, as kexec-file works, so this never matches anything.

sizeof(ARM64_MAGIC) includes the null terminator, but this sequence is output in
head.S using '.ascii' which doesn't include the terminator, (otherwise it
wouldn't fit in the 4byte magic field). The memcmp() here is also consuming the
least significant bytes of the next field.

I think this line should be:
| 			memcmp(&h->magic, ARM64_MAGIC, sizeof(h->magic)))


> +static void *image_load(struct kimage *image,
> +				char *kernel, unsigned long kernel_len,
> +				char *initrd, unsigned long initrd_len,
> +				char *cmdline, unsigned long cmdline_len)

> +	kbuf.buffer = kernel;
> +	kbuf.bufsz = kernel_len;
> +	kbuf.memsz = le64_to_cpu(h->image_size);
> +	text_offset = le64_to_cpu(h->text_offset);
> +	kbuf.buf_align = SZ_2M;

Nit: MIN_KIMG_ALIGN ?


> +	/* Adjust kernel segment with TEXT_OFFSET */
> +	kbuf.memsz += text_offset;
> +
> +	ret = kexec_add_buffer(&kbuf);
> +	if (ret)
> +		goto out;

You just return in the error cases above but here you goto ... the return
statement at the end. Seems a bit odd.


With the memcmp() thing fixed:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
