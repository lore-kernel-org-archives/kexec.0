Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz0tp-0007hT-A0
 for kexec@lists.infradead.org; Fri, 24 Jul 2020 16:50:22 +0000
From: Nathan Lynch <nathanl@linux.ibm.com>
Subject: Re: [PATCHv3 2/2] powerpc/pseries: update device tree before ejecting
 hotplug uevents
In-Reply-To: <CAFgQCTu_QO=50v2J0=aY2iV8P-oM82_Kfw9My600ZARUt01grw@mail.gmail.com>
References: <1595382730-10565-1-git-send-email-kernelfans@gmail.com>
 <1595382730-10565-2-git-send-email-kernelfans@gmail.com>
 <87imee1hvt.fsf@linux.ibm.com>
 <CAFgQCTu_QO=50v2J0=aY2iV8P-oM82_Kfw9My600ZARUt01grw@mail.gmail.com>
Date: Fri, 24 Jul 2020 11:50:12 -0500
Message-ID: <87d04k26yj.fsf@linux.ibm.com>
MIME-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pingfan Liu <kernelfans@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, cheloha@linux.ibm.com, Kexec Mailing List <kexec@lists.infradead.org>, ldufour@linux.ibm.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Hari Bathini <hbathini@linux.ibm.com>

Pingfan Liu <kernelfans@gmail.com> writes:
> On Thu, Jul 23, 2020 at 9:27 PM Nathan Lynch <nathanl@linux.ibm.com> wrote:
>> Pingfan Liu <kernelfans@gmail.com> writes:
>> > This will introduce extra dt updating payload for each involved lmb when hotplug.
>> > But it should be fine since drmem_update_dt() is memory based operation and
>> > hotplug is not a hot path.
>>
>> This is great analysis but the performance implications of the change
>> are grave. The add/remove paths here are already O(n) where n is the
>> quantity of memory assigned to the LP, this change would make it O(n^2):
>>
>> dlpar_memory_add_by_count
>>   for_each_drmem_lmb             <--
>>     dlpar_add_lmb
>>       drmem_update_dt(_v1|_v2)
>>         for_each_drmem_lmb       <--
>>
>> Memory add/remove isn't a hot path but quadratic runtime complexity
>> isn't acceptable. Its current performance is bad enough that I have
> Yes, the quadratic runtime complexity sounds terrible.
> And I am curious about the bug. Does the system have thousands of lmb?

Yes.

>> Not to mention we leak memory every time drmem_update_dt is called
>> because we can't safely free device tree properties :-(
> Do you know what block us to free it?

It's a longstanding problem. References to device tree properties aren't
counted or tracked so there's no way to safely free them unless the node
itself is released. But the ibm,dynamic-reconfiguration-memory node does
not ever go away and its properties are only subject to updates.

Maybe there's a way to address the specific case of
ibm,dynamic-reconfiguration-memory and the ibm,dynamic-memory(-v2)
properties, instead of tackling the general problem.

Regardless of all that, the drmem code needs better data structures and
lookup functions.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
