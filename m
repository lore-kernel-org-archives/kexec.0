Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TZxJY-0000IB-2p
 for kexec@lists.infradead.org; Sun, 18 Nov 2012 05:21:04 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
 <1353107067-14564-4-git-send-email-yinghai@kernel.org>
 <87haoo21mw.fsf@xmission.com>
 <CAE9FiQU=tW51h_NL+_AGQMDhNRM1dBCTW1FJVe6vpQYVQEzY=Q@mail.gmail.com>
 <87fw48zldz.fsf@xmission.com>
 <CAE9FiQVX8xnAGGkPtR0BA1iYbQi5fXY2+P3pW=d-tX8fpWibnw@mail.gmail.com>
 <CAE9FiQXNDEPw6WhfgYspqZsy+VVrPoA7M4kKo+5N95=22WBpkQ@mail.gmail.com>
 <50A86563.30303@zytor.com> <876253sej9.fsf@xmission.com>
 <CAE9FiQVfRHpoBoUyZssfE32wv7j3fD2skRL4UFXP=FBq7rrE1w@mail.gmail.com>
Date: Sat, 17 Nov 2012 21:20:50 -0800
In-Reply-To: <CAE9FiQVfRHpoBoUyZssfE32wv7j3fD2skRL4UFXP=FBq7rrE1w@mail.gmail.com>
 (Yinghai Lu's message of "Sat, 17 Nov 2012 20:56:37 -0800")
Message-ID: <878v9zqyfh.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/8] add mem64_min/max control
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
To: Yinghai Lu <yinghai@kernel.org>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

Yinghai Lu <yinghai@kernel.org> writes:

> On Sat, Nov 17, 2012 at 8:47 PM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> "H. Peter Anvin" <hpa@zytor.com> writes:
>>
>>
>> 64bit purgatory coming from kexec should be running with a page table
>> that identity maps everything loaded by kexec and in practice all of
>> memory.
>
> there is lots of R_X86_64_32 and R_X86_64_32S for 64bit purgatory.
>
> those come from global variables...could kill some by converting them static...
>
> but still have some global string or ro data....
>
> build one big file include all .S ?

For R_x86_64_32 and R_x86_64_32S the problem is that the instructions
are using absolute 32bit addresses.

It is probably overkill but we should be able to solve this with
by adding "-mcmodel=large" to the build of purgatory.

Hopefully there are not 32bit or 16bit assembly routines getting linked
in and using problemenatic instructions.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
