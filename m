Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U0frI-0001Uu-T7
 for kexec@lists.infradead.org; Wed, 30 Jan 2013 22:10:21 +0000
Message-ID: <51099A3E.5090705@zytor.com>
Date: Wed, 30 Jan 2013 14:10:06 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Cleanup kdump memmap= passing and e820 usage
References: <1358866935-18458-1-git-send-email-trenn@suse.de>
 <201301301713.43946.trenn@suse.de>
 <4dc77552-977d-4761-860e-afdec61c4317@email.android.com>
 <201301301739.52358.trenn@suse.de> <51094FD5.2070909@zytor.com>
 <87obg6sdtv.fsf@xmission.com> <510992C7.2050000@zytor.com>
 <877gmumizr.fsf@xmission.com>
In-Reply-To: <877gmumizr.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, yinghai@kernel.org, Thomas Renninger <trenn@suse.de>, vgoyal@redhat.com

On 01/30/2013 01:57 PM, Eric W. Biederman wrote:
>>
>> Yes, those seem to be the options, and we're currently discussing which one.
>>
>> The second seems to make more sense to me.  The kexec tools build the
>> memory map anyway, and it makes sense to me at least to just build a
>> memory map with the appropriate regions marked as a dumpable type.
> 
> This dumpable type doesn't make sense to me.  Are you suggesting making
> regions that are memory but that we should not use a special memory
> type?

Yes.

> I think I would prefer that to call that new type RESERVED_MEM or
> RESERVED_CACHABLE.  Being more specific is fine but dumpable certainly
> doesn't bring to mind what we are saying.  Especially since we already
> communicate which areas were memory to the last kernel in an
> architecture generic format.

I was thinking that marking them differently might help debugging, at
least, but yes, we can have a RESERVED_MEM type.

However, Thomas does have a point that the current use of fairly small
positive values for Linux-defined types is a bad idea.  We should use
negative types, or at least something north of 0x40000000 or so.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
