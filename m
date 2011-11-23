Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-iy0-f177.google.com ([209.85.210.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RTEJq-0006xW-OC
 for kexec@lists.infradead.org; Wed, 23 Nov 2011 15:01:03 +0000
Received: by iapp10 with SMTP id p10so1956247iap.36
 for <kexec@lists.infradead.org>; Wed, 23 Nov 2011 07:01:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1322054283.10119.11.camel@br98xy6r>
References: <1322043068.10119.7.camel@br98xy6r>
 <20111123102214.GA4914@verge.net.au>
 <1322054283.10119.11.camel@br98xy6r>
Date: Wed, 23 Nov 2011 23:01:00 +0800
Message-ID: <CAM_iQpUowWDiX-44n_qud5cb81MfQCzXKiP3sgokkDzzVrE9FA@mail.gmail.com>
Subject: Re: [PATCH v2] kdump: crashk_res init check for
 /sys/kernel/kexec_crash_size
From: Cong Wang <xiyou.wangcong@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: holzheu@linux.vnet.ibm.com
Cc: heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, schwidefsky@de.ibm.com, akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

On Wed, Nov 23, 2011 at 9:18 PM, Michael Holzheu
<holzheu@linux.vnet.ibm.com> wrote:
> From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
>
> Currently it is possible to set the crash_size via the sysfs
> /sys/kernel/kexec_crash_size even if no crash kernel memory has
> been defined with the "crashkernel" parameter. In this case
> "crashk_res" is not initialized and crashk_res.start = crashk_res.end = 0.
> Unfortunately resource_size(&crashk_res) returns 1 in this case.
> This breaks the s390 implementation of crash_(un)map_reserved_pages().
>
> To fix the problem the correct "old_size" is now calculated in
> crash_shrink_memory(). "old_size is set to "0" if crashk_res is
> not initialized. With this change crash_shrink_memory() will do nothing,
> when "crashk_res" is not initialized. It will return "0" for
> "echo 0 > /sys/kernel/kexec_crash_size" and -EINVAL for
> "echo [not zero] > /sys/kernel/kexec_crash_size".
>
> In addition to that this patch also simplifies the "ret = -EINVAL"
> vs. "ret = 0" logic as suggested by Simon Horman.
>
> Cc: Simon Horman <horms@verge.net.au>
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>

Reviewed-by: WANG Cong <xiyou.wangcong@gmail.com>

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
