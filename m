Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uxdy3-0001NF-7w
 for kexec@lists.infradead.org; Fri, 12 Jul 2013 14:05:04 +0000
Message-ID: <51E00CF9.7080604@citrix.com>
Date: Fri, 12 Jul 2013 15:04:41 +0100
From: Andrew Cooper <andrew.cooper3@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 2/7] elf: Increase buf size in
 get_pt_note_info()
References: <1373636895-31682-1-git-send-email-daniel.kiper@oracle.com>
 <1373636895-31682-3-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1373636895-31682-3-git-send-email-daniel.kiper@oracle.com>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: kexec@lists.infradead.org, xen-devel@lists.xensource.com, kumagai-atsushi@mxc.nes.nec.co.jp

On 12/07/13 14:48, Daniel Kiper wrote:
> get_pt_note_info() always ignores VMCOREINFO_XEN note
> because buf size is too small. It does not have place
> for \0 char which marks EOS. This patch fixes that bug
> and VMCOREINFO_XEN note living in /proc/vmcore file
> could be properly detected now.
>
> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> ---
>  elf_info.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/elf_info.c b/elf_info.c
> index 0c1e36a..70a6dd2 100644
> --- a/elf_info.c
> +++ b/elf_info.c
> @@ -310,7 +310,7 @@ get_pt_note_info(void)
>  {
>  	int n_type, size_name, size_desc;
>  	off_t offset, offset_desc;
> -	char buf[VMCOREINFO_XEN_NOTE_NAME_BYTES];
> +	char buf[VMCOREINFO_XEN_NOTE_NAME_BYTES + 1];
>  	char note[MAX_SIZE_NHDR];
>  
>  	nr_cpus = 0;

Elf Note namesz is defined to include the terminating null character, so
I would argue that VMCOREINFO_XEN_NOTE_NAME_BYTES is off-by-one.

~Andrew

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
