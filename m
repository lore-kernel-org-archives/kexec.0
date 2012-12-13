Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TjIQk-0003Oi-Hw
 for kexec@lists.infradead.org; Thu, 13 Dec 2012 23:43:12 +0000
Message-ID: <50CA67FF.90009@zytor.com>
Date: Thu, 13 Dec 2012 15:42:55 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v6 3/6] kexec, x86: Fix bzImage real-mode booting
References: <1355437112-9250-1-git-send-email-yinghai@kernel.org>
 <1355437112-9250-4-git-send-email-yinghai@kernel.org>
In-Reply-To: <1355437112-9250-4-git-send-email-yinghai@kernel.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On 12/13/2012 02:18 PM, Yinghai Lu wrote:

> +	if (real_mode_entry) {
> +		/* restore can use heap and load high */
> +		real_mode->loader_flags = 0x81;
> +		if (real_mode->protocol_version >= 0x0201)
> +			real_mode->heap_end_ptr += heap_size - 0x200; /*stack*/
> +	}
> +

This code is wrong: the bits at the bottom of this field (LOADED_HIGH) 
are kernel->bootloader flags.

The right behavior is:

	if (real_mode->protocol_version >= 0x0201) {
		real_mode->loader_flag |= CAN_USE_HEAP;
		real_mode->heap_end_ptr += heap_size - 0x200; /*stack*/
	}


> +		regs16.ds = regs16.es = regs16.fs = regs16.gs = setup_base >> 4;
> +		regs16.cs = regs16.ds + 0x20;
> +		regs16.ip = 0;
> +		/* XXX: Documentation/i386/boot.txt says 'ss' must equal 'ds' */
> +		regs16.ss = (elf_rel_get_addr(&info->rhdr, "stack_end") - 64*1024) >> 4;
> +		/* XXX: Documentation/i386/boot.txt says 'sp' must equal heap_end */
> +		regs16.esp = 0xFFFC;
> +

And, pray tell, why aren't they?

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
