Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NCNZD-0003og-Ai
	for kexec@lists.infradead.org; Mon, 23 Nov 2009 01:18:16 +0000
Received: by pwi12 with SMTP id 12so3370514pwi.2
	for <kexec@lists.infradead.org>; Sun, 22 Nov 2009 17:18:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <m18wdypvjd.fsf@fess.ebiederm.org>
References: <86802c440911220226g21cc42bbmdc3ebe21d0f61943@mail.gmail.com>
	<m18wdypvjd.fsf@fess.ebiederm.org>
Date: Sun, 22 Nov 2009 17:18:09 -0800
Message-ID: <86802c440911221718l541c0dq599f6a401fd03157@mail.gmail.com>
Subject: Re: [PATCH] x86: crash kernel reserve with reserve_early
From: Yinghai Lu <yhlu.kernel@gmail.com>
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
Cc: kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>

On Sun, Nov 22, 2009 at 4:56 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Yinghai Lu <yhlu.kernel@gmail.com> writes:
>
>> [PATCH] x86: crash kernel reserve with reserve_early
>>
>> use find_e820_area/reserve_early instead.
>> will get next good one automatically with alignment
>
> Semantically this is broken, as you are now ignoring a passed in
> base address if one is supplied. =A0What problem are you trying to fix?

avoid to use bootmem.

also simpify the code.

YH

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
