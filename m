Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TbGiX-0003XB-Ci
 for kexec@lists.infradead.org; Wed, 21 Nov 2012 20:16:18 +0000
Message-ID: <50AD3685.3050702@zytor.com>
Date: Wed, 21 Nov 2012 12:16:05 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/4] kexec, x86_64: Load bzImage64 above 4G
References: <1353483098-14883-1-git-send-email-yinghai@kernel.org>
 <1353483098-14883-5-git-send-email-yinghai@kernel.org>
 <20121121143729.GC13114@redhat.com>
 <CAE9FiQWRtMwXjUEr5pHtKKR+mPk7qtKRDpS_G_o=VzzKkBwL1Q@mail.gmail.com>
 <50AD31ED.3020202@zytor.com>
 <CAE9FiQXjH8nLQrPdP=OiXqROvhwf=mT8XOq9Netmsj08FXrEiw@mail.gmail.com>
In-Reply-To: <CAE9FiQXjH8nLQrPdP=OiXqROvhwf=mT8XOq9Netmsj08FXrEiw@mail.gmail.com>
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

On 11/21/2012 12:01 PM, Yinghai Lu wrote:
> On Wed, Nov 21, 2012 at 11:56 AM, H. Peter Anvin <hpa@zytor.com> wrote:
>> On 11/21/2012 11:54 AM, Yinghai Lu wrote:
>>>
>>> in kernel arch/x86/kernel/head_64.S
>>>
>>> it only set first 1G ident mapping. and if it find that code is above
>>> 1G, it will set extra ident mapping
>>> for new _text.._end.
>>> To make checking and add extra mapping simple and also save two extra
>>> pages for mapping.
>>> Limit that _text.._end in them same GB range.
>>>
>>
>> No, this is backwards.
> 
> old one: it limited bzImage in [0,1G) aka the first 1G.
> 
> Now we can put it in any aligned 1G range.
> 
> So how could it be called backwards?
> 

Because you're adding a more complicated hack.

>>
>> We should fix that limitation instead.
> 
> sure, but that will make arch/x86/boot/compressed/head_64.S not need
> complicated.
> 

But it makes the bootloaders more complicated, and the bootloaders are
harder to fix.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
