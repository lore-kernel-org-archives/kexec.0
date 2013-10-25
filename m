Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VZYkl-0002M5-6G
 for kexec@lists.infradead.org; Fri, 25 Oct 2013 04:12:05 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: print spinner in progress information
Date: Fri, 25 Oct 2013 04:07:21 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971B8EE2@BPXM01GP.gisp.nec.co.jp>
References: <5269CD32.200@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello HATAYAMA-san,

(2013/10/25 9:55), HATAYAMA Daisuke wrote:
> On system with huge memory, percentage in progress information is
> updated at very slow interval, because 1 percent on 1 TiB memory is
> about 10 GiB, which looks like as if system has freezed. Then,
> confused users might get tempted to push a reset button to recover the
> system. We want to avoid such situation as much as possible.
>
> To address the issue, this patch adds spinner that rotates in the
> order of /, |, \ and - next to the progress indicator in percentage,
> which helps users to get aware that system is still active and crash
> dump process is still in progress now.
>
> This code is borrowed from diskdump code.
>
> The example is like this:
>
> Copying data                       : [  0 %] /
> Copying data                       : [  8 %] |
> Copying data                       : [ 11 %] \
> Copying data                       : [ 14 %] -
> Copying data                       : [ 16 %] /
> ...
> Copying data                       : [ 99 %] /
> Copying data                       : [100 %] |

I like it, but have a comment.

    6109 int
    6110 write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page,
    6111                          struct page_desc *pd_zero, off_t *offset_data)
    6112 {
    ...
    6156         per = info->num_dumpable / 100;
    ...
    6178         for (pfn = start_pfn; pfn < end_pfn; pfn++) {
    6179
    6180                 if ((num_dumped % per) == 0)
    6181                         print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable);

The interval of calling print_progress() looks still long if
num_dumpable is huge.
So how about fix this, e.g., by changing the interval to time based ?


Thanks
Atsushi Kumagai

> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> ---
>   print_info.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/print_info.c b/print_info.c
> index 3527970..879fa4b 100644
> --- a/print_info.c
> +++ b/print_info.c
> @@ -286,6 +286,8 @@ print_progress(const char *msg, unsigned long current, unsigned long end)
>   	int progress;
>   	time_t tm;
>   	static time_t last_time = 0;
> +	static unsigned int lapse = 0;
> +	const char *spinner = "/|\\-";
>
>   	if (current < end) {
>   		tm = time(NULL);
> @@ -297,13 +299,14 @@ print_progress(const char *msg, unsigned long current, unsigned long end)
>   		progress = 100;
>
>   	if (flag_ignore_r_char) {
> -		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%]\n",
> -			     msg, progress);
> +		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%] %c\n",
> +			     msg, progress, spinner[lapse & 3]);
>   	} else {
>   		PROGRESS_MSG("\r");
> -		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%] ",
> -			     msg, progress);
> +		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%] %c",
> +			     msg, progress, spinner[lapse & 3]);
>   	}
> +	lapse++;
>   }
>
>   void
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
