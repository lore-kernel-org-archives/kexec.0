Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmQSP-0000AE-9N
 for kexec@lists.infradead.org; Wed, 23 Jan 2019 21:53:15 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH 1/2] Makedumpfile: add a new variable 'sme_mask' to
 number_table
Date: Wed, 23 Jan 2019 21:51:55 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03566D77@BPXM09GP.gisp.nec.co.jp>
References: <20190122080357.23381-1-lijiang@redhat.com>
 <20190122080357.23381-2-lijiang@redhat.com>
In-Reply-To: <20190122080357.23381-2-lijiang@redhat.com>
Content-Language: en-US
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: "anderson@redhat.com" <anderson@redhat.com>, "dyoung@redhat.com" <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "bhe@redhat.com" <bhe@redhat.com>

Hi Lianbo,

On 1/22/2019 3:03 AM, Lianbo Jiang wrote:
> It will be used to store the sme mask for crashed kernel, the
> sme_mask denotes whether the old memory is encrypted or not.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  makedumpfile.c | 3 +++
>  makedumpfile.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 8923538..a03aaa1 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -1743,6 +1743,7 @@ get_structure_info(void)
>  	ENUM_NUMBER_INIT(NR_FREE_PAGES, "NR_FREE_PAGES");
>  	ENUM_NUMBER_INIT(N_ONLINE, "N_ONLINE");
>  	ENUM_NUMBER_INIT(pgtable_l5_enabled, "pgtable_l5_enabled");
> +	ENUM_NUMBER_INIT(sme_mask, "sme_mask");

This is useless because the sme_mask is not enum number.
Please remove it.

And, dividing this patchset into the two patches doesn't make sense
to me in this case. Could you merge them into a patch?

Thanks,
Kazu

> 
>  	ENUM_NUMBER_INIT(PG_lru, "PG_lru");
>  	ENUM_NUMBER_INIT(PG_private, "PG_private");
> @@ -2276,6 +2277,7 @@ write_vmcoreinfo_data(void)
>  	WRITE_NUMBER("NR_FREE_PAGES", NR_FREE_PAGES);
>  	WRITE_NUMBER("N_ONLINE", N_ONLINE);
>  	WRITE_NUMBER("pgtable_l5_enabled", pgtable_l5_enabled);
> +	WRITE_NUMBER("sme_mask", sme_mask);
> 
>  	WRITE_NUMBER("PG_lru", PG_lru);
>  	WRITE_NUMBER("PG_private", PG_private);
> @@ -2672,6 +2674,7 @@ read_vmcoreinfo(void)
>  	READ_NUMBER("NR_FREE_PAGES", NR_FREE_PAGES);
>  	READ_NUMBER("N_ONLINE", N_ONLINE);
>  	READ_NUMBER("pgtable_l5_enabled", pgtable_l5_enabled);
> +	READ_NUMBER("sme_mask", sme_mask);
> 
>  	READ_NUMBER("PG_lru", PG_lru);
>  	READ_NUMBER("PG_private", PG_private);
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 73813ed..e97b2e7 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -1912,6 +1912,7 @@ struct number_table {
>  	long	NR_FREE_PAGES;
>  	long	N_ONLINE;
>  	long	pgtable_l5_enabled;
> +	long	sme_mask;
> 
>  	/*
>   	* Page flags
> --
> 2.17.1
> 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
