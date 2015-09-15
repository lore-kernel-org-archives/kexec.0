Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZbeUJ-00029l-Ff
 for kexec@lists.infradead.org; Tue, 15 Sep 2015 00:52:48 +0000
Received: by padhy16 with SMTP id hy16so158498527pad.1
 for <kexec@lists.infradead.org>; Mon, 14 Sep 2015 17:52:26 -0700 (PDT)
Message-ID: <55f76bc8.2108450a.97c6e.129a@mx.google.com>
Date: Mon, 14 Sep 2015 17:52:24 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 04/13] Always expose MAP_UNINITIALIZED to userspace
In-Reply-To: <20150915002358.GA12618@node.dhcp.inet.fi>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kirill@shutemov.name, arnd@arndb.de
Cc: dave@sr71.net, linux-xtensa@linux-xtensa.org, dhowells@redhat.com, jcmvbkbc@gmail.com, hpa@zytor.com, mingo@kernel.org, ast@plumgrid.com, aarcange@redhat.com, bhe@redhat.com, x86@kernel.org, tomi.valkeinen@ti.com, 3chas3@gmail.com, paulmck@linux.vnet.ibm.com, plagnioj@jcrosoft.com, vgoyal@redhat.com, aishchuk@linux.vnet.ibm.com, linux-arch@vger.kernel.org, a.p.zijlstra@chello.nl, jikos@kernel.org, josh@joshtriplett.org, acme@kernel.org, mathieu.desnoyers@efficios.com, viro@zeniv.linux.org.uk, luto@kernel.org, tglx@linutronix.de, drysdale@google.com, chris@zankel.net, iulia.manda21@gmail.com, geoff@infradead.org, gregkh@linuxfoundation.org, dyoung@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, davem@davemloft.net

On Mon, 14 Sep 2015 17:23:58 PDT (-0700), kirill@shutemov.name wrote:
> On Mon, Sep 14, 2015 at 03:50:38PM -0700, Palmer Dabbelt wrote:
>> This used to be hidden behind CONFIG_MMAP_ALLOW_UNINITIALIZED, so
>> userspace wouldn't actually ever see it be non-zero.  While I could
>> have kept hiding it, the man pages seem to indicate that
>> MAP_UNINITIALIZED should be visible:
>>
>>   mmap(2)
>>   MAP_UNINITIALIZED (since Linux 2.6.33)
>>     Don't clear anonymous pages.  This flag is intended to improve
>>     performance on embedded devices.  This flag is honored only if the
>>     kernel was configured with the CONFIG_MMAP_ALLOW_UNINITIALIZED
>>     option.  Because of the security implications, that option is
>>     normally enabled only on embedded devices (i.e., devices where one
>>     has complete control of the contents of user memory).
>>
>> and since the only time it shows up in my /usr/include is in this
>> header I believe this should have been visible to userspace (as
>> non-zero, which wouldn't do anything when or'd into the flags) all
>> along.
>
> Are you sure about "wouldn't do anything"?

That was bad writing for me.  I'd originally written something like "I
believe this should have been visible to userspace all along", but
then added the ()'s.  I meant to say:

 * I think MAP_UNINITIALIZED should have been non-zero in userspace.
 * MAP_UNINITAILIZED was zero in userspace.
 * A zero MAP_UNINITIALIZED does nothing when OR'd in.

> Suspiciously, 0x4000000 is also (1 << MAP_HUGE_SHIFT). I'm not sure if any
> architecture has order-1 huge pages, but still looks like we have conflict
> here.
>
> I think it's harmful to expose non-zero MAP_UNINITIALIZED to system which
> potentially can handle multiple users. Or non-trivial user space in
> general.

This doesn't have MAP_UNINITIALIZED do anything by default, it just
defines the flag the same way on all systems.  I was under the
impression that this just happened if I set MAP_UNINITIALIZED.
Looking at MAP_HUGE_SHIFT it mmap.c, that's definitely why my mmap()
test case ignored the set MAP_UNINITIALIZED on my PC.

I'm going to make this

 #ifndef MAP_UNINITAILIZED
 #define MAP_UNINITAILIZED 0
 #endif

and then leave Xtensa's port alone.  This is what Arnd suggested
originally, sorry for the extra work!

> Should we leave it at least under '#ifndef CONFIG_MMU'? I don't think it's
> possible to have single ABI for MMU and MMU-less systems anyway. And we
> can avoid conflict with MAP_HUGE_SHIFT this way.

The whole goal here was to eliminate "#ifndef CONFIG_*" from the
user-visible headers.  This all started because I got bit by a very
similar-looking bug (see patch #1), so I'd prefer not to go down that
route.

> P.S. MAP_UNINITIALIZED itself looks very broken to me. I probably need dig
> mailing list on why it was allowed.
> But that's other topic.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
