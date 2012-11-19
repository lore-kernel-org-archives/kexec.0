Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TaV17-000318-Ae
 for kexec@lists.infradead.org; Mon, 19 Nov 2012 17:20:17 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <878v9zp55t.fsf@xmission.com>
 <1353294278-32230-1-git-send-email-yinghai@kernel.org>
 <1353294278-32230-4-git-send-email-yinghai@kernel.org>
Date: Mon, 19 Nov 2012 09:20:00 -0800
In-Reply-To: <1353294278-32230-4-git-send-email-yinghai@kernel.org> (Yinghai
 Lu's message of "Sun, 18 Nov 2012 19:04:35 -0800")
Message-ID: <87sj8533y7.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/6] kexec, x86: put ramdisk high for 64bit bzImage
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

Yinghai Lu <yinghai@kernel.org> writes:

> only do that for 64bit bzImage, and will fall back to low if fail to
> get high.

The way you have modified the code is silly.

You should be able to do this with one add_buffer call.  Making
the breaking of all of the add_buffer callers unnecessary.
You just need to supply a larger range to add_buffer.

You can get a wider range to add_buffer by modifying the initialization
of initrd_addr_max to account for boot protocol 0x020c.

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  kexec/arch/i386/x86-linux-setup.c |   30 ++++++++++++++++++++++--------
>  1 files changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
> index 53d9df9..b0e6119 100644
> --- a/kexec/arch/i386/x86-linux-setup.c
> +++ b/kexec/arch/i386/x86-linux-setup.c
> @@ -69,20 +69,34 @@ void setup_linux_bootloader_parameters(
>  	}
>  
>  	/* Load the initrd if we have one */
> +	initrd_base = 0;
>  	if (initrd_buf) {
> -		initrd_base = add_buffer(info,
> -			initrd_buf, initrd_size, initrd_size,
> -			4096, INITRD_BASE, initrd_addr_max, -1);
> +		if (real_mode->protocol_version >= 0x020c &&
> +		    real_mode->code64_start_offset) {
> +			initrd_base = add_buffer(info,
> +				initrd_buf, initrd_size, initrd_size,
> +				4096, 1UL<<32, ULONG_MAX, -1);
> +			if (!initrd_base)
> +				initrd_base = add_buffer(info,
> +					initrd_buf, initrd_size, initrd_size,
> +					4096, 1UL<<30, 1UL<<32, -1);



> +		}
> +		if (!initrd_base)
> +			initrd_base = add_buffer(info,
> +				initrd_buf, initrd_size, initrd_size,
> +				4096, INITRD_BASE, initrd_addr_max, -1);
>  		dbgprintf("Loaded initrd at 0x%lx size 0x%lx\n", initrd_base,
>  			initrd_size);
> -	} else {
> -		initrd_base = 0;
> +	} else
>  		initrd_size = 0;
> -	}
>  
>  	/* Ramdisk address and size */
> -	real_mode->initrd_start = initrd_base;
> -	real_mode->initrd_size  = initrd_size;
> +	real_mode->initrd_start = initrd_base & 0xffffffff;
> +	real_mode->initrd_size  = initrd_size & 0xffffffff;
> +	if ((initrd_base + initrd_size) > (1ULL<<32)) {
> +		real_mode->ext_ramdisk_image = initrd_base >> 32;
> +		real_mode->ext_ramdisk_size  = initrd_size >> 32;
> +	}

And this needs to compile 32bit which where 1ULL<<32 doesn't work.  So I
suggest you make the code look like:

+	if (real_mode->protocol_version >= 0x020c &&
+	    (initrd_base & 0xffffffffUL) != initrd_base)
+		real_mode->ext_ramdisk_image = initrd_base >> 32;
+
+	if (real_mode->protocol_version >= 0x020c &&
+	    (initrd_size & 0xffffffffUL) != initrd_size)
+		real_mode->ext_ramdisk_size  = initrd_size >> 32;

Eric


>  	/* The location of the command line */
>  	/* if (real_mode_base == 0x90000) { */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
