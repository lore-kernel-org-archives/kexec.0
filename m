Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vw0-f49.google.com ([209.85.212.49])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PCRH9-0001B6-Km
	for kexec@lists.infradead.org; Sun, 31 Oct 2010 06:20:20 +0000
Received: by vws8 with SMTP id 8so847940vws.36
	for <kexec@lists.infradead.org>; Sat, 30 Oct 2010 23:20:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100619194532.GQ18946@basil.fritz.box>
References: <20100619132633.GA24277@basil.fritz.box>
	<m1mxuqu8yr.fsf@fess.ebiederm.org>
	<20100619194532.GQ18946@basil.fritz.box>
From: Michael Kerrisk <mtk.manpages@gmail.com>
Date: Sun, 31 Oct 2010 07:19:58 +0100
Message-ID: <AANLkTi=eT_6UjgLsrOtQt833xeTOkjDvHXvd=xbEZ34c@mail.gmail.com>
Subject: Re: [PATCH] kexec_load manpage
Reply-To: mtk.manpages@gmail.com
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
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-man@vger.kernel.org, Kexec Mailing List <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On Sat, Jun 19, 2010 at 9:45 PM, Andi Kleen <andi@firstfloor.org> wrote:
> On Sat, Jun 19, 2010 at 12:18:52PM -0700, Eric W. Biederman wrote:
>> Andi Kleen <andi@firstfloor.org> writes:
>>
>> > Here are the beginnings of a kexec_load manpage.
>> >
>> > Probably needs some more review from Eric and may need some additional
>> > information.
>> >
>> > The syscall is actually only usable with a kernel patch to export
>> > the header I just sent separately.
>>
>> The syscall has been used for years with a separate non-kernel header.
>
> Yes but that's not a sane interface that can be documented.

Agreed. Surely the right thing to do is export the proper header?

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Author of "The Linux Programming Interface"; http://man7.org/tlpi/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
