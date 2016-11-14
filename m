Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c6A6Z-0004q4-Ph
 for kexec@lists.infradead.org; Mon, 14 Nov 2016 05:46:56 +0000
Date: Mon, 14 Nov 2016 13:46:28 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: vmcore cant be generated under kernel 4.7.9
Message-ID: <20161114054628.GA17011@dhcp-128-65.nay.redhat.com>
References: <CAN3hGLe_ga1vE=6HhTaKcgDBqUApj9w4rtzX2EB3BoDo5iOKdw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAN3hGLe_ga1vE=6HhTaKcgDBqUApj9w4rtzX2EB3BoDo5iOKdw@mail.gmail.com>
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
To: R Sun <ulxwork@gmail.com>
Cc: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>, Daisuke Nishimura <dai-nishimura@rc.jp.nec.com>, Minoru Usui <min-usui@ti.jp.nec.com>, kexec-ml <kexec@lists.infradead.org>, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>

On 11/12/16 at 11:02am, R Sun wrote:
> Hello,
> 
> I updated my fedora23 from 4.5.7-202 to 4.7.9-100 recently, and found out kdump
> could not generate vmcore when crashed, but its ok with
> vmcore-dmesg.txt. i traced
> it for a while and find out its because of a change in the page struct
> which _count renamed to _refcount committed as 0139aa7b7f in kernel.

The makedumpfile patch has been in Fedora rawhide and F25 kexec-tools
patckage. I think you can use the rawhide rpm on F23

Thanks
Dave
> 
> Below is my patch to fix this problem
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 853b999..1bfafb7 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -2492,6 +2492,13 @@ read_vmcoreinfo(void)
> 
>         READ_MEMBER_OFFSET("page.flags", page.flags);
>         READ_MEMBER_OFFSET("page._count", page._count);
> +       /*
> +        * _count, field of struct page, renamed to _refcount according to
> +        * commit 0139aa7b7f in kernel. so just try page._refcount if
> +        * page._count does not work
> +        */
> +       if (OFFSET(page._count) == NOT_FOUND_STRUCTURE)
> +               READ_MEMBER_OFFSET("page._refcount", page._count);
>         READ_MEMBER_OFFSET("page.mapping", page.mapping);
>         READ_MEMBER_OFFSET("page.lru", page.lru);
>         READ_MEMBER_OFFSET("page._mapcount", page._mapcount);
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
