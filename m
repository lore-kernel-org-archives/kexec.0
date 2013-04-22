Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UU4Ck-0003Cr-NW
 for kexec@lists.infradead.org; Mon, 22 Apr 2013 00:02:00 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 8DE333EE0AE
 for <kexec@lists.infradead.org>; Mon, 22 Apr 2013 09:01:49 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 7768345DE5C
 for <kexec@lists.infradead.org>; Mon, 22 Apr 2013 09:01:49 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5E49245DE5B
 for <kexec@lists.infradead.org>; Mon, 22 Apr 2013 09:01:49 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 51D601DB804B
 for <kexec@lists.infradead.org>; Mon, 22 Apr 2013 09:01:49 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 05D761DB8052
 for <kexec@lists.infradead.org>; Mon, 22 Apr 2013 09:01:49 +0900 (JST)
Message-ID: <51747DD3.8000104@jp.fujitsu.com>
Date: Mon, 22 Apr 2013 09:01:23 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: Check dump file early
References: <20130419173644.4c24dead@holzheu>
In-Reply-To: <20130419173644.4c24dead@holzheu>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org

(2013/04/20 0:36), Michael Holzheu wrote:
> On s390 the makedumpfile tool sometimes is used directly by
> users on the command line. Currently the check if the dump
> file already exists is done after the filtering function has
> been called. Therefore, for large dumps the user has to wait
> for filtering and after some time he gets the error message
> "open_dump_file: Can't open the dump file(out). File exists".
>
> This patch improves this by adding an early check for the
> existence of the dump file. In case the -f (force) option has
> been specified it is checked that an existing file is writable.
>
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> ---
>   makedumpfile.c |   37 ++++++++++++++++++++++++++++++++++++-
>   1 file changed, 36 insertions(+), 1 deletion(-)
>
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -730,6 +730,24 @@ open_dump_file(void)
>   }
>
>   int
> +check_dump_file(const char *path)
> +{
> +	char *err_str;
> +
> +	if (access(path, F_OK) != 0)
> +		return TRUE; /* File does not exist */
> +	if (info->flag_force) {
> +		if (access(path, W_OK) == 0)
> +			return TRUE; /* We have write permission */
> +		err_str = strerror(errno);
> +	} else {
> +		err_str = "File exists";

How about strerror(EEXIST)? It's better to avoid hard code to use the 
same string as what libc returns.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
