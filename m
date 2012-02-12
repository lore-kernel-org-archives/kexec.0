Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f49.google.com ([209.85.213.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RwQsi-0000uq-UI
 for kexec@lists.infradead.org; Sun, 12 Feb 2012 04:17:45 +0000
Received: by yhjj56 with SMTP id j56so2198904yhj.36
 for <kexec@lists.infradead.org>; Sat, 11 Feb 2012 20:17:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <m1ipjc3fsk.fsf@fess.ebiederm.org>
References: <tip-d9bc9be89629445758670220787683e37c93f6c1@git.kernel.org>
 <CAE9FiQWRjvu_uNcx_bJXYHeg4D4k6YzHHmSudsq7EyubLi7+nw@mail.gmail.com>
 <m1ipjc3fsk.fsf@fess.ebiederm.org>
Date: Sat, 11 Feb 2012 20:17:43 -0800
Message-ID: <CAE9FiQVLnyRB+pAqi22C5mCbHOOVKxsBhQKaB6P0p9f2LBL8bA@mail.gmail.com>
Subject: Re: [tip:x86/debug] x86/kdump: No need to disable ioapic/ lapic in
 crash path
From: Yinghai Lu <yinghai@kernel.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: dzickus@redhat.com, linux-tip-commits@vger.kernel.org, mingo@elte.hu, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, akpm@linux-foundation.org, torvalds@linux-foundation.org, tglx@linutronix.de, vgoyal@redhat.com

On Sat, Feb 11, 2012 at 7:13 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Yinghai Lu <yinghai@kernel.org> writes:
>> After reverting this commit, kdump is working again.
>>
>> So assume you need to drop this patch.
>
> It sounds like there is a bug in ioapic initialization in the context of
> VT-d. =A0Where do you fail?
>
before get debug print out from second kernel, the system get reset.

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
