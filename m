Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1ToN1s-0001kP-2a
 for kexec@lists.infradead.org; Thu, 27 Dec 2012 23:38:25 +0000
Message-ID: <50DCDBD3.1020703@zytor.com>
Date: Thu, 27 Dec 2012 15:37:55 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 06/11] x86/xen: Add i386 kexec/kdump implementation
References: <5698071f-c96c-4891-81d6-a77c4e3b77c2@default>
In-Reply-To: <5698071f-c96c-4891-81d6-a77c4e3b77c2@default>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: xen-devel@lists.xensource.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, ebiederm@xmission.com, jbeulich@suse.com, maxim.uvarov@oracle.com, tglx@linutronix.de, vgoyal@redhat.com

On 12/27/2012 03:23 PM, Daniel Kiper wrote:
>> On 12/26/2012 06:18 PM, Daniel Kiper wrote:
>>> Add i386 kexec/kdump implementation.
>>>
>>> v2 - suggestions/fixes:
>>>      - allocate transition page table pages below 4 GiB
>>>        (suggested by Jan Beulich).
>>
>> Why?
>
> Sadly all addresses are passed via unsigned long
> variable to kexec hypercall.
>

So can you unf*ck your broken interface before imposing it on anyone else?

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
