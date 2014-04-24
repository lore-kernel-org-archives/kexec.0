Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WdFxQ-0001Tp-CD
 for kexec@lists.infradead.org; Thu, 24 Apr 2014 09:28:41 +0000
Date: Thu, 24 Apr 2014 11:28:15 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH v2] makedumpfile: code cleanup: set_bitmap
Message-ID: <20140424112815.398f9852@hananiah.suse.cz>
In-Reply-To: <1398330673-23016-1-git-send-email-wangnan0@huawei.com>
References: <0910DD04CBD6DE4193FCF86B9C00BE97205CAA@BPXM01GP.gisp.nec.co.jp>
 <1398330673-23016-1-git-send-email-wangnan0@huawei.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Wang Nan <wangnan0@huawei.com>
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp, Geng Hui <hui.geng@huawei.com>

On Thu, 24 Apr 2014 17:11:13 +0800
Wang Nan <wangnan0@huawei.com> wrote:

> This patch makes set_bitmap() to call sync_bitmap() instead rewrite
> identical code to do same thing.
> 
> Change from v1:
> 
> - fix a simple mistake:
>   sync_bitmap() returns TRUE(1) when it succeeds, so use
>   (!sync_bitmap()) for checking.

Hi Wang Nan,

I like your change. See my comments below:

> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> Cc: kexec@lists.infradead.org
> Cc: Geng Hui <hui.geng@huawei.com>
> ---
>  makedumpfile.c | 70 ++++++++++++++++++++++++++--------------------------------
>  1 file changed, 31 insertions(+), 39 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index ce4a866..cea37a2 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -3309,6 +3309,34 @@ initialize_2nd_bitmap(struct dump_bitmap *bitmap)
>  }
>  
>  int
> +sync_bitmap(struct dump_bitmap *bitmap)
> +{
> +	off_t offset;
> +	offset = bitmap->offset + BUFSIZE_BITMAP * bitmap->no_block;
> +
> +	/*
> +	 * The bitmap buffer is not dirty, and it is not necessary
> +	 * to write out it.
> +	 */
> +	if (bitmap->no_block < 0)
> +		return TRUE;
> +
> +	if (lseek(bitmap->fd, offset, SEEK_SET) < 0 ) {
> +		ERRMSG("Can't seek the bitmap(%s). %s\n",
> +		    bitmap->file_name, strerror(errno));
> +		return FALSE;
> +	}
> +	if (write(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP)
> +	    != BUFSIZE_BITMAP) {
> +		ERRMSG("Can't write the bitmap(%s). %s\n",
> +		    bitmap->file_name, strerror(errno));
> +		return FALSE;
> +	}
> +	return TRUE;
> +}
> +
> +
> +int
>  set_bitmap(struct dump_bitmap *bitmap, unsigned long long pfn,
>      int val)
>  {
> @@ -3317,20 +3345,11 @@ set_bitmap(struct dump_bitmap *bitmap, unsigned long long pfn,
>  	old_offset = bitmap->offset + BUFSIZE_BITMAP * bitmap->no_block;
>  	new_offset = bitmap->offset + BUFSIZE_BITMAP * (pfn / PFN_BUFBITMAP);

After applying this patch, both old_offset and new_offset are
calculated only to compare for equality. And new_offset is in fact
computed twice (once in set_bitmap and once in sync_bitmap).

This could be cleaned up by replacing the offsets with:

	int new_no_block = pfn / PFN_BUFBITMAP;

Then change all occurrences of if (old_offset != new_offset) to:

	if (bitmap->no_block != new_no_block)

and finally re-use new_no_block in the assignment to bitmap->no_block
near the end of the function, like this:

-		bitmap->no_block = pfn / PFN_BUFBITMAP;
+		bitmap->no_block = new_no_block;

Petr T

>  
> -	if (0 <= bitmap->no_block && old_offset != new_offset) {
> -		if (lseek(bitmap->fd, old_offset, SEEK_SET) < 0 ) {
> -			ERRMSG("Can't seek the bitmap(%s). %s\n",
> -			    bitmap->file_name, strerror(errno));
> -			return FALSE;
> -		}
> -		if (write(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP)
> -		    != BUFSIZE_BITMAP) {
> -			ERRMSG("Can't write the bitmap(%s). %s\n",
> -			    bitmap->file_name, strerror(errno));
> +	if (old_offset != new_offset) {
> +		if (!sync_bitmap(bitmap)) {
> +			ERRMSG("Can't sync bitmap\n");
>  			return FALSE;
>  		}
> -	}
> -	if (old_offset != new_offset) {
>  		if (lseek(bitmap->fd, new_offset, SEEK_SET) < 0 ) {
>  			ERRMSG("Can't seek the bitmap(%s). %s\n",
>  			    bitmap->file_name, strerror(errno));
> @@ -3386,33 +3405,6 @@ set_bitmap_cyclic(char *bitmap, unsigned long long pfn, int val, struct cycle *c
>  }
>  
>  int
> -sync_bitmap(struct dump_bitmap *bitmap)
> -{
> -	off_t offset;
> -	offset = bitmap->offset + BUFSIZE_BITMAP * bitmap->no_block;
> -
> -	/*
> -	 * The bitmap buffer is not dirty, and it is not necessary
> -	 * to write out it.
> -	 */
> -	if (bitmap->no_block < 0)
> -		return TRUE;
> -
> -	if (lseek(bitmap->fd, offset, SEEK_SET) < 0 ) {
> -		ERRMSG("Can't seek the bitmap(%s). %s\n",
> -		    bitmap->file_name, strerror(errno));
> -		return FALSE;
> -	}
> -	if (write(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP)
> -	    != BUFSIZE_BITMAP) {
> -		ERRMSG("Can't write the bitmap(%s). %s\n",
> -		    bitmap->file_name, strerror(errno));
> -		return FALSE;
> -	}
> -	return TRUE;
> -}
> -
> -int
>  sync_1st_bitmap(void)
>  {
>  	return sync_bitmap(info->bitmap1);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
