Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TQOqT-0008Aa-Kr
 for kexec@lists.infradead.org; Mon, 22 Oct 2012 20:43:34 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20121016043357.20003.5885.stgit@localhost6.localdomain6>
 <20121016043528.20003.601.stgit@localhost6.localdomain6>
 <873916i88t.fsf@xmission.com> <5085A9A8.5020004@zytor.com>
 <87fw56fduo.fsf@xmission.com> <5085AD7D.106@zytor.com>
Date: Mon, 22 Oct 2012 13:43:21 -0700
In-Reply-To: <5085AD7D.106@zytor.com> (H. Peter Anvin's message of "Mon, 22
 Oct 2012 13:33:01 -0700")
Message-ID: <87a9vedyqe.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/2] x86, apic: Disable BSP if boot cpu is AP
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
Cc: len.brown@intel.com, fenghua.yu@intel.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, tglx@linutronix.de, mingo@elte.hu, vgoyal@redhat.com

"H. Peter Anvin" <hpa@zytor.com> writes:

> On 10/22/2012 01:31 PM, Eric W. Biederman wrote:
>>>
>>> IIRC Fenghua experimented with that and it didn't work.  Not all BIOSes
>>> use that bit to determine BSP-ness.
>> 
>> What does a BIOS have to do with anything?
>> 
>> The practical issue here is does an INIT IPI cause the cpu to go into
>> startup-ipi-wait or to start booting at 4G-16 bytes.
>> 
>> For dealing with BIOSen we may still need to use the bootstrap processor
>> for firmware calls, cpu suspend, and other firmware weirdness, but that
>> should all be completely orthogonal to the behavior to what happens
>> when an INIT IPI is sent to the cpu.
>> 
>> The only firmware problem I can imagine having is cpu virtualization
>> bug.
>> 
>
> The whole problem is that some BIOSes go wonky after receiving an INIT
> (as in INIT-SIPI-SIPI) to the BSP.

The reason the BIOSen go wonky is the INIT cause the cpu to go to the
reset vector at 4G-16 bytes.  So it is very much expected that the
BIOSen start acting like you just came out of reset.

If you can clear bit 8 of IA32_APIC_BASE_MSR and inform the cpu to not
send the cpu to 4G-16 bytes and instead send the cpu into it's magic
startup-ipi-wait mode then the BIOSen will not be involved on that path.

It is a simple question of does the cpu support clearing bit 8
meaningfully.

If the cpu allows bit 8 to be cleared and sends the cpu to the reset
vector on receipt of the INIT IPI I would call that a deviation from the
x86 cpu specification.

So clearing bit 8 is not a question about BIOSen it is a question of can
we avoid the BIOSen, by using an obscure under-documented cpu feature.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
