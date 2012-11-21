Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TbHLe-0007ZQ-Ty
 for kexec@lists.infradead.org; Wed, 21 Nov 2012 20:56:43 +0000
In-Reply-To: <CAE9FiQWjWC59Vha8hfuSC6tRYgQ42ooA37UuOg4SP3_1Fzc5Tw@mail.gmail.com>
References: <1353483098-14883-1-git-send-email-yinghai@kernel.org>
 <1353483098-14883-5-git-send-email-yinghai@kernel.org>
 <20121121143729.GC13114@redhat.com>
 <CAE9FiQWRtMwXjUEr5pHtKKR+mPk7qtKRDpS_G_o=VzzKkBwL1Q@mail.gmail.com>
 <50AD31ED.3020202@zytor.com>
 <CAE9FiQXjH8nLQrPdP=OiXqROvhwf=mT8XOq9Netmsj08FXrEiw@mail.gmail.com>
 <50AD3685.3050702@zytor.com>
 <CAE9FiQWjWC59Vha8hfuSC6tRYgQ42ooA37UuOg4SP3_1Fzc5Tw@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/4] kexec, x86_64: Load bzImage64 above 4G
From: "H. Peter Anvin" <hpa@zytor.com>
Date: Wed, 21 Nov 2012 12:56:24 -0800
Message-ID: <7ecd8dcf-3b94-413a-a110-765c615863b4@email.android.com>
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
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

Yes.

Yinghai Lu <yinghai@kernel.org> wrote:

>On Wed, Nov 21, 2012 at 12:16 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>> On 11/21/2012 12:01 PM, Yinghai Lu wrote:
>>> On Wed, Nov 21, 2012 at 11:56 AM, H. Peter Anvin <hpa@zytor.com>
>wrote:
>>>> On 11/21/2012 11:54 AM, Yinghai Lu wrote:
>>>>>
>>>>> in kernel arch/x86/kernel/head_64.S
>>>>>
>>>>> it only set first 1G ident mapping. and if it find that code is
>above
>>>>> 1G, it will set extra ident mapping
>>>>> for new _text.._end.
>>>>> To make checking and add extra mapping simple and also save two
>extra
>>>>> pages for mapping.
>>>>> Limit that _text.._end in them same GB range.
>>>>>
>>>>
>>>> No, this is backwards.
>>>
>>> old one: it limited bzImage in [0,1G) aka the first 1G.
>>>
>>> Now we can put it in any aligned 1G range.
>>>
>>> So how could it be called backwards?
>>>
>>
>> Because you're adding a more complicated hack.
>
>not that complicated, and it only add 7 lines
>
>        /* same GB ? */
>        while ((addr >> 30) != ((addr + size - 1) >> 30)) {
>                addr = locate_hole(info, size, align, 0x100000,
>                           round_down(addr + size - 1, (1UL<<30)), -1);
>                if (addr == ULONG_MAX)
>                        die("can not load bzImage64");
>        }
>
>>
>>>>
>>>> We should fix that limitation instead.
>>>
>>> sure, but that will make arch/x86/boot/compressed/head_64.S not need
>>> complicated.
>
>If that add cover cross GB boundary handling in head_64.S, may need
>another 100 line code
>for checking and etc.
>
>Also will need another two spare pages for cross 512G boundary.
>
>>
>> But it makes the bootloaders more complicated, and the bootloaders
>are
>> harder to fix.
>
>current bootloader does not have this feature and will
>add the feature. and looks like kexec is only one at this point.
>
>BTW,  is there any 64bit boot loader?

-- 
Sent from my mobile phone. Please excuse brevity and lack of formatting.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
