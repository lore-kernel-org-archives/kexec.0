Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ie-in-x0236.1e100.net ([2607:f8b0:4001:c03::236]
 helo=mail-ie0-x236.google.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U0gTA-0004zz-H5
 for kexec@lists.infradead.org; Wed, 30 Jan 2013 22:49:29 +0000
Received: by mail-ie0-f182.google.com with SMTP id k14so1775603iea.41
 for <kexec@lists.infradead.org>; Wed, 30 Jan 2013 14:49:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5109A1A7.1040609@zytor.com>
References: <1358866935-18458-1-git-send-email-trenn@suse.de>
 <201301301713.43946.trenn@suse.de>
 <4dc77552-977d-4761-860e-afdec61c4317@email.android.com>
 <201301301739.52358.trenn@suse.de> <51094FD5.2070909@zytor.com>
 <87obg6sdtv.fsf@xmission.com> <510992C7.2050000@zytor.com>
 <877gmumizr.fsf@xmission.com> <51099A3E.5090705@zytor.com>
 <87ehh2l2z3.fsf@xmission.com> <5109A1A7.1040609@zytor.com>
Date: Wed, 30 Jan 2013 14:49:25 -0800
Message-ID: <CAE9FiQXjGe335nCFu4df4KRsxpD=zxCk=9pxzABsCwGnStYX3g@mail.gmail.com>
Subject: Re: [PATCH 0/3] Cleanup kdump memmap= passing and e820 usage
From: Yinghai Lu <yinghai@kernel.org>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Thomas Renninger <trenn@suse.de>, vgoyal@redhat.com

On Wed, Jan 30, 2013 at 2:41 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 01/30/2013 02:29 PM, Eric W. Biederman wrote:
> The bigger question is if we need a separate value from the current
> E820_RESERVED_KERN.  Since it is always easier to have multiple values
> with the same semantics than it is to have too few, I would still prefer
> we added a new E820_RESERVED_KDUMP, which would then be 2000000001.

current for E820_RESERVED_KERN: during filling memblock.memory,
it will be treated as E820_RAM, and also memblock.reserve already have entries
for them.

For E820_RESERVED_KDUMP, looks only usage is for kernel to find saved_max_pfn.

So we may have to separate them.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
