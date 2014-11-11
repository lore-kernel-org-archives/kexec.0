Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xo7p3-0007Gf-8E
 for kexec@lists.infradead.org; Tue, 11 Nov 2014 09:33:13 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sAB9WPZs018280
 for <kexec@lists.infradead.org>; Tue, 11 Nov 2014 17:32:25 +0800
Message-ID: <5461D6F3.6050909@cn.fujitsu.com>
Date: Tue, 11 Nov 2014 17:29:23 +0800
From: =?UTF-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?=
 <zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: Fix the variable pfn_needed leaking
References: <1415696079-29701-1-git-send-email-mhuang@redhat.com>
In-Reply-To: <1415696079-29701-1-git-send-email-mhuang@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

On 11/11/2014 04:54 PM, Minfei Huang wrote:
> If the page pfn calculated by read_from_splitblock_table is bigger than
> pfn_needed, the variable pfn_needed will leak.
>
> makedumpfile cannot assign the pfn averagely bacause of condition
> pfn_needed invalid.
>
> Signed-off-by: Minfei Huang<mhuang@redhat.com>
> ---
>   makedumpfile.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 59c4952..8807a90 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -8415,7 +8415,7 @@ calculate_end_pfn_by_splitblock(mdf_pfn_t start_pfn,
>   		return info->max_mapnr;
>
>   	mdf_pfn_t end_pfn;
> -	long long pfn_needed, offset;
> +	long long pfn_needed, offset, per_splitblock_pfn;
>   	char *splitblock_value_offset;
>
>   	pfn_needed = info->num_dumpable / info->num_dumpfile;
> @@ -8424,7 +8424,8 @@ calculate_end_pfn_by_splitblock(mdf_pfn_t start_pfn,
>   	end_pfn = start_pfn;
>
>   	while (*cur_splitblock_num<  splitblock->num&&  pfn_needed>  0) {
> -		pfn_needed -= read_from_splitblock_table(splitblock_value_offset);
> +		per_splitblock_pfn = read_from_splitblock_table(splitblock_value_offset);
> +		pfn_needed = pfn_needed<  per_splitblock_pfn ? 0 : pfn_needed - per_splitblock_pfn;
>   		splitblock_value_offset += splitblock->entry_size;
>   		++*cur_splitblock_num;
>   	}

Hello Huang,

Actually, pfn_needed is used to indicate whether the dumpfile have enough pfn or not.
It doesn't matter whether pfn_needed == 0 or pfn_needed < 0.

I know what you want to express. Maybe you can get some useful information at
http://lists.infradead.org/pipermail/kexec/2014-October/012805.html

-- 
Thanks
Zhou Wenjian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
