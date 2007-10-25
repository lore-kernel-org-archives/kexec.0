Return-path: <kexec-bounces@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IkqfI-0007XF-7D
	for kexec@lists.infradead.org; Thu, 25 Oct 2007 01:33:58 +0100
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 1/3] x86: add lapic_shutdown for x86_64
References: <47195763.1090803@ct.jp.nec.com> <47195807.6030809@ct.jp.nec.com>
	<20071024062933.GA4622@in.ibm.com> <471FB8D2.5060208@ct.jp.nec.com>
Date: Wed, 24 Oct 2007 18:28:15 -0600
In-Reply-To: <471FB8D2.5060208@ct.jp.nec.com> (Hiroshi Shimamoto's message of
	"Wed, 24 Oct 2007 14:27:46 -0700")
Message-ID: <m1odeo6ns0.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces@lists.infradead.org
To: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Cc: hbabu@us.ibm.com, tglx@linutronix.de, vgoyal@in.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com> writes:

>> Do we really have to introduce this function for 64bit? I remember some
>> issues were faced on i386 w.r.t kernel enabling the LAPIC against the
>> wishes of BIOS hence kernel was disabling it while shutting down. No
>> such problems were reported for x86_64 hence this function existed only
>> for i386.
>
> Thanks for the comment. I didn't know the issues, so I'd simply added
> this function for unification.
>
>> If that is the case, probably we don't have to introduce lapic_shutdown()
>> for x86_64. Instead call lapic_shutdown() for X86_32, and disble_local_APIC()
>> otherwise?
>
> I will do that. I was thinking which is good when posting these patches.

I'm a little concerned here.  This sounds like forced unification.
If we can't clean up the infrastructure so things are obviously better
and cleanly factored for both architectures we should not unify the files.

As a general principle I would rather have two crudy files side by
side the one super crudy file.

So for unification I suggest finally fixing this right and taking the
apics completely out of the kexec on panic path.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
