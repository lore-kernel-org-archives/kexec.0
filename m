Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MQGHy-0007RL-DC
	for kexec@lists.infradead.org; Mon, 13 Jul 2009 07:49:37 +0000
Received: from m1.gw.fujitsu.co.jp ([10.0.50.71])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n6D7nKac010826 for <kexec@lists.infradead.org> (envelope-from
	seto.hidetoshi@jp.fujitsu.com); Mon, 13 Jul 2009 16:49:24 +0900
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id C428B45DE51
	for <kexec@lists.infradead.org>; Mon, 13 Jul 2009 16:49:19 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 846E745DE4E
	for <kexec@lists.infradead.org>; Mon, 13 Jul 2009 16:49:19 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4502D1DB803A
	for <kexec@lists.infradead.org>; Mon, 13 Jul 2009 16:49:19 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.249.87.103])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id DBC271DB803F
	for <kexec@lists.infradead.org>; Mon, 13 Jul 2009 16:49:18 +0900 (JST)
Message-ID: <4A5AE6E7.2000208@jp.fujitsu.com>
Date: Mon, 13 Jul 2009 16:48:55 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH-v2] kdump: Enable kdump if 2nd-kernel is loaded.
References: <4A55A4AE.3000206@mxs.nes.nec.co.jp>
	<4A56E069.5040907@jp.fujitsu.com>
	<4A5AB903.6090204@mxs.nes.nec.co.jp>
In-Reply-To: <4A5AB903.6090204@mxs.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>

Ken'ichi Ohmichi wrote:
> Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
> Acked-by: Simon Horman <horms@verge.net.au>
> ---
> --- a/kernel/kexec.c	2009-07-08 12:30:26.000000000 +0900
> +++ b/kernel/kexec.c	2009-07-13 13:49:03.000000000 +0900
> @@ -57,7 +57,7 @@ struct resource crashk_res = {
>  
>  int kexec_should_crash(struct task_struct *p)
>  {
> -	if (in_interrupt() || !p->pid || is_global_init(p) || panic_on_oops)
> +	if (kexec_crash_image)
>  		return 1;
>  	return 0;
>  }

Reviewed-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

Thanks,
H.Seto


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
