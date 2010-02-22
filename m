Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NjMBZ-0005xw-LS
	for kexec@lists.infradead.org; Mon, 22 Feb 2010 00:30:10 +0000
Message-ID: <4B81C9F9.4050409@mxs.nes.nec.co.jp>
Date: Mon, 22 Feb 2010 09:04:09 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH] Fix buffer overflow when writing dh->signature
References: <1266747178-3536-1-git-send-email-bernhard@bwalle.de>
In-Reply-To: <1266747178-3536-1-git-send-email-bernhard@bwalle.de>
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
To: Bernhard Walle <bernhard@bwalle.de>
Cc: kexec@lists.infradead.org


Hi Bernhard,

Thank you for your patch.
The patch is good for me, and it has been merged into the git tree.

http://makedumpfile.git.sourceforge.net/git/gitweb.cgi?p=makedumpfile/makedumpfile;a=summary


Thanks
Ken'ichi Ohmichi

Bernhard Walle wrote:
> Fix following compile warning when building with gcc 4.5 and with the
> flags '-O2 -Wall -D_FORTIFY_SOURCE=2 -fstack-protector -funwind-tables
> -fasynchronous-unwind-tables -g -O2 -Wall'.
> 
>   In function 'strcpy',
>       inlined from 'write_kdump_header' at makedumpfile.c:5457:8: \
>       /usr/include/bits/string3.h:107:3: warning: call to \
>       __builtin___strcpy_chk will always overflow destination buffer
> 
> Solution: Don't copy the terminating zero byte.
> 
> Signed-off-by: Bernhard Walle <bernhard@bwalle.de>
> ---
>  makedumpfile.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 4fa6f50..855c718 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -5454,7 +5454,7 @@ write_kdump_header(void)
>  	/*
>  	 * Write common header
>  	 */
> -	strcpy(dh->signature, KDUMP_SIGNATURE);
> +	strncpy(dh->signature, KDUMP_SIGNATURE, strlen(KDUMP_SIGNATURE));
>  	dh->header_version = 3;
>    	dh->block_size     = info->page_size;
>  	dh->sub_hdr_size   = sizeof(kh) + info->size_vmcoreinfo;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
