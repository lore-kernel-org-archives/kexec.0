Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx03.syneticon.net ([87.79.32.166])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KDk2q-0004hK-4n
	for kexec@lists.infradead.org; Tue, 01 Jul 2008 17:53:36 +0000
Message-ID: <486A6F0D.4070802@wpkg.org>
Date: Tue, 01 Jul 2008 19:53:17 +0200
From: Tomasz Chmielewski <mangoo@wpkg.org>
MIME-Version: 1.0
Subject: Re: kexec on mips - anyone has it working?
References: <483BCB75.4050901@wpkg.org>
	<200805301327.11925.nschichan@freebox.fr>
	<483FE764.1090901@wpkg.org>
	<200807011542.29274.nschichan@freebox.fr>
In-Reply-To: <200807011542.29274.nschichan@freebox.fr>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Nicolas Schichan <nschichan@freebox.fr>
Cc: linux-mips@linux-mips.org, openwrt-devel@lists.openwrt.org, Kexec Mailing List <kexec@lists.infradead.org>

Nicolas Schichan schrieb:
> On Friday 30 May 2008 13:39:16 Tomasz Chmielewski wrote:
> 
> Hello,
> 
>> Nicolas Schichan schrieb:
>>> On Thursday 29 May 2008 22:15:47 Tomasz Chmielewski wrote:
>>>> Will call new kernel at 00305000
>>> The calling address of the kernel looks quite wrong, it should clearly
>>> be inside the KSEG0 zone. could  you please indicate the output of the
>>> command "mips-linux-readelf -l vmlinux" ?
>> # uname -m
>> mips
>> # readelf -l vmlinux
>>
>> Elf file type is EXEC (Executable file)
>> Entry point 0x80251b50
> 
> This is  quite surprising.   The jump address  that kexec will  use is
> cleary not what  I expected. I would have expected it  to be the Entry
> point address given by readelf.
> 
> could  you try  the  following patch  to  make sure  that the  kimage*
> structure is not corrupted by the code in machine_kexec() ?
> 
> Index: linux/arch/mips/kernel/machine_kexec.c
> ===================================================================
> --- linux/arch/mips/kernel/machine_kexec.c	(revision 8056)
> +++ linux/arch/mips/kernel/machine_kexec.c	(working copy)
> @@ -49,6 +49,8 @@
>  	unsigned long entry;
>  	unsigned long *ptr;
>  
> +	printk("image->start = %p", image->start);
> +
>  	reboot_code_buffer =
>  	  (unsigned long)page_address(image->control_code_page);

Umm?

   CC      arch/mips/kernel/machine_kexec.o
cc1: warnings being treated as errors
arch/mips/kernel/machine_kexec.c: In function 'machine_kexec':
arch/mips/kernel/machine_kexec.c:52: warning: format '%p' expects type 
'void *', but argument 2 has type 'long unsigned int'
make[6]: *** [arch/mips/kernel/machine_kexec.o] Error 1
make[5]: *** [arch/mips/kernel] Error 2
make[5]: Leaving directory 
`/home/tch-data/openwrt/11612/build_dir/linux-brcm47xx/linux-2.6.25.9'



-- 
Tomasz Chmielewski
http://wpkg.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
