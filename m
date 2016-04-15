Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aqtbV-0004Iz-S5
 for kexec@lists.infradead.org; Fri, 15 Apr 2016 02:35:30 +0000
Date: Fri, 15 Apr 2016 10:39:57 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH v6] Improve the performance of --num-threads -d 31
Message-ID: <20160415023957.GA26257@dhcp-128-25.nay.redhat.com>
References: <1460612555-19430-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1460612555-19430-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
To: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Cc: kexec@lists.infradead.org

On 04/14/16 at 01:42pm, Zhou Wenjian wrote:
> @@ -10223,6 +10263,20 @@ calculate_cyclic_buffer_size(void) {
>  	 *  free memory for safety.
>  	 */
>  	limit_size = get_free_memory_size() * 0.6;
> +
> +	/*
> +	 * Recalculate the limit_size according to num_threads.
> +	 * And reset num_threads if there is not enough memory.
> +	 */
> +	if (limit_size - maximum_size < THREAD_REGION * info->num_threads) {
> +		MSG("There isn't enough memory for %d threads.\n", info->num_threads);
> +
> +		info->num_threads = MAX(0, limit_size - maximum_size) / THREAD_REGION;

Hi, Zhou.

Since both limit_size and maximum_size are unsigned long long,
comparison is necessary for the if branch. Thus the micro MAX can be
removed as well.

Thanks
Minfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
