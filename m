Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pw0-f49.google.com ([209.85.160.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Rq0Ub-00067k-B0
 for kexec@lists.infradead.org; Wed, 25 Jan 2012 10:54:17 +0000
Received: by pbdx9 with SMTP id x9so1921480pbd.36
 for <kexec@lists.infradead.org>; Wed, 25 Jan 2012 02:54:15 -0800 (PST)
Message-ID: <4F1FDF52.8050301@gmail.com>
Date: Wed, 25 Jan 2012 18:54:10 +0800
From: Cong Wang <xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Subject: Re: Makedumpfile 1.4.2 release
References: <4F1FDE5F.5080403@gmail.com>
In-Reply-To: <4F1FDE5F.5080403@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

On 01/25/2012 06:50 PM, Cong Wang wrote:
> Hello, Kumagai-san,
>
> I saw you released 1.4.2:
>

By the way, the latest kernel supported by makedumpfile 1.4.2 is still
2.6.36.

makedumpfile.h
383:#define LATEST_VERSION		KERNEL_VERSION(2, 6, 36)/* linux-2.6.36 */

The latest stable kernel is already 3.2.1. :) So, what prevents 
makedumpfile supporting newer kernels?

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
