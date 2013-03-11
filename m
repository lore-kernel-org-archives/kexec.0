Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UEwq7-0006Pc-Sj
 for kexec@lists.infradead.org; Mon, 11 Mar 2013 07:08:10 +0000
Date: Mon, 11 Mar 2013 15:57:13 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [RFC] makedumpfile: Improve reading speed with mmap()
Message-Id: <20130311155713.535e97a47d89e4325583ec82@mxc.nes.nec.co.jp>
In-Reply-To: <20130309.150805.363182260.d.hatayama@jp.fujitsu.com>
References: <20130306.181349.528423566.d.hatayama@jp.fujitsu.com>
 <20130308.104518.339920543.d.hatayama@jp.fujitsu.com>
 <20130308113332.12c1d2e83e973e652757eaf0@mxc.nes.nec.co.jp>
 <20130309.150805.363182260.d.hatayama@jp.fujitsu.com>
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
To: d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org, cpw@sgi.com, lisa.mitchell@hp.com, vgoyal@redhat.com

On Sat, 09 Mar 2013 15:08:05 +0900 (JST)
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> > But, anyway, I created the branch "mmap":
> > 
> > http://makedumpfile.git.sourceforge.net/git/gitweb.cgi?p=makedumpfile/makedumpfile;a=shortlog;h=refs/heads/mmap
> > 
> > Please use it for benchmark.
> 
> Thanks! It's very helpful.
> 
> Also, I tested a little the mmap branch code and found a small bug
> that max file offset used in calculating mmap()'s position is
> wrong. Please see the next patch.
> 
> # But sorry, I made this quickly so I didn't consider design enough.

Thanks, that's enough for now. 
I've pushed this into the mmap branch.


Atsushi Kumagai
 
> From 77ef0e836bba4713bfb578949d2785962179d630 Mon Sep 17 00:00:00 2001
> From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> Date: Sat, 9 Mar 2013 13:49:43 +0900
> Subject: [PATCH] makedumpfile: fix max offset relative to file
> 
> To see file offset of each memory chunk, it's correct to read p_offset
> in the corresponing PT_LOAD entrie.
> 
> On /proc/vmcore PT_LOAD entries are sorted on p_load values in
> increasing order. So, it's sufficient to refer to the last PT_LOAD
> entry only. But the code here doesn't assuming that, calculating
> maximum one from all the PT_LOAD entries.
> 
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> ---
>  elf_info.c     | 12 ++++++++++++
>  elf_info.h     |  2 ++
>  makedumpfile.c |  2 +-
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/elf_info.c b/elf_info.c
> index 9bd8cd0..aa8cacb 100644
> --- a/elf_info.c
> +++ b/elf_info.c
> @@ -45,6 +45,7 @@ struct pt_load_segment {
>  };
>  
>  static int			nr_cpus;             /* number of cpu */
> +static off_t			max_file_offset;
>  
>  /*
>   * File information about /proc/vmcore:
> @@ -637,6 +638,12 @@ get_elf_info(int fd, char *filename)
>  			return FALSE;
>  		j++;
>  	}
> +	max_file_offset = 0;
> +	for (i = 0; i < num_pt_loads; ++i) {
> +		struct pt_load_segment *p = &pt_loads[i];
> +		max_file_offset=MAX(max_file_offset,
> +				    p->file_offset+p->phys_end-p->phys_start);
> +	}
>  	if (!has_pt_note()) {
>  		ERRMSG("Can't find PT_NOTE Phdr.\n");
>  		return FALSE;
> @@ -869,3 +876,8 @@ set_eraseinfo(off_t offset, unsigned long size)
>  	size_eraseinfo   = size;
>  }
>  
> +off_t
> +get_max_file_offset(void)
> +{
> +	return max_file_offset;
> +}
> diff --git a/elf_info.h b/elf_info.h
> index eb58023..61ab3c9 100644
> --- a/elf_info.h
> +++ b/elf_info.h
> @@ -71,6 +71,8 @@ int has_eraseinfo(void);
>  void get_eraseinfo(off_t *offset, unsigned long *size);
>  void set_eraseinfo(off_t offset, unsigned long size);
>  
> +off_t get_max_file_offset(void);
> +
>  #endif  /* ELF_INFO_H */
>  
>  
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 3351158..7acbf72 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -235,7 +235,7 @@ static int
>  update_mmap_range(off_t offset) {
>  	off_t start_offset;
>  	off_t map_size;
> -	off_t max_offset = info->max_mapnr * info->page_size;
> +	off_t max_offset = get_max_file_offset();
>  
>  	munmap(info->mmap_buf,
>  	       info->mmap_end_offset - info->mmap_start_offset);
> -- 
> 1.8.1.4

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
