Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from foss.arm.com ([217.140.110.172])
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icZDw-0003Uk-Ng
 for kexec@lists.infradead.org; Wed, 04 Dec 2019 18:18:06 +0000
Subject: Re: [PATCH] efi/memreserve: register reservations as 'reserved' in
 /proc/iomem
References: <20191204145233.11962-1-ardb@kernel.org>
 <20191204171744.o3ijdspnelqn5fgd@gabell>
From: James Morse <james.morse@arm.com>
Message-ID: <08f05b18-12b2-0ba4-b819-b95ba27d1862@arm.com>
Date: Wed, 4 Dec 2019 18:17:59 +0000
MIME-Version: 1.0
In-Reply-To: <20191204171744.o3ijdspnelqn5fgd@gabell>
Content-Language: en-GB
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
To: Masayoshi Mizuma <msys.mizuma@gmail.com>, Ard Biesheuvel <ardb@kernel.org>
Cc: mark.rutland@arm.com, Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>, linux-efi@vger.kernel.org, kexec@lists.infradead.org, d.hatayama@fujitsu.com

Hi Masa,

On 04/12/2019 17:17, Masayoshi Mizuma wrote:
> Thank you for sending the patch, but unfortunately it doesn't work for the issue...
> 
> After applied your patch, the LPI tables are marked as reserved in
> /proc/iomem like as:
> 
> 80300000-a1fdffff : System RAM
>   80480000-8134ffff : Kernel code
>   81350000-817bffff : reserved
>   817c0000-82acffff : Kernel data
>   830f0000-830fffff : reserved # Property table
>   83480000-83480fff : reserved # Pending table
>   83490000-8349ffff : reserved # Pending table
> 
> However, kexec tries to allocate memory from System RAM, it doesn't care
> the reserved in System RAM.

> I'm not sure why kexec doesn't care the reserved in System RAM, however,

Hmm, we added these to fix a problem with the UEFI memory map, and more recently ACPI
tables being overwritten by kexec.

Which version of kexec-tools are you using? Could you try:
https://git.linaro.org/people/takahiro.akashi/kexec-tools.git/commit/?h=arm64/resv_mem


> if the kexec behaivor is right, the LPI tables should not belong to
> System RAM.

> Like as:
> 
> 80300000-830effff : System RAM
>   80480000-8134ffff : Kernel code
>   81350000-817bffff : reserved
>   817c0000-82acffff : Kernel data
> 830f0000-830fffff : reserved # Property table
> 83480000-83480fff : reserved # Pending table
> 83490000-8349ffff : reserved # Pending table
> 834a0000-a1fdffff : System RAM
> 
> I don't have ideas to separete LPI tables from System RAM... so I tried
> to add a new file to inform the LPI tables to userspace.

This is how 'nomap' memory appears, we carve it out of System RAM. A side effect of this
is kdump can't touch it, as you've told it this isn't memory.

As these tables are memory, mapped by the linear map, I think Ard's patch is the right
thing to do ... I suspect your kexec-tools doesn't have those patches from Akashi to make
it honour all second level entries.


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
