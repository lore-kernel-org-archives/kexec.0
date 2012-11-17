Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZpDM-0005z7-A6
 for kexec@lists.infradead.org; Sat, 17 Nov 2012 20:42:09 +0000
In-Reply-To: <CAE9FiQVX8xnAGGkPtR0BA1iYbQi5fXY2+P3pW=d-tX8fpWibnw@mail.gmail.com>
References: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
 <1353107067-14564-4-git-send-email-yinghai@kernel.org>
 <87haoo21mw.fsf@xmission.com>
 <CAE9FiQU=tW51h_NL+_AGQMDhNRM1dBCTW1FJVe6vpQYVQEzY=Q@mail.gmail.com>
 <87fw48zldz.fsf@xmission.com>
 <CAE9FiQVX8xnAGGkPtR0BA1iYbQi5fXY2+P3pW=d-tX8fpWibnw@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/8] add mem64_min/max control
From: "H. Peter Anvin" <hpa@zytor.com>
Date: Sat, 17 Nov 2012 12:41:40 -0800
Message-ID: <6eadd4ad-0e3f-4670-81a8-38beb9354e01@email.android.com>
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

Sorry, with "real mode" are we talking about struct boot_params or the actual realmode trampoline?  The latter needs to be < 640K as a hw requirement.

Sorry, on my cellphone atm and can't direcly check.

Yinghai Lu <yinghai@kernel.org> wrote:

>On Sat, Nov 17, 2012 at 12:25 AM, Eric W. Biederman
><ebiederm@xmission.com> wrote:
>> Yinghai Lu <yinghai@kernel.org> writes:
>>
>>> On Fri, Nov 16, 2012 at 10:18 PM, Eric W. Biederman
>>> <ebiederm@xmission.com> wrote:
>>>> Yinghai Lu <yinghai@kernel.org> writes:
>>>>
>>>>> So could limit range for 4g above buffers.
>>>>
>>>> What is wrong with mem-min and mem-max?  At this point in the
>patchset
>>>> it looks like you are introducing mem64-min and mem64-max as a hack
>to
>>>> avoid fixing mem-min and mem-max properly.
>>>
>>> if we set mem-min high, some buffers for purgatory and real_mode can
>>> not be allocated properly.
>>
>> Let's see.  For a 32bit kexec that is a fundamental limit, even if we
>> are booting a 64bit kernel.
>>
>> For a 64bit kexec we have a 64bit purgatory so it should not be a
>> problem to relocate it higher.
>>
>> Hmm.  I'm not certain about the real_mode bits.  Splitting out the
>64bit
>> bzImage loader from the 32bit bzImage loader should allow a lot of
>the
>> legacy bits to be deleted.  Past that I think we simply down in the
>real
>> of needing a command line pointer that is 64bit instead of the
>current
>> 32bit one.  That we should be able to fix by fixing the boot
>protocol.
>>
>> Since the real mode bits when loading a 64bit kernel are just a
>> parameter area there should be no fundamental reason for them to be
>> below 4G.
>>
>> The code needs to default to loading the kernel in the non kdump case
>> at the address it was compiled to run at.  But for the rest I really
>> don't see why we can't load the kernel very high.
>
>then for setup data (boot param) and command line, we have to set extra
>ident
>mapping for them in kernel arch/x86/kernel/head_64.S
>
>with my current patchset for kernel and kexec,  we only need to set
>ident mapping
>for [_text, _end) in kernel arch/x86/kernel/head_64.S
>
>Yinghai

-- 
Sent from my mobile phone. Please excuse brevity and lack of formatting.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
