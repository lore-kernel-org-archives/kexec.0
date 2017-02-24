Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1chABp-0007qU-BO
 for kexec@lists.infradead.org; Fri, 24 Feb 2017 07:21:19 +0000
Received: by mail-pg0-f48.google.com with SMTP id 1so8067618pgi.1
 for <kexec@lists.infradead.org>; Thu, 23 Feb 2017 23:20:56 -0800 (PST)
Subject: Re: [PATCH] /proc/kcore: Update physical address for kcore ram and
 text
References: <f951340d2917cdd2a329fae9837a83f2059dc3b2.1485318868.git.panand@redhat.com>
 <CAHB_GupwpXiZjmy+4SQLvoJaJkAo9VvNVxQgxqvXeACRR--exg@mail.gmail.com>
 <CAGXu5jL89e33t0g+iVm8o7sstn3B9QCiFP_AhxZj8QiyaTjNZw@mail.gmail.com>
 <5b28ea05-24ab-b8db-e3d1-216399734297@redhat.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <905c2861-11bf-0449-31ab-596d9347e7cc@redhat.com>
Date: Fri, 24 Feb 2017 12:50:50 +0530
MIME-Version: 1.0
In-Reply-To: <5b28ea05-24ab-b8db-e3d1-216399734297@redhat.com>
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
To: Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, Kexec Mailing List <kexec@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, Dave Anderson <anderson@redhat.com>, Dave Young <dyoung@redhat.com>

Hi Andrew/Kees,

On Tuesday 14 February 2017 07:16 AM, Pratyush Anand wrote:
>>
>> Well, CONFIG_PROC_KCORE is a generalized root KASLR exposure (though
>> there are lots of such exposures). Why is the actual physical address
>> needed? Can this just report the virtual address instead? Then the
>> tool can build a map, but it looks like an identity map, rather than
>> creating a new physical/virtual memory ASLR offset exposure?
>
> Well, having an ASLR offset information can help to translate an
> identity mapped virtual address to a physical address. But that would be
> an additional field in PT_LOAD header structure and an arch dependent
> value.
>
> Moreover, sending a valid physical address like 0 does not seem right.
> So, IMHO it is better to fix that and send valid physical address when
> available (identity mapped).
>
> Thanks for the review.

So, whats the decision on this patch? I see that patch is lying in 
next/master. Should I expect this patch in v4.11-rc1?

Couple of user-space makedumpfile modification will depend on this 
patch. So, we can not get those makedumpfile patches merged until this 
patch hits upstream.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
