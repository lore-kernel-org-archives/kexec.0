Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TgxnU-0004Yx-W4
 for kexec@lists.infradead.org; Fri, 07 Dec 2012 13:16:57 +0000
Received: by mail-ob0-f177.google.com with SMTP id uo13so368483obb.36
 for <kexec@lists.infradead.org>; Fri, 07 Dec 2012 05:16:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20121206145020.93fd7128.akpm@linux-foundation.org>
References: <1354810175-4338-1-git-send-email-js1304@gmail.com>
 <20121206145020.93fd7128.akpm@linux-foundation.org>
Date: Fri, 7 Dec 2012 22:16:55 +0900
Message-ID: <CAAmzW4N-=uXBdgjbkdL=aNVtKvvXZs-6BNgpDzi7CLkeo0-jBg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] remove vm_struct list management
From: JoonSoo Kim <js1304@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, linux-mm@kvack.org

2012/12/7 Andrew Morton <akpm@linux-foundation.org>:
> On Fri,  7 Dec 2012 01:09:27 +0900
> Joonsoo Kim <js1304@gmail.com> wrote:
>
>> I'm not sure that "7/8: makes vmlist only for kexec" is fine.
>> Because it is related to userspace program.
>> As far as I know, makedumpfile use kexec's output information and it only
>> need first address of vmalloc layer. So my implementation reflect this
>> fact, but I'm not sure. And now, I don't fully test this patchset.
>> Basic operation work well, but I don't test kexec. So I send this
>> patchset with 'RFC'.
>
> Yes, this is irritating.  Perhaps Vivek or one of the other kexec
> people could take a look at this please - if would obviously be much
> better if we can avoid merging [patch 7/8] at all.

I'm not sure, but I almost sure that [patch 7/8] have no problem.
In kexec.c, they write an address of vmlist and offset of vm_struct's
address field.
It imply that user for this information doesn't have any other
information about vm_struct,
and they can't use other field of vm_struct. They can use *only* address field.
So, remaining just one vm_struct for vmlist which represent first area
of vmalloc layer
may be safe.

But, kexec people may be very helpful to validate this patch.

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
