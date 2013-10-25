Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VZXbS-0001eH-Hg
 for kexec@lists.infradead.org; Fri, 25 Oct 2013 02:58:23 +0000
Message-ID: <5269DE2E.3000304@hp.com>
Date: Fri, 25 Oct 2013 10:57:50 +0800
From: Jingbai Ma <jingbai.ma@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: print spinner in progress information
References: <5269CD32.200@jp.fujitsu.com>
In-Reply-To: <5269CD32.200@jp.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, jingbai.ma@hp.com

On 10/25/2013 09:45 AM, HATAYAMA Daisuke wrote:
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
>
> Signed-off-by: HATAYAMA Daisuke<d.hatayama@jp.fujitsu.com>
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

I believe your spinner should be:
const char *spinner = "/|\-/|\-";

>
>   	if (current<  end) {
>   		tm = time(NULL);
> @@ -297,13 +299,14 @@ print_progress(const char *msg, unsigned long current, unsigned long end)
>   		progress = 100;
>
>   	if (flag_ignore_r_char) {
> -		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%]\n",
> -			     msg, progress);
> +		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%] %c\n",
> +			     msg, progress, spinner[lapse&  3]);
>   	} else {
>   		PROGRESS_MSG("\r");
> -		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%] ",
> -			     msg, progress);
> +		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%] %c",
> +			     msg, progress, spinner[lapse&  3]);
>   	}
> +	lapse++;
>   }
>
>   void


-- 
Thanks,
Jingbai Ma

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
