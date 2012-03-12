Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by casper.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1S75Qa-000170-JK
 for kexec@lists.infradead.org; Mon, 12 Mar 2012 13:36:45 +0000
Date: Mon, 12 Mar 2012 09:36:19 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 1/2] boot: ignore early NMIs
Message-ID: <20120312133619.GB17288@redhat.com>
References: <m1ipip6xe8.fsf@fess.ebiederm.org> <4F573E1C.2060909@oss.ntt.co.jp>
 <4F573E74.5040504@oss.ntt.co.jp> <m1eht31z8e.fsf@fess.ebiederm.org>
 <4F58495B.5080308@oss.ntt.co.jp> <m1r4x3yrsv.fsf@fess.ebiederm.org>
 <4F5A6D87.4050809@zytor.com> <4F5D8D0E.8060702@oss.ntt.co.jp>
 <4F5D8E63.60606@zytor.com> <4F5D943C.5020403@oss.ntt.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F5D943C.5020403@oss.ntt.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Fernando Luis =?iso-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>
Cc: Don Zickus <dzickus@redhat.com>, akpm@linux-foundation.org, linux-tip-commits@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, tglx@linutronix.de, torvalds@linux-foundation.org, mingo@elte.hu

On Mon, Mar 12, 2012 at 03:14:20PM +0900, Fernando Luis V=E1zquez Cao wrote:

[..]
> The thing is that we want to avoid playing with hardware in the kdump
> reboot patch when we can avoid it, the premise being that it cannot
> be accessed without risking a lockup or worse (as the deadlock accessing
> the I/O APIC showed).

I think there needs to be a limit to being paranoid. On one hand people
want to run panic notifiers, all the kmsg_dump() hooks in panic path, and
on the other hand we are afraid of even disabling LAPIC.

I personally think that disabling LAPIC is reasonably practical solution
to the problem until and unless somebody shows that it deadlocks easily.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
