Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZcWCf-0005ax-AR
 for kexec@lists.infradead.org; Thu, 17 Sep 2015 10:14:11 +0000
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20150915140742.GA11938@x>
References: <20150915140742.GA11938@x>
 <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
 <1442271047-4908-1-git-send-email-palmer@dabbelt.com>
 <1442271047-4908-5-git-send-email-palmer@dabbelt.com>
 <20150915002358.GA12618@node.dhcp.inet.fi> <20150915051919.GB4091@x>
 <20150915094200.GA15444@node.dhcp.inet.fi>
Subject: Re: [PATCH 04/13] Always expose MAP_UNINITIALIZED to userspace
MIME-Version: 1.0
Content-ID: <16168.1442484811.1@warthog.procyon.org.uk>
Date: Thu, 17 Sep 2015 11:13:31 +0100
Message-ID: <16169.1442484811@warthog.procyon.org.uk>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: dave@sr71.net, linux-xtensa@linux-xtensa.org, dhowells@redhat.com, jcmvbkbc@gmail.com, hpa@zytor.com, mingo@kernel.org, ast@plumgrid.com, aarcange@redhat.com, bhe@redhat.com, x86@kernel.org, tomi.valkeinen@ti.com, 3chas3@gmail.com, paulmck@linux.vnet.ibm.com, dyoung@redhat.com, vgoyal@redhat.com, aishchuk@linux.vnet.ibm.com, linux-arch@vger.kernel.org, jikos@kernel.org, a.p.zijlstra@chello.nl, arnd@arndb.de, plagnioj@jcrosoft.com, acme@kernel.org, mathieu.desnoyers@efficios.com, viro@zeniv.linux.org.uk, luto@kernel.org, "Kirill A. Shutemov" <kirill@shutemov.name>, tglx@linutronix.de, drysdale@google.com, chris@zankel.net, iulia.manda21@gmail.com, geoff@infradead.org, gregkh@linuxfoundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, ebiederm@xmission.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, davem@davemloft.net

Josh Triplett <josh@joshtriplett.org> wrote:

> > Sure. And 0 is perfectly fine value for the flag. Like with MAP_FILE.
> 
> Rephrasing: the flag should always exist with the correct value.
> Whether the kernel handles it or not, the kernel *headers* shouldn't
> change to match the kernel, not least of which because they don't
> necessarily match the running kernel.  Just like we define the
> prototypes for syscalls that the running kernel may return ENOSYS for.

Josh is correct.

CONFIG_xxx *should* *not* be seen in UAPI headers, except inside #ifdef
__KERNEL__ guards under special circumstances - and #ifdef __KERNEL__ guards
*should* *not* be seen in UAPI headers except under special circumstances.

In terms of such special circumstances, take a peek in
include/uapi/linux/acct.h at struct acct with this:

	/* m68k had no padding here. */
	#if !defined(CONFIG_M68K) || !defined(__KERNEL__)
		__u16		ac_ahz;			/* AHZ */
	#endif

in the middle of it...

Or include/{,uapi/}linux/agpgart.h where it defines two different but
same-named variants of several structs.

Now, some of these - particularly things like the latter - can be fixed by
someone who has the time.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
