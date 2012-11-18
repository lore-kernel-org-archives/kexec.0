Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZwap-0007uD-Bb
 for kexec@lists.infradead.org; Sun, 18 Nov 2012 04:34:52 +0000
Message-ID: <50A86563.30303@zytor.com>
Date: Sat, 17 Nov 2012 20:34:43 -0800
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
In-Reply-To: <CAE9FiQXNDEPw6WhfgYspqZsy+VVrPoA7M4kKo+5N95=22WBpkQ@mail.gmail.com>
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
To: Yinghai Lu <yinghai@kernel.org>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On 11/17/2012 04:44 PM, Yinghai Lu wrote:
> On Sat, Nov 17, 2012 at 12:04 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Sat, Nov 17, 2012 at 12:25 AM, Eric W. Biederman
>> <ebiederm@xmission.com> wrote:
>>
>> then for setup data (boot param) and command line, we have to set extra ident
>> mapping for them in kernel arch/x86/kernel/head_64.S
>>
>
> find the solution for this one:
> We don't need to set ident map for boot_param and command line in head_64.S
>
> as we already get arch/x86/kernel/head64.c, and could use
> early_ioremap to access
> and copy them out.
>

I don't think that is feasible; we need access to this structure 
extremely early.  I think if you're using the 64-bit entry point it has 
to be an entry condition that those structures are mapped.  It simply 
becomes a precondition for using the 64-bit entry point.

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
