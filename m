Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KdxiZ-0004ex-6D
	for kexec@lists.infradead.org; Fri, 12 Sep 2008 01:45:03 +0000
Message-ID: <48C9C2B0.3070006@mxs.nes.nec.co.jp>
Date: Fri, 12 Sep 2008 10:15:28 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [patch] [PATCH] Don't write undefined values to disk
References: <20080911121403.GA29229@suse.de>
In-Reply-To: <20080911121403.GA29229@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0024734022=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org

--===============0024734022==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Bernhard,

Thank you for the patch.
It will be merged to the next release.


Thanks
Ken'ichi Ohmichi

Bernhard Walle wrote:
> Because of structure member alignment, the simple structure
> 
>     struct kdump_sub_header {
>             unsigned long   phys_base;
>             int             dump_level;     
>     };  
> 
> is 16 bytes large on x86_64. So if you fill the two members phys_base and
> dump_level with values, you still have uninitialised memory if you write
> sizeof(struct kdump_sub_header) to disk.
> 
> This patch initialises everything with zero first to get rid of that problem.
> The patch fixes valgrind warning
> 
>     ==24152== Syscall param write(buf) points to uninitialised byte(s)
>     ==24152==    at 0x4EEFFC0: write (in /lib64/libc-2.8.so)
>     ==24152==    by 0x40A97D: (within /bin/makedumpfile)
>     ==24152==    by 0x40ACEF: (within /bin/makedumpfile)
>     ==24152==    by 0x41896C: (within /bin/makedumpfile)
>     ==24152==    by 0x4191AA: (within /bin/makedumpfile)
>     ==24152==    by 0x4E48435: (below main) (in /lib64/libc-2.8.so)
>     ==24152==  Address 0x7fefffbfc is on thread 1's stack
> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> 
> ---
>  makedumpfile.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -4707,6 +4707,7 @@ write_kdump_header(void)
>  	/*
>  	 * Write sub header
>  	 */
> +	memset(&sub_dump_header, 0, sizeof(struct kdump_sub_header));
>  	sub_dump_header.phys_base  = info->phys_base;
>  	sub_dump_header.dump_level = info->dump_level;
>  	size = sizeof(struct kdump_sub_header);
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 



--===============0024734022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0024734022==--
