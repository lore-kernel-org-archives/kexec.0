Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TQOmO-0004sL-D2
 for kexec@lists.infradead.org; Mon, 22 Oct 2012 20:39:22 +0000
Message-ID: <5085AEDE.1060806@zytor.com>
Date: Mon, 22 Oct 2012 13:38:54 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/2] x86, apic: Disable BSP if boot cpu is AP
References: <20121016043357.20003.5885.stgit@localhost6.localdomain6>
 <20121016043528.20003.601.stgit@localhost6.localdomain6>
 <873916i88t.fsf@xmission.com> <5085A9A8.5020004@zytor.com>
 <87fw56fduo.fsf@xmission.com> <5085AD7D.106@zytor.com>
In-Reply-To: <5085AD7D.106@zytor.com>
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
Cc: len.brown@intel.com, fenghua.yu@intel.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, tglx@linutronix.de, mingo@elte.hu, vgoyal@redhat.com

On 10/22/2012 01:33 PM, H. Peter Anvin wrote:
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
> 

(I presume the failure is SMM-related, but Fenghua might have more
details...)

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
