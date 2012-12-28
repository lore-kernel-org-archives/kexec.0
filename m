Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1ToQRY-0003dL-R0
 for kexec@lists.infradead.org; Fri, 28 Dec 2012 03:17:09 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <5698071f-c96c-4891-81d6-a77c4e3b77c2@default>
 <50DCDBD3.1020703@zytor.com>
Date: Thu, 27 Dec 2012 19:16:46 -0800
In-Reply-To: <50DCDBD3.1020703@zytor.com> (H. Peter Anvin's message of "Thu,
 27 Dec 2012 15:37:55 -0800")
Message-ID: <87han6n9wh.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 06/11] x86/xen: Add i386 kexec/kdump implementation
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
Cc: xen-devel@lists.xensource.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, Daniel Kiper <daniel.kiper@oracle.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, jbeulich@suse.com, maxim.uvarov@oracle.com, tglx@linutronix.de, vgoyal@redhat.com

"H. Peter Anvin" <hpa@zytor.com> writes:

> On 12/27/2012 03:23 PM, Daniel Kiper wrote:
>>> On 12/26/2012 06:18 PM, Daniel Kiper wrote:
>>>> Add i386 kexec/kdump implementation.
>>>>
>>>> v2 - suggestions/fixes:
>>>>      - allocate transition page table pages below 4 GiB
>>>>        (suggested by Jan Beulich).
>>>
>>> Why?
>>
>> Sadly all addresses are passed via unsigned long
>> variable to kexec hypercall.
>>
>
> So can you unf*ck your broken interface before imposing it on anyone
> else?

Hasn't 32bit dom0 been retired?

Untill the kexec firmware pass through and the normal kexec code paths
are separated I can't make sense out of this code.

The normal kexec code path should be doable without any special
constraints on the kernel.  Just leaning on some xen paravirt calls.

The kexec pass through probably should not even touch x86 arch code.

Certainly the same patch should not have code for both the xen kexec
pass through and the paravirt arch code for the normal kexec path.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
