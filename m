Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zbe2p-0003oR-9v
 for kexec@lists.infradead.org; Tue, 15 Sep 2015 00:24:23 +0000
Received: by wicgb1 with SMTP id gb1so5983182wic.1
 for <kexec@lists.infradead.org>; Mon, 14 Sep 2015 17:24:00 -0700 (PDT)
Date: Tue, 15 Sep 2015 03:23:58 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 04/13] Always expose MAP_UNINITIALIZED to userspace
Message-ID: <20150915002358.GA12618@node.dhcp.inet.fi>
References: <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
 <1442271047-4908-1-git-send-email-palmer@dabbelt.com>
 <1442271047-4908-5-git-send-email-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1442271047-4908-5-git-send-email-palmer@dabbelt.com>
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
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: dave@sr71.net, linux-xtensa@linux-xtensa.org, dhowells@redhat.com, jcmvbkbc@gmail.com, hpa@zytor.com, mingo@kernel.org, ast@plumgrid.com, aarcange@redhat.com, bhe@redhat.com, x86@kernel.org, tomi.valkeinen@ti.com, 3chas3@gmail.com, paulmck@linux.vnet.ibm.com, dyoung@redhat.com, vgoyal@redhat.com, aishchuk@linux.vnet.ibm.com, linux-arch@vger.kernel.org, jikos@kernel.org, a.p.zijlstra@chello.nl, arnd@arndb.de, plagnioj@jcrosoft.com, josh@joshtriplett.org, acme@kernel.org, mathieu.desnoyers@efficios.com, viro@zeniv.linux.org.uk, luto@kernel.org, tglx@linutronix.de, drysdale@google.com, chris@zankel.net, iulia.manda21@gmail.com, geoff@infradead.org, gregkh@linuxfoundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, davem@davemloft.net

On Mon, Sep 14, 2015 at 03:50:38PM -0700, Palmer Dabbelt wrote:
> This used to be hidden behind CONFIG_MMAP_ALLOW_UNINITIALIZED, so
> userspace wouldn't actually ever see it be non-zero.  While I could
> have kept hiding it, the man pages seem to indicate that
> MAP_UNINITIALIZED should be visible:
> 
>   mmap(2)
>   MAP_UNINITIALIZED (since Linux 2.6.33)
>     Don't clear anonymous pages.  This flag is intended to improve
>     performance on embedded devices.  This flag is honored only if the
>     kernel was configured with the CONFIG_MMAP_ALLOW_UNINITIALIZED
>     option.  Because of the security implications, that option is
>     normally enabled only on embedded devices (i.e., devices where one
>     has complete control of the contents of user memory).
> 
> and since the only time it shows up in my /usr/include is in this
> header I believe this should have been visible to userspace (as
> non-zero, which wouldn't do anything when or'd into the flags) all
> along.

Are you sure about "wouldn't do anything"?
Suspiciously, 0x4000000 is also (1 << MAP_HUGE_SHIFT). I'm not sure if any
architecture has order-1 huge pages, but still looks like we have conflict
here.

I think it's harmful to expose non-zero MAP_UNINITIALIZED to system which
potentially can handle multiple users. Or non-trivial user space in
general.

Should we leave it at least under '#ifndef CONFIG_MMU'? I don't think it's
possible to have single ABI for MMU and MMU-less systems anyway. And we
can avoid conflict with MAP_HUGE_SHIFT this way.

P.S. MAP_UNINITIALIZED itself looks very broken to me. I probably need dig
mailing list on why it was allowed. 
But that's other topic.

-- 
 Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
