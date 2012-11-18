Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZxDS-0000Ef-DR
 for kexec@lists.infradead.org; Sun, 18 Nov 2012 05:14:47 +0000
Message-ID: <50A86EC0.2030304@zytor.com>
Date: Sat, 17 Nov 2012 21:14:40 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/8] add mem64_min/max control
References: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
 <1353107067-14564-4-git-send-email-yinghai@kernel.org>
 <87haoo21mw.fsf@xmission.com>
 <CAE9FiQU=tW51h_NL+_AGQMDhNRM1dBCTW1FJVe6vpQYVQEzY=Q@mail.gmail.com>
 <87fw48zldz.fsf@xmission.com>
 <CAE9FiQVX8xnAGGkPtR0BA1iYbQi5fXY2+P3pW=d-tX8fpWibnw@mail.gmail.com>
 <CAE9FiQXNDEPw6WhfgYspqZsy+VVrPoA7M4kKo+5N95=22WBpkQ@mail.gmail.com>
 <50A86563.30303@zytor.com> <876253sej9.fsf@xmission.com>
 <50A86A4D.8090503@zytor.com> <87haonqzdz.fsf@xmission.com>
In-Reply-To: <87haonqzdz.fsf@xmission.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

On 11/17/2012 09:00 PM, Eric W. Biederman wrote:
>>
>> The easy way to fix that is to do what we do on 32 bits: we copy it
>> into the bss before we turn paging on (the 64-bit equivalent is before
>> we switch to the new page tables.)  That way we know where it is, at
>> least for the bounded-size data items.
>
> Whatever works.  It sounds like six of one half a dozen of the other to
> me.  Last I looked early_ioremap works as soon as paging is enabled on
> x86_64.
>

Well, x86-64 means paging is enabled.  Presumably you mean "as son as we 
are onl our own page tables".  I'm fine either way, *as long as* we 
don't touch *any* memory outside text/data/bss/brk before we recover 
this content.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
