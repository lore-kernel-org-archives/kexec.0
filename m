Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZyHw-000112-2d
 for kexec@lists.infradead.org; Sun, 18 Nov 2012 06:23:29 +0000
In-Reply-To: <878v9zqyfh.fsf@xmission.com>
References: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
 <1353107067-14564-4-git-send-email-yinghai@kernel.org>
 <87haoo21mw.fsf@xmission.com>
 <CAE9FiQU=tW51h_NL+_AGQMDhNRM1dBCTW1FJVe6vpQYVQEzY=Q@mail.gmail.com>
 <87fw48zldz.fsf@xmission.com>
 <CAE9FiQVX8xnAGGkPtR0BA1iYbQi5fXY2+P3pW=d-tX8fpWibnw@mail.gmail.com>
 <CAE9FiQXNDEPw6WhfgYspqZsy+VVrPoA7M4kKo+5N95=22WBpkQ@mail.gmail.com>
 <50A86563.30303@zytor.com> <876253sej9.fsf@xmission.com>
 <CAE9FiQVfRHpoBoUyZssfE32wv7j3fD2skRL4UFXP=FBq7rrE1w@mail.gmail.com>
 <878v9zqyfh.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/8] add mem64_min/max control
From: "H. Peter Anvin" <hpa@zytor.com>
Date: Sat, 17 Nov 2012 22:23:16 -0800
Message-ID: <306ab84f-139c-47e2-8790-eb7b4b45c261@email.android.com>
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
To: ebiederm@xmission.com, Yinghai Lu <yinghai@kernel.org>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

I think you just need one of the PIC models, or the medium model.

ebiederm@xmission.com wrote:

>Yinghai Lu <yinghai@kernel.org> writes:
>
>> On Sat, Nov 17, 2012 at 8:47 PM, Eric W. Biederman
>> <ebiederm@xmission.com> wrote:
>>> "H. Peter Anvin" <hpa@zytor.com> writes:
>>>
>>>
>>> 64bit purgatory coming from kexec should be running with a page
>table
>>> that identity maps everything loaded by kexec and in practice all of
>>> memory.
>>
>> there is lots of R_X86_64_32 and R_X86_64_32S for 64bit purgatory.
>>
>> those come from global variables...could kill some by converting them
>static...
>>
>> but still have some global string or ro data....
>>
>> build one big file include all .S ?
>
>For R_x86_64_32 and R_x86_64_32S the problem is that the instructions
>are using absolute 32bit addresses.
>
>It is probably overkill but we should be able to solve this with
>by adding "-mcmodel=large" to the build of purgatory.
>
>Hopefully there are not 32bit or 16bit assembly routines getting linked
>in and using problemenatic instructions.
>
>Eric

-- 
Sent from my mobile phone. Please excuse brevity and lack of formatting.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
