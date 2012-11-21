Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TbGUF-0000ui-T8
 for kexec@lists.infradead.org; Wed, 21 Nov 2012 20:01:32 +0000
Received: by mail-bk0-f49.google.com with SMTP id jm19so1894904bkc.36
 for <kexec@lists.infradead.org>; Wed, 21 Nov 2012 12:01:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50AD31ED.3020202@zytor.com>
References: <1353483098-14883-1-git-send-email-yinghai@kernel.org>
 <1353483098-14883-5-git-send-email-yinghai@kernel.org>
 <20121121143729.GC13114@redhat.com>
 <CAE9FiQWRtMwXjUEr5pHtKKR+mPk7qtKRDpS_G_o=VzzKkBwL1Q@mail.gmail.com>
 <50AD31ED.3020202@zytor.com>
Date: Wed, 21 Nov 2012 12:01:30 -0800
Message-ID: <CAE9FiQXjH8nLQrPdP=OiXqROvhwf=mT8XOq9Netmsj08FXrEiw@mail.gmail.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On Wed, Nov 21, 2012 at 11:56 AM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 11/21/2012 11:54 AM, Yinghai Lu wrote:
>>
>> in kernel arch/x86/kernel/head_64.S
>>
>> it only set first 1G ident mapping. and if it find that code is above
>> 1G, it will set extra ident mapping
>> for new _text.._end.
>> To make checking and add extra mapping simple and also save two extra
>> pages for mapping.
>> Limit that _text.._end in them same GB range.
>>
>
> No, this is backwards.

old one: it limited bzImage in [0,1G) aka the first 1G.

Now we can put it in any aligned 1G range.

So how could it be called backwards?

>
> We should fix that limitation instead.

sure, but that will make arch/x86/boot/compressed/head_64.S not need
complicated.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
