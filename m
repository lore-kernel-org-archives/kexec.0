Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dQ5WY-0000Bp-OF
 for kexec@lists.infradead.org; Wed, 28 Jun 2017 05:28:24 +0000
Received: by mail-pg0-f46.google.com with SMTP id t186so26341696pgb.1
 for <kexec@lists.infradead.org>; Tue, 27 Jun 2017 22:28:02 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH] vmcore-dmesg: avoid allocating large memory chunk for log
 buf
References: <1497910994-15129-1-git-send-email-xiyou.wangcong@gmail.com>
Message-ID: <2550dd3e-4473-aef8-41cf-4bfe1bb930df@redhat.com>
Date: Wed, 28 Jun 2017 10:57:58 +0530
MIME-Version: 1.0
In-Reply-To: <1497910994-15129-1-git-send-email-xiyou.wangcong@gmail.com>
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
To: Cong Wang <xiyou.wangcong@gmail.com>, kexec@lists.infradead.org
Cc: horms@verge.net.au



On Tuesday 20 June 2017 03:53 AM, Cong Wang wrote:
> In kdump kernel, we got:
>
>     Saving vmcore-dmesg.txt
>     Failed to malloc 67108864 bytes for the logbuf: Cannot allocate memory
>
> Apparently 64M is too luxury for a kdump kernel which only has 128M
> in total.
>
> We can avoid allocating such a large memory chunk, instead just allocate
> a smaller chunk inside the loop each time.

Nice improvement.

>
> Verify the result by comparing the vmcore-dmesg output with and without
> this patch.

Yes, it works.

Modification looks fine to me.

Reviewed-by: Pratyush Anand <panand@redhat.com>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
