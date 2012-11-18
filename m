Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZyIn-000138-Pc
 for kexec@lists.infradead.org; Sun, 18 Nov 2012 06:24:22 +0000
In-Reply-To: <CAE9FiQX7MsAaD4TaDv5gisuA5PNa9AmhDk54AjpzEzp4D_+aDg@mail.gmail.com>
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
 <CAE9FiQV=6qeBgzd3ekBRXh1jfv+_-s_UuQqRyMAYwK5E=S55fA@mail.gmail.com>
 <CAE9FiQX7MsAaD4TaDv5gisuA5PNa9AmhDk54AjpzEzp4D_+aDg@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/8] add mem64_min/max control
From: "H. Peter Anvin" <hpa@zytor.com>
Date: Sat, 17 Nov 2012 22:24:14 -0800
Message-ID: <9e53bef0-669e-456c-beae-6cacd442fbd3@email.android.com>
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
To: Yinghai Lu <yinghai@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

.S files have to be recoded to match the memory model!

Yinghai Lu <yinghai@kernel.org> wrote:

>On Sat, Nov 17, 2012 at 9:35 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Sat, Nov 17, 2012 at 9:20 PM, Eric W. Biederman
>> <ebiederm@xmission.com> wrote:
>>> Yinghai Lu <yinghai@kernel.org> writes:
>>>>
>>>> there is lots of R_X86_64_32 and R_X86_64_32S for 64bit purgatory.
>>>>
>>>> those come from global variables...could kill some by converting
>them static...
>>>>
>>>> but still have some global string or ro data....
>>>>
>>>> build one big file include all .S ?
>>>
>>> For R_x86_64_32 and R_x86_64_32S the problem is that the
>instructions
>>> are using absolute 32bit addresses.
>>>
>>> It is probably overkill but we should be able to solve this with
>>> by adding "-mcmodel=large" to the build of purgatory.
>>
>> it kill some...
>>
>> still have left.... looks they from .S
>>
>> yhlu@linux-siqj:~/xx/xx/utils/kexec-tools> readelf --relocs
>> purgatory/purgatory.ro | grep R_X86_64_32
>> 0000000005e9  00020000000b R_X86_64_32S      0000000000000000 .rodata
>+ c0
>
>looks like .S did not get that -mcmodel=large applied..

-- 
Sent from my mobile phone. Please excuse brevity and lack of formatting.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
