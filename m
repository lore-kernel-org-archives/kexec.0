Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yb0-x242.google.com ([2607:f8b0:4002:c09::242])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cH9l9-0007BK-Io
 for kexec@lists.infradead.org; Wed, 14 Dec 2016 13:38:16 +0000
Received: by mail-yb0-x242.google.com with SMTP id h184so1866550ybb.1
 for <kexec@lists.infradead.org>; Wed, 14 Dec 2016 05:37:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <800dfe9c-02cf-def8-0cb6-8469553d6d00@windriver.com>
References: <800dfe9c-02cf-def8-0cb6-8469553d6d00@windriver.com>
From: Maxim Uvarov <muvarov@gmail.com>
Date: Wed, 14 Dec 2016 16:37:53 +0300
Message-ID: <CAJGZr0KQusKA_O_E410m4xEE1as=7=P7yqgFioiUTsjrZyf-xg@mail.gmail.com>
Subject: Re: Need help for arm64
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
To: He Zhe <zhe.he@windriver.com>
Cc: geoff@infradead.org, Yang Shi <yang.shi@windriver.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

which kexec-tools and which kernel are you using?

Maxim.

2016-12-14 12:42 GMT+03:00 He Zhe <zhe.he@windriver.com>:
> Hi,
>
> I notice the function below in kexec/arch/arm64/crashdump-arm64.c. It looks it always causes "kexec -p" to return:
> "Memory for crashkernel is not reserved
> Please reserve memory by passing"crashkernel=X@Y" parameter to kernel
> Then try to loading kdump kernel"
>
> int is_crashkernel_mem_reserved(void)
> {
>         return 0;
> }
>
> Do we have plan to implement this?
> Do we have workaround for arm64?
>
> Thanks,
> Zhe
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec



-- 
Best regards,
Maxim Uvarov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
