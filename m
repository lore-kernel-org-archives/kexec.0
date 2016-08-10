Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bXTFu-0008LY-DG
 for kexec@lists.infradead.org; Wed, 10 Aug 2016 13:09:11 +0000
Date: Wed, 10 Aug 2016 15:08:46 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH 3/3] close_dump_bitmap: simplify logic
Message-ID: <20160810150846.6a257447@hananiah.suse.cz>
In-Reply-To: <20160810125658.23366-4-mwilck@suse.de>
References: <20160810125658.23366-1-mwilck@suse.de>
 <20160810125658.23366-4-mwilck@suse.de>
MIME-Version: 1.0
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
To: Martin Wilck <mwilck@suse.de>
Cc: ats-kumagai@wm.jp.nec.com, kexec@lists.infradead.org

On Wed, 10 Aug 2016 14:56:58 +0200
Martin Wilck <mwilck@suse.de> wrote:

> The boolean expression replicates the logic of open_dump_bitmap().
> It's simpler and less error-prone to simply check if fd_bitmap is
> valid.
> 
> Signed-off-by: Martin Wilck <mwilck@suse.de>
> ---
>  makedumpfile.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 43278f1..771ab7c 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -8579,8 +8579,7 @@ close_dump_file(void)
>  void
>  close_dump_bitmap(void)
>  {
> -	if (!info->working_dir && !info->flag_reassemble && !info->flag_refiltering
> -	    && !info->flag_sadump && !info->flag_mem_usage)
> +	if (!info->fd_bitmap)

Strictly speaking, zero is a valid FD. I can see that it is highly
unlikely to be the bitmap FD, but it would be a nice cleanup to
initialize fd_bitmap to a negative number and check info->fd_bitmap < 0.
I'm just not sure where to put the initializition...

OTOH I know I'm asking you to fix something that you didn't break.

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
