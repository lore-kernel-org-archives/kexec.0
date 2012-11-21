Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TbGNx-0000Sp-MX
 for kexec@lists.infradead.org; Wed, 21 Nov 2012 19:55:02 +0000
Received: by mail-bk0-f49.google.com with SMTP id jm19so1892647bkc.36
 for <kexec@lists.infradead.org>; Wed, 21 Nov 2012 11:55:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20121121143729.GC13114@redhat.com>
References: <1353483098-14883-1-git-send-email-yinghai@kernel.org>
 <1353483098-14883-5-git-send-email-yinghai@kernel.org>
 <20121121143729.GC13114@redhat.com>
Date: Wed, 21 Nov 2012 11:54:59 -0800
Message-ID: <CAE9FiQWRtMwXjUEr5pHtKKR+mPk7qtKRDpS_G_o=VzzKkBwL1Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] kexec, x86_64: Load bzImage64 above 4G
From: Yinghai Lu <yinghai@kernel.org>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>

On Wed, Nov 21, 2012 at 6:37 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
> On Tue, Nov 20, 2012 at 11:31:38PM -0800, Yinghai Lu wrote:
>
> [..]
>> +     /* avoid cross GB boundary */
>> +     align = real_mode->kernel_alignment;
>> +     addr = locate_hole(info, size, align, 0x100000, -1, -1);
>> +     if (addr == ULONG_MAX)
>> +             die("can not load bzImage64");
>> +     /* same GB ? */
>> +     while ((addr >> 30) != ((addr + size - 1) >> 30)) {
>> +             addr = locate_hole(info, size, align, 0x100000,
>> +                              round_down(addr + size - 1, (1UL<<30)), -1);
>> +             if (addr == ULONG_MAX)
>> +                     die("can not load bzImage64");
>> +     }
>> +     dbgprintf("Found kernel buffer at %lx size %lx\n", addr, size);
>
> Where does this limitation of not loading kernel across GB boundary come
> from?

in kernel arch/x86/kernel/head_64.S

it only set first 1G ident mapping. and if it find that code is above
1G, it will set extra ident mapping
for new _text.._end.
To make checking and add extra mapping simple and also save two extra
pages for mapping.
Limit that _text.._end in them same GB range.

Thanks

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
