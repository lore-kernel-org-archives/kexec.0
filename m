Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZnen-0006Rs-NE
 for kexec@lists.infradead.org; Wed, 27 Nov 2019 03:06:23 +0000
Subject: Re: [PATCH] fix bug in is_dumpable_file()
References: <1574133077-5436-1-git-send-email-piliu@redhat.com>
From: piliu <piliu@redhat.com>
Message-ID: <8eea60e3-8e45-dee5-12bd-645aedc201b5@redhat.com>
Date: Wed, 27 Nov 2019 11:06:07 +0800
MIME-Version: 1.0
In-Reply-To: <1574133077-5436-1-git-send-email-piliu@redhat.com>
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
To: kexec@lists.infradead.org
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>

NACKed by myself due to a misunderstand of the code.


On 11/19/2019 11:11 AM, Pingfan Liu wrote:
> is_dumpable_file() is inconsistent with write_kdump_bitmap_file().
> In the former one, bitmap->offset takes account for the header. But the
> later one does not.
> 
> It makes things more mussy where info->bitmap1/bitmap2's offset do not
> account for header, while info->bitmap_memory does.
> 
> Making all of these consistent by not accounting for header.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> ---
>  makedumpfile.c | 5 +----
>  makedumpfile.h | 5 +++--
>  sadump_info.c  | 4 ++--
>  3 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index d76a435..496e212 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -3637,7 +3637,6 @@ initialize_bitmap_memory(void)
>  	struct disk_dump_header	*dh;
>  	struct kdump_sub_header *kh;
>  	struct dump_bitmap *bmp;
> -	off_t bitmap_offset;
>  	off_t bitmap_len, max_sect_len;
>  	mdf_pfn_t pfn;
>  	int i, j;
> @@ -3647,8 +3646,6 @@ initialize_bitmap_memory(void)
>  	kh = info->kh_memory;
>  	block_size = dh->block_size;
>  
> -	bitmap_offset
> -	    = (DISKDUMP_HEADER_BLOCKS + dh->sub_hdr_size) * block_size;
>  	bitmap_len = block_size * dh->bitmap_blocks;
>  
>  	bmp = malloc(sizeof(struct dump_bitmap));
> @@ -3667,7 +3664,7 @@ initialize_bitmap_memory(void)
>  	bmp->file_name = info->name_memory;
>  	bmp->no_block  = -1;
>  	memset(bmp->buf, 0, BUFSIZE_BITMAP);
> -	bmp->offset = bitmap_offset + bitmap_len / 2;
> +	bmp->offset = bitmap_len / 2;
>  	info->bitmap_memory = bmp;
>  
>  	if (dh->header_version >= 6)
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 24b2f69..3c02e83 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -1171,6 +1171,7 @@ struct dump_bitmap {
>  	int		no_block;
>  	char		*file_name;
>  	char		*buf;
> +	/* offset in bitmap section */
>  	off_t		offset;
>  };
>  
> @@ -2204,10 +2205,10 @@ is_dumpable_buffer(struct dump_bitmap *bitmap, mdf_pfn_t pfn, struct cycle *cycl
>  static inline int
>  is_dumpable_file(struct dump_bitmap *bitmap, mdf_pfn_t pfn)
>  {
> -	off_t offset;
> +	off_t offset = info->offset_bitmap1;
>  	ssize_t rcode;
>  	if (pfn == 0 || bitmap->no_block != pfn/PFN_BUFBITMAP) {
> -		offset = bitmap->offset + BUFSIZE_BITMAP*(pfn/PFN_BUFBITMAP);
> +		offset += bitmap->offset + BUFSIZE_BITMAP*(pfn/PFN_BUFBITMAP);
>  		if (lseek(bitmap->fd, offset, SEEK_SET) < 0 ) {
>  			ERRMSG("Can't seek the bitmap(%s). %s\n",
>  				bitmap->file_name, strerror(errno));
> diff --git a/sadump_info.c b/sadump_info.c
> index 46867ce..a3d51b9 100644
> --- a/sadump_info.c
> +++ b/sadump_info.c
> @@ -137,11 +137,11 @@ sadump_is_on(char *bitmap, mdf_pfn_t i)
>  static inline int
>  sadump_is_dumpable(struct dump_bitmap *bitmap, mdf_pfn_t pfn)
>  {
> -	off_t offset;
> +	off_t offset = info->offset_bitmap1;
>  	ssize_t rcode;
>  
>  	if (pfn == 0 || bitmap->no_block != pfn/PFN_BUFBITMAP) {
> -		offset = bitmap->offset + BUFSIZE_BITMAP*(pfn/PFN_BUFBITMAP);
> +		offset += bitmap->offset + BUFSIZE_BITMAP*(pfn/PFN_BUFBITMAP);
>  		lseek(bitmap->fd, offset, SEEK_SET);
>  		rcode = read(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP);
>  		if (rcode != BUFSIZE_BITMAP)
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
