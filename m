Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UzjHs-0003uw-Dv
 for kexec@lists.infradead.org; Thu, 18 Jul 2013 08:10:09 +0000
Date: Thu, 18 Jul 2013 17:03:43 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v2 2/7] elf: Properly check buf size in get_pt_note_info()
Message-Id: <20130718170343.0a8ae7b354a5dedbe601b9b0@mxc.nes.nec.co.jp>
In-Reply-To: <1373977929-4253-3-git-send-email-daniel.kiper@oracle.com>
References: <1373977929-4253-1-git-send-email-daniel.kiper@oracle.com>
 <1373977929-4253-3-git-send-email-daniel.kiper@oracle.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: daniel.kiper@oracle.com
Cc: andrew.cooper3@citrix.com, xen-devel@lists.xensource.com, kexec@lists.infradead.org

On Tue, 16 Jul 2013 14:32:04 +0200
Daniel Kiper <daniel.kiper@oracle.com> wrote:

> get_pt_note_info() always ignores VMCOREINFO_XEN note because
> buf size must be smaller than note size including \0 char.
> Usualy this condition is true but when VMCOREINFO_XEN note
> is encountered it does not work due to buf size defined
> as sizeof("VMCOREINFO_XEN"). This patch fixes that bug
> and VMCOREINFO_XEN note living in /proc/vmcore file
> could be properly detected now.
> 
> v2 - suggestions/fixes:
>    - properly check buf size instead of increasing buf size
>      (suggested by Andrew Cooper).
> 
> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>

Good, I'll merge this patch into v1.5.5.


Thanks
Atsushi Kumagai

> ---
>  elf_info.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/elf_info.c b/elf_info.c
> index 0c1e36a..e350b99 100644
> --- a/elf_info.c
> +++ b/elf_info.c
> @@ -332,7 +332,7 @@ get_pt_note_info(void)
>  		size_desc   = note_descsz(note);
>  		offset_desc = offset + offset_note_desc(note);
>  
> -		if (!size_name || size_name >= sizeof(buf))
> +		if (!size_name || size_name > sizeof(buf))
>  			goto next_note;
>  
>  		if (read(fd_memory, &buf, sizeof(buf)) != sizeof(buf)) {
> -- 
> 1.7.10.4
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
