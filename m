Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1bDXsE-0003vG-Q9
 for kexec@lists.infradead.org; Thu, 16 Jun 2016 14:02:23 +0000
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH] makedumpfile: support _count -> _refcount rename in
 struct page
References: <1466084029-22290-1-git-send-email-vkuznets@redhat.com>
 <1366043437.15957172.1466084968204.JavaMail.zimbra@redhat.com>
Date: Thu, 16 Jun 2016 16:01:58 +0200
In-Reply-To: <1366043437.15957172.1466084968204.JavaMail.zimbra@redhat.com>
 (Dave Anderson's message of "Thu, 16 Jun 2016 09:49:28 -0400 (EDT)")
Message-ID: <8760t9fd0p.fsf@vitty.brq.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Anderson <anderson@redhat.com>
Cc: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, Minoru Usui <min-usui@ti.jp.nec.com>, kexec@lists.infradead.org, Daisuke Nishimura <dai-nishimura@rc.jp.nec.com>

Dave Anderson <anderson@redhat.com> writes:

> ----- Original Message -----
>> _count member was renamed to _refcount in linux commit commit 0139aa7b7fa12
>> ("mm: rename _count, field of the struct page, to _refcount") and this
>> broke makedumpfile. The reason for making the change was to find all users
>> accessing it directly and not through the recommended API. I tried
>> suggesting to revert the change but failed, I see no other choice than to
>> start supporting both _count and _refcount in makedumpfile.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>> - 'crash' tool is now broken as well.
>
> FYI, crash was fixed upstream a few weeks ago:
>
>   commit 8ceb1ac628bf6a0a7f0bbfff030ec93081bca4cd
>   Author: Dave Anderson <anderson@redhat.com>
>   Date:   Mon May 23 11:23:01 2016 -0400
>
>     Fix for Linux commit 0139aa7b7fa12ceef095d99dc36606a5b10ab83a, which
>     renamed the page._count member to page._refcount.  Without the patch,
>     certain "kmem" commands fail with the "kmem: invalid structure member
>     offset: page_count".
>     (anderson@redhat.com)

Missed that, thanks for the heads up!

-- 
  Vitaly

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
