Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fFaVq-0005qH-1W
 for kexec@lists.infradead.org; Mon, 07 May 2018 07:24:48 +0000
From: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>
Subject: RE: [PATCH 2/4] Makedumpfile: Add pgtable_l5_enabled to number_table
Date: Mon, 7 May 2018 07:20:11 +0000
Message-ID: <61D4E5D821F1674CB87C99F080A210BE011A75C8@BPXM01GP.gisp.nec.co.jp>
References: <20180302054841.22195-1-bhe@redhat.com>
 <20180302054841.22195-3-bhe@redhat.com>
In-Reply-To: <20180302054841.22195-3-bhe@redhat.com>
Content-Language: ja-JP
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
To: Baoquan He <bhe@redhat.com>
Cc: "douly.fnst@cn.fujitsu.com" <douly.fnst@cn.fujitsu.com>, "indou.takao@jp.fujitsu.com" <indou.takao@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Keiichi Nakamura <kei-nakamura@vt.jp.nec.com>

Hi Baoquan,

Sorry for the late reply.

> +	ENUM_NUMBER_INIT(N_ONLINE, "pgtable_l5_enabled");
Is this ENUM_NUMBER_INIT(pgtable_l5_enabled, "pgtable_l5_enabled");  ?

> +	WRITE_NUMBER("N_ONLINE", pgtable_l5_enabled);
Is this WRITE_NUMBER("pgtable_l5_enabled", pgtable_l5_enabled);  ?

If so, I will correct these.

Thanks
Tachibana


> -----Original Message-----
> From: kexec [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Baoquan He
> Sent: Friday, March 02, 2018 2:49 PM
> To: kexec@lists.infradead.org
> Cc: douly.fnst@cn.fujitsu.com; indou.takao@jp.fujitsu.com; Hayashi Masahiko() <mas-hayashi@tg.jp.nec.com>;
> Baoquan He <bhe@redhat.com>; Tachibana Masaki() <mas-tachibana@vf.jp.nec.com>
> Subject: [PATCH 2/4] Makedumpfile: Add pgtable_l5_enabled to number_table
> 
> This is in preparation for later 5-level supporting.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  makedumpfile.c | 3 +++
>  makedumpfile.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index ed138d3..c1e893a 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -1723,6 +1723,7 @@ get_structure_info(void)
> 
>  	ENUM_NUMBER_INIT(NR_FREE_PAGES, "NR_FREE_PAGES");
>  	ENUM_NUMBER_INIT(N_ONLINE, "N_ONLINE");
> +	ENUM_NUMBER_INIT(N_ONLINE, "pgtable_l5_enabled");
> 
>  	ENUM_NUMBER_INIT(PG_lru, "PG_lru");
>  	ENUM_NUMBER_INIT(PG_private, "PG_private");
> @@ -2251,6 +2252,7 @@ write_vmcoreinfo_data(void)
> 
>  	WRITE_NUMBER("NR_FREE_PAGES", NR_FREE_PAGES);
>  	WRITE_NUMBER("N_ONLINE", N_ONLINE);
> +	WRITE_NUMBER("N_ONLINE", pgtable_l5_enabled);
> 
>  	WRITE_NUMBER("PG_lru", PG_lru);
>  	WRITE_NUMBER("PG_private", PG_private);
> @@ -2645,6 +2647,7 @@ read_vmcoreinfo(void)
> 
>  	READ_NUMBER("NR_FREE_PAGES", NR_FREE_PAGES);
>  	READ_NUMBER("N_ONLINE", N_ONLINE);
> +	READ_NUMBER("pgtable_l5_enabled", pgtable_l5_enabled);
> 
>  	READ_NUMBER("PG_lru", PG_lru);
>  	READ_NUMBER("PG_private", PG_private);
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 088dfc3..a0d1c13 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -1856,6 +1856,7 @@ struct array_table {
>  struct number_table {
>  	long	NR_FREE_PAGES;
>  	long	N_ONLINE;
> +	long	pgtable_l5_enabled;
> 
>  	/*
>   	* Page flags
> --
> 2.13.6
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
