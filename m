Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tzzjj-0006JO-2G
 for kexec@lists.infradead.org; Tue, 29 Jan 2013 01:11:43 +0000
Message-ID: <510721C6.6080705@zytor.com>
Date: Mon, 28 Jan 2013 17:11:34 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] x86 e820: Introduce memmap=resetusablemap for kdump
 usage
References: <1358868049-19884-1-git-send-email-trenn@suse.de>
 <CAE9FiQWJqWQJhoJb2dBn=iAsKjxuf3MJro-jz+6k+WNZor8-xQ@mail.gmail.com>
 <CAE9FiQWXcwagEb0jdFfdHvNcByNxtaLbvvoRC-jAppQmiGS22w@mail.gmail.com>
 <6950516.1uefDuthAH@hammer82.arch.suse.de>
In-Reply-To: <6950516.1uefDuthAH@hammer82.arch.suse.de>
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
To: Thomas Renninger <trenn@suse.de>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, Yinghai Lu <yinghai@kernel.org>, vgoyal@redhat.com

On 01/28/2013 05:05 PM, Thomas Renninger wrote:
> 
> But this (converting usable memory to reserved one before usable kdump memory
> is added) will let machines run into problems again for which the check:
> "mmconf area must be in reserved memory" got added?
> 
> If, then memory which was usable before has to be converted to a special
> E820_KUMP (or whatever type) to make sure existing checks which look for
> "is reserved memory" still work the same way as in a productive kernel.
> 
> Advantage of this would be that the info what originally was usable
> memory is preserved and can be used in future kdump related patches.
> 
> So I guess the final patch should be:
>    - Add a new e820 type:
>         E820_KDUMP_RESERVED /* Originally usable memory where the crashed
>                                                     kernel kernel resided in */
>   - Use Yinghai's last posted patch, but instead of:
> +			e820_update_range(0, ULLONG_MAX, E820_RAM,
> +					  E820_RESERVED);
> ...
> +			e820_remove_range(start_at, mem_size, E820_RESERVED, 0);
> do:
> +			e820_update_range(0, ULLONG_MAX, E820_RAM,
> +					  E820_KDUMP_RESERVED);
> ...
> +			e820_remove_range(start_at, mem_size, E820_KDUMP_RESERVED, 0);
> 
>   - Come up with another memmap=kdump_reserve_ram memmap option name
>     or however it should get named...
> 
> If this proposal gets accepted, I can send a tested patch...
> 

Yes, this is much saner.  There really shouldn't need to be an option,
even; since the tools need to be modified anyway, just modify the actual
memory map data structure itself.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
